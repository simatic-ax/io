NAMESPACE Siemens.AX.IO.Output
    /// <summary>
    /// Class to handle REAL output values
    /// </summary>
    CLASS RealOutput EXTENDS OutputBase
        VAR
            _actualValue : REAL;
            _oldValue : REAL;
        END_VAR
        
        
        /// <summary>
        /// Set the value of class RealOutput
        /// </summary>
        /// <param name="value">Value to set</param>
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : REAL;
            END_VAR
            _actualValue := value;
        END_METHOD

        /// <summary>
        /// Write the value to the periphery. But class can also be uses for none hardware access
        /// </summary>
        /// <param name="Q">The actual value of the REAL output as DWORD</param>
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