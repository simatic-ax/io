USING System.Math;

NAMESPACE Simatic.Ax.IO.Input
    
    /// Integer (INT) input signal handler with quality monitoring and change detection
    /// Handles 16-bit signed integer input values from hardware or software sources
    /// Range: -32768 to 32767
    /// Provides tolerance-based change detection to filter minor fluctuations
    CLASS IntInput EXTENDS InputBase

        VAR PRIVATE
            _value : INT := 0; // Current input value
            _default : INT := 0; // Default value used when signal is invalid
        END_VAR
        
        /// Data type limits for INT
        VAR CONSTANT PUBLIC
            MAX : INT := 32767; // Maximum value for INT data type
            MIN : INT := -32768; // Minimum value for INT data type
        END_VAR

        /// Read the integer input value cyclically
        /// Must be called every cycle to update the input value and quality status
        /// Change detection uses tolerance to avoid triggering on minor fluctuations
        /// value: The INT input value from hardware or software source
        /// valid: TRUE if the input is valid (periphery OK), FALSE if there's a hardware error
        /// default: Default value to use when valid = FALSE (default: 0)
        /// tolerance: Minimum change required to set HasChanged flag (default: 0)
        METHOD PUBLIC ReadCyclic
            VAR_INPUT
                value : INT;
                valid : BOOL := TRUE;
                default : INT := 0;
                tolerance : INT := 0;
            END_VAR

            THIS.QBad(value := NOT(valid));
            _hasChanged := ABS(_value - value) > tolerance;
            _value := value;
            _default := default;
        END_METHOD

        /// Returns the current integer value
        /// If signal quality is good (QBad = FALSE), returns the actual value
        /// If signal quality is bad (QBad = TRUE), returns the default value
        /// RETURN: Current INT value or default value if invalid
        METHOD PUBLIC Q : Int
            IF (NOT(THIS.QBad())) THEN
                Q := _value;
            ELSE
                Q := _default;
            END_IF;
        END_METHOD

    END_CLASS
END_NAMESPACE
