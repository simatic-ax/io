USING Siemens.AX.IO.Output;
USING AxUnit;

NAMESPACE Siemens.AX.IO.Output.Test

    {TestFixture}
    CLASS TestRealOutputSetValueClass
        VAR
            o : RealOutput;
            oHasChanged : RealOutput;
        END_VAR

        // -----------------------------------------------------------
        // test SetQ(value)
        // -----------------------------------------------------------
        {Test(value := REAL#0.0, actual := REAL#0.0)}
        {Test(value := REAL#1.0, actual := REAL#1.0)}
        METHOD PUBLIC TestWordOutputSetValue
            VAR_INPUT
                value : REAL;
                actual : REAL;
            END_VAR
            VAR_TEMP
                _expect : DWORD;
            END_VAR
        
                
            o.SetValue(value := value);
            o.WriteCyclic(Q => _expect);
            Assert.Equal(expected := _expect, actual := TO_DWORD(actual));
        END_METHOD


        {Test}
        METHOD PUBLIC TestRealOutputHasChanged                      
            VAR_TEMP
                value : DWORD;
            END_VAR
            Assert.Equal(FALSE, oHasChanged.HasChanged());
            oHasChanged.SetValue(value := REAL#1.0);
            oHasChanged.WriteCyclic(Q => value);
            Assert.Equal(TRUE, oHasChanged.HasChanged());
        END_METHOD
    END_CLASS
END_NAMESPACE
