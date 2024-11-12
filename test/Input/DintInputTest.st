USING Simatic.Ax.IO.Input;
USING AxUnit;

NAMESPACE Simatic.Ax.IO.Input.Test

    {TestFixture}
    CLASS DintInputTest
        VAR
            o : DintInput;
            oMinMaxTest : DintInput;
        END_VAR


        {Test(signalValue := DINT#0, isValid := FALSE, defaultValue := DINT#0, expectedValueWhenQBad := DINT#0, expectedQBad := TRUE)}
        {Test(signalValue := DINT#0, isValid := FALSE, defaultValue := DINT#1, expectedValueWhenQBad := DINT#1, expectedQBad := TRUE)}
        {Test(signalValue := DINT#0, isValid := TRUE, defaultValue := DINT#0, expectedValueWhenQBad := DINT#0, expectedQBad := FALSE)}
        {Test(signalValue := DINT#0, isValid := TRUE, defaultValue := DINT#1, expectedValueWhenQBad := DINT#0, expectedQBad := FALSE)}

        {Test(signalValue := DINT#100, isValid := FALSE, defaultValue := DINT#0, expectedValueWhenQBad := DINT#0, expectedQBad := TRUE)}
        {Test(signalValue := DINT#100, isValid := FALSE, defaultValue := DINT#1, expectedValueWhenQBad := DINT#1, expectedQBad := TRUE)}
        {Test(signalValue := DINT#100, isValid := TRUE, defaultValue := DINT#0, expectedValueWhenQBad := DINT#100, expectedQBad := FALSE)}
        {Test(signalValue := DINT#100, isValid := TRUE, defaultValue := DINT#1, expectedValueWhenQBad := DINT#100, expectedQBad := FALSE)}
        METHOD PUBLIC Check_different_values_and_results
            VAR_INPUT
                signalValue : DINT;
                isValid : BOOL;
                defaultValue : DINT;
                expectedValueWhenQBad : DINT;
                expectedQBad : BOOL;
            END_VAR
            
            o.ReadCyclic(value := signalValue, valid := isValid, default := defaultValue);  
            Assert.Equal(expected := expectedValueWhenQBad, actual := o.Q());
            Assert.Equal(expected := expectedQBad, actual := o.QBad());
        END_METHOD

        {Test}
        METHOD PUBLIC CheckMinMax  
            Assert.Equal(expected := DINT#-2147483648, actual := oMinMaxTest.Min);
            Assert.Equal(expected := DINT#2147483647, actual := oMinMaxTest.Max);
        END_METHOD

        {Test(signalValue := DINT#100, newSignalValue := DINT#100, expectedHasChanged := FALSE)}
        {Test(signalValue := DINT#100, newSignalValue := DINT#101, expectedHasChanged := TRUE)}
        METHOD PUBLIC CheckHasChanged
            VAR_INPUT
                signalValue : DINT;
                newSignalValue : DINT;
                expectedHasChanged : BOOL;
            END_VAR

            o.ReadCyclic(value := signalValue, valid := TRUE, default := 0);
            o.ReadCyclic(value := newSignalValue, valid := TRUE, default := 0);
            Assert.Equal(expected := expectedHasChanged, actual := o.HasChanged());
        END_METHOD

        {Test(signalValue := DINT#100, newSignalValue := DINT#100, tolerance := DINT#10, expectedHasChanged := FALSE)}
        {Test(signalValue := DINT#100, newSignalValue := DINT#111, tolerance := DINT#10, expectedHasChanged := TRUE)}
        METHOD PUBLIC CheckHasChangedWithTolerance
            VAR_INPUT
                signalValue : DINT;
                newSignalValue : DINT;
                tolerance : DINT;
                expectedHasChanged : BOOL;
            END_VAR

            o.ReadCyclic(value := signalValue, valid := TRUE, default := 0);
            o.ReadCyclic(value := newSignalValue, valid := TRUE, default := 0, tolerance := tolerance);
            Assert.Equal(expected := expectedHasChanged, actual := o.HasChanged());
        END_METHOD
    END_CLASS
END_NAMESPACE