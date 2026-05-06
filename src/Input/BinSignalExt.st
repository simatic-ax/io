USING System.Timer;
NAMESPACE Simatic.Ax.IO.Input
    
    /// Extended binary signal input handler with configurable on-delay and off-delay timing
    /// Extends BinSignal with time-based filtering to debounce or delay signal transitions
    /// - ondelay: Delays the rising edge (FALSE->TRUE transition)
    /// - offdelay: Delays the falling edge (TRUE->FALSE transition)
    /// Useful for filtering noisy signals or implementing time-based logic
    CLASS BinSignalExt EXTENDS BinSignal
        VAR PUBLIC
            ondelay : TIME; // Delay time for rising edge (FALSE->TRUE), T#0ms = no delay
            offdelay : TIME; // Delay time for falling edge (TRUE->FALSE), T#0ms = no delay
        END_VAR
        VAR PRIVATE
            _ton : OnDelay; // Timer for on-delay functionality
            _toff : OffDelay; // Timer for off-delay functionality
            _signalInOld : BOOL; // Previous signal state for edge detection after delays
        END_VAR

        /// Read digital signal with time-based filtering
        /// Must be executed in every cycle (recommendation: beginning of cycle for digital inputs)
        /// Applies on-delay and off-delay timing to filter signal transitions
        /// signal: Digital/Boolean signal from hardware input
        /// valid: TRUE if signal is valid (periphery OK), FALSE if there's a hardware error
        /// default: Default value to use when valid = FALSE (default: FALSE)
        METHOD PUBLIC OVERRIDE ReadCyclic
            VAR_INPUT
                signal : BOOL;
                valid : BOOL := TRUE;
                default : BOOL := FALSE;
            END_VAR
            VAR_TEMP
                _tonDelayed : BOOL; // Signal after on-delay is applied
                _toffDelayed : BOOL; // Signal after off-delay is applied
            END_VAR

            // Call base class to handle inversion and quality status
            SUPER.ReadCyclic(signal := signal, valid := valid, default := default);
            
            // Apply on-delay: delays rising edge (FALSE->TRUE)
            IF (ondelay > T#0ms) THEN
                _ton(duration := ondelay, signal := _signalInPrefiltered);
                _tonDelayed := _ton.output;
            ELSE
                _tonDelayed := _signalInPrefiltered;
            END_IF;

            // Apply off-delay: delays falling edge (TRUE->FALSE)
            IF (offdelay > T#0ms) THEN
                _toff(duration := offdelay, signal := _signalInPrefiltered);
                _toffDelayed := _toff.output;
            ELSE
                _toffDelayed := _tonDelayed;
            END_IF;
            
            // Combine delayed signals: signal is TRUE if either timer is active
            _statusQ := _tonDelayed OR _toffDelayed;
            
            // Detect edges after delays are applied
            _statusQRis := _statusQ AND NOT(_signalInOld);
            _statusQFal := NOT(_statusQ) AND _signalInOld;
            _signalInOld := _statusQ;
        END_METHOD

    END_CLASS
END_NAMESPACE
