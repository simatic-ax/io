USING Simatic.Ax.IO.Output;
USING AxUnit;

NAMESPACE Simatic.Ax.IO.Output.Test

    {TestFixture}
    CLASS TestIntOutputSetValueClass
        VAR
            o : IntOutput;
            oHasChanged : IntOutput;
        END_VAR

        // -----------------------------------------------------------
        // test SetQ(value)
        // -----------------------------------------------------------
        {Test(value := 0, actual := 0)}
        {Test(value := 1, actual := 1)}
        METHOD PUBLIC TestOutputSetValue
            VAR_INPUT
                value : INT;
                actual : INT;
            END_VAR
            VAR_TEMP
                _expect : INT;
            END_VAR
        
                
            o.SetValue(value := value);
            o.WriteCyclic(Q => _expect);
            Assert.Equal(expected := _expect, actual := actual);
        END_METHOD


        {Test}
        METHOD PUBLIC TestOutputHasChanged                      
            VAR_TEMP
                value : INT;
            END_VAR
            Assert.Equal(FALSE, oHasChanged.HasChanged());
            oHasChanged.SetValue(value := 1);
            oHasChanged.WriteCyclic(Q => value);
            Assert.Equal(TRUE, oHasChanged.HasChanged());
        END_METHOD
    END_CLASS
END_NAMESPACE
