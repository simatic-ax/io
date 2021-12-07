NAMESPACE Simatic.Ax.IO.Output
    /// <summary>
    /// Class to handle WORD output values
    /// </summary>
    CLASS WordOutput EXTENDS OutputBase
        VAR
            _actualValue : WORD;
            _oldValue : WORD;
        END_VAR
        
        
        /// <summary>
        /// Set the value of class WordOutput
        /// </summary>
        /// <param name="value">Value to set</param>
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : WORD;
            END_VAR
            _actualValue := value;
        END_METHOD

        /// <summary>
        /// Write the value to the periphery. But class can also be uses for none hardware access
        /// </summary>
        /// <param name="Q">The actual value of the WORD output</param>
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