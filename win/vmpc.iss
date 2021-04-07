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
UsePreviousTasks=No

[Types]
Name: "custom"; Description: "Custom installation"; Flags: iscustom

[Components]
Name: standalone; Description: "Standalone"; Types: custom
Name: vst3; Description: "VST3"; Types: custom

[Tasks]
Name: remove_previous_user_data; Description: "Remove previous user data"; Flags: unchecked; Check: Foo

[Files]
Source: "../../vmpc-binaries/win64/VMPC2000XL.exe"; DestDir: "{app}"; Check: Is64BitInstallMode; Flags: ignoreversion; Components: standalone
Source: "../../vmpc-binaries/win32/VMPC2000XL.exe"; DestDir: "{app}"; Check: not Is64BitInstallMode; Flags: ignoreversion; Components: standalone

Source: "../../vmpc-binaries/win64/VMPC2000XL.vst3/*"; DestDir: "C:/Program Files/Common Files/VST3/VMPC2000XL.vst3"; Check: Is64BitInstallMode; Flags: ignoreversion recursesubdirs; Components: vst3
Source: "../../vmpc-binaries/win32/VMPC2000XL.vst3/*"; DestDir: "C:/Program Files (x86)/Common Files/VST3/VMPC2000XL.vst3"; Check: not Is64BitInstallMode; Flags: ignoreversion recursesubdirs; Components: vst3

Source: "../../vmpc-workspace/mpc/demo_data/*"; DestDir: "{userappdata}/VMPC2000XL/DemoData"; Flags: ignoreversion recursesubdirs

[Icons]
Name: "{group}\VMPC2000XL"; Filename: "{app}\VMPC2000XL.exe"; IconFilename: "{app}\VMPC2000XL.exe"
Name: "{commondesktop}\VMPC2000XL"; Filename: "{app}\VMPC2000XL.exe"; IconFilename: "{app}\VMPC2000XL.exe"

[Code]

function Foo: Boolean;
begin
  Result := True;
 end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    
    if (CompareText(WizardSelectedTasks(False), 'remove_previous_user_data') = 0) then
    begin
      DelTree(GetEnv('USERPROFILE') + '\vMPC', True, True, True)
    end;

  end;
end;