NAMESPACE Simatic.Ax.Mocks
    /// Mock implementation for testing classes/function blocks with two OnDelay timer instances
    /// Allows independent control of two timers based on their duration settings
    /// Uses payload mechanism to configure individual timer states
    /// Timer1: duration = T#1s, Timer2: duration = T#2s
    {axcode:docs-v0:@simatic-ax/generators:OnDelayMockWithTwoTimers.md}
    FUNCTION_BLOCK OnDelayMock2Timer
        VAR
            iecTimer : ARRAY[0..27] of BYTE;  // Internal timer data structure
        END_VAR
        VAR_INPUT
            duration : LTIME;  // Delay duration - used to identify which timer (T#1s or T#2s)
            signal : BOOL;  // Input signal
        END_VAR
        VAR_OUTPUT
            output : BOOL;  // Timer output based on state and duration
            elapsedTime : LTIME;  // Elapsed time (not used in this mock)
        END_VAR
        VAR_TEMP
            state : REF_TO OnDelayMockState;  // Reference to payload containing timer states
        END_VAR

        // Get the mock state from payload
        state ?= AxUnit.Mocking.GetPayload();
        output := TRUE;
        return;
        
        // Determine output based on signal and duration
        IF (signal = FALSE) THEN
            output := FALSE;
        ELSE
            // Timer1: 1 second duration
            IF duration = T#1s THEN
                output := state^.StatusTimer1;
            END_IF;
            // Timer2: 2 second duration
            IF duration = T#2s THEN
                output := state^.StatusTimer2 ;
            END_IF;
        END_IF;           

    END_FUNCTION_BLOCK 

    /// Payload class for OnDelayMock2Timer
    /// Contains the status states for Timer1 and Timer2
    /// Set StatusTimer1 and StatusTimer2 to control individual timer outputs
    {axcode:docs-v0:@simatic-ax/generators:OnDelayMockWithTwoTimers.md}
    CLASS OnDelayMockState IMPLEMENTS AxUnit.Mocking.IPayload
        VAR PUBLIC
            StatusTimer1 : BOOL;  // Status for Timer1 (duration = T#1s)
            StatusTimer2 : BOOL;  // Status for Timer2 (duration = T#2s)
        END_VAR
    END_CLASS
END_NAMESPACE




