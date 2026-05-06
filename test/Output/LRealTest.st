USING Simatic.Ax.IO.Output;
USING AxUnit;

NAMESPACE Simatic.Ax.IO.Output.Test

    /// Test fixture for LRealOutput class
    /// Verifies long real (LREAL) double precision floating-point output functionality including:
    /// - Setting output values via SetValue()
    /// - Writing values cyclically via WriteCyclic() as LWORD bit pattern
    /// - Change detection via HasChanged()
    {TestFixture}
    CLASS TestLRealOutputSetValueClass
        VAR
            o : LRealOutput;  // Test object for LRealOutput
            oHasChanged : LRealOutput;  // Test object for change detection
        END_VAR

        /// Parameterized test for setting and writing LREAL output values
        /// Verifies SetValue() and WriteCyclic() work correctly
        /// Output is converted to LWORD bit pattern for hardware compatibility
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

        /// Test change detection functionality
        /// Verifies HasChanged() returns TRUE after value changes
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
