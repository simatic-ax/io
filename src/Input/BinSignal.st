NAMESPACE Simatic.Ax.IO.Input
    CLASS BinSignal EXTENDS InputBase IMPLEMENTS ItfBinSignal
        VAR PUBLIC
            invert : BOOL := FALSE;
        END_VAR
        VAR PRIVATE
            _signalInOld : BOOL;
        END_VAR
        VAR PROTECTED 
            _signalInPrefiltered : BOOL;
            _statusQ : BOOL;
            _statusQRis : BOOL;
            _statusQFal : BOOL;            
        END_VAR

        /// Read the input value from Input area of type BOOL
        /// The BOOL input value
        /// The input value is valid (e.g. periphery is ok)
        /// Default value if invalid = FALSE
        METHOD PUBLIC ReadCyclic
            VAR_INPUT
                signal : BOOL;
                valid : BOOL := TRUE;
                default : BOOL := FALSE;
            END_VAR

            IF (valid) THEN
                _signalInPrefiltered :=  signal XOR invert;
                THIS.QBad(value := FALSE);
            ELSE
                _signalInPrefiltered := default;
                THIS.QBad(value := TRUE);
            END_IF;

            _statusQ := _signalInPrefiltered;
            _hasChanged := _signalInOld <> _signalInPrefiltered;
            _statusQRis := _statusQ AND NOT(_signalInOld);
            _statusQFal := NOT(_statusQ) AND _signalInOld;
            _signalInOld := _statusQ;
        END_METHOD


        ///Returns if the signal is inverted
        METHOD PUBLIC IsInverted : BOOL                        
            IsInverted := invert;
        END_METHOD

        ///Returns the current status of BinSignal
        METHOD PUBLIC Q : BOOL
            Q := _statusQ;
        END_METHOD

        ///Returns if a rising edge was detected in the current cycle
        METHOD PUBLIC QRis : BOOL
            QRis := _statusQRis;            
        END_METHOD

        ///Returns if a falling edge was detected in the current cycle
        METHOD PUBLIC QFal : BOOL
            QFal := _statusQFal;
        END_METHOD
    END_CLASS
END_NAMESPACE