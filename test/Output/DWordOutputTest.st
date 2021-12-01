USING Siemens.AX.IO.Output;
USING AxUnit;

NAMESPACE Siemens.AX.IO.Output.Test

    {TestFixture}
    CLASS TestDWordOutputSetValueClass
        VAR
            o : DWordOutput;
            oHasChanged : DWordOutput;
        END_VAR

        // -----------------------------------------------------------
        // test SetQ(value)
        // -----------------------------------------------------------
        {Test(value := DWORD#16#0, actual := DWORD#16#0)}
        {Test(value := DWORD#16#1, actual := DWORD#16#1)}
        METHOD PUBLIC TestOutputSetValue
            VAR_INPUT
                value : DWORD;
                actual : DWORD;
            END_VAR
            VAR_TEMP
                _expect : DWORD;
            END_VAR
        
                
            o.SetValue(value := value);
            o.WriteCyclic(Q => _expect);
            Assert.Equal(expected := _expect, actual := actual);
        END_METHOD


        {Test}
        METHOD PUBLIC TestOutputHasChanged                      
            VAR_TEMP
                value : DWORD;
            END_VAR
            Assert.Equal(FALSE, oHasChanged.HasChanged());
            oHasChanged.SetValue(value := DWORD#1);
            oHasChanged.WriteCyclic(Q => value);
            Assert.Equal(TRUE, oHasChanged.HasChanged());
        END_METHOD
    END_CLASS
END_NAMESPACE
