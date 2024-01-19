USING AxUnit;
USING Simatic.Ax.IO.Input;
USING System.Timer;
//USING AxUnit;

NAMESPACE Simatic.Ax.IO.Input.Test

    {TestFixture}
    CLASS BinSignalTest
        VAR
            o : BinSignal;   
            oStateLess : BinSignalExt;     
        END_VAR

        {TestSetup}
        METHOD PUBLIC MyTestSetup
        // Will be called before MyTest_A AND before Test_B are executed
            o := oStateLess;
        END_METHOD

        {Test}
        METHOD PUBLIC TestQ_And_expect_true
            o.ReadCyclic(signal := TRUE);
            Assert.Equal(expected := TRUE, actual := o.Q());
        END_METHOD

        {Test(isignal := FALSE, ienable := FALSE, idefault := FALSE, iexpq := FALSE, iexpqbad := TRUE)}
        {Test(isignal := FALSE, ienable := FALSE, idefault := TRUE, iexpq := TRUE, iexpqbad := TRUE)}
        {Test(isignal := FALSE, ienable := TRUE, idefault := FALSE, iexpq := FALSE, iexpqbad := FALSE)}
        {Test(isignal := FALSE, ienable := TRUE, idefault := TRUE, iexpq := FALSE, iexpqbad := FALSE)}
    
        {Test(isignal := TRUE, ienable := FALSE, idefault := FALSE, iexpq := FALSE, iexpqbad := TRUE)}
        {Test(isignal := TRUE, ienable := FALSE, idefault := TRUE, iexpq := TRUE, iexpqbad := TRUE)}
        {Test(isignal := TRUE, ienable := TRUE, idefault := FALSE, iexpq := TRUE, iexpqbad := FALSE)}
        {Test(isignal := TRUE, ienable := TRUE, idefault := TRUE, iexpq := TRUE, iexpqbad := FALSE)}
    
        METHOD PUBLIC  execute
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

        {Test(isignal := TRUE, ienable := TRUE, idefault := FALSE, iexpq := TRUE, iexpqris := TRUE, iexpqfal := FALSE, itestfallingedge := FALSE)}
        {Test(isignal := FALSE, ienable := TRUE, idefault := FALSE, iexpq := FALSE, iexpqris := FALSE, iexpqfal := TRUE, itestfallingedge := TRUE)}
        //-----------------------------------------------------------
        // test SetOff
        //-----------------------------------------------------------
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

        //-----------------------------------------------------------
        // test Q
        //-----------------------------------------------------------
        {Test}
        METHOD PUBLIC  Q
            VAR_TEMP
            END_VAR        
            AxUnit.Assert.Equal(expected := FALSE, actual := o.Q());
            o.ReadCyclic(signal := TRUE);
            AxUnit.Assert.Equal(expected := TRUE, actual := o.Q());
            AxUnit.Assert.Equal(expected := FALSE, actual := o.QBad());
        END_METHOD

        //-----------------------------------------------------------
        // test QRis
        //-----------------------------------------------------------
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
        //-----------------------------------------------------------
        // test QFal
        //-----------------------------------------------------------
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

        //-----------------------------------------------------------
        // test QBad
        //-----------------------------------------------------------
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
        
        

    END_CLASS
END_NAMESPACE