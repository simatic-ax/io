USING Simatic.Ax.IO.Output;
USING AxUnit;

NAMESPACE Simatic.Ax.IO.Output.Test

    /// Test fixture for DWordOutput class
    /// Verifies double word (DWORD) output functionality including:
    /// - Setting output values via SetValue()
    /// - Writing values cyclically via WriteCyclic()
    /// - Change detection via HasChanged()
    {TestFixture}
    CLASS TestDWordOutputSetValueClass
        VAR
            o : DWordOutput;  // Test object for DWordOutput
            oHasChanged : DWordOutput;  // Test object for change detection
        END_VAR

        /// Parameterized test for setting and writing DWORD output values
        /// Verifies SetValue() and WriteCyclic() work correctly
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

        /// Test change detection functionality
        /// Verifies HasChanged() returns TRUE after value changes
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
