USING Simatic.Ax.IO.Input;
USING AxUnit;

NAMESPACE Simatic.Ax.IO.Input.Test

    {TestFixture}
    CLASS WordInputTest
        VAR
            o : WordInput;
            oMinMaxTest : WordInput;
        END_VAR


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

        {Test}
        METHOD PUBLIC CheckMinMax  
            AxUnit.Assert.Equal(expected := WORD#16#0, actual := oMinMaxTest.Min);
            AxUnit.Assert.Equal(expected := WORD#16#FFFF, actual := oMinMaxTest.Max);

        END_METHOD
    END_CLASS
END_NAMESPACE