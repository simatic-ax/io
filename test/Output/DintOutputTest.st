USING Siemens.AX.IO.Output;
USING AxUnit;

NAMESPACE Siemens.AX.IO.Output.Test

    {TestFixture}
    CLASS TestDIntOutputSetValueClass
        VAR
            o : DIntOutput;
            oHasChanged : DIntOutput;
        END_VAR

        // -----------------------------------------------------------
        // test SetQ(value)
        // -----------------------------------------------------------
        {Test(value := DINT#0, actual := DINT#0)}
        {Test(value := DINT#1, actual := DINT#1)}
        METHOD PUBLIC TestOutputSetValue
            VAR_INPUT
                value : DINT;
                actual : DINT;
            END_VAR
            VAR_TEMP
                _expect : DINT;
            END_VAR
        
                
            o.SetValue(value := value);
            o.WriteCyclic(Q => _expect);
            Assert.Equal(expected := _expect, actual := actual);
        END_METHOD


        {Test}
        METHOD PUBLIC TestOutputHasChanged                      
            VAR_TEMP
                value : DINT;
            END_VAR
            Assert.Equal(FALSE, oHasChanged.HasChanged());
            oHasChanged.SetValue(value := DINT#1);
            oHasChanged.WriteCyclic(Q => value);
            Assert.Equal(TRUE, oHasChanged.HasChanged());
        END_METHOD
    END_CLASS
END_NAMESPACE
