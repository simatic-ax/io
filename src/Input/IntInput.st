NAMESPACE Simatic.Ax.IO.Input
    /// Class to handle INT input values 
    CLASS IntInput EXTENDS InputBase

        VAR PRIVATE
            _value : INT := 0;
            _default : INT := 0;
        END_VAR
        /// The max and min value of datataype int
        VAR CONSTANT PUBLIC
            MAX : INT := 32767;
            MIN : INT := -32768;
        END_VAR

        /// Read the input value from Input area of type Integer
        /// The integer input value
        /// The input value is valid (e.g. periphery is ok)
        /// Default value if valid = FALSE
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

        /// Returns the actual value of integer
        /// Actual value of the INT
        METHOD PUBLIC Q : Int
            IF (NOT(THIS.QBad())) THEN 
                Q := _value;
            ELSE
                Q := _default;
            END_IF;     
        END_METHOD
        
    END_CLASS
END_NAMESPACE
