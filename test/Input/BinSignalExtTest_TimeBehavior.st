USING AxUnit;
USING Simatic.Ax.IO.Input;
USING System.Timer;
USING Simatic.Ax.Mocks;

NAMESPACE Simatic.Ax.IO.Input.Test

    /// Test fixture for timing behavior of BinSignalExt.
    /// Tests the correct handling of on-delay and off-delay logic in BinSignalExt.
    /// Input: None.
    /// Returns: None.
    {TestFixture}
    CLASS BinSignalExt_TimingTest
        VAR
            o, oStateLess : BinSignalExt;      
        END_VAR

        /// Sets up the test environment for each test.
        /// Input: None.
        /// Returns: None.
        {TestSetup}
        METHOD PUBLIC TestSetup
            o := oStateLess;
        END_METHOD

        /// Verifies that Q() is FALSE immediately after signal becomes TRUE with on-delay active.
        /// Input: None.
        /// Returns: None.
        {Test}
        METHOD PUBLIC TestOnDelay_After_signal_true_expect_false
            AxUnit.Mocking.Mock(NAME_OF(OnDelay), NAME_OF(OnDelayMock_false));  
            o.ondelay := T#10ms;
            o.ReadCyclic(signal := TRUE);
            Assert.Equal(expected := FALSE, actual := o.Q());
        END_METHOD

        /// Verifies that Q() is TRUE after signal is TRUE and on-delay has elapsed.
        /// Input: None.
        /// Returns: None.
        {Test}
        METHOD PUBLIC TestOnDelay_10ms_After_signal_true_expect_true
            AxUnit.Mocking.Mock(NAME_OF(OnDelay), NAME_OF(OnDelayMock_true));  
            o.ondelay := T#10ms;
            o.ReadCyclic(signal := TRUE);
            Assert.Equal(expected := TRUE, actual := o.Q());
        END_METHOD

        /// Verifies that Q() is TRUE after on-delay, and becomes FALSE when signal goes to FALSE.
        /// Input: None.
        /// Returns: None.
        {Test}
        METHOD PUBLIC TestOnDelay_10ms_signal_goes_to_False_expect_false
            AxUnit.Mocking.Mock(NAME_OF(OnDelay), NAME_OF(OnDelayMock_true));
            o.ondelay := T#10ms;
            o.ReadCyclic(signal := TRUE);
            Assert.Equal(expected := TRUE, actual := o.Q());
            AxUnit.Mocking.Mock(NAME_OF(OnDelay), NAME_OF(OnDelayMock_false));
            o.ReadCyclic(signal := FALSE);
            Assert.Equal(expected := FALSE, actual := o.Q());
        END_METHOD

        /// Verifies that Q() remains TRUE after signal goes FALSE if off-delay is active, then becomes FALSE after off-delay.
        /// Input: None.
        /// Returns: None.
        {Test}
        METHOD PUBLIC TestOffDelay_10ms_After_signal_true_expect_true
            AxUnit.Mocking.Mock(NAME_OF(OffDelay), NAME_OF(OffDelayMock_true));
            o.offdelay := T#10ms;
            o.ReadCyclic(signal := TRUE);
            o.ReadCyclic(signal := FALSE);
            Assert.Equal(expected := TRUE, actual := o.Q());

            AxUnit.Mocking.Mock('System.Timer.OffDelay', 'Simatic.Ax.Mocks.OffDelayMock_false');
            o.ReadCyclic(signal := FALSE);
            Assert.Equal(expected := FALSE, actual := o.Q());
        END_METHOD
    END_CLASS
END_NAMESPACE