NAMESPACE Simatic.Ax.IO.Output
    /// <summary>
    /// Class to handle double word output values
    /// </summary>
    CLASS DWordOutput EXTENDS OutputBase
        VAR
            _actualValue : DWORD;
            _oldValue : DWORD;
        END_VAR
        
        
        /// <summary>
        /// Set the value of class DWordOutput
        /// </summary>
        /// <param name="value">Value to set</param>
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : DWORD;
            END_VAR
            _actualValue := value;
        END_METHOD

        /// <summary>
        /// Write the value to the periphery. But class can also be uses for none hardware access
        /// </summary>
        /// <param name="Q">The actual value of the DWORD output</param>
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