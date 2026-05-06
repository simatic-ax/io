USING System.Math;

NAMESPACE Simatic.Ax.IO.Input
    
    /// Real (REAL) floating-point input signal handler with quality monitoring and change detection
    /// Handles 32-bit floating-point input values from hardware or software sources
    /// Range: approximately ±3.4e38 (single precision IEEE 754)
    /// Provides tolerance-based change detection to filter minor fluctuations
    /// Supports reading from DWORD (hardware format) or REAL (software format)
    CLASS RealInput EXTENDS InputBase

        VAR PRIVATE
            _value : REAL := REAL#0.0; // Current input value
            _default : REAL := REAL#0.0; // Default value used when signal is invalid
        END_VAR

        /// Data type limits for REAL
        VAR CONSTANT PUBLIC
            MAX : REAL := REAL#+3.402823e+38; // Maximum positive value for REAL data type
            MIN : REAL := REAL#-3.402823e+38; // Maximum negative value for REAL data type
        END_VAR
        
        /// Read the real input value from hardware (DWORD format) cyclically
        /// Must be called every cycle to update the input value and quality status
        /// Converts DWORD bit pattern to REAL floating-point value
        /// Change detection uses tolerance to avoid triggering on minor fluctuations
        /// value: The DWORD input value from hardware (bit pattern representing REAL)
        /// valid: TRUE if the input is valid (periphery OK), FALSE if there's a hardware error
        /// default: Default value to use when valid = FALSE (default: REAL#0.0)
        /// tolerance: Minimum change required to set HasChanged flag (default: REAL#0.0)
        METHOD PUBLIC ReadCyclic
            VAR_INPUT
                value : DWORD;
                valid : BOOL := TRUE;
                default : REAL := REAL#0.0;
                tolerance : REAL := REAL#0.0;
            END_VAR

            THIS.QBad(value := NOT(valid));
            _hasChanged := ABS(_value - TO_REAL(value)) > tolerance;
            _value := TO_REAL(value);
            _default := default;
        END_METHOD

        /// Read the real input value from software (REAL format) cyclically
        /// Must be called every cycle to update the input value and quality status
        /// Change detection uses tolerance to avoid triggering on minor fluctuations
        /// value: The REAL input value from software source
        /// valid: TRUE if the input is valid, FALSE if there's an error
        /// default: Default value to use when valid = FALSE (default: REAL#0.0)
        /// tolerance: Minimum change required to set HasChanged flag (default: REAL#0.0)
        METHOD PUBLIC ReadCyclic
            VAR_INPUT
                value : REAL;
                valid : BOOL := TRUE;
                default : REAL := REAL#0.0;
                tolerance : REAL := REAL#0.0;
            END_VAR

            THIS.QBad(value := NOT(valid));
            _hasChanged := ABS(_value - value) > tolerance;
            _value := value;
            _default := default;
        END_METHOD

        /// Returns the current real floating-point value
        /// If signal quality is good (QBad = FALSE), returns the actual value
        /// If signal quality is bad (QBad = TRUE), returns the default value
        /// RETURN: Current REAL value or default value if invalid
        METHOD PUBLIC Q : REAL
            IF (NOT(THIS.QBad())) THEN
                Q := _value;
            ELSE
                Q := _default;
            END_IF;
        END_METHOD

    END_CLASS
END_NAMESPACE
