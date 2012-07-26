# jsonToPlist

### A Command Line Utility for OSX

This is a simple application that when compiled and run takes a single argument, which is an absolute or relative path to a plist file. The output of this application will be a JSON file written in the same directory of the plist. 

### How Do I Use It?
`plistToJSON [sourceFilename] [targetFilename] [-r]`

###Arguments:

*sourceFilename*	Relative or Absolute path to a PList or JSON file that you wish to convert

*targetFilename*  Relative or Absolute path to which you would like to output the converted file

*-r*	Flag indicating we are reversing the conversion: Use this to convert from JSON to PList

###Examples:
`plistToJSON filename.plist`

This will output a JSON file filename.plist.json to the same directory as filename.plist

`plistToJSON filename.plist converted.json`

This will output a JSON file converted.josn to the same directory as filename.plist

`plistToJSON filename.json -r`
This will output a file filename.plist.json to the same directory as filename.plist

`plistToJSON filename.json converted.plist -r`
This will output a file converted.plist to the same directory as filename.plist

