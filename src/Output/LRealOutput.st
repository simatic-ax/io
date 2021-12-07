NAMESPACE Simatic.Ax.IO.Output
    /// <summary>
    /// Class to handle long REAL output values 
    /// </summary>
    CLASS LRealOutput EXTENDS OutputBase
        VAR
            _actualValue : LREAL;
            _oldValue : LREAL;
        END_VAR
        
        
        /// <summary>
        /// Set the value of class LRealOutput
        /// </summary>
        /// <param name="value">Value to set</param>
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : LREAL;
            END_VAR
            _actualValue := value;
        END_METHOD

        /// <summary>
        /// Write the value to the periphery. But class can also be uses for none hardware access
        /// </summary>
        /// <param name="Q">The actual value of the LREAL output as LWORD</param>
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