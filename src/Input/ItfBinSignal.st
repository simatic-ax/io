NAMESPACE Simatic.Ax.IO.Input

    /// Interface for binary signal input handling
    /// Defines the contract for reading binary input signals with edge detection and quality status
    /// Implementations provide access to signal state, rising/falling edges, and validity information
    INTERFACE ItfBinSignal
        
        /// Returns the current state of the binary signal
        /// RETURN: TRUE if signal is active, FALSE if signal is inactive
        METHOD Q : BOOL
        END_METHOD
        
        /// Returns TRUE if a rising edge was detected in the current cycle
        /// Rising edge: transition from FALSE to TRUE
        /// RETURN: TRUE for one cycle after rising edge, otherwise FALSE
        METHOD QRis : BOOL
        END_METHOD
        
        /// Returns TRUE if a falling edge was detected in the current cycle
        /// Falling edge: transition from TRUE to FALSE
        /// RETURN: TRUE for one cycle after falling edge, otherwise FALSE
        METHOD QFal : BOOL
        END_METHOD
        
        /// Returns the quality status of the signal
        /// RETURN: TRUE if signal is invalid/bad, FALSE if signal is valid/good
        METHOD QBad : BOOL
        END_METHOD
    END_INTERFACE

    /// Null Object pattern implementation for ItfBinSignal
    /// Provides a safe default implementation that returns FALSE for all methods
    /// Use this to avoid null pointer checks when a binary signal is optional
    CLASS NullBinSignal
        IMPLEMENTS ItfBinSignal

        /// Returns the current state (always FALSE for null object)
        /// RETURN: FALSE
        METHOD PUBLIC Q : BOOL
            ;
        END_METHOD

        /// Returns rising edge status (always FALSE for null object)
        /// RETURN: FALSE
        METHOD PUBLIC QRis : BOOL
            ;
        END_METHOD

        /// Returns falling edge status (always FALSE for null object)
        /// RETURN: FALSE
        METHOD PUBLIC QFal : BOOL
            ;
        END_METHOD

        /// Returns quality status (always FALSE for null object, indicating "good" quality)
        /// RETURN: FALSE
        METHOD PUBLIC QBad : BOOL
            ;
        END_METHOD
    END_CLASS

END_NAMESPACE
