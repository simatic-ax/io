NAMESPACE Simatic.Ax.IO.Output
    
    /// Base class for all output signal types
    /// Provides common functionality for change detection
    /// This class should be extended by specific output type implementations
    CLASS OutputBase
        VAR
            _hasChanged : BOOL; // TRUE: value changed in the last cycle
        END_VAR
        
        /// Returns TRUE if the output value has changed in the last cycle
        /// Change detection is updated during WriteCyclic() calls
        /// RETURN: TRUE if value changed, FALSE if value remained the same
        METHOD PUBLIC HasChanged : BOOL
            HasChanged := _hasChanged;
        END_METHOD

        /// Set the change detection status internally
        /// Used by derived classes to indicate when output value has changed
        /// Must be called by derived classes in their WriteCyclic() method
        /// value: TRUE if the value has changed, FALSE otherwise
        METHOD PROTECTED HasChanged
            VAR_INPUT
                value : BOOL;
            END_VAR
            _hasChanged := true;
        END_METHOD

    END_CLASS
END_NAMESPACE