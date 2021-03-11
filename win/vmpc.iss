[Setup]

#define VersionInExecutable GetFileVersion('../../vmpc-binaries/win64/VMPC2000XL.exe')

AppName=VMPC2000XL
AppVersion={#VersionInExecutable}
VersionInfoVersion={#VersionInExecutable}
DefaultDirName={autopf}\VMPC2000XL
DefaultGroupName=VMPC2000XL
UninstallDisplayIcon={app}\VMPC2000XL.exe
WizardStyle=modern
Compression=lzma2
SolidCompression=yes
OutputDir="../../vmpc-binaries/installers/"
OutputBaseFilename="VMPC2000XL-Installer-x86_64"
ArchitecturesInstallIn64BitMode=x64

[Files]
Source: "../../vmpc-binaries/win64/VMPC2000XL.exe"; DestDir: "{app}"; Check: Is64BitInstallMode; Flags: ignoreversion
Source: "../../vmpc-binaries/win32/VMPC2000XL.exe"; DestDir: "{app}"; Check: not Is64BitInstallMode; Flags: solidbreak ignoreversion

Source: "../../vmpc-home-dir/vMPC/*"; DestDir: "{%USERPROFILE}/vMPC"; Flags: ignoreversion recursesubdirs

[Icons]
Name: "{group}\VMPC2000XL"; Filename: "{app}\VMPC2000XL.exe"; IconFilename: "{app}\VMPC2000XL.exe"
Name: "{commondesktop}\VMPC2000XL"; Filename: "{app}\VMPC2000XL.exe"; IconFilename: "{app}\VMPC2000XL.exe"