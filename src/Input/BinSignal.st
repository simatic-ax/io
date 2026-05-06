NAMESPACE Simatic.Ax.IO.Input
    
    /// Binary signal input handler with edge detection and inversion support
    /// Provides reading of digital input signals with automatic edge detection (rising/falling)
    /// Supports signal inversion and quality status monitoring
    /// Must be called cyclically via ReadCyclic() method
    CLASS BinSignal EXTENDS InputBase IMPLEMENTS ItfBinSignal
        VAR PUBLIC
            invert : BOOL := FALSE; // When TRUE, inverts the input signal (TRUE becomes FALSE and vice versa)
        END_VAR
        VAR PRIVATE
            _signalInOld : BOOL; // Previous signal state for edge detection
        END_VAR
        VAR PROTECTED
            _signalInPrefiltered : BOOL; // Signal after inversion is applied
            _statusQ : BOOL; // Current signal state
            _statusQRis : BOOL; // TRUE for one cycle when rising edge detected
            _statusQFal : BOOL; // TRUE for one cycle when falling edge detected
        END_VAR

        /// Read the binary input signal cyclically
        /// Must be called every cycle (recommended: at the beginning of the cycle)
        /// Handles signal inversion, edge detection, and quality status
        /// signal: The boolean input value from the hardware input
        /// valid: TRUE if the input is valid (periphery OK), FALSE if there's a hardware error
        /// default: Default value to use when valid = FALSE (default: FALSE)
        METHOD PUBLIC ReadCyclic
            VAR_INPUT
                signal : BOOL;
                valid : BOOL := TRUE;
                default : BOOL := FALSE;
            END_VAR

            // Apply inversion if configured and set quality status
            IF (valid) THEN
                _signalInPrefiltered :=  signal XOR invert;
                THIS.QBad(value := FALSE);
            ELSE
                _signalInPrefiltered := default;
                THIS.QBad(value := TRUE);
            END_IF;

            // Update current status and detect changes
            _statusQ := _signalInPrefiltered;
            _hasChanged := _signalInOld <> _signalInPrefiltered;
            
            // Detect edges: rising (FALSE->TRUE) and falling (TRUE->FALSE)
            _statusQRis := _statusQ AND NOT(_signalInOld);
            _statusQFal := NOT(_statusQ) AND _signalInOld;
            
            // Store current state for next cycle's edge detection
            _signalInOld := _statusQ;
        END_METHOD


        /// Returns whether the signal inversion is active
        /// RETURN: TRUE if signal is inverted, FALSE if signal is not inverted
        METHOD PUBLIC IsInverted : BOOL
            IsInverted := invert;
        END_METHOD

        /// Returns the current state of the binary signal
        /// Takes into account inversion setting and quality status
        /// RETURN: TRUE if signal is active, FALSE if signal is inactive
        METHOD PUBLIC Q : BOOL
            Q := _statusQ;
        END_METHOD

        /// Returns TRUE if a rising edge was detected in the current cycle
        /// Rising edge: transition from FALSE to TRUE (after inversion is applied)
        /// RETURN: TRUE for one cycle after rising edge, otherwise FALSE
        METHOD PUBLIC QRis : BOOL
            QRis := _statusQRis;
        END_METHOD

        /// Returns TRUE if a falling edge was detected in the current cycle
        /// Falling edge: transition from TRUE to FALSE (after inversion is applied)
        /// RETURN: TRUE for one cycle after falling edge, otherwise FALSE
        METHOD PUBLIC QFal : BOOL
            QFal := _statusQFal;
        END_METHOD
    END_CLASS
END_NAMESPACE