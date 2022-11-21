NAMESPACE Simatic.Ax.IO.Output
    
    /// Class to handle long REAL output values 
    CLASS LRealOutput EXTENDS OutputBase
        VAR
            _actualValue : LREAL;
            _oldValue : LREAL;
        END_VAR
        
        /// Set the value of class LRealOutput
        /// Value to set
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : LREAL;
            END_VAR
            _actualValue := value;
        END_METHOD

        /// Write the value to the periphery. But class can also be uses for none hardware access
        /// The actual value of the LREAL output as LWORD
        METHOD PUBLIC WriteCyclic
            VAR_OUTPUT
                Q : LWORD;
            END_VAR
            THIS.HasChanged(value := _actualValue <> _oldValue);
            _oldValue := _actualValue;
            Q:= TO_LWORD(_actualValue);
        END_METHOD

    END_CLASS
END_NAMESPACE