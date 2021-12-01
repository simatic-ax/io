NAMESPACE Siemens.AX.IO.Output
    /// <summary>
    /// Class BinOutput
    /// An OOP concept to handle digital outputs as a own object
    /// </summary>
    CLASS BinOutput IMPLEMENTS IBinOutput         
        VAR
            _state : BOOL;  // internal status 
            _stateOld : BOOL := FALSE;
            _switchedOn : BOOL;
            _switchedOff : BOOL;
            _hasChanged : BOOL;
        END_VAR
        
        /// <summary>
        /// Write the internal state to the digital output
        /// (must be executed in every cycle - recommendation end of cycle)
        /// </summary>
        /// <param name="Q">The internal state of the digital output</param>
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

        /// <summary>
        /// Set the digital output to "value"
        /// </summary>
        /// <param name="value">Value to set</param>
        METHOD PUBLIC SetQ
            VAR_INPUT
                value : BOOL;
            END_VAR
            _state := value;
        END_METHOD

        /// <summary>
        /// Set the digital output to "TRUE"
        /// </summary>
        METHOD PUBLIC SetOn
            _state := TRUE;
        END_METHOD
        
        /// <summary>
        /// Set the digital output to "off"
        /// </summary>
        METHOD PUBLIC SetOff
            _state := FALSE;
        END_METHOD
        
        /// <summary>
        ///  Toggle the digital output to off-->on-->off
        /// </summary>
        METHOD PUBLIC Toggle
            _state := NOT(_state);
        END_METHOD

        /// <summary>
        /// Returns the status of the digital output
        /// </summary>
        /// <returns>The status of the digital output</returns>
        METHOD PUBLIC IsOn : BOOL
            IsOn := _state;
        END_METHOD

        /// <summary>
        /// Returns TRUE if the value has changed
        /// </summary>
        /// <returns>TRUE if the value has changed</returns>
        METHOD PUBLIC HasChanged : BOOL
            HasChanged := _hasChanged;
        END_METHOD

        /// <summary>
        /// Returns TRUE if the value has switched on
        /// </summary>
        /// <returns>TRUE if the value has switched on</returns>
        METHOD PUBLIC HasSwitchedOn : BOOL
            HasSwitchedOn := _switchedOn;
        END_METHOD

        /// <summary>
        /// Returns TRUE if the value has switched off
        /// </summary>
        /// <returns>TRUE if the value has switched off</returns>
        METHOD PUBLIC HasSwitchedOff : BOOL
            HasSwitchedOff := _switchedOff;
        END_METHOD
        
    END_CLASS
END_NAMESPACE
