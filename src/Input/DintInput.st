USING System.Math;

NAMESPACE Simatic.Ax.IO.Input
    
    /// Double Integer (DINT) input signal handler with quality monitoring and change detection
    /// Handles 32-bit signed integer input values from hardware or software sources
    /// Range: -2,147,483,648 to 2,147,483,647
    /// Provides tolerance-based change detection to filter minor fluctuations
    CLASS DintInput EXTENDS InputBase

        VAR PRIVATE
            _value : DINT := DINT#0; // Current input value
            _default : DINT := DINT#0; // Default value used when signal is invalid
            _qBad : BOOL; // Quality status (unused, inherited from base class)
        END_VAR

        /// Data type limits for DINT
        VAR CONSTANT PUBLIC
            MIN : DINT := DINT#-2147483648; // Minimum value for DINT data type
            MAX : DINT := DINT#2147483647; // Maximum value for DINT data type
        END_VAR

        /// Read the double integer input value cyclically
        /// Must be called every cycle to update the input value and quality status
        /// Change detection uses tolerance to avoid triggering on minor fluctuations
        /// value: The DINT input value from hardware or software source
        /// valid: TRUE if the input is valid (periphery OK), FALSE if there's a hardware error
        /// default: Default value to use when valid = FALSE (default: DINT#0)
        /// tolerance: Minimum change required to set HasChanged flag (default: DINT#0)
        METHOD PUBLIC ReadCyclic
            VAR_INPUT
                value : DINT;
                valid : BOOL := TRUE;
                default : DINT := DINT#0;
                tolerance : DINT := DINT#0;
            END_VAR

            THIS.QBad(value := NOT(valid));
            _hasChanged := ABS(_value - value) > tolerance;
            _value := value;
            _default := default;
        END_METHOD

        /// Returns the current double integer value
        /// If signal quality is good (QBad = FALSE), returns the actual value
        /// If signal quality is bad (QBad = TRUE), returns the default value
        /// RETURN: Current DINT value or default value if invalid
        METHOD PUBLIC Q : DINT
            IF (NOT(THIS.QBad())) THEN
                Q := _value;
            ELSE
                Q := _default;
            END_IF;
        END_METHOD

    END_CLASS
END_NAMESPACE
