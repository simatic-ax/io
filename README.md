# IO Handling Library for SIMATIC AX

Object-oriented I/O handling library for SIMATIC AX that provides a workaround for the limitation that variables pointing to periphery (IOM) cannot be used as references in AX. This package offers classes for reading from the DI area and writing to the DQ area in S7-1500 PLCs, enabling reference-based I/O operations.

## Features

- ✅ **Binary I/O**: Digital input/output handling with edge detection
- ✅ **Analog I/O**: Support for INT, DINT, REAL, LREAL, WORD, DWORD data types
- ✅ **Edge Detection**: Automatic rising and falling edge detection for binary signals
- ✅ **Time Filtering**: On-delay and off-delay for signal debouncing
- ✅ **Quality Status**: QBad status monitoring for invalid signals
- ✅ **Change Detection**: Tolerance-based change detection for analog values
- ✅ **Signal Inversion**: Built-in signal inversion support
- ✅ **OOP Design**: Clean, testable, and maintainable code structure

## Installation

```cli
apax add @simatic-ax/io
```

> **Note:** To install this package, you need to login to the GitHub registry. More information [here](https://github.com/simatic-ax/.github/blob/main/docs/personalaccesstoken.md).

## Namespaces

```iecst
USING Simatic.Ax.IO.Input;
USING Simatic.Ax.IO.Output;
```

## Quick Start Examples

### Example 1: Basic Binary Input (BinSignal)

```iecst
USING Simatic.Ax.IO.Input;

PROGRAM MyProgram
    VAR
        startButton : BinSignal;  // Start button input
        stopButton : BinSignal;   // Stop button input with inversion
    END_VAR
    
    // Configure stop button as normally closed (inverted)
    stopButton.invert := TRUE;
    
    // Read inputs cyclically (call at beginning of cycle)
    startButton.ReadCyclic(signal := %I0.0, valid := TRUE);
    stopButton.ReadCyclic(signal := %I0.1, valid := TRUE);
    
    // Check for start button press (rising edge)
    IF startButton.QRis() THEN
        // Start button was just pressed
        // Your start logic here
    END_IF;
    
    // Check current state
    IF startButton.Q() THEN
        // Start button is currently pressed
    END_IF;
    
    // Check for button release (falling edge)
    IF startButton.QFal() THEN
        // Start button was just released
    END_IF;
    
    // Check if signal changed
    IF startButton.HasChanged() THEN
        // Signal state changed in this cycle
    END_IF;
END_PROGRAM
```

### Example 2: Binary Input with Time Filtering (BinSignalExt)

```iecst
USING Simatic.Ax.IO.Input;

PROGRAM DebounceExample
    VAR
        noisyButton : BinSignalExt;  // Button with contact bounce
    END_VAR
    
    // Configure debounce timing
    noisyButton.ondelay := T#50ms;   // 50ms on-delay for debouncing
    noisyButton.offdelay := T#50ms;  // 50ms off-delay for debouncing
    
    // Read input cyclically
    noisyButton.ReadCyclic(signal := %I0.2, valid := TRUE);
    
    // Signal is now filtered - only changes after delay
    IF noisyButton.QRis() THEN
        // Button press confirmed after 50ms
    END_IF;
END_PROGRAM
```

### Example 3: Basic Binary Output (BinOutput)

```iecst
USING Simatic.Ax.IO.Output;

PROGRAM OutputExample
    VAR
        motorOutput : BinOutput;  // Motor control output
        lampOutput : BinOutput;   // Indicator lamp
        outputValue : BOOL;
    END_VAR
    
    // Set output states
    motorOutput.SetOn();           // Turn motor on
    lampOutput.SetOff();           // Turn lamp off
    
    // Or use SetQ for conditional setting
    motorOutput.SetQ(value := TRUE);
    
    // Toggle output
    lampOutput.Toggle();  // Changes state: OFF->ON or ON->OFF
    
    // Write outputs cyclically (call at end of cycle)
    motorOutput.WriteCyclic(Q => %Q0.0);
    lampOutput.WriteCyclic(Q => %Q0.1);
    
    // Check output state
    IF motorOutput.IsOn() THEN
        // Motor is currently on
    END_IF;
    
    // Detect output changes
    IF motorOutput.HasSwitchedOn() THEN
        // Motor just turned on in this cycle
    END_IF;
    
    IF motorOutput.HasSwitchedOff() THEN
        // Motor just turned off in this cycle
    END_IF;
END_PROGRAM
```

### Example 4: Analog Input with Tolerance

```iecst
USING Simatic.Ax.IO.Input;

PROGRAM AnalogExample
    VAR
        temperatureSensor : RealInput;   // Temperature sensor
        pressureSensor : IntInput;       // Pressure sensor
        temperature : REAL;
        pressure : INT;
    END_VAR
    
    // Read temperature with tolerance to filter noise
    temperatureSensor.ReadCyclic(
        value := %IW100,           // Hardware input word
        valid := TRUE,
        default := REAL#20.0,      // Default if invalid
        tolerance := REAL#0.5      // Only detect changes > 0.5°C
    );
    
    // Read pressure
    pressureSensor.ReadCyclic(
        value := %IW102,
        valid := TRUE,
        default := INT#0,
        tolerance := INT#10        // Only detect changes > 10 units
    );
    
    // Get values
    temperature := temperatureSensor.Q();
    pressure := pressureSensor.Q();
    
    // Check for significant changes
    IF temperatureSensor.HasChanged() THEN
        // Temperature changed by more than 0.5°C
    END_IF;
    
    // Check signal quality
    IF temperatureSensor.QBad() THEN
        // Sensor signal is invalid - using default value
    END_IF;
END_PROGRAM
```

### Example 5: Analog Output

```iecst
USING Simatic.Ax.IO.Output;

PROGRAM AnalogOutputExample
    VAR
        valvePosition : RealOutput;  // Analog valve control
        motorSpeed : IntOutput;      // Motor speed setpoint
        outputWord : DWORD;
    END_VAR
    
    // Set analog values
    valvePosition.SetValue(value := REAL#75.5);  // 75.5% open
    motorSpeed.SetValue(value := INT#1500);      // 1500 RPM
    
    // Write outputs cyclically (call at end of cycle)
    valvePosition.WriteCyclic(Q => outputWord);  // Outputs as DWORD
    %QW100 := outputWord;  // Write to hardware
    
    motorSpeed.WriteCyclic(Q => %QW102);  // Direct to hardware
    
    // Check for changes
    IF valvePosition.HasChanged() THEN
        // Valve position setpoint changed
    END_IF;
END_PROGRAM
```

### Example 6: Complete Application with Start/Stop Logic

```iecst
USING Simatic.Ax.IO.Input;
USING Simatic.Ax.IO.Output;

PROGRAM MotorControl
    VAR
        // Inputs
        startButton : BinSignal;
        stopButton : BinSignal;
        emergencyStop : BinSignal;
        motorRunning : BinSignal;  // Feedback from motor
        
        // Outputs
        motorContactor : BinOutput;
        runningLamp : BinOutput;
        faultLamp : BinOutput;
        
        // Internal
        motorEnabled : BOOL := FALSE;
    END_VAR
    
    // Configure inputs
    stopButton.invert := TRUE;        // Normally closed
    emergencyStop.invert := TRUE;     // Normally closed
    
    // Read all inputs at beginning of cycle
    startButton.ReadCyclic(signal := %I0.0);
    stopButton.ReadCyclic(signal := %I0.1);
    emergencyStop.ReadCyclic(signal := %I0.2);
    motorRunning.ReadCyclic(signal := %I0.3);
    
    // Control logic
    IF startButton.QRis() AND stopButton.Q() AND emergencyStop.Q() THEN
        motorEnabled := TRUE;
    END_IF;
    
    IF stopButton.QFal() OR emergencyStop.QFal() THEN
        motorEnabled := FALSE;
    END_IF;
    
    // Set outputs
    motorContactor.SetQ(value := motorEnabled);
    runningLamp.SetQ(value := motorRunning.Q());
    
    // Fault detection: motor should run but feedback is off
    IF motorEnabled AND NOT motorRunning.Q() THEN
        faultLamp.SetOn();
    ELSE
        faultLamp.SetOff();
    END_IF;
    
    // Write all outputs at end of cycle
    motorContactor.WriteCyclic(Q => %Q0.0);
    runningLamp.WriteCyclic(Q => %Q0.1);
    faultLamp.WriteCyclic(Q => %Q0.2);
END_PROGRAM
```

## Available Classes

### Input Classes

| Class | Description | Key Features |
|-------|-------------|--------------|
| `BinSignal` | Binary signal input | Edge detection, inversion, QBad status |
| `BinSignalExt` | Extended binary signal | All BinSignal features + on-delay/off-delay |
| `IntInput` | 16-bit signed integer | Range: -32768 to 32767, tolerance-based change detection |
| `DintInput` | 32-bit signed integer | Range: -2,147,483,648 to 2,147,483,647 |
| `WordInput` | 16-bit unsigned word | Range: 0 to 65535, bit pattern handling |
| `RealInput` | 32-bit floating-point | IEEE 754 single precision, tolerance filtering |
| `LRealInput` | 64-bit floating-point | IEEE 754 double precision, high accuracy |

### Output Classes

| Class | Description | Key Features |
|-------|-------------|--------------|
| `BinOutput` | Binary signal output | Edge detection, toggle, state management |
| `IntOutput` | 16-bit signed integer | Change detection |
| `DintOutput` | 32-bit signed integer | Change detection |
| `WordOutput` | 16-bit unsigned word | Bit pattern output |
| `DWordOutput` | 32-bit unsigned word | Bit pattern output |
| `LIntOutput` | 64-bit signed integer | Large value range |
| `RealOutput` | 32-bit floating-point | Outputs as DWORD bit pattern |
| `LRealOutput` | 64-bit floating-point | Outputs as LWORD bit pattern |

## Key Concepts

### Cyclic Execution

All I/O classes require cyclic method calls:

- **Inputs**: Call `ReadCyclic()` at the **beginning** of each cycle
- **Outputs**: Call `WriteCyclic()` at the **end** of each cycle

### Quality Status (QBad)

The `QBad()` method indicates signal validity:
- `FALSE` = Signal is valid and can be trusted
- `TRUE` = Signal is invalid (e.g., hardware error), default value is used

### Edge Detection

Binary signals provide automatic edge detection:
- `QRis()` = Rising edge (FALSE → TRUE) detected in current cycle
- `QFal()` = Falling edge (TRUE → FALSE) detected in current cycle
- Edges are only TRUE for one cycle

### Change Detection

Analog inputs support tolerance-based change detection:
- `HasChanged()` returns TRUE when value change exceeds tolerance
- Helps filter noise and minor fluctuations
- Tolerance parameter in `ReadCyclic()` method

## Best Practices

1. **Cyclic Calls**: Always call `ReadCyclic()` and `WriteCyclic()` every cycle
2. **Input First**: Read all inputs at the beginning of the cycle
3. **Output Last**: Write all outputs at the end of the cycle
4. **Use Tolerance**: Set appropriate tolerance for analog inputs to filter noise
5. **Check QBad**: Monitor signal quality for critical inputs
6. **Debounce**: Use `BinSignalExt` with delays for noisy digital inputs
7. **Edge Detection**: Use `QRis()` and `QFal()` for event-driven logic instead of state comparison

## Testing

The library includes comprehensive unit tests using AxUnit framework. Tests cover:
- Signal reading and edge detection
- Time-based filtering (on-delay/off-delay)
- Quality status handling
- Change detection with tolerance
- Output state management

## Contribution

Thanks for your interest in contributing. Anybody is free to report bugs, unclear documentation, and other problems regarding this repository in the Issues section or, even better, propose changes using Pull Requests.

## License and Legal Information

Please read the [Legal information](LICENSE.md)
