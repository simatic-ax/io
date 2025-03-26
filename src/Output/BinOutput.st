NAMESPACE Simatic.Ax.IO.Output
    
    /// Class BinOutput
    /// An OOP concept to handle digital outputs as a own object
    CLASS BinOutput IMPLEMENTS ItfBinOutput         
        VAR
            _state : BOOL;  // internal status 
            _stateOld : BOOL := FALSE;
            _switchedOn : BOOL;
            _switchedOff : BOOL;
            _hasChanged : BOOL;
        END_VAR
        
        
        /// Write the internal state to the digital output
        /// (must be executed in every cycle - recommendation end of cycle)
        /// The internal state of the digital output
        METHOD PUBLIC WriteCyclic
            VAR_OUTPUT
                Q : BOOL;
            END_VAR            
            _switchedOn := _state AND NOT(_stateOld);
            _switchedOff := NOT(_state) AND _stateOld;
            _hasChanged := _switchedOn OR _switchedOff;
            _stateOld := _state;
            Q:= _state;

        END_METHOD

        
        /// Set the digital output to "value"
        /// Value to set
        METHOD PUBLIC SetQ
            VAR_INPUT
                value : BOOL;
            END_VAR
            _state := value;
        END_METHOD

        
        /// Set the digital output to "TRUE"
        METHOD PUBLIC SetOn
            _state := TRUE;
        END_METHOD
        
        
        /// Set the digital output to "off"
        METHOD PUBLIC SetOff
            _state := FALSE;
        END_METHOD
        
        
        /// Toggle the digital output to off-->on-->off
        METHOD PUBLIC Toggle
            _state := NOT(_state);
        END_METHOD

        
        /// Returns the status of the digital output
        /// The status of the digital output
        METHOD PUBLIC IsOn : BOOL
            IsOn := _state;
        END_METHOD

        
        /// Returns TRUE if the value has changed
        /// TRUE if the value has changed
        METHOD PUBLIC HasChanged : BOOL
            HasChanged := _hasChanged;
        END_METHOD

        
        /// Returns TRUE if the value has switched on
        /// TRUE if the value has switched on
        METHOD PUBLIC HasSwitchedOn : BOOL
            HasSwitchedOn := _switchedOn;
        END_METHOD

        
        /// Returns TRUE if the value has switched off
        /// TRUE if the value has switched off
        METHOD PUBLIC HasSwitchedOff : BOOL
            HasSwitchedOff := _switchedOff;
        END_METHOD
        
    END_CLASS
END_NAMESPACE
