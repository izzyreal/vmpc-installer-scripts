[Setup]

#define VersionInExecutable GetFileVersion('../../vmpc-binaries/win64/vmpc2000xl.exe')

AppName=vMPC2000XL
AppVersion={#VersionInExecutable}
DefaultDirName={autopf}\vMPC2000XL
DefaultGroupName=vMPC2000XL
UninstallDisplayIcon={app}\vmpc2000xl.exe
WizardStyle=modern
Compression=lzma2
SolidCompression=yes
OutputDir="../../vmpc-binaries/installers/"
OutputBaseFilename="vmpc2000xl-installer"
ArchitecturesInstallIn64BitMode=x64

[Files]
Source: "../../vmpc-binaries/win64/vmpc2000xl.exe"; DestDir: "{app}"; Check: Is64BitInstallMode; Flags: ignoreversion
Source: "../../vmpc-binaries/win32/vmpc2000xl.exe"; DestDir: "{app}"; Check: not Is64BitInstallMode; Flags: solidbreak ignoreversion

Source: "../../vmpc-home-dir/vMPC/*"; DestDir: "{%USERPROFILE}/vMPC"; Flags: ignoreversion recursesubdirs

[Icons]
Name: "{group}\vMPC2000XL"; Filename: "{app}\vmpc2000xl.exe"; IconFilename: "{app}\vmpc2000xl.exe"
Name: "{commondesktop}\vMPC2000XL"; Filename: "{app}\vmpc2000xl.exe"; IconFilename: "{app}\vmpc2000xl.exe"