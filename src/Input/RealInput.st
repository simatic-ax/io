USING System.Math;

NAMESPACE Simatic.Ax.IO.Input
    /// Class to handle REAL input values 
    CLASS RealInput EXTENDS InputBase

        VAR PRIVATE
            _value : REAL := REAL#0.0;
            _default : REAL := REAL#0.0;
        END_VAR

        /// The max and min value of datataype REAL
        VAR CONSTANT PUBLIC
            MAX : REAL := REAL#+3.402823e+38;
            MIN : REAL := REAL#-3.402823e+38;
        END_VAR
        
        /// Read the input value from Input area of type REAL
        /// The REAL input value
        /// The input value is valid (e.g. periphery is ok)
        /// Default value if invalid = 0.0
        /// Tolerance used with HasChanged, defaults to 0.0
        METHOD PUBLIC ReadCyclic
            VAR_INPUT
                value : DWORD;
                valid : BOOL := TRUE;
                default : REAL := REAL#0.0;
                tolerance : REAL := REAL#0.0;
            END_VAR

            THIS.QBad(value := NOT(valid));
            _hasChanged := ABS(_value - TO_REAL(value)) > tolerance;
            _value := TO_REAL(value);
            _default := default;
        END_METHOD

        /// Read the input value from Input area of type REAL
        /// The REAL input value
        /// The input value is valid (e.g. periphery is ok)
        /// Default value if invalid = 0.0
        /// Tolerance used with HasChanged, defaults to 0.0
        METHOD PUBLIC ReadCyclic
            VAR_INPUT
                value : REAL;
                valid : BOOL := TRUE;
                default : REAL := REAL#0.0;
                tolerance : REAL := REAL#0.0;
            END_VAR

            THIS.QBad(value := NOT(valid));
            _hasChanged := ABS(_value - value) > tolerance;
            _value := value;
            _default := default;
        END_METHOD

        /// Returns the actual value of the REAL
        /// Actual value of the REAL input
        METHOD PUBLIC Q : REAL
            IF (NOT(THIS.QBad())) THEN 
                Q := _value;
            ELSE
                Q := _default;
            END_IF;     
        END_METHOD

    END_CLASS
END_NAMESPACE
