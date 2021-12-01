NAMESPACE Siemens.AX.IO.Output
    /// <summary>
    /// Class to handle long integer output values 
    /// </summary>
    CLASS LIntOutput EXTENDS OutputBase
        VAR
            _actualValue : LINT;
            _oldValue : LINT;
        END_VAR
        
        
        /// <summary>
        /// Set the value of class LIntOutput
        /// </summary>
        /// <param name="value">Value to set</param>
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : LINT;
            END_VAR
            _actualValue := value;
        END_METHOD

        /// <summary>
        /// Write the value to the periphery. But class can also be uses for none hardware access
        /// </summary>
        /// <param name="Q">The actual value of the LINT output</param>
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