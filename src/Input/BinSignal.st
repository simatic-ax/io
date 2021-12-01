NAMESPACE Siemens.Ax.IO.Input
    CLASS BinSignal EXTENDS InputBase IMPLEMENTS IBinSignal
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
            _statusQRis := _statusQ AND NOT(_signalInOld);
            _statusQFal := NOT(_statusQ) AND _signalInOld;
            _signalInOld := _statusQ;
        END_METHOD


        /// <summary>
        /// </summary>
        /// <RETURNs>Returns if the signal is inverted</RETURNs>
        METHOD PUBLIC IsInverted : BOOL                        
            IsInverted := invert;
        END_METHOD

        /// <summary>
        /// </summary>
        /// <RETURNs>Returns the current status of BinSignal</RETURNs>
        METHOD PUBLIC Q : BOOL
            Q := _statusQ;
        END_METHOD

        /// <summary>
        /// </summary>
        /// <RETURNs>Returns if a rising edge was detected in the current cycle</RETURNs>
        METHOD PUBLIC QRis : BOOL
            QRis := _statusQRis;            
        END_METHOD

        /// <summary>
        /// </summary>
        /// <RETURNs>Returns if a falling edge was detected in the current cycle</RETURNs>
        METHOD PUBLIC QFal : BOOL
            QFal := _statusQFal;
        END_METHOD
    END_CLASS
END_NAMESPACE