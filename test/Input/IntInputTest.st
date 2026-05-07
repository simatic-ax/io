USING Simatic.Ax.IO.Input;
USING AxUnit;

NAMESPACE Simatic.Ax.IO.Input.Test

    /// Test fixture for IntInput class
    /// Verifies integer (INT) input functionality including:
    /// - Signal reading with valid/invalid status
    /// - Default value handling when signal is invalid
    /// - QBad status management
    /// - Change detection with and without tolerance
    /// - MIN/MAX constant values
    {TestFixture}
    CLASS IntInputTest
        VAR
            o : IntInput;  // Test object for IntInput
            oMinMaxTest : IntInput;  // Test object for MIN/MAX verification
        END_VAR

        /// Parameterized test for different signal values and validity combinations
        /// Verifies Q() returns correct value based on validity and QBad() reflects status
        {Test(signalValue := INT#0, isValid := FALSE, defaultValue := INT#0, expectedValueWhenQBad := INT#0, expectedQBad := TRUE)}
        {Test(signalValue := INT#0, isValid := FALSE, defaultValue := INT#1, expectedValueWhenQBad := INT#1, expectedQBad := TRUE)}
        {Test(signalValue := INT#0, isValid := TRUE, defaultValue := INT#0, expectedValueWhenQBad := INT#0, expectedQBad := FALSE)}
        {Test(signalValue := INT#0, isValid := TRUE, defaultValue := INT#1, expectedValueWhenQBad := INT#0, expectedQBad := FALSE)}

        {Test(signalValue := INT#100, isValid := FALSE, defaultValue := INT#0, expectedValueWhenQBad := INT#0, expectedQBad := TRUE)}
        {Test(signalValue := INT#100, isValid := FALSE, defaultValue := INT#1, expectedValueWhenQBad := INT#1, expectedQBad := TRUE)}
        {Test(signalValue := INT#100, isValid := TRUE, defaultValue := INT#0, expectedValueWhenQBad := INT#100, expectedQBad := FALSE)}
        {Test(signalValue := INT#100, isValid := TRUE, defaultValue := INT#1, expectedValueWhenQBad := INT#100, expectedQBad := FALSE)}
        METHOD PUBLIC Check_different_values_and_results
            VAR_INPUT
                signalValue : INT;
                isValid : BOOL;
                defaultValue : INT;
                expectedValueWhenQBad : INT;
                expectedQBad : BOOL;
            END_VAR
            
            o.ReadCyclic(value := signalValue, valid := isValid, default := defaultValue);  
            Assert.Equal(expected := expectedValueWhenQBad, actual := o.Q());
            Assert.Equal(expected := expectedQBad, actual := o.QBad());
        END_METHOD

        /// Test MIN and MAX constants for INT data type
        {Test}
        METHOD PUBLIC CheckMinMax
            AxUnit.Assert.Equal(expected := -32768, actual := oMinMaxTest.Min);
            AxUnit.Assert.Equal(expected :=  32767, actual := oMinMaxTest.Max);

        END_METHOD

        /// Test change detection without tolerance
        /// Verifies HasChanged() detects any value change
        {Test(signalValue := INT#100, newSignalValue := INT#100, expectedHasChanged := FALSE)}
        {Test(signalValue := INT#100, newSignalValue := INT#101, expectedHasChanged := TRUE)}
        METHOD PUBLIC CheckHasChanged
            VAR_INPUT
                signalValue : INT;
                newSignalValue : INT;
                expectedHasChanged : BOOL;
            END_VAR

            o.ReadCyclic(value := signalValue, valid := TRUE, default := 0);
            o.ReadCyclic(value := newSignalValue, valid := TRUE, default := 0);
            Assert.Equal(expected := expectedHasChanged, actual := o.HasChanged());
        END_METHOD

        /// Test change detection with tolerance
        /// Verifies HasChanged() only triggers when change exceeds tolerance
        {Test(signalValue := INT#100, newSignalValue := INT#100, tolerance := 10, expectedHasChanged := FALSE)}
        {Test(signalValue := INT#100, newSignalValue := INT#111, tolerance := 10, expectedHasChanged := TRUE)}
        METHOD PUBLIC CheckHasChangedWithTolerance
            VAR_INPUT
                signalValue : INT;
                newSignalValue : INT;
                tolerance : INT;
                expectedHasChanged : BOOL;
            END_VAR

            o.ReadCyclic(value := signalValue, valid := TRUE, default := 0);
            o.ReadCyclic(value := newSignalValue, valid := TRUE, default := 0, tolerance := tolerance);
            Assert.Equal(expected := expectedHasChanged, actual := o.HasChanged());
        END_METHOD
    END_CLASS
END_NAMESPACE