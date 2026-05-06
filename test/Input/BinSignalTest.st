USING AxUnit;
USING Simatic.Ax.IO.Input;
USING System.Timer;

NAMESPACE Simatic.Ax.IO.Input.Test

    /// Test fixture for BinSignal class
    /// Verifies binary signal input functionality including:
    /// - Signal reading and state management
    /// - Edge detection (rising and falling edges)
    /// - Signal inversion
    /// - Quality status (QBad) handling
    /// - Change detection
    {TestFixture}
    CLASS BinSignalTest
        VAR
            o : BinSignal;   // Test object for BinSignal
            oStateLess : BinSignalExt;  // Stateless test object
        END_VAR

        /// Setup method called before each test
        /// Initializes test objects to ensure clean state
        {TestSetup}
        METHOD PUBLIC MyTestSetup
            o := oStateLess;
        END_METHOD

        /// Test basic signal reading - expects TRUE output when TRUE signal is read
        {Test}
        METHOD PUBLIC TestQ_And_expect_true
            o.ReadCyclic(signal := TRUE);
            Assert.Equal(expected := TRUE, actual := o.Q());
        END_METHOD

        /// Parameterized test for signal reading with different valid/invalid combinations
        /// Tests all combinations of signal value, validity flag, and default value
        /// Verifies that Q() returns correct value and QBad() reflects validity status
        {Test(isignal := FALSE, ienable := FALSE, idefault := FALSE, iexpq := FALSE, iexpqbad := TRUE)}
        {Test(isignal := FALSE, ienable := FALSE, idefault := TRUE, iexpq := TRUE, iexpqbad := TRUE)}
        {Test(isignal := FALSE, ienable := TRUE, idefault := FALSE, iexpq := FALSE, iexpqbad := FALSE)}
        {Test(isignal := FALSE, ienable := TRUE, idefault := TRUE, iexpq := FALSE, iexpqbad := FALSE)}
    
        {Test(isignal := TRUE, ienable := FALSE, idefault := FALSE, iexpq := FALSE, iexpqbad := TRUE)}
        {Test(isignal := TRUE, ienable := FALSE, idefault := TRUE, iexpq := TRUE, iexpqbad := TRUE)}
        {Test(isignal := TRUE, ienable := TRUE, idefault := FALSE, iexpq := TRUE, iexpqbad := FALSE)}
        {Test(isignal := TRUE, ienable := TRUE, idefault := TRUE, iexpq := TRUE, iexpqbad := FALSE)}
    
        METHOD PUBLIC execute
            VAR_INPUT
                isignal : BOOL;
                ienable : BOOL;
                idefault : BOOL;
                iexpq : BOOL;
                iexpqbad : BOOL;
            END_VAR
    
            o.ReadCyclic(signal := iSignal, valid := iEnable, default := iDefault);        
            AxUnit.Assert.Equal(expected := iExpQ, actual := o.Q());

        END_METHOD

        /// Parameterized test for edge detection (rising and falling edges)
        /// Verifies QRis() and QFal() correctly detect signal transitions
        {Test(isignal := TRUE, ienable := TRUE, idefault := FALSE, iexpq := TRUE, iexpqris := TRUE, iexpqfal := FALSE, itestfallingedge := FALSE)}
        {Test(isignal := FALSE, ienable := TRUE, idefault := FALSE, iexpq := FALSE, iexpqris := FALSE, iexpqfal := TRUE, itestfallingedge := TRUE)}
        METHOD PUBLIC QRis2
            VAR_INPUT
                isignal : BOOL;
                ienable : BOOL;
                idefault : BOOL;
                iexpq : BOOL;
                iexpqris : BOOL;
                iexpqfal : BOOL;
                itestfallingedge : BOOL;
            END_VAR

        
            IF (iTestFallingEdge) then 
                o.ReadCyclic(signal := TRUE, valid := iEnable, default := iDefault); 
            END_IF;

            o.ReadCyclic(signal := iSignal, valid := iEnable, default := iDefault);
            AxUnit.Assert.Equal(expected := iExpQ, actual := o.Q());
            AxUnit.Assert.Equal(expected := iExpQRis, actual := o.QRis());
            AxUnit.Assert.Equal(expected := iExpQFal, actual := o.QFal());
            
            o.ReadCyclic(signal := iSignal, valid := iEnable, default := iDefault);
            AxUnit.Assert.Equal(expected := iExpQ, actual := o.Q());
            AxUnit.Assert.Equal(expected := FALSE, actual := o.QRis());
            AxUnit.Assert.Equal(expected := FALSE, actual := o.QFal());

        END_METHOD

        /// Test Q() method - verifies signal state reading and QBad status
        {Test}
        METHOD PUBLIC Q
            VAR_TEMP
            END_VAR        
            AxUnit.Assert.Equal(expected := FALSE, actual := o.Q());
            o.ReadCyclic(signal := TRUE);
            AxUnit.Assert.Equal(expected := TRUE, actual := o.Q());
            AxUnit.Assert.Equal(expected := FALSE, actual := o.QBad());
        END_METHOD

        /// Test QRis() method - verifies rising edge detection with and without inversion
        {Test}
        METHOD PUBLIC QRis
            AxUnit.Assert.Equal(expected := FALSE, actual := o.QRis());
            o.ReadCyclic(signal := TRUE);
            AxUnit.Assert.Equal(expected := TRUE, actual := o.QRis());
            o.ReadCyclic(signal := TRUE);
            AxUnit.Assert.Equal(expected := FALSE, actual := o.QRis());

            o.invert := TRUE;
            o.ReadCyclic(signal := TRUE);
            AxUnit.Assert.Equal(expected := FALSE, actual := o.QRis());
            o.ReadCyclic(signal := FALSE);
            AxUnit.Assert.Equal(expected := TRUE, actual := o.QRis());
            o.ReadCyclic(signal := TRUE);
            AxUnit.Assert.Equal(expected := FALSE, actual := o.QRis());

        END_METHOD
        /// Test QFal() method - verifies falling edge detection with and without inversion
        {Test}
        METHOD PUBLIC QFal

            o.ReadCyclic(signal := TRUE);
            AxUnit.Assert.Equal(expected := FALSE, actual := o.QFal());
            o.ReadCyclic(signal := FALSE);
            AxUnit.Assert.Equal(expected := TRUE, actual := o.QFal());
            o.ReadCyclic(signal := FALSE);
            AxUnit.Assert.Equal(expected := FALSE, actual := o.QFal());

            o.invert := TRUE;
            o.ReadCyclic(signal := FALSE);
            AxUnit.Assert.Equal(expected := FALSE, actual := o.QFal());
            o.ReadCyclic(signal := TRUE);
            AxUnit.Assert.Equal(expected := TRUE, actual := o.QFal());
            o.ReadCyclic(signal := FALSE);
            AxUnit.Assert.Equal(expected := FALSE, actual := o.QFal());

            
        END_METHOD

        /// Test QBad() method - verifies quality status handling with valid/invalid signals
        /// Tests default value behavior and signal inversion with quality status
        {Test}
        METHOD PUBLIC QBad

            o.ReadCyclic(signal := TRUE, valid := FALSE, default := FALSE);
            AxUnit.Assert.Equal(expected := TRUE, actual := o.QBad());            
            AxUnit.Assert.Equal(expected := FALSE, actual := o.Q());

            o.ReadCyclic(signal := FALSE, valid := FALSE, default := TRUE);
            AxUnit.Assert.Equal(expected := TRUE, actual := o.QBad());    
            AxUnit.Assert.Equal(expected := TRUE, actual := o.Q());

            o.invert  := TRUE;
            o.ReadCyclic(signal := TRUE, valid := FALSE, default := FALSE);
            AxUnit.Assert.Equal(expected := TRUE, actual := o.QBad());    
            AxUnit.Assert.Equal(expected := FALSE, actual := o.Q());

            o.ReadCyclic(signal := FALSE, valid := FALSE, default := TRUE);
            AxUnit.Assert.Equal(expected := TRUE, actual := o.QBad());    
            AxUnit.Assert.Equal(expected := TRUE, actual := o.Q());

            
            o.invert := TRUE;
            AxUnit.Assert.Equal(expected := TRUE, actual := o.IsInverted());
            o.ReadCyclic(signal := FALSE);
            AxUnit.Assert.Equal(expected := TRUE, actual := o.Q());

        END_METHOD

        /// Test HasChanged() method - verifies change detection between consecutive reads
        {Test}
        METHOD PUBLIC HasChanged

            o.ReadCyclic(signal := TRUE, valid := TRUE, default := FALSE);
            o.ReadCyclic(signal := TRUE, valid := TRUE, default := FALSE);
            AxUnit.Assert.Equal(expected := FALSE, actual := o.HasChanged());

            o.ReadCyclic(signal := FALSE, valid := TRUE, default := FALSE);
            o.ReadCyclic(signal := FALSE, valid := TRUE, default := FALSE);
            AxUnit.Assert.Equal(expected := FALSE, actual := o.HasChanged());

            o.ReadCyclic(signal := FALSE, valid := TRUE, default := FALSE);
            o.ReadCyclic(signal := TRUE, valid := TRUE, default := FALSE);
            AxUnit.Assert.Equal(expected := TRUE, actual := o.HasChanged());

            o.ReadCyclic(signal := TRUE, valid := TRUE, default := FALSE);
            o.ReadCyclic(signal := FALSE, valid := TRUE, default := FALSE);
            AxUnit.Assert.Equal(expected := TRUE, actual := o.HasChanged());
            
        END_METHOD

    END_CLASS
END_NAMESPACE