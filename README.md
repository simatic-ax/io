# IO handling

In AX it is not possible to use variables pointing on the periphery (IOM) as references. This disadvantage can be solved with a workaround. In this package you can find some classes, which are reading from die DI area and can write to teh DQ area in the 1500 PLCs. This classes can be used as reference. But keep in mind that you always have to call the ReadCyclic or WriteCyclic method.

## Install this package

Enter:

```cli
apax add @simatic-ax/io
```

> to install this package you need to login into the GitHub registry. You'll find more information [here](https://github.com/simatic-ax/.github/blob/main/docs/personalaccesstoken.md)

## Namespace

```yml
Simatic.Ax.IO.Input
Simatic.Ax.IO.Output
```

## Available Classes

|||
|-|-|
|BinSignal      | Evaluate a boolean signal including rising and falling edge |
|BinSignalExt   | Like BinSginal but support also OnDelay and OffDeleay |
|DintInput      | Read and evaluate a DINT value|
|IntInput       | Read and evaluate a INT value|
|LRealInput     | Read and evaluate a LREAL value |
|RealInput      | Read and evaluate a REAL value |
|WordInput      | Read and evaluate a WORD value |
|BinOutput      | Evaluate and write a BOOL value |
|DIntOutput      | Evaluate and write a DINT value |
|DWordOutput      | Evaluate and write a DWORD value |
|IntOutput      | Evaluate and write a INT value |
|LRealOutput      | Evaluate and write a LREAL value |
|RealOutput      | Evaluate and write a REAL value |
|WordOutput      | Evaluate and write a WORD value |

## Contribution

Thanks for your interest in contributing. Anybody is free to report bugs, unclear documentation, and other problems regarding this repository in the Issues section or, even better, is free to propose any changes to this repository using Merge Requests.

## License and Legal information

Please read the [Legal information](LICENSE.md)
