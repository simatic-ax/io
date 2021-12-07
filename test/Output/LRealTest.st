USING Simatic.Ax.IO.Output;
USING AxUnit;

NAMESPACE Simatic.Ax.IO.Output.Test

    {TestFixture}
    CLASS TestLRealOutputSetValueClass
        VAR
            o : LRealOutput;
            oHasChanged : LRealOutput;
        END_VAR

        // -----------------------------------------------------------
        // test SetQ(value)
        // -----------------------------------------------------------
        {Test(value := LREAL#0.0, actual := LREAL#0.0)}
        {Test(value := LREAL#1.0, actual := LREAL#1.0)}
        METHOD PUBLIC TestOutputSetValue
            VAR_INPUT
                value : LREAL;
                actual : LREAL;
            END_VAR
            VAR_TEMP
                _expect : LWORD;
            END_VAR
        
                
            o.SetValue(value := value);
            o.WriteCyclic(Q => _expect);
            Assert.Equal(expected := _expect, actual := TO_LWORD(actual));
        END_METHOD


        {Test}
        METHOD PUBLIC TestOutputHasChanged                      
            VAR_TEMP
                value : LWORD;
            END_VAR
            Assert.Equal(FALSE, oHasChanged.HasChanged());
            oHasChanged.SetValue(value := LREAL#1.0);
            oHasChanged.WriteCyclic(Q => value);
            Assert.Equal(TRUE, oHasChanged.HasChanged());
        END_METHOD
    END_CLASS
END_NAMESPACE
