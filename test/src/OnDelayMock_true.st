NAMESPACE Simatic.Ax.Mocks
    /// Mock implementation of OnDelay timer that always returns TRUE
    /// Used for testing BinSignalExt when on-delay timer has elapsed
    /// This mock simulates the behavior where the delay duration has passed
    FUNCTION_BLOCK OnDelayMock_true
        VAR_INPUT
            duration : LTIME;  // Delay duration (ignored in mock)
            signal : BOOL;  // Input signal (ignored in mock)
        END_VAR
        VAR_OUTPUT
            output : BOOL;  // Always TRUE - simulates timer elapsed
            elapsedTime : LTIME;  // Elapsed time (not used in this mock)
        END_VAR
        output := TRUE;
    END_FUNCTION_BLOCK
END_NAMESPACE
