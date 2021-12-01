USING System.Timer;
NAMESPACE Siemens.AX.IO.Input
    CLASS BinSignalExt EXTENDS BinSignal
        VAR PUBLIC 
            ondelay : TIME;
            offdelay : TIME;
        END_VAR
        VAR PRIVATE
            _ton : OnDelay;
            _toff : OffDelay;
            _signalInOld : BOOL;
        END_VAR

        /// <summary>
        /// Read digital signal (must be executed in every cycle - recommendation: begin of cycle in case of digital input signals)
        /// </summary>
        /// <param name="signal">Digital/Boolean signal</param>
        /// <param name="valid">signal is valid (if FALSE, the default value will be used); default = TRUE</param>
        /// <param name="default">default value which is used, when valid 0 FALSE</param>        
        METHOD PUBLIC OVERRIDE ReadCyclic
            VAR_INPUT
                signal : BOOL;
                valid : BOOL := TRUE;
                default : BOOL := FALSE;
            END_VAR
            VAR_TEMP
                _tonDelayed : BOOL;
                _toffDelayed : BOOL;
            END_VAR

            SUPER.ReadCyclic(signal := signal, valid := valid, default := default);
            

            IF (ondelay > T#0ms) THEN 
                _ton(duration := ondelay, signal := _signalInPrefiltered);
                _tonDelayed := _ton.output;
            ELSE
                _tonDelayed := _signalInPrefiltered;
            END_IF;

            IF (offdelay > T#0ms) THEN 
                _toff(duration := offdelay, signal := _signalInPrefiltered);
                _toffDelayed := _toff.output;
            ELSE
                _toffDelayed := _tonDelayed;
            END_IF;
            
            _statusQ := _tonDelayed OR _toffDelayed;
            _statusQRis := _statusQ AND NOT(_signalInOld);
            _statusQFal := NOT(_statusQ) AND _signalInOld;
            _signalInOld := _statusQ;
        END_METHOD

    END_CLASS
END_NAMESPACE
