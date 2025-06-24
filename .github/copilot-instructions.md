// Settings for Copilot usage in this project

// 1. Code Generation Guidelines:
// - Always generate code in IEC61131-3 Structured Text (ST) format.
// - All functions, function blocks, classes, methods and types must include inline documentation in the following format:
//   /// <Brief description of the function>
//   /// Input: <Parameter descriptions>
//   /// Returns: <Return value description>
// Example:
//   /// Converts a subset of a CHAR array to a string.
//   /// Input: arr - Input CHAR array to convert.
//   ///        startIdx - Start index of the subset.
//   ///        endIdx - End index of the subset.
//   /// Returns: A string representation of the specified subset of the CHAR array.
//   FUNCTION ToString : STRING
//       VAR_INPUT
//           arr : ARRAY[*] OF CHAR; // Input CHAR array to convert
//           startIdx : INT; // Start index of the subset
//           endIdx : INT; // End index of the subset
//       END_VAR
//       ;
//   END_FUNCTION

// 2. Unit Test Guidelines:
// Test-Files shall be stored in the folder `test`.
// - Use AxUnit for unit testing.
// - Tests should follow the structure below:
//   - {TestFixture} to define a test class.
//   - {Test} for individual test methods.
//   - Support parameterized tests using {Test(...)} annotations.
// Example:
//   USING AxUnit.Assert;
//   NAMESPACE AnyNamespace
//       {TestFixture}
//       CLASS TestClass
//           VAR
//               val : LINT;
//               val2 : ULINT;
//               res : BOOL;
//           END_VAR
//
//           {Test}
//           METHOD PUBLIC Convert_STRING_0_TO_LINT_0
//               res := StringToAnyInt(str := '0', value => val);
//               Equal(expected := 0, actual := val);
//               Equal(expected := TRUE, actual := res);
//           END_METHOD
//
//           {Test(str := STRING#'18446744073709551746', value := ULINT#0, success := FALSE)}
//           {Test(str := STRING#'18446744073709551800', value := ULINT#0, success := FALSE)}
//           METHOD PUBLIC Convert_STRING_TO_ULINT
//               VAR_INPUT
//                   str : STRING;
//                   value : ULINT;
//                   success : BOOL;
//               END_VAR
//               VAR_TEMP
//                   resVal : ULINT;
//               END_VAR
//               res := StringToULint(str := str, value => resVal);
//               Equal(expected := value, actual := resVal);
//               Equal(expected := success, actual := res);
//           END_METHOD
//       END_CLASS
//   END_NAMESPACE

// 3. Documentation Rules:
// - All types, functions, and methods must include inline documentation.
// - Use the following format for documentation:
//   /// <Brief description>
//   /// Input: <Parameter descriptions>
//   /// Returns: <Return value description>
// - Ensure that all parameters and return values are clearly described.
// - Documentation must be placed directly above the method or function it describes.

// 4. File Organization Rules:
// - Place all source files in the `src` folder.
// - Place all test files in the `test` folder.
// - Use descriptive filenames that reflect the functionality of the file.

// 5. Naming Conventions:
// - Use PascalCase for function and type names (e.g., `ToString`, `SimotionDateTime`).

// 6. Code Format Rules:
// - Always generate code in IEC61131-3 Structured Text (ST) format.

// 7. Constant Declaration Rules:
// - Constants, like 1.0 or 23 except for `INT`, `BOOL` and `LREAL`, must always include explicit type annotations.
//   Examples:
//     - REAL#1.0
//     - ULINT#1
//     - SINT#23

// 8. Return Statement Rules:
// - `RETURN` cannot take a return value.
// - Return values must always be assigned to the function or method name before using `RETURN`.
//   Example:
//     FunctionName := ReturnValue;
//     RETURN;

// 9. Method and Function Rules:
// - All methods and functions must contain at least one statement or a semicolon (`;`).

// 10. Unit Tests
// - Unit Tests must be declared in a namespace

// 11. Structured Text
// 11.1 Initialization of arrays
// - array must initialized in the declaration 
// 11.1.1 One dimensional arrays
// - arr : ARRAY[1..100] OF INT := [50(2), 50(3)];
// - A: ARRAY[1..2, 1..3] of INT := [1, 2, 3, 4, 5, 6];
// 11.1.2 Two dimensional arrays
// two_dim_array : ARRAY[0..2, 0..2] OF INT := [1, 2, 3, 4, 5, 6, 7, 8, 9];
//             // [0, 0] := 1, [0, 1] := 2, [0, 2] := 3
//             // [1, 0] := 4, [1, 1] := 5, [1, 2] := 6
//             // [2, 0] := 7, [2, 1] := 8, [2, 2] := 9
// 11.2.0 Types
// 11.2.1 Enumerations
//    TYPE
//        Colours : (RED, GREEN, BLUE) := RED;
//    END_TYPE
//    Usage: t : Colours := Colours#RED;
// 11.3.0 Control structures
// 11.3.1 If statement
//    IF (valueofBool) THEN
//        ;
//    ELSE
//        ;
//    END_IF;

// 12. Function Block and Class Guidelines:
// - Function blocks and classes must include inline documentation in the following format:
//   /// <Brief description of the function block or class>
//   /// Input: <Parameter descriptions, if applicable>
//   /// Returns: <Return value description, if applicable>
// - Documentation must be placed directly above the method or function block it describes.
// Example for a function block:
//   /// A function block for controlling a motor.
//   FUNCTION_BLOCK MotorControl
//       VAR_INPUT
//           speed : REAL; // Desired motor speed
//           direction : BOOL; // Motor direction (TRUE = forward, FALSE = reverse)
//       END_VAR
//       VAR_OUTPUT
//           status : BOOL; // Motor status (TRUE = running, FALSE = stopped)
//       END_VAR
//       ;
//   END_FUNCTION_BLOCK
//
// Example for a class:
//   /// A class representing a 3D point.
//   CLASS Point3D
//       VAR
//           x : REAL; // X-coordinate
//           y : REAL; // Y-coordinate
//           z : REAL; // Z-coordinate
//       END_VAR
//       /// Calculates the distance to another 3D point.
//       /// Input: other - Another 3D point.
//       /// Returns: The distance to the other point as a REAL value.
//       METHOD PUBLIC GetDistance : REAL
//           VAR_INPUT
//               other : Point3D; // Another 3D point
//           END_VAR
//           ;
//       END_METHOD
//       /// Converts the 3D point to a string representation.
//       /// Input: None.
//       /// Returns: A string representation of the 3D point in the format "(x, y, z)".
//       METHOD PUBLIC ToString : STRING
//           ;
//       END_METHOD
//   END_CLASS
// 14. Interfaces 
// /// Interface for calculation classes.
// INTERFACE ICalculation
//    METHOD Calculate : REAL END_METHOD // Calculates something
// END_INTERFACE
