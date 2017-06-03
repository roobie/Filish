# Filish
Simple Windows utility to compute hash checksums for files and check them using
the Windows Explorer context menu

![Image of Filish](https://raw.githubusercontent.com/roobie/Filish/master/assets/filish.PNG)


## Installing (manual process, for now)

1. [Download](https://github.com/roobie/Filish/releases) a release, and unzip it.
2. Put the `Filish` folder in `C:\Program Files\`
3. Import the `install.reg` file (adds two entries in the Windows Explorer
   context menu)
4. Done.

## Uninstalling

1. Import the `uninstall.reg`, to delete the registry keys added by `install.reg`
2. Delete the `C:\Program Files\Filish` folder
3. Done.


## Building

use `lazbuild` or build from lazarus directly.


## API

```
filish.exe [mode] [file]

where [mode] can be
- generate
  computes the hash of the given file, and writes it to "[file].sha512.sig.txt"
- check
  computes the hash of the file and compares the result with the contents of
  "[file].sha512.sig.txt" and reports whether it is a match or not.


and [file] is an absolute path to a file
```