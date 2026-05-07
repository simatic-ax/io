NAMESPACE Simatic.Ax.IO.Output
    
    /// Real (REAL) floating-point output signal handler with change detection
    /// Handles 32-bit floating-point output values to hardware or software targets
    /// Range: approximately ±3.4e38 (single precision IEEE 754)
    /// Outputs as DWORD bit pattern for hardware compatibility
    CLASS RealOutput EXTENDS OutputBase
        VAR
            _actualValue : REAL; // Current output value to be written
            _oldValue : REAL; // Previous output value for change detection
        END_VAR
        
        /// Set the real floating-point output value
        /// The value is stored internally and written during WriteCyclic() call
        /// value: REAL value to set (32-bit floating-point)
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : REAL;
            END_VAR
            _actualValue := value;
        END_METHOD

        /// Write the value to the output periphery cyclically
        /// Must be executed every cycle (recommendation: at the end of the cycle)
        /// Updates change detection and outputs the current value as DWORD bit pattern
        /// Can also be used for non-hardware (software-only) outputs
        /// Q: Output parameter containing the current REAL value as DWORD bit pattern
        METHOD PUBLIC WriteCyclic
            VAR_OUTPUT
                Q : DWORD;
            END_VAR
            THIS.HasChanged(value := _actualValue <> _oldValue);
            _oldValue := _actualValue;
            Q:= TO_DWORD(_actualValue);
        END_METHOD

    END_CLASS
END_NAMESPACE