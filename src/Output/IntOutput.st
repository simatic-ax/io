NAMESPACE Simatic.Ax.IO.Output
    
    /// Integer (INT) output signal handler with change detection
    /// Handles 16-bit signed integer output values to hardware or software targets
    /// Range: -32768 to 32767
    /// Provides automatic change detection when WriteCyclic() is called
    CLASS IntOutput EXTENDS OutputBase
        VAR
            _actualValue : INT; // Current output value to be written
            _oldValue : INT; // Previous output value for change detection
        END_VAR
        
        /// Set the integer output value
        /// The value is stored internally and written during WriteCyclic() call
        /// value: INT value to set (range: -32768 to 32767)
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : INT;
            END_VAR
            _actualValue := value;
        END_METHOD

        /// Write the value to the output periphery cyclically
        /// Must be executed every cycle (recommendation: at the end of the cycle)
        /// Updates change detection and outputs the current value
        /// Can also be used for non-hardware (software-only) outputs
        /// Q: Output parameter containing the current INT value
        METHOD PUBLIC WriteCyclic
            VAR_OUTPUT
                Q : INT;
            END_VAR
            THIS.HasChanged(value := _actualValue <> _oldValue);
            _oldValue := _actualValue;
            Q:= _actualValue;
        END_METHOD
    END_CLASS
END_NAMESPACE