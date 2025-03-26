NAMESPACE Simatic.Ax.IO.Output
    INTERFACE ItfBinOutput
        METHOD SetQ
            VAR_INPUT
                value : BOOL;
            END_VAR
        END_METHOD
        METHOD SetOn
        END_METHOD
        METHOD SetOff
        END_METHOD
        METHOD Toggle
        END_METHOD
        METHOD IsOn : BOOL
        END_METHOD
    END_INTERFACE
END_NAMESPACE