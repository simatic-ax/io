NAMESPACE Simatic.Ax.IO.Output

    /// Interface for binary output signal handling
    /// Defines the contract for controlling binary output signals
    /// Implementations provide methods to set, toggle, and query output state
    INTERFACE IBinOutput
        
        /// Set the output to a specific boolean value
        /// value: TRUE to turn output on, FALSE to turn output off
        METHOD SetQ
            VAR_INPUT
                value : BOOL;
            END_VAR
        END_METHOD
        
        /// Set the output to ON (TRUE)
        METHOD SetOn
        END_METHOD
        
        /// Set the output to OFF (FALSE)
        METHOD SetOff
        END_METHOD
        
        /// Toggle the output state (ON->OFF or OFF->ON)
        METHOD Toggle
        END_METHOD
        
        /// Returns the current state of the output
        /// RETURN: TRUE if output is on, FALSE if output is off
        METHOD IsOn : BOOL
        END_METHOD
    END_INTERFACE

    /// Null Object pattern implementation for ItfBinOutput
    /// Provides a safe default implementation that does nothing
    /// Use this to avoid null pointer checks when a binary output is optional
    CLASS NullBinOutput
        IMPLEMENTS IBinOutput

        /// Set output to specific value (no operation for null object)
        /// value: Ignored
        METHOD PUBLIC SetQ
            VAR_INPUT
                value : BOOL;
            END_VAR
            ;
        END_METHOD

        /// Set output to ON (no operation for null object)
        METHOD PUBLIC SetOn
            ;
        END_METHOD

        /// Set output to OFF (no operation for null object)
        METHOD PUBLIC SetOff
            ;
        END_METHOD

        /// Toggle output state (no operation for null object)
        METHOD PUBLIC Toggle
            ;
        END_METHOD

        /// Returns output state (always FALSE for null object)
        /// RETURN: FALSE
        METHOD PUBLIC IsOn : BOOL
            ;
        END_METHOD
    END_CLASS

END_NAMESPACE
