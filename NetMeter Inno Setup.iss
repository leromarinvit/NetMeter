; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
AppName=NetMeter
AppVerName=NetMeter 1.1.4 BETA
AppPublisher=ReadError
AppPublisherURL=http://www.metal-machine.de/readerror/
AppSupportURL=http://www.metal-machine.de/readerror/
AppUpdatesURL=http://www.metal-machine.de/readerror/
DefaultDirName={pf}\NetMeter
DefaultGroupName=NetMeter
AllowNoIcons=yes
LicenseFile=C:\Users\ReadError\Documents\Borland Studio Projects\NetMeter\gpl.txt
InfoAfterFile=C:\Users\ReadError\Documents\Borland Studio Projects\NetMeter\ReadMe.txt
OutputBaseFilename=NetMeter_v114_beta
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\Users\ReadError\Documents\Borland Studio Projects\NetMeter\NetMeter.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\ReadError\Documents\Borland Studio Projects\NetMeter\ReadMe.txt"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\NetMeter"; Filename: "{app}\NetMeter.exe"
Name: "{group}\{cm:UninstallProgram,NetMeter}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\NetMeter"; Filename: "{app}\NetMeter.exe"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\NetMeter"; Filename: "{app}\NetMeter.exe"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\NetMeter.exe"; Description: "{cm:LaunchProgram,NetMeter}"; Flags: nowait postinstall skipifsilent

[Registry]
Root: HKCU; Subkey: "Software\Microsoft\Windows\CurrentVersion\Run"; ValueType: string; ValueName: "{app}\NetMeter.exe"; ValueData: "{app}\NetMeter.exe" ;Flags: uninsdeletevalue
