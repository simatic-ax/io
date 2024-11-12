USING System.Math;

NAMESPACE Simatic.Ax.IO.Input
    /// Class to handle LREAL input values 
    CLASS LRealInput EXTENDS InputBase

        VAR PRIVATE
            _value : LREAL := LREAL#0.0;
            _default : LREAL := LREAL#0.0;
        END_VAR

        /// The max and min value of datataype LReal
        VAR CONSTANT PUBLIC
            MAX : LREAL := LREAL#1.79769313486231e+308;
            MIN : LREAL := LREAL#-1.79769313486231e+308;
        END_VAR

        /// Read the input value from Input area of type LWORD
        /// The LWORD input value
        /// The input value is valid (e.g. periphery is ok)
        /// Default value if invalid = 0.0
        /// Tolerance used with HasChanged, defaults to 0.0
        METHOD PUBLIC ReadCyclic
            VAR_INPUT
                value : LWORD;
                valid : BOOL := TRUE;
                default : LREAL := LREAL#0.0;
                tolerance : LREAL := LREAL#0.0;
            END_VAR

            THIS.QBad(value := NOT(valid));
            _hasChanged := ABS(_value - TO_LREAL(value)) > tolerance;
            _value := TO_LREAL(value);
            _default := default;
        END_METHOD

        /// Read the input value from Input area of type LREAL
        /// The LREAL input value
        /// The input value is valid (e.g. periphery is ok)
        /// Default value if invalid = 0.0
        /// Tolerance used with HasChanged, defaults to 0.0
        METHOD PUBLIC ReadCyclic
            VAR_INPUT
                value : LREAL;
                valid : BOOL := TRUE;
                default : LREAL := LREAL#0.0;
                tolerance : LREAL := LREAL#0.0;
            END_VAR

            THIS.QBad(value := NOT(valid));
            _hasChanged := ABS(_value - value) > tolerance;
            _value := value;
            _default := default;
        END_METHOD

        /// Returns the actual value of the LREAL
        /// Actual value of the LREAL input
        METHOD PUBLIC Q : LREAL
            IF (NOT(THIS.QBad())) THEN 
                Q := _value;
            ELSE
                Q := _default;
            END_IF;     
        END_METHOD

    END_CLASS
END_NAMESPACE
