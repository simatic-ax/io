NAMESPACE Simatic.Ax.IO.Input
    
    /// Base class for all input signal types
    /// Provides common functionality for quality status (QBad) and change detection
    /// This class should be extended by specific input type implementations
    CLASS InputBase
        VAR PROTECTED
            _isQBad : BOOL; // TRUE: signal is invalid (e.g., periphery error)
            _hasChanged : BOOL; // TRUE: value changed between consecutive reads
        END_VAR

        /// Set the QBad status internally
        /// Used by derived classes to indicate signal validity
        /// value: TRUE if signal is bad/invalid, FALSE if signal is good/valid
        METHOD PROTECTED QBad
            VAR_INPUT
                value : BOOL;
            END_VAR
            _isQBad := value;
        END_METHOD

        /// Returns the QBad status of the input signal
        /// QBad = TRUE indicates the signal is invalid (e.g., when valid parameter in ReadCyclic is FALSE)
        /// QBad = FALSE indicates the signal is valid and can be trusted
        /// RETURN: TRUE if signal is bad/invalid, FALSE if signal is good/valid
        METHOD PUBLIC QBad : BOOL
            QBad := _isQBad;
            ;
        END_METHOD

        /// Returns TRUE if the input value has changed between the current and previous read cycle
        /// Change detection is implemented by derived classes based on their specific data types
        /// RETURN: TRUE if value changed, FALSE if value remained the same
        METHOD PUBLIC HasChanged : BOOL;
            HasChanged := _hasChanged;
        END_METHOD

    END_CLASS
END_NAMESPACE


