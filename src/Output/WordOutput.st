NAMESPACE Simatic.Ax.IO.Output
    
    /// Class to handle WORD output values
    CLASS WordOutput EXTENDS OutputBase
        VAR
            _actualValue : WORD;
            _oldValue : WORD;
        END_VAR
        
        /// Set the value of class WordOutput
        /// Value to set
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : WORD;
            END_VAR
            _actualValue := value;
        END_METHOD

        /// Write the value to the periphery. But class can also be uses for none hardware access
        /// The actual value of the WORD output
        METHOD PUBLIC WriteCyclic
            VAR_OUTPUT
                Q : WORD;
            END_VAR
            THIS.HasChanged(value := _actualValue <> _oldValue);
            _oldValue := _actualValue;
            Q:= _actualValue;
        END_METHOD
    END_CLASS
END_NAMESPACE