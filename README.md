# Compiling On Desktop
Firstly, install Haxe. Then open up your Terminal and run
```
haxelib install lime
haxelib install openfl
haxelib install flixel
haxelib install flixel-ui
haxelib install flixel-addons
```
Then
```haxelib set lime 7.7.0```

And then
```haxelib run lime setup```

Finally, run this command to compile
```lime test windows/mac/linux/ -release```