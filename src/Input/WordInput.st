NAMESPACE Simatic.Ax.IO.Input
    
    /// Word (WORD) input signal handler with quality monitoring and change detection
    /// Handles 16-bit unsigned word input values from hardware or software sources
    /// Range: 0 (16#0) to 65535 (16#FFFF)
    /// Typically used for bit patterns, status words, or unsigned integer values
    CLASS WordInput EXTENDS InputBase

        VAR PRIVATE
            _value : WORD := WORD#16#0; // Current input value
            _default : WORD := WORD#16#0; // Default value used when signal is invalid
        END_VAR

        /// Data type limits for WORD
        VAR CONSTANT PUBLIC
            MIN : WORD := WORD#16#0; // Minimum value for WORD data type (0)
            MAX : WORD := WORD#16#FFFF; // Maximum value for WORD data type (65535)
        END_VAR

        /// Read the word input value cyclically
        /// Must be called every cycle to update the input value and quality status
        /// Change detection triggers on any bit change
        /// value: The WORD input value from hardware or software source
        /// valid: TRUE if the input is valid (periphery OK), FALSE if there's a hardware error
        /// default: Default value to use when valid = FALSE (default: WORD#16#0)
        METHOD PUBLIC ReadCyclic
            VAR_INPUT
                value : WORD;
                valid : BOOL := TRUE;
                default : WORD := WORD#16#0;
            END_VAR

            THIS.QBad(value := NOT(valid));
            _hasChanged := _value <> value;
            _value := value;
            _default := default;
        END_METHOD

        /// Returns the current word value
        /// If signal quality is good (QBad = FALSE), returns the actual value
        /// If signal quality is bad (QBad = TRUE), returns the default value
        /// RETURN: Current WORD value or default value if invalid
        METHOD PUBLIC Q : WORD
            IF (NOT(THIS.QBad())) THEN
                Q := _value;
            ELSE
                Q := _default;
            END_IF;
        END_METHOD

    END_CLASS
END_NAMESPACE
