NAMESPACE Simatic.Ax.IO.Output
    
    /// Long Integer (LINT) output signal handler with change detection
    /// Handles 64-bit signed integer output values to hardware or software targets
    /// Range: -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807
    /// Provides automatic change detection when WriteCyclic() is called
    CLASS LIntOutput EXTENDS OutputBase
        VAR
            _actualValue : LINT; // Current output value to be written
            _oldValue : LINT; // Previous output value for change detection
        END_VAR
        
        /// Set the long integer output value
        /// The value is stored internally and written during WriteCyclic() call
        /// value: LINT value to set (64-bit signed integer)
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : LINT;
            END_VAR
            _actualValue := value;
        END_METHOD

        /// Write the value to the output periphery cyclically
        /// Must be executed every cycle (recommendation: at the end of the cycle)
        /// Updates change detection and outputs the current value
        /// Can also be used for non-hardware (software-only) outputs
        /// Q: Output parameter containing the current LINT value
        METHOD PUBLIC WriteCyclic
            VAR_OUTPUT
                Q : LINT;
            END_VAR
            THIS.HasChanged(value := _actualValue <> _oldValue);
            _oldValue := _actualValue;
            Q:= _actualValue;
        END_METHOD
    END_CLASS
END_NAMESPACE