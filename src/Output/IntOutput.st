NAMESPACE Siemens.AX.IO.Output
    /// <summary>
    /// Class to handle integer output values
    /// </summary>
    CLASS IntOutput EXTENDS OutputBase
        VAR
            _actualValue : INT;
            _oldValue : INT;
        END_VAR
        
        
        /// <summary>
        /// Set the value of class IntOutput
        /// </summary>
        /// <param name="value">Value to set</param>
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : INT;
            END_VAR
            _actualValue := value;
        END_METHOD

        /// <summary>
        /// Write the value to the periphery. But class can also be uses for none hardware access
        /// </summary>
        /// <param name="Q">The actual value of the INT output</param>
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