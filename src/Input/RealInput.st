NAMESPACE Siemens.AX.IO.Input
    /// <summary>
    /// Class to handle REAL input values 
    /// </summary>
    CLASS RealInput EXTENDS InputBase

        VAR PRIVATE
            _value : REAL := REAL#0.0;
            _default : REAL := REAL#0.0;
        END_VAR

        /// <summary>
        /// The max and min value of datataype LReal
        /// </summary>
        VAR CONSTANT PUBLIC
            MAX : REAL := REAL#+3.402823e+38;
            MIN : REAL := REAL#-3.402823e+38;
        END_VAR

        /// <summary>
        /// Read the input value from Input area of type Real
        /// </summary>
        /// <param name="value">The integer input value</param>
        /// <param name="valid">The input value is valid (e.g. periphery is ok)</param>
        /// <param name="default">Default value if valid = FALSE</param>
        METHOD PUBLIC ReadCyclic
            VAR_INPUT
                value : DWORD;
                valid : BOOL := TRUE;
                default : REAL := REAL#0.0;
            END_VAR

            THIS.QBad(value := NOT(valid));
            _value := TO_REAL(value);
            _default := default;
        END_METHOD

        /// <summary>
        /// Returns the actual value of integer
        /// </summary>
        /// <returns>Actual value of the REAL input</returns>
        METHOD PUBLIC Q : REAL
            IF (NOT(THIS.QBad())) THEN 
                Q := _value;
            ELSE
                Q := _default;
            END_IF;     
        END_METHOD

    END_CLASS
END_NAMESPACE
