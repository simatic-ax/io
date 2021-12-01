USING Siemens.AX.IO.Output;
USING AxUnit;

NAMESPACE Siemens.AX.IO.Output.Test

    {TestFixture}
    CLASS TestWordOutputSetValueClass
        VAR
            o : WordOutput;
            oHasChanged : WordOutput;
        END_VAR

        // -----------------------------------------------------------
        // test SetQ(value)
        // -----------------------------------------------------------
        {Test(value := WORD#16#0, actual := WORD#16#0)}
        {Test(value := WORD#16#1, actual := WORD#16#1)}
        METHOD PUBLIC TestOutputSetValue
            VAR_INPUT
                value : WORD;
                actual : WORD;
            END_VAR
            VAR_TEMP
                _expect : WORD;
            END_VAR
        
                
            o.SetValue(value := value);
            o.WriteCyclic(Q => _expect);
            Assert.Equal(expected := _expect, actual := actual);
        END_METHOD


        {Test}
        METHOD PUBLIC TestOutputHasChanged                      
            VAR_TEMP
                value : Word;
            END_VAR
            Assert.Equal(FALSE, oHasChanged.HasChanged());
            oHasChanged.SetValue(value := WORD#1);
            oHasChanged.WriteCyclic(Q => value);
            Assert.Equal(TRUE, oHasChanged.HasChanged());
        END_METHOD
    END_CLASS
END_NAMESPACE
