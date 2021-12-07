USING Simatic.Ax.IO.Input;
USING AxUnit;

NAMESPACE Simatic.Ax.IO.Input.Test

    {TestFixture}
    CLASS RealInputTest
        VAR
            o : RealInput;
            oMinMaxTest : RealInput;
        END_VAR


        {Test(signalValue := REAL#0.0, isValid := FALSE, defaultValue := REAL#0.0, expectedValueWhenQBad := REAL#0.0, expectedQBad := TRUE)}
        {Test(signalValue := REAL#0.0, isValid := FALSE, defaultValue := REAL#1.0, expectedValueWhenQBad := REAL#1.0, expectedQBad := TRUE)}
        {Test(signalValue := REAL#0.0, isValid := TRUE, defaultValue := REAL#0.0, expectedValueWhenQBad := REAL#0.0, expectedQBad := FALSE)}
        {Test(signalValue := REAL#0.0, isValid := TRUE, defaultValue := REAL#1.0, expectedValueWhenQBad := REAL#0.0, expectedQBad := FALSE)}

        {Test(signalValue := REAL#100.0, isValid := FALSE, defaultValue := REAL#0.0, expectedValueWhenQBad := REAL#0.0, expectedQBad := TRUE)}
        {Test(signalValue := REAL#100.0, isValid := FALSE, defaultValue := REAL#1.0, expectedValueWhenQBad := REAL#1.0, expectedQBad := TRUE)}
        {Test(signalValue := REAL#100.0, isValid := TRUE, defaultValue := REAL#0.0, expectedValueWhenQBad := REAL#100.0, expectedQBad := FALSE)}
        {Test(signalValue := REAL#100.0, isValid := TRUE, defaultValue := REAL#1.0, expectedValueWhenQBad := REAL#100.0, expectedQBad := FALSE)}
        METHOD PUBLIC Check_different_values_and_results
            VAR_INPUT
                signalValue : REAL;
                isValid : BOOL;
                defaultValue : REAL;
                expectedValueWhenQBad : REAL;
                expectedQBad : BOOL;
            END_VAR
            
            o.ReadCyclic(value := TO_DWORD(signalValue), valid := isValid, default := defaultValue);  
            Assert.Equal(expected := expectedValueWhenQBad, actual := o.Q());
            Assert.Equal(expected := expectedQBad, actual := o.QBad());
        END_METHOD

        {Test}
        METHOD PUBLIC CheckMinMax  
            Assert.Equal(expected := REAL#+3.402823e+38, actual := oMinMaxTest.Max);
            Assert.Equal(expected :=  REAL#-3.402823e+38, actual := oMinMaxTest.Min);
        END_METHOD
    END_CLASS
END_NAMESPACE

