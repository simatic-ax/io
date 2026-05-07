NAMESPACE Simatic.Ax.IO.Output
    
    /// Long Real (LREAL) floating-point output signal handler with change detection
    /// Handles 64-bit double precision floating-point output values to hardware or software targets
    /// Range: approximately ±1.8e308 (double precision IEEE 754)
    /// Outputs as LWORD bit pattern for hardware compatibility
    CLASS LRealOutput EXTENDS OutputBase
        VAR
            _actualValue : LREAL; // Current output value to be written
            _oldValue : LREAL; // Previous output value for change detection
        END_VAR
        
        /// Set the long real floating-point output value
        /// The value is stored internally and written during WriteCyclic() call
        /// value: LREAL value to set (64-bit double precision floating-point)
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : LREAL;
            END_VAR
            _actualValue := value;
        END_METHOD

        /// Write the value to the output periphery cyclically
        /// Must be executed every cycle (recommendation: at the end of the cycle)
        /// Updates change detection and outputs the current value as LWORD bit pattern
        /// Can also be used for non-hardware (software-only) outputs
        /// Q: Output parameter containing the current LREAL value as LWORD bit pattern
        METHOD PUBLIC WriteCyclic
            VAR_OUTPUT
                Q : LWORD;
            END_VAR
            THIS.HasChanged(value := _actualValue <> _oldValue);
            _oldValue := _actualValue;
            Q:= TO_LWORD(_actualValue);
        END_METHOD

    END_CLASS
END_NAMESPACE