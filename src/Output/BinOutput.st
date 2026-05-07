NAMESPACE Simatic.Ax.IO.Output
    
    /// Binary output signal handler with edge detection
    /// OOP-based approach to handle digital outputs as independent objects
    /// Provides state management, edge detection (switched on/off), and change tracking
    /// Must be called cyclically via WriteCyclic() method
    CLASS BinOutput IMPLEMENTS IBinOutput
        VAR
            _state : BOOL;  // Internal state of the output
            _stateOld : BOOL := FALSE; // Previous state for edge detection
            _switchedOn : BOOL; // TRUE for one cycle when output switches from OFF to ON
            _switchedOff : BOOL; // TRUE for one cycle when output switches from ON to OFF
            _hasChanged : BOOL; // TRUE for one cycle when output state changes
        END_VAR
        
        /// Write the internal state to the digital output hardware
        /// Must be executed every cycle (recommendation: at the end of the cycle)
        /// Updates edge detection flags and outputs the current state
        /// Q: Output parameter containing the current state to be written to hardware
        METHOD PUBLIC WriteCyclic
            VAR_OUTPUT
                Q : BOOL;
            END_VAR
            // Detect edges: switched on (OFF->ON) and switched off (ON->OFF)
            _switchedOn := _state AND NOT(_stateOld);
            _switchedOff := NOT(_state) AND _stateOld;
            _hasChanged := _switchedOn OR _switchedOff;
            
            // Store current state for next cycle's edge detection
            _stateOld := _state;
            
            // Output the current state
            Q:= _state;
        END_METHOD

        /// Set the digital output to a specific boolean value
        /// value: TRUE to turn output on, FALSE to turn output off
        METHOD PUBLIC SetQ
            VAR_INPUT
                value : BOOL;
            END_VAR
            _state := value;
        END_METHOD

        /// Set the digital output to ON (TRUE)
        /// Convenience method equivalent to SetQ(TRUE)
        METHOD PUBLIC SetOn
            _state := TRUE;
        END_METHOD
        
        /// Set the digital output to OFF (FALSE)
        /// Convenience method equivalent to SetQ(FALSE)
        METHOD PUBLIC SetOff
            _state := FALSE;
        END_METHOD
        
        /// Toggle the digital output state
        /// Changes state from OFF to ON or from ON to OFF
        METHOD PUBLIC Toggle
            _state := NOT(_state);
        END_METHOD

        /// Returns the current state of the digital output
        /// RETURN: TRUE if output is on, FALSE if output is off
        METHOD PUBLIC IsOn : BOOL
            IsOn := _state;
        END_METHOD

        /// Returns TRUE if the output value has changed in the current cycle
        /// Change is detected during WriteCyclic() call
        /// RETURN: TRUE for one cycle after state change, otherwise FALSE
        METHOD PUBLIC HasChanged : BOOL
            HasChanged := _hasChanged;
        END_METHOD

        /// Returns TRUE if the output has switched on in the current cycle
        /// Switched on: transition from OFF (FALSE) to ON (TRUE)
        /// RETURN: TRUE for one cycle after switching on, otherwise FALSE
        METHOD PUBLIC HasSwitchedOn : BOOL
            HasSwitchedOn := _switchedOn;
        END_METHOD

        /// Returns TRUE if the output has switched off in the current cycle
        /// Switched off: transition from ON (TRUE) to OFF (FALSE)
        /// RETURN: TRUE for one cycle after switching off, otherwise FALSE
        METHOD PUBLIC HasSwitchedOff : BOOL
            HasSwitchedOff := _switchedOff;
        END_METHOD
        
    END_CLASS
END_NAMESPACE
