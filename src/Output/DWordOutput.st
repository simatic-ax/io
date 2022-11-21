NAMESPACE Simatic.Ax.IO.Output
    
    /// Class to handle double word output values
    CLASS DWordOutput EXTENDS OutputBase
        VAR
            _actualValue : DWORD;
            _oldValue : DWORD;
        END_VAR
        
        /// Set the value of class DWordOutput
        /// Value to set
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : DWORD;
            END_VAR
            _actualValue := value;
        END_METHOD

        /// Write the value to the periphery. But class can also be uses for none hardware access
        /// The actual value of the DWORD output
        METHOD PUBLIC WriteCyclic
            VAR_OUTPUT
                Q : DWORD;
            END_VAR
            THIS.HasChanged(value := _actualValue <> _oldValue);
            _oldValue := _actualValue;
            Q:= _actualValue;
        END_METHOD
    END_CLASS
END_NAMESPACE