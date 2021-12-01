USING System.Timer;

NAMESPACE Siemens.AX.IO
    FUNCTION CheckTimerstatus : BOOL
        VAR_IN_OUT
            iecTimer : OnDelay;
        END_VAR
        CheckTimerstatus := iecTimer.output;        
    END_FUNCTION

    FUNCTION CheckTimerstatus : BOOL
        VAR_IN_OUT
            iecTimer : OffDelay;
        END_VAR
        CheckTimerstatus := iecTimer.output;        
    END_FUNCTION

END_NAMESPACE