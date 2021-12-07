NAMESPACE Simatic.Ax.IO.Input
    /// <summary>
    /// Class to handle WORD input values 
    /// </summary>
    CLASS WordInput EXTENDS InputBase

        VAR PRIVATE
            _value : WORD := WORD#16#0;
            _default : WORD := WORD#16#0;
        END_VAR

        /// <summary>
        /// The max and min value of datataype word
        /// </summary>
        VAR CONSTANT PUBLIC
            MIN : WORD := WORD#16#0;
            MAX : WORD := WORD#16#FFFF;
        END_VAR

        /// <summary>
        /// Read the input value from Input area of type Integer
        /// </summary>
        /// <param name="value">The integer input value</param>
        /// <param name="valid">The input value is valid (e.g. periphery is ok)</param>
        /// <param name="default">Default value if valid = FALSE</param>
        METHOD PUBLIC ReadCyclic
            VAR_INPUT
                value : WORD;
                valid : BOOL := TRUE;
                default : WORD := WORD#16#0;
            END_VAR

            THIS.QBad(value := NOT(valid));
            _value := value;
            _default := default;
        END_METHOD

        /// <summary>
        /// Returns the actual value of integer
        /// </summary>
        /// <returns>Actual value of the WORD input</returns>
        METHOD PUBLIC Q : WORD
            IF (NOT(THIS.QBad())) THEN 
                Q := _value;
            ELSE
                Q := _default;
            END_IF;     
        END_METHOD
    END_CLASS
END_NAMESPACE
