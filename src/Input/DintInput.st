NAMESPACE Siemens.AX.IO.Input
    /// <summary>
    /// Class to handle DINT input values 
    /// </summary>
    CLASS DintInput EXTENDS InputBase

        VAR PRIVATE
            _value : DINT := DINT#0;
            _default : DINT := DINT#0;
            _qBad : BOOL;
        END_VAR

        /// <summary>
        /// The max and min value of datataype Dint
        /// </summary>
        VAR CONSTANT PUBLIC
            MIN : DINT := DINT#-2147483648;
            MAX : DINT := DINT#2147483647;
        END_VAR

        /// <summary>
        /// Read the input value from Input area of type Double Integer
        /// </summary>
        /// <param name="value">The double integer input value</param>
        /// <param name="valid">The input value is valid (e.g. periphery is ok)</param>
        /// <param name="default">Default value if valid = FALSE</param>
        METHOD PUBLIC ReadCyclic
            VAR_INPUT
                value : DINT;
                valid : BOOL := TRUE;
                default : DINT := DINT#0;
            END_VAR

            THIS.QBad(value := NOT(valid));
            _value := value;
            _default := default;
        END_METHOD

        /// <summary>
        /// Returns the actual value of double integer
        /// </summary>
        /// <returns>Actual value of the DINT</returns>
        METHOD PUBLIC Q : DINT
            IF (NOT(THIS.QBad())) THEN 
                Q := _value;
            ELSE
                Q := _default;
            END_IF;     
        END_METHOD
    END_CLASS
END_NAMESPACE
