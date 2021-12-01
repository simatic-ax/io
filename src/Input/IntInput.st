NAMESPACE Siemens.AX.IO.Input
    /// <summary>
    /// Class to handle INT input values 
    /// </summary>
    CLASS IntInput EXTENDS InputBase

        VAR PRIVATE
            _value : INT := 0;
            _default : INT := 0;
        END_VAR
        /// <summary>
        /// The max and min value of datataype int
        /// </summary>
        VAR CONSTANT PUBLIC
            MAX : INT := 32767;
            MIN : INT := -32768;
        END_VAR

        /// <summary>
        /// Read the input value from Input area of type Integer
        /// </summary>
        /// <param name="value">The integer input value</param>
        /// <param name="valid">The input value is valid (e.g. periphery is ok)</param>
        /// <param name="default">Default value if valid = FALSE</param>
        METHOD PUBLIC ReadCyclic
            VAR_INPUT
                value : INT;
                valid : BOOL := TRUE;
                default : INT := 0;
            END_VAR

            THIS.QBad(value := NOT(valid));
            _value := value;
            _default := default;
        END_METHOD

        /// <summary>
        /// Returns the actual value of integer
        /// </summary>
        /// <returns>Actual value of the INT</returns>
        METHOD PUBLIC Q : Int
            IF (NOT(THIS.QBad())) THEN 
                Q := _value;
            ELSE
                Q := _default;
            END_IF;     
        END_METHOD
        
    END_CLASS
END_NAMESPACE
