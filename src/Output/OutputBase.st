NAMESPACE Simatic.Ax.IO.Output
    /// <summary>
    /// Status of binary output signal
    /// </summary>
    CLASS OutputBase
        VAR
            _hasChanged : BOOL;
        END_VAR
        
        /// <summary>
        /// Returns if the value has changed in the last cycle
        /// </summary>
        /// <returns>If the value has changed in the last cycle</returns>
        METHOD PUBLIC HasChanged : BOOL
            HasChanged := _hasChanged;
        END_METHOD

        /// <summary>
        /// Set the status of hasChanged. Must be implemented in the concrete class
        /// </summary>
        /// <param name="value">TRUE if the value has changed</param>
        METHOD PROTECTED HasChanged
            VAR_INPUT
                value : BOOL;
            END_VAR        
            _hasChanged := true;
        END_METHOD

    END_CLASS
END_NAMESPACE