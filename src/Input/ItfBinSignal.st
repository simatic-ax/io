NAMESPACE Simatic.Ax.IO.Input

    INTERFACE ItfBinSignal
        METHOD Q : BOOL
        END_METHOD
        METHOD QRis : BOOL
        END_METHOD
        METHOD QFal : BOOL
        END_METHOD
        METHOD QBad : BOOL
        END_METHOD
    END_INTERFACE

    CLASS NullBinSignal
        IMPLEMENTS ItfBinSignal

        METHOD PUBLIC Q : BOOL
            ;
        END_METHOD

        METHOD PUBLIC QRis : BOOL
            ;
        END_METHOD

        METHOD PUBLIC QFal : BOOL
            ;
        END_METHOD

        METHOD PUBLIC QBad : BOOL
            ;
        END_METHOD
    END_CLASS

END_NAMESPACE
