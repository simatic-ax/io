NAMESPACE Simatic.Ax.IO.Output
    
    /// Class to handle integer output values
    CLASS IntOutput EXTENDS OutputBase
        VAR
            _actualValue : INT;
            _oldValue : INT;
        END_VAR
        
        /// Set the value of class IntOutput
        /// Value to set
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : INT;
            END_VAR
            _actualValue := value;
        END_METHOD

        
        /// Write the value to the periphery. But class can also be uses for none hardware access
        /// The actual value of the INT output
        METHOD PUBLIC WriteCyclic
            VAR_OUTPUT
                Q : INT;
            END_VAR
            THIS.HasChanged(value := _actualValue <> _oldValue);
            _oldValue := _actualValue;
            Q:= _actualValue;
        END_METHOD
    END_CLASS
END_NAMESPACE