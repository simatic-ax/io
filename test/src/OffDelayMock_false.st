NAMESPACE Simatic.Ax.Mocks
    /// Mock implementation of OffDelay timer that always returns FALSE
    /// Used for testing BinSignalExt when off-delay timer has not elapsed
    /// This mock simulates the behavior where the delay duration has not yet passed
    FUNCTION_BLOCK OffDelayMock_false
        VAR_INPUT
            duration : LTIME;  // Delay duration (ignored in mock)
            signal : BOOL;  // Input signal (ignored in mock)
        END_VAR
        VAR_OUTPUT
            output : BOOL;  // Always FALSE - simulates timer not elapsed
            elapsedTime : LTIME;  // Elapsed time (not used in this mock)
        END_VAR
        output := FALSE;
    END_FUNCTION_BLOCK
END_NAMESPACE
