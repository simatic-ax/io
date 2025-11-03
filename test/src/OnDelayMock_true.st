NAMESPACE Simatic.Ax.Mocks
    FUNCTION_BLOCK OnDelayMock_true
        VAR
            iecTimer : ARRAY[0..27] of BYTE;
        END_VAR
        VAR_INPUT
            duration : LTIME;
            signal : BOOL;
        END_VAR
        VAR_OUTPUT
            output : BOOL;
            elapsedTime : LTIME;
        END_VAR
        output := TRUE;
    END_FUNCTION_BLOCK
END_NAMESPACE