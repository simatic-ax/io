NAMESPACE Simatic.Ax.IO.Output
    
    /// Class to handle long integer output values 
    CLASS LIntOutput EXTENDS OutputBase
        VAR
            _actualValue : LINT;
            _oldValue : LINT;
        END_VAR
        
        /// Set the value of class LIntOutput
        /// Value to set
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : LINT;
            END_VAR
            _actualValue := value;
        END_METHOD

        
        /// Write the value to the periphery. But class can also be uses for none hardware access
        /// The actual value of the LINT output
        METHOD PUBLIC WriteCyclic
            VAR_OUTPUT
                Q : LINT;
            END_VAR
            THIS.HasChanged(value := _actualValue <> _oldValue);
            _oldValue := _actualValue;
            Q:= _actualValue;
        END_METHOD
    END_CLASS
END_NAMESPACE