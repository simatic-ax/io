NAMESPACE Simatic.Ax.IO.Input
    
    /// Class to handle WORD input values  
    CLASS WordInput EXTENDS InputBase

        VAR PRIVATE
            _value : WORD := WORD#16#0;
            _default : WORD := WORD#16#0;
        END_VAR

        
        /// The max and min value of datataype word
        VAR CONSTANT PUBLIC
            MIN : WORD := WORD#16#0;
            MAX : WORD := WORD#16#FFFF;
        END_VAR

        
        /// Read the input value from Input area of type Integer
        /// The integer input value
        /// The input value is valid (e.g. periphery is ok)
        /// Default value if valid = FALSE
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

        
        /// Returns the actual value of integer
        /// Actual value of the WORD input
        METHOD PUBLIC Q : WORD
            IF (NOT(THIS.QBad())) THEN 
                Q := _value;
            ELSE
                Q := _default;
            END_IF;     
        END_METHOD
    END_CLASS
END_NAMESPACE
