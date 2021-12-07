USING Simatic.Ax.IO.Output;
USING AxUnit;

NAMESPACE Simatic.Ax.IO.Output.Test

    {TestFixture}
    CLASS TestLIntOutputSetValueClass
        VAR
            o : LIntOutput;
            oHasChanged : LIntOutput;
        END_VAR

        // -----------------------------------------------------------
        // test SetQ(value)
        // -----------------------------------------------------------
        {Test(value := LINT#0, actual := LINT#0)}
        {Test(value := LINT#1, actual := LINT#1)}
        METHOD PUBLIC TestOutputSetValue
            VAR_INPUT
                value : LINT;
                actual : LINT;
            END_VAR
            VAR_TEMP
                _expect : LINT;
            END_VAR
        
                
            o.SetValue(value := value);
            o.WriteCyclic(Q => _expect);
            Assert.Equal(expected := _expect, actual := actual);
        END_METHOD


        {Test}
        METHOD PUBLIC TestOutputHasChanged                      
            VAR_TEMP
                value : LINT;
            END_VAR
            Assert.Equal(FALSE, oHasChanged.HasChanged());
            oHasChanged.SetValue(value := LINT#1);
            oHasChanged.WriteCyclic(Q => value);
            Assert.Equal(TRUE, oHasChanged.HasChanged());
        END_METHOD
    END_CLASS
END_NAMESPACE
