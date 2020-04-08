[Setup]
AppName=vmpc
AppVersion=1.0
DefaultDirName={autopf}\vmpc
DefaultGroupName=vmpc
UninstallDisplayIcon={app}\vmpc.exe
WizardStyle=modern
Compression=lzma2
SolidCompression=yes
OutputDir="../../vmpc-binaries/installers/"
OutputBaseFilename="vmpc-installer"
ArchitecturesInstallIn64BitMode=x64

[Files]
Source: "../../vmpc-binaries/win64/vmpc.exe"; DestDir: "{app}"; Check: Is64BitInstallMode
Source: "../../vmpc-binaries/win32/vmpc.exe"; DestDir: "{app}"; Check: not Is64BitInstallMode; Flags: solidbreak

Source: "../../vmpc-home-dir/vMPC/*"; DestDir: "{%USERPROFILE}/vMPC"; Flags: ignoreversion recursesubdirs

[Icons]
Name: "{group}\vMPC2000XL"; Filename: "{app}\vmpc.exe"
Name: "{commondesktop}\vMPC2000XL"; Filename: "{app}\vmpc.exe"