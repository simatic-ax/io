NAMESPACE Simatic.Ax.IO.Output
    
    /// Class to handle double integer output values
    
    CLASS DintOutput EXTENDS OutputBase
        VAR
            _actualValue : DINT;
            _oldValue : DINT;
        END_VAR
        
        
        /// Set the value of class DINTOutput
        /// Value to set
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : DINT;
            END_VAR
            _actualValue := value;
        END_METHOD

        
        /// Write the value to the periphery. But class can also be uses for none hardware access
        /// The actual value of the DINT output
        METHOD PUBLIC WriteCyclic
            VAR_OUTPUT
                Q : DINT;
            END_VAR
            THIS.HasChanged(value := _actualValue <> _oldValue);
            _oldValue := _actualValue;
            Q:= _actualValue;
        END_METHOD
    END_CLASS
END_NAMESPACE