# Filish
Simple Windows utility to compute hash checksums for files and check them using the Windows Explorer context menu

![Image of Filish](https://raw.githubusercontent.com/roobie/Filish/master/assets/filish.PNG)


## Building

use lazbuild or build from lazarus directly.


## API

```
filish.exe [mode] [file]

where [mode] can be
- generate
  computes the hash of the given file, and writes it to "[file].sha512.sig.txt"
- check
  computes the hash of the file and compares the result with the contents of "[file].sha512.sig.txt" and reports whether it is a match or not.


and [file] is an absolute path to a file
```


## "Installing"

Edit the `.reg` file to point to your locally compiled version and import it, whereafter you should see both 'Calculate hash' and 'Check hash' in the context menu, when you right-click a file. 
