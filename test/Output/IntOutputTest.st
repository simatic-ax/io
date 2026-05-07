USING Simatic.Ax.IO.Output;
USING AxUnit;

NAMESPACE Simatic.Ax.IO.Output.Test

    /// Test fixture for IntOutput class
    /// Verifies integer (INT) output functionality including:
    /// - Setting output values via SetValue()
    /// - Writing values cyclically via WriteCyclic()
    /// - Change detection via HasChanged()
    {TestFixture}
    CLASS TestIntOutputSetValueClass
        VAR
            o : IntOutput;  // Test object for IntOutput
            oHasChanged : IntOutput;  // Test object for change detection
        END_VAR

        /// Parameterized test for setting and writing INT output values
        /// Verifies SetValue() and WriteCyclic() work correctly
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


        /// Test change detection functionality
        /// Verifies HasChanged() returns TRUE after value changes
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
