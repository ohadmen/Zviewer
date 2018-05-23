; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{4D24E365-B225-4EAE-A2DE-827BBBF5F9AD}
AppName=3dom
AppVersion=1.0
;AppVerName=3dom 1.0
AppPublisher=3dom
AppPublisherURL=https://github.com/ohadmen/3dom
AppSupportURL=https://github.com/ohadmen/3dom
AppUpdatesURL=https://github.com/ohadmen/3dom
DefaultDirName={pf}\3dom
DisableProgramGroupPage=yes
OutputBaseFilename=setup
SetupIconFile=C:\Dropbox\envC\source\3dom\res\main.ico
Compression=lzma
SolidCompression=yes
ChangesAssociations = yes


[Registry]
Root: HKCR; Subkey: ".stl";                             ValueData: "3dom";          Flags: uninsdeletevalue; ValueType: string;  ValueName: ""
Root: HKCR; Subkey: "3dom";                     ValueData: "Program 3dom";  Flags: uninsdeletekey;   ValueType: string;  ValueName: ""
Root: HKCR; Subkey: "3dom\DefaultIcon";             ValueData: "{app}\3dom.exe,0";               ValueType: string;  ValueName: ""
Root: HKCR; Subkey: "3dom\shell\open\command";  ValueData: """{app}\3dom.exe"" ""%1""";  ValueType: string;  ValueName: ""



[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\Dropbox\envC\source\3dom\release\3dom.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Dropbox\envC\source\3dom\release\D3Dcompiler_47.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Dropbox\envC\source\3dom\release\libEGL.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Dropbox\envC\source\3dom\release\libGLESV2.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Dropbox\envC\source\3dom\release\opengl32sw.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Dropbox\envC\source\3dom\release\Qt5Core.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Dropbox\envC\source\3dom\release\Qt5Gui.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Dropbox\envC\source\3dom\release\Qt5Svg.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Dropbox\envC\source\3dom\release\Qt5Widgets.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Dropbox\envC\source\3dom\release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{commonprograms}\3dom"; Filename: "{app}\3dom.exe"
Name: "{commondesktop}\3dom"; Filename: "{app}\3dom.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\3dom.exe"; Description: "{cm:LaunchProgram,3dom}"; Flags: nowait postinstall skipifsilent

