USING Simatic.Ax.IO.Input;
USING AxUnit;

NAMESPACE Simatic.Ax.IO.Input.Test

    /// Test fixture for LRealInput class
    /// Verifies long real (LREAL) double precision floating-point input functionality including:
    /// - Signal reading with valid/invalid status (from LWORD hardware format and LREAL software format)
    /// - Default value handling when signal is invalid
    /// - QBad status management
    /// - Change detection with tolerance for floating-point values
    /// - MIN/MAX constant values
    {TestFixture}
    CLASS LRealInputTest
        VAR
            o : LRealInput;  // Test object for LRealInput
            oMinMaxTest : LRealInput;  // Test object for MIN/MAX verification
        END_VAR

        /// Parameterized test for different signal values and validity combinations
        /// Tests reading from LWORD hardware format (TO_LWORD conversion)
        /// Verifies Q() returns correct value based on validity and QBad() reflects status
        {Test(signalValue := LREAL#0.0, isValid := FALSE, defaultValue := LREAL#0.0, expectedValueWhenQBad := LREAL#0.0, expectedQBad := TRUE)}
        {Test(signalValue := LREAL#0.0, isValid := FALSE, defaultValue := LREAL#1.0, expectedValueWhenQBad := LREAL#1.0, expectedQBad := TRUE)}
        {Test(signalValue := LREAL#0.0, isValid := TRUE, defaultValue := LREAL#0.0, expectedValueWhenQBad := LREAL#0.0, expectedQBad := FALSE)}
        {Test(signalValue := LREAL#0.0, isValid := TRUE, defaultValue := LREAL#1.0, expectedValueWhenQBad := LREAL#0.0, expectedQBad := FALSE)}

        {Test(signalValue := LREAL#100.0, isValid := FALSE, defaultValue := LREAL#0.0, expectedValueWhenQBad := LREAL#0.0, expectedQBad := TRUE)}
        {Test(signalValue := LREAL#100.0, isValid := FALSE, defaultValue := LREAL#1.0, expectedValueWhenQBad := LREAL#1.0, expectedQBad := TRUE)}
        {Test(signalValue := LREAL#100.0, isValid := TRUE, defaultValue := LREAL#0.0, expectedValueWhenQBad := LREAL#100.0, expectedQBad := FALSE)}
        {Test(signalValue := LREAL#100.0, isValid := TRUE, defaultValue := LREAL#1.0, expectedValueWhenQBad := LREAL#100.0, expectedQBad := FALSE)}
        METHOD PUBLIC Check_different_values_and_results
            VAR_INPUT
                signalValue : LREAL;
                isValid : BOOL;
                defaultValue : LREAL;
                expectedValueWhenQBad : LREAL;
                expectedQBad : BOOL;
            END_VAR
            
            o.ReadCyclic(value := TO_LWORD(signalValue), valid := isValid, default := defaultValue);  
            Assert.Equal(expected := expectedValueWhenQBad, actual := o.Q());
            Assert.Equal(expected := expectedQBad, actual := o.QBad());
        END_METHOD

        /// Parameterized test for LREAL software format input
        /// Tests reading directly from LREAL values (software sources)
        /// Verifies Q() returns correct value based on validity and QBad() reflects status
        {Test(signalValue := LREAL#0.0, isValid := FALSE, defaultValue := LREAL#0.0, expectedValueWhenQBad := LREAL#0.0, expectedQBad := TRUE)}
        {Test(signalValue := LREAL#0.0, isValid := FALSE, defaultValue := LREAL#1.0, expectedValueWhenQBad := LREAL#1.0, expectedQBad := TRUE)}
        {Test(signalValue := LREAL#0.0, isValid := TRUE, defaultValue := LREAL#0.0, expectedValueWhenQBad := LREAL#0.0, expectedQBad := FALSE)}
        {Test(signalValue := LREAL#0.0, isValid := TRUE, defaultValue := LREAL#1.0, expectedValueWhenQBad := LREAL#0.0, expectedQBad := FALSE)}

        {Test(signalValue := LREAL#100.0, isValid := FALSE, defaultValue := LREAL#0.0, expectedValueWhenQBad := LREAL#0.0, expectedQBad := TRUE)}
        {Test(signalValue := LREAL#100.0, isValid := FALSE, defaultValue := LREAL#1.0, expectedValueWhenQBad := LREAL#1.0, expectedQBad := TRUE)}
        {Test(signalValue := LREAL#100.0, isValid := TRUE, defaultValue := LREAL#0.0, expectedValueWhenQBad := LREAL#100.0, expectedQBad := FALSE)}
        {Test(signalValue := LREAL#100.0, isValid := TRUE, defaultValue := LREAL#1.0, expectedValueWhenQBad := LREAL#100.0, expectedQBad := FALSE)}
        METHOD PUBLIC Check_different_LREAL_values_and_results
            VAR_INPUT
                signalValue : LREAL;
                isValid : BOOL;
                defaultValue : LREAL;
                expectedValueWhenQBad : LREAL;
                expectedQBad : BOOL;
            END_VAR
            
            o.ReadCyclic(value := signalValue, valid := isValid, default := defaultValue);  
            Assert.Equal(expected := expectedValueWhenQBad, actual := o.Q());
            Assert.Equal(expected := expectedQBad, actual := o.QBad());
        END_METHOD

        /// Test MIN and MAX constants for LREAL data type
        {Test}
        METHOD PUBLIC CheckMinMax  
            Assert.Equal(expected := LREAL#1.79769313486231e+308, actual := oMinMaxTest.Max);
            Assert.Equal(expected :=  LREAL#-1.79769313486231e+308, actual := oMinMaxTest.Min);
        END_METHOD

        /// Test change detection with tolerance for double precision floating-point values
        /// Verifies HasChanged() only triggers when change exceeds tolerance
        /// Important for filtering minor floating-point fluctuations
        {Test(signalValue := LREAL#100.0, newSignalValue := LREAL#100.0, tolerance := 0.1, expectedHasChanged := FALSE)}
        {Test(signalValue := LREAL#100.0, newSignalValue := LREAL#101.0, tolerance := 0.1, expectedHasChanged := TRUE)}
        {Test(signalValue := LREAL#100.0, newSignalValue := LREAL#100.2, tolerance := 0.1, expectedHasChanged := TRUE)}
        {Test(signalValue := LREAL#100.0, newSignalValue := LREAL#100.05, tolerance := 0.1, expectedHasChanged := FALSE)}
        METHOD PUBLIC CheckHasChanged
            VAR_INPUT
                signalValue : LREAL;
                newSignalValue : LREAL;
                tolerance : LREAL;
                expectedHasChanged : BOOL;
            END_VAR

            o.ReadCyclic(value := signalValue, valid := TRUE, default := 0);
            o.ReadCyclic(value := newSignalValue, valid := TRUE, default := 0, tolerance := tolerance);
            Assert.Equal(expected := expectedHasChanged, actual := o.HasChanged());
        END_METHOD
    END_CLASS
END_NAMESPACE
