NAMESPACE Simatic.Ax.IO.Input
    /// Class to handle DINT input values
    CLASS DintInput EXTENDS InputBase

        VAR PRIVATE
            _value : DINT := DINT#0;
            _default : DINT := DINT#0;
            _qBad : BOOL;
        END_VAR

        /// The max and min value of datataype Dint
        VAR CONSTANT PUBLIC
            MIN : DINT := DINT#-2147483648;
            MAX : DINT := DINT#2147483647;
        END_VAR

        /// Read the input value from Input area of type Double Integer
        /// The double integer input value
        /// The input value is valid (e.g. periphery is ok)
        /// Default value if valid = FALSE
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

        /// Returns the actual value of double integer
        /// Actual value of the DINT
        METHOD PUBLIC Q : DINT
            IF (NOT(THIS.QBad())) THEN 
                Q := _value;
            ELSE
                Q := _default;
            END_IF;     
        END_METHOD
    END_CLASS
END_NAMESPACE
