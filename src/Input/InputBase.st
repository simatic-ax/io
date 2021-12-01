NAMESPACE Siemens.AX.IO.Input
    /// <summary>
    /// QBad-Status of binary input signal
    /// </summary>
    CLASS InputBase
        VAR PROTECTED
            _isQBad : BOOL; // TRUE : signal is invalid
        END_VAR

    /// <summary>
    /// Set the status to QBad
    /// </summary>
    /// <param name="value">OnDelay value for BinSignal</param>
    METHOD PROTECTED QBad
        VAR_INPUT
            value : BOOL;
        END_VAR
        _isQBad := value; 
    END_METHOD

    /// <summary>
    /// Returns the QBad-Status of BinSignal. If valid = FALSE --> QBad = TRUE 
    /// </summary>
    /// <returns>The QBad-Status of BinSignal</returns>
    METHOD PUBLIC QBad : BOOL
        QBad := _isQBad;
        ;
    END_METHOD

    END_CLASS
END_NAMESPACE

