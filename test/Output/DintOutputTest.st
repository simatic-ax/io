USING Simatic.Ax.IO.Output;
USING AxUnit;

NAMESPACE Simatic.Ax.IO.Output.Test

    /// Test fixture for DintOutput class
    /// Verifies double integer (DINT) output functionality including:
    /// - Setting output values via SetValue()
    /// - Writing values cyclically via WriteCyclic()
    /// - Change detection via HasChanged()
    {TestFixture}
    CLASS TestDIntOutputSetValueClass
        VAR
            o : DIntOutput;  // Test object for DintOutput
            oHasChanged : DIntOutput;  // Test object for change detection
        END_VAR

        /// Parameterized test for setting and writing DINT output values
        /// Verifies SetValue() and WriteCyclic() work correctly
        {Test(value := DINT#0, actual := DINT#0)}
        {Test(value := DINT#1, actual := DINT#1)}
        METHOD PUBLIC TestOutputSetValue
            VAR_INPUT
                value : DINT;
                actual : DINT;
            END_VAR
            VAR_TEMP
                _expect : DINT;
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
                value : DINT;
            END_VAR
            Assert.Equal(FALSE, oHasChanged.HasChanged());
            oHasChanged.SetValue(value := DINT#1);
            oHasChanged.WriteCyclic(Q => value);
            Assert.Equal(TRUE, oHasChanged.HasChanged());
        END_METHOD
    END_CLASS
END_NAMESPACE
