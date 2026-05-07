NAMESPACE Simatic.Ax.IO.Output
    
    /// Double Word (DWORD) output signal handler with change detection
    /// Handles 32-bit unsigned word output values to hardware or software targets
    /// Range: 0 (16#0) to 4,294,967,295 (16#FFFFFFFF)
    /// Typically used for bit patterns, status words, or unsigned integer values
    CLASS DWordOutput EXTENDS OutputBase
        VAR
            _actualValue : DWORD; // Current output value to be written
            _oldValue : DWORD; // Previous output value for change detection
        END_VAR
        
        /// Set the double word output value
        /// The value is stored internally and written during WriteCyclic() call
        /// value: DWORD value to set (range: 0 to 4,294,967,295)
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : DWORD;
            END_VAR
            _actualValue := value;
        END_METHOD

        /// Write the value to the output periphery cyclically
        /// Must be executed every cycle (recommendation: at the end of the cycle)
        /// Updates change detection and outputs the current value
        /// Can also be used for non-hardware (software-only) outputs
        /// Q: Output parameter containing the current DWORD value
        METHOD PUBLIC WriteCyclic
            VAR_OUTPUT
                Q : DWORD;
            END_VAR
            THIS.HasChanged(value := _actualValue <> _oldValue);
            _oldValue := _actualValue;
            Q:= _actualValue;
        END_METHOD
    END_CLASS
END_NAMESPACE