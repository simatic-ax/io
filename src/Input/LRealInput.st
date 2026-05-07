USING System.Math;

NAMESPACE Simatic.Ax.IO.Input
    
    /// Long Real (LREAL) floating-point input signal handler with quality monitoring and change detection
    /// Handles 64-bit double precision floating-point input values from hardware or software sources
    /// Range: approximately ±1.8e308 (double precision IEEE 754)
    /// Provides tolerance-based change detection to filter minor fluctuations
    /// Supports reading from LWORD (hardware format) or LREAL (software format)
    CLASS LRealInput EXTENDS InputBase

        VAR PRIVATE
            _value : LREAL := LREAL#0.0; // Current input value
            _default : LREAL := LREAL#0.0; // Default value used when signal is invalid
        END_VAR

        /// Data type limits for LREAL
        VAR CONSTANT PUBLIC
            MAX : LREAL := LREAL#1.79769313486231e+308; // Maximum positive value for LREAL data type
            MIN : LREAL := LREAL#-1.79769313486231e+308; // Maximum negative value for LREAL data type
        END_VAR

        /// Read the long real input value from hardware (LWORD format) cyclically
        /// Must be called every cycle to update the input value and quality status
        /// Converts LWORD bit pattern to LREAL floating-point value
        /// Change detection uses tolerance to avoid triggering on minor fluctuations
        /// value: The LWORD input value from hardware (bit pattern representing LREAL)
        /// valid: TRUE if the input is valid (periphery OK), FALSE if there's a hardware error
        /// default: Default value to use when valid = FALSE (default: LREAL#0.0)
        /// tolerance: Minimum change required to set HasChanged flag (default: LREAL#0.0)
        METHOD PUBLIC ReadCyclic
            VAR_INPUT
                value : LWORD;
                valid : BOOL := TRUE;
                default : LREAL := LREAL#0.0;
                tolerance : LREAL := LREAL#0.0;
            END_VAR

            THIS.QBad(value := NOT(valid));
            _hasChanged := ABS(_value - TO_LREAL(value)) > tolerance;
            _value := TO_LREAL(value);
            _default := default;
        END_METHOD

        /// Read the long real input value from software (LREAL format) cyclically
        /// Must be called every cycle to update the input value and quality status
        /// Change detection uses tolerance to avoid triggering on minor fluctuations
        /// value: The LREAL input value from software source
        /// valid: TRUE if the input is valid, FALSE if there's an error
        /// default: Default value to use when valid = FALSE (default: LREAL#0.0)
        /// tolerance: Minimum change required to set HasChanged flag (default: LREAL#0.0)
        METHOD PUBLIC ReadCyclic
            VAR_INPUT
                value : LREAL;
                valid : BOOL := TRUE;
                default : LREAL := LREAL#0.0;
                tolerance : LREAL := LREAL#0.0;
            END_VAR

            THIS.QBad(value := NOT(valid));
            _hasChanged := ABS(_value - value) > tolerance;
            _value := value;
            _default := default;
        END_METHOD

        /// Returns the current long real floating-point value
        /// If signal quality is good (QBad = FALSE), returns the actual value
        /// If signal quality is bad (QBad = TRUE), returns the default value
        /// RETURN: Current LREAL value or default value if invalid
        METHOD PUBLIC Q : LREAL
            IF (NOT(THIS.QBad())) THEN
                Q := _value;
            ELSE
                Q := _default;
            END_IF;
        END_METHOD

    END_CLASS
END_NAMESPACE
