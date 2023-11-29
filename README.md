# Compiling On Desktop
Firstly, install Haxe. Then open up your Terminal and run:
```
haxelib install lime
haxelib install openfl
haxelib install flixel
haxelib install flixel-ui
haxelib install flixel-addons
```
Then
```haxelib set lime 7.7.0```

and
```haxelib run lime setup```

Finally, run this command to compile.
```lime test windows/mac/linux -release```

Note for Linux: You'll need to `apt-get` `g++-multilib` and `gcc-multilib`.

# Windows Only Dependencies
If you are planning to build for Windows, you also need to install Visual Studio 2019. 
While installing it, don't click on any of the options to install workloads.
Instead, go to the individual components tab and choose the following:

-   MSVC v142 - VS 2019 C++ x64/x86 build tools
-   Windows SDK (10.0.17763.0)

This will install about 4 GB of crap, but is necessary to build for Windows.
