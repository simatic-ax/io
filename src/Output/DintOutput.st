NAMESPACE Siemens.AX.IO.Output
    /// <summary>
    /// Class to handle double integer output values
    /// </summary>
    CLASS DintOutput EXTENDS OutputBase
        VAR
            _actualValue : DINT;
            _oldValue : DINT;
        END_VAR
        
        /// <summary>
        /// Set the value of class DINTOutput
        /// </summary>
        /// <param name="value">Value to set</param>
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : DINT;
            END_VAR
            _actualValue := value;
        END_METHOD

        /// <summary>
        /// Write the value to the periphery. But class can also be uses for none hardware access
        /// </summary>
        /// <param name="Q">The actual value of the DINT output</param>
        METHOD PUBLIC WriteCyclic
            VAR_OUTPUT
                Q : DINT;
            END_VAR
            THIS.HasChanged(value := _actualValue <> _oldValue);
            _oldValue := _actualValue;
            Q:= _actualValue;
        END_METHOD
    END_CLASS
END_NAMESPACE