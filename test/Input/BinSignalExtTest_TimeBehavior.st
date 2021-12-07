USING AxUnit;
USING Simatic.Ax.IO.Input;
USING System.Timer;
//USING AxUnit;

NAMESPACE Simatic.Ax.IO.Input.Test

    {TestFixture}
    CLASS BinSignalExt_TimingTest
        VAR
            o : BinSignalExt;      
        END_VAR

        {Test}
        METHOD PUBLIC TestOnDelay_After_signal_true_expect_false
            o.ondelay := T#10ms;
            o.ReadCyclic(signal := TRUE);
            Assert.Equal(expected := FALSE, actual := o.Q());
        END_METHOD

        {Test}
        METHOD PUBLIC TestOnDelay_10ms_After_signal_true_expect_true
            AxUnit.Mocking.Mock('System.Timer.OnDelay', 'Simatic.Ax.Mocks.OnDelayMock_true');
            o.ondelay := T#10ms;
            o.ReadCyclic(signal := TRUE);
            Assert.Equal(expected := TRUE, actual := o.Q());
        END_METHOD

        {Test}
        METHOD PUBLIC TestOnDelay_10ms_signal_goes_to_False_expect_false
            //this.TestOnDelay_10ms_After_signal_true_expect_true();
            AxUnit.Mocking.Mock('System.Timer.OnDelay', 'Simatic.Ax.Mocks.OnDelayMock_true');
            o.ondelay := T#10ms;
            o.ReadCyclic(signal := TRUE);
            Assert.Equal(expected := TRUE, actual := o.Q());
            AxUnit.Mocking.Mock('System.Timer.OnDelay', 'Simatic.Ax.Mocks.OnDelayMock_false');
            o.ReadCyclic(signal := FALSE);
            Assert.Equal(expected := FALSE, actual := o.Q());
        END_METHOD


        {Test}
        METHOD PUBLIC TestOffDelay_10ms_After_signal_true_expect_true
            AxUnit.Mocking.Mock('System.Timer.OffDelay', 'Simatic.Ax.Mocks.OffDelayMock_true');
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