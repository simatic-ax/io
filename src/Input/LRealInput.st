NAMESPACE Siemens.AX.IO.Input
    /// <summary>
    /// Class to handle LREAL input values 
    /// </summary>
    CLASS LRealInput EXTENDS InputBase

        VAR PRIVATE
            _value : LREAL := LREAL#0.0;
            _default : LREAL := LREAL#0.0;
        END_VAR

        /// <summary>
        /// The max and min value of datataype LReal
        /// </summary>
        VAR CONSTANT PUBLIC
            MAX : LREAL := LREAL#1.79769313486231e+308;
            MIN : LREAL := LREAL#-1.79769313486231e+308;
        END_VAR

        /// <summary>
        /// Read the input value from Input area of type Real
        /// </summary>
        /// <param name="value">The integer input value</param>
        /// <param name="valid">The input value is valid (e.g. periphery is ok)</param>
        /// <param name="default">Default value if valid = FALSE</param>
        METHOD PUBLIC ReadCyclic
            VAR_INPUT
                value : LWORD;
                valid : BOOL := TRUE;
                default : LREAL := LREAL#0.0;
            END_VAR

            THIS.QBad(value := NOT(valid));
            _value := TO_LREAL(value);
            _default := default;
        END_METHOD

        /// <summary>
        /// Read the input value from Input area of type Real
        /// </summary>
        /// <param name="value">The LREAL input value</param>
        /// <param name="valid">The input value is valid (e.g. periphery is ok)</param>
        /// <param name="default">Default value if valid = FALSE</param>
        METHOD PUBLIC ReadCyclic
            VAR_INPUT
                value : LREAL;
                valid : BOOL := TRUE;
                default : LREAL := LREAL#0.0;
            END_VAR

            THIS.QBad(value := NOT(valid));
            _value := value;
            _default := default;
        END_METHOD

        /// <summary>
        /// Returns the actual value of integer
        /// </summary>
        /// <returns>Actual value of the LREAL input</returns>
        METHOD PUBLIC Q : LREAL
            IF (NOT(THIS.QBad())) THEN 
                Q := _value;
            ELSE
                Q := _default;
            END_IF;     
        END_METHOD
    END_CLASS
END_NAMESPACE
