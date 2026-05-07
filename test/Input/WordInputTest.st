USING Simatic.Ax.IO.Input;
USING AxUnit;

NAMESPACE Simatic.Ax.IO.Input.Test

    /// Test fixture for WordInput class
    /// Verifies word (WORD) input functionality including:
    /// - Signal reading with valid/invalid status
    /// - Default value handling when signal is invalid
    /// - QBad status management
    /// - Change detection (any bit change triggers)
    /// - MIN/MAX constant values
    {TestFixture}
    CLASS WordInputTest
        VAR
            o : WordInput;  // Test object for WordInput
            oMinMaxTest : WordInput;  // Test object for MIN/MAX verification
        END_VAR

        /// Parameterized test for different signal values and validity combinations
        /// Verifies Q() returns correct value based on validity and QBad() reflects status
        {Test(signalValue := WORD#16#0, isValid := FALSE, defaultValue := WORD#16#0, expectedValueWhenQBad := WORD#16#0, expectedQBad := TRUE)}
        {Test(signalValue := WORD#16#0, isValid := FALSE, defaultValue := WORD#16#1, expectedValueWhenQBad := WORD#16#1, expectedQBad := TRUE)}
        {Test(signalValue := WORD#16#0, isValid := TRUE, defaultValue := WORD#16#0, expectedValueWhenQBad := WORD#16#0, expectedQBad := FALSE)}
        {Test(signalValue := WORD#16#0, isValid := TRUE, defaultValue := WORD#16#1, expectedValueWhenQBad := WORD#16#0, expectedQBad := FALSE)}

        {Test(signalValue := WORD#16#100, isValid := FALSE, defaultValue := WORD#16#0, expectedValueWhenQBad := WORD#16#0, expectedQBad := TRUE)}
        {Test(signalValue := WORD#16#100, isValid := FALSE, defaultValue := WORD#16#1, expectedValueWhenQBad := WORD#16#1, expectedQBad := TRUE)}
        {Test(signalValue := WORD#16#100, isValid := TRUE, defaultValue := WORD#16#0, expectedValueWhenQBad := WORD#16#100, expectedQBad := FALSE)}
        {Test(signalValue := WORD#16#100, isValid := TRUE, defaultValue := WORD#16#1, expectedValueWhenQBad := WORD#16#100, expectedQBad := FALSE)}
        METHOD PUBLIC Check_different_values_and_results
            VAR_INPUT
                signalValue : WORD;
                isValid : BOOL;
                defaultValue : WORD;
                expectedValueWhenQBad : WORD;
                expectedQBad : BOOL;
            END_VAR
            
            o.ReadCyclic(value := signalValue, valid := isValid, default := defaultValue);  
            Assert.Equal(expected := expectedValueWhenQBad, actual := o.Q());
            Assert.Equal(expected := expectedQBad, actual := o.QBad());
        END_METHOD

        /// Test MIN and MAX constants for WORD data type
        {Test}
        METHOD PUBLIC CheckMinMax  
            AxUnit.Assert.Equal(expected := WORD#16#0, actual := oMinMaxTest.Min);
            AxUnit.Assert.Equal(expected := WORD#16#FFFF, actual := oMinMaxTest.Max);

        END_METHOD

        /// Test change detection - triggers on any bit change
        /// Verifies HasChanged() detects any value change
        {Test(signalValue := WORD#100, newSignalValue := WORD#100, expectedHasChanged := FALSE)}
        {Test(signalValue := WORD#100, newSignalValue := WORD#101, expectedHasChanged := TRUE)}
        METHOD PUBLIC CheckHasChanged
            VAR_INPUT
                signalValue : WORD;
                newSignalValue : WORD;
                expectedHasChanged : BOOL;
            END_VAR

            o.ReadCyclic(value := signalValue, valid := TRUE, default := WORD#16#0);
            o.ReadCyclic(value := newSignalValue, valid := TRUE, default := WORD#16#0);
            Assert.Equal(expected := expectedHasChanged, actual := o.HasChanged());
        END_METHOD
    END_CLASS
END_NAMESPACE
