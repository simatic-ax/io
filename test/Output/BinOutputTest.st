// USING Siemens.AX.IO.Output;

// NAMESPACE Siemens.AX.IO.Output.Test

//     //-----------------------------------------------------------
//     // test SetQ(value)
//     //-----------------------------------------------------------
//     {Test(value := 0, expect := 0)}
//     {Test(value := 1, expect := 1)}
//     FUNCTION TestSetQ
//         VAR_INPUT
//             value : INT;
//             expect : INT;
//         END_VAR
//         VAR_EXTERNAL
//             bo1 : BinOutput;
//         END_VAR               
//         VAR_TEMP            
//             tValue : BOOL;
//             tExp : BOOL;
//             tActual : BOOL;
//         END_VAR
        
//         tValue := value <> 0;
//         tExp := expect <> 0;
        
//         bo1.SetQ(value := tValue);
//         AxUnit.Assert.Equal(expected := tExp, actual := bo1.IsOn());
//     END_FUNCTION

//     //-----------------------------------------------------------
//     // test SetOn
//     //-----------------------------------------------------------
//     {Test}
//     FUNCTION SetOn
//         VAR_EXTERNAL
//             bo2 : BinOutput;
//         END_VAR               

//         AxUnit.Assert.Equal(expected := FALSE, actual := bo2.IsOn());
//         bo2.SetOn();
//         AxUnit.Assert.Equal(expected := TRUE, actual := bo2.IsOn());
//     END_FUNCTION

//     //-----------------------------------------------------------
//     // test SetOff
//     //-----------------------------------------------------------
//     {Test}
//     FUNCTION SetOff    

//         VAR_EXTERNAL
//             bo3 : BinOutput;
//         END_VAR               
        
//         bo3.SetOn();
//         AxUnit.Assert.Equal(expected := TRUE, actual := bo3.IsOn());
//         bo3.SetOff();
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo3.IsOn());
//     END_FUNCTION
   
//     //-----------------------------------------------------------
//     // test SetOff
//     //-----------------------------------------------------------
//     {Test}
//     FUNCTION Toggle

//         VAR_EXTERNAL
//             bo4 : BinOutput;
//         END_VAR               
                
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo4.IsOn());
//         bo4.Toggle();
//         AxUnit.Assert.Equal(expected := TRUE, actual := bo4.IsOn());
//         bo4.Toggle();
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo4.IsOn());
//     END_FUNCTION   
   
//     //-----------------------------------------------------------
//     // HasChanged
//     //-----------------------------------------------------------
//     {Test}
//     FUNCTION HasChanged_Test_Toggle

//         VAR_EXTERNAL
//             bo5 : BinOutput;
//         END_VAR               
               
        
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo5.HasChanged());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo5.HasSwitchedOff());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo5.HasSwitchedOn());
        
//         bo5.Toggle();
//         bo5.WriteCyclic();
//         AxUnit.Assert.Equal(expected := TRUE, actual := bo5.HasChanged());
//         AxUnit.Assert.Equal(expected := TRUE, actual := bo5.HasSwitchedOn());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo5.HasSwitchedOff());
//         bo5.WriteCyclic();
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo5.HasChanged());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo5.HasSwitchedOn());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo5.HasSwitchedOff());


//         bo5.Toggle();
//         bo5.WriteCyclic();
//         AxUnit.Assert.Equal(expected := TRUE, actual := bo5.HasChanged());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo5.HasSwitchedOn());
//         AxUnit.Assert.Equal(expected := TRUE, actual := bo5.HasSwitchedOff());

//         bo5.WriteCyclic();
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo5.HasChanged());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo5.HasSwitchedOn());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo5.HasSwitchedOff());
//     END_FUNCTION   

//     {Test}
//     FUNCTION HasChanged_Test_SetQ

//         VAR_EXTERNAL
//             bo6 : BinOutput;
//         END_VAR               
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo6.HasChanged());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo6.HasSwitchedOn());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo6.HasSwitchedOff());

//         bo6.SetQ(TRUE);
//         bo6.WriteCyclic();
//         AxUnit.Assert.Equal(expected := TRUE, actual := bo6.HasChanged());
//         AxUnit.Assert.Equal(expected := TRUE, actual := bo6.HasSwitchedOn());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo6.HasSwitchedOff());

//         bo6.WriteCyclic();
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo6.HasChanged());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo6.HasSwitchedOn());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo6.HasSwitchedOff());

//         bo6.SetQ(FALSE);
//         bo6.WriteCyclic();
//         AxUnit.Assert.Equal(expected := TRUE, actual := bo6.HasChanged());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo6.HasSwitchedOn());
//         AxUnit.Assert.Equal(expected := TRUE, actual := bo6.HasSwitchedOff());
        
//         bo6.WriteCyclic();
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo6.HasChanged());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo6.HasSwitchedOn());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo6.HasSwitchedOff());

//     END_FUNCTION   

    
//     {Test}
//     FUNCTION HasChanged_Test_SetOnOff

//         VAR_EXTERNAL
//             bo7 : BinOutput;
//         END_VAR               
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo7.HasChanged());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo7.HasSwitchedOn());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo7.HasSwitchedOff());

//         bo7.SetOn();
//         bo7.WriteCyclic();
//         AxUnit.Assert.Equal(expected := TRUE, actual := bo7.HasChanged());
//         AxUnit.Assert.Equal(expected := TRUE, actual := bo7.HasSwitchedOn());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo7.HasSwitchedOff());        
//         bo7.WriteCyclic();
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo7.HasChanged());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo7.HasSwitchedOn());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo7.HasSwitchedOff());

//         bo7.SetOff();
//         bo7.WriteCyclic();
//         AxUnit.Assert.Equal(expected := TRUE, actual := bo7.HasChanged());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo7.HasSwitchedOn());
//         AxUnit.Assert.Equal(expected := TRUE, actual := bo7.HasSwitchedOff());
//         bo7.WriteCyclic();
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo7.HasChanged());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo7.HasSwitchedOn());
//         AxUnit.Assert.Equal(expected := FALSE, actual := bo7.HasSwitchedOff());
//     END_FUNCTION   



// END_NAMESPACE