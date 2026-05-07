USING Simatic.Ax.IO.Output;
USING AxUnit;

NAMESPACE Simatic.Ax.IO.Output.Test

    /// Test fixture for RealOutput class
    /// Verifies real (REAL) floating-point output functionality including:
    /// - Setting output values via SetValue()
    /// - Writing values cyclically via WriteCyclic() as DWORD bit pattern
    /// - Change detection via HasChanged()
    {TestFixture}
    CLASS TestRealOutputSetValueClass
        VAR
            o : RealOutput;  // Test object for RealOutput
            oHasChanged : RealOutput;  // Test object for change detection
        END_VAR

        /// Parameterized test for setting and writing REAL output values
        /// Verifies SetValue() and WriteCyclic() work correctly
        /// Output is converted to DWORD bit pattern for hardware compatibility
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

        /// Test change detection functionality
        /// Verifies HasChanged() returns TRUE after value changes
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
