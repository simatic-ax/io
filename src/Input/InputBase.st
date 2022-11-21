NAMESPACE Simatic.Ax.IO.Input
    /// QBad-Status of binary input signal
    CLASS InputBase
        VAR PROTECTED
            _isQBad : BOOL; // TRUE : signal is invalid
        END_VAR

    /// Set the status to QBad
    /// OnDelay value for BinSignal
    METHOD PROTECTED QBad
        VAR_INPUT
            value : BOOL;
        END_VAR
        _isQBad := value; 
    END_METHOD

    /// Returns the QBad-Status of BinSignal. If valid = FALSE --> QBad = TRUE 
    /// The QBad-Status of BinSignal
    METHOD PUBLIC QBad : BOOL
        QBad := _isQBad;
        ;
    END_METHOD

    END_CLASS
END_NAMESPACE

