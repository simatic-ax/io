NAMESPACE Simatic.Ax.IO.Output
    
    /// Double Integer (DINT) output signal handler with change detection
    /// Handles 32-bit signed integer output values to hardware or software targets
    /// Range: -2,147,483,648 to 2,147,483,647
    /// Provides automatic change detection when WriteCyclic() is called
    CLASS DintOutput EXTENDS OutputBase
        VAR
            _actualValue : DINT; // Current output value to be written
            _oldValue : DINT; // Previous output value for change detection
        END_VAR
        
        /// Set the double integer output value
        /// The value is stored internally and written during WriteCyclic() call
        /// value: DINT value to set (range: -2,147,483,648 to 2,147,483,647)
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : DINT;
            END_VAR
            _actualValue := value;
        END_METHOD

        /// Write the value to the output periphery cyclically
        /// Must be executed every cycle (recommendation: at the end of the cycle)
        /// Updates change detection and outputs the current value
        /// Can also be used for non-hardware (software-only) outputs
        /// Q: Output parameter containing the current DINT value
        METHOD PUBLIC WriteCyclic
            VAR_OUTPUT
                Q : DINT;
            END_VAR
            THIS.HasChanged(value := _actualValue <> _oldValue);
            _oldValue := _actualValue;
            Q:= _actualValue;
        END_METHOD
    END_CLASS
END_NAMESPACE