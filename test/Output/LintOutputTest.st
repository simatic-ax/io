USING Simatic.Ax.IO.Output;
USING AxUnit;

NAMESPACE Simatic.Ax.IO.Output.Test

    /// Test fixture for LIntOutput class
    /// Verifies long integer (LINT) output functionality including:
    /// - Setting output values via SetValue()
    /// - Writing values cyclically via WriteCyclic()
    /// - Change detection via HasChanged()
    {TestFixture}
    CLASS TestLIntOutputSetValueClass
        VAR
            o : LIntOutput;  // Test object for LIntOutput
            oHasChanged : LIntOutput;  // Test object for change detection
        END_VAR

        /// Parameterized test for setting and writing LINT output values
        /// Verifies SetValue() and WriteCyclic() work correctly
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

        /// Test change detection functionality
        /// Verifies HasChanged() returns TRUE after value changes
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
