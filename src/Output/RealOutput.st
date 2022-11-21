NAMESPACE Simatic.Ax.IO.Output
    
    /// Class to handle REAL output values
    CLASS RealOutput EXTENDS OutputBase
        VAR
            _actualValue : REAL;
            _oldValue : REAL;
        END_VAR
        
        /// Set the value of class RealOutput
        /// Value to set
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : REAL;
            END_VAR
            _actualValue := value;
        END_METHOD

        
        /// Write the value to the periphery. But class can also be uses for none hardware access
        /// The actual value of the REAL output as DWORD
        METHOD PUBLIC WriteCyclic
            VAR_OUTPUT
                Q : DWORD;
            END_VAR
            THIS.HasChanged(value := _actualValue <> _oldValue);
            _oldValue := _actualValue;
            Q:= TO_DWORD(_actualValue);
        END_METHOD

    END_CLASS
END_NAMESPACE