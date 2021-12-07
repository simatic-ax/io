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
    END_CLASS
END_NAMESPACE