USING Siemens.AX.IO.Input;
USING AxUnit;

NAMESPACE Siemens.AX.IO.Input.Test

    {TestFixture}
    CLASS LRealInputTest
        VAR
            o : LRealInput;
            oMinMaxTest : LRealInput;
        END_VAR


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

        {Test}
        METHOD PUBLIC CheckMinMax  
            Assert.Equal(expected := LREAL#1.79769313486231e+308, actual := oMinMaxTest.Max);
            Assert.Equal(expected :=  LREAL#-1.79769313486231e+308, actual := oMinMaxTest.Min);
        END_METHOD
    END_CLASS
END_NAMESPACE
