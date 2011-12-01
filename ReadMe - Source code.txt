NetMeter source code
====================

The following things are required to compile NetMeter:

+ Borland Turbo Delphi Explorer 2006 (http://www.turboexplorer.com/)
NOTES:
  - Using an older Version of Delphi (i.e. Delphi 7) may require slight modifications to the code.
  - Using Delphi 2007 it should compile out of the box.
  - Using Delphi 2009 (and newer) may require more extensive modifications due to the introduction of unicode strings.

+ CoolTrayIcon component by Troels Jakobsen (http://subsimple.com/download/CoolTrayIcon.zip)
NOTES:
  - Turbo Delphi doesn't allow the installation of VCL-Components to the IDE. To work around this limitation, simple extract the component to a folder of your choice and add this folder to Delphi's library path. NetMeter will create the component in runtime.
  - This component is also needed because of its "SimpleTimer" class which NetMeter uses instead of the more bloated VCL timer component.

ADDITIONAL INFO:

+ UPX is used to compress the compiled .exe file (http://upx.sourceforge.net/)

+ InnoSetup is used to compile the installer (http://www.jrsoftware.org/isinfo.php)
