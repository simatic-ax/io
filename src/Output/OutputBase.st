NAMESPACE Simatic.Ax.IO.Output
    
    /// Status of binary output signal
    CLASS OutputBase
        VAR
            _hasChanged : BOOL;
        END_VAR
        
        /// Returns if the value has changed in the last cycle
        /// If the value has changed in the last cycle
        METHOD PUBLIC HasChanged : BOOL
            HasChanged := _hasChanged;
        END_METHOD

        /// Set the status of hasChanged. Must be implemented in the concrete class
        /// TRUE if the value has changed
        METHOD PROTECTED HasChanged
            VAR_INPUT
                value : BOOL;
            END_VAR        
            _hasChanged := true;
        END_METHOD

    END_CLASS
END_NAMESPACE