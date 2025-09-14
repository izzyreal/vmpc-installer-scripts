#define Get32BitExecutablePath GetEnv('32_BIT_EXECUTABLE_PATH')
#define Get64BitExecutablePath GetEnv('64_BIT_EXECUTABLE_PATH')
#define Get32BitVst3Path GetEnv('32_BIT_VST3_PATH')
#define Get64BitVst3Path GetEnv('64_BIT_VST3_PATH')
#define Get32BitLv2Path GetEnv('32_BIT_LV2_PATH')
#define Get64BitLv2Path GetEnv('64_BIT_LV2_PATH')
#define GetDemoDataPath GetEnv('DEMO_DATA_PATH')
#define GetOutputDir GetEnv('OUTPUT_DIR')

#define ApplicationVersion GetVersionNumbersString(Get64BitExecutablePath)

[Setup]
AppName=VMPC2000XL
AppVersion={#ApplicationVersion}
VersionInfoVersion={#ApplicationVersion}
DefaultDirName={autopf}\VMPC2000XL
DefaultGroupName=VMPC2000XL
UninstallDisplayIcon={app}\VMPC2000XL.exe
WizardStyle=modern
Compression=lzma2
SolidCompression=yes
OutputDir={#GetOutputDir}
OutputBaseFilename="VMPC2000XL-Installer-x86_64"
ArchitecturesInstallIn64BitMode=x64
UsePreviousTasks=No

[Types]
Name: "custom"; Description: "Custom installation"; Flags: iscustom

[Components]
Name: standalone; Description: "Standalone"; Types: custom
Name: vst3; Description: "VST3"; Types: custom
Name: lv2; Description: "LV2"; Types: custom

[Tasks]
Name: import_previous_user_data; Description: "Import previous user data (APS, SND, etc.)"; Check: PreviousUserDataExists
Name: import_previous_keyboard_mapping; Description: "Import previous keyboard mapping"; Check: PreviousKeyboardMappingExists
Name: import_previous_nvram; Description: "Import previous NVRAM (USER defaults)"; Check: PreviousNvramExists
Name: import_previous_vmpc_specific; Description: "Import previous VMPC specific config"; Check: PreviousVmpcSpecificExists
Name: remove_previous_user_data;   Description: "Remove previous user data";   Flags: unchecked; Check: PreviousUserDataExists
Name: remove_previous_application; Description: "Remove previous application"; Flags: unchecked; Check: PreviousApplicationExists
Name: remove_obsolete_demodata; Description: "Remove obsolete demo beats (recommended)"

[Files]
Source: "{#SourcePath}{#Get64BitExecutablePath}"; DestDir: {app}; Check: Is64BitInstallMode; Flags: ignoreversion; Components: standalone
Source: "{#SourcePath}{#Get32BitExecutablePath}"; DestDir: {app}; Check: not Is64BitInstallMode; Flags: ignoreversion; Components: standalone

Source: "{#SourcePath}{#Get64BitVst3Path}"; DestDir: "C:/Program Files/Common Files/VST3/VMPC2000XL.vst3"; Check: Is64BitInstallMode; Flags: ignoreversion recursesubdirs; Components: vst3
Source: "{#SourcePath}{#Get32BitVst3Path}"; DestDir: "C:/Program Files/Common Files/VST3/VMPC2000XL.vst3"; Check: not Is64BitInstallMode; Flags: ignoreversion recursesubdirs; Components: vst3

Source: "{#SourcePath}{#Get64BitLv2Path}"; DestDir: "C:/Program Files/Common Files/LV2/VMPC2000XL.lv2"; Check: Is64BitInstallMode; Flags: ignoreversion recursesubdirs; Components: lv2
Source: "{#SourcePath}{#Get32BitLv2Path}"; DestDir: "C:/Program Files/Common Files/LV2/VMPC2000XL.lv2"; Check: not Is64BitInstallMode; Flags: ignoreversion recursesubdirs; Components: lv2

Source: "{#SourcePath}{#GetDemoDataPath}"; DestDir: "{userappdata}/VMPC2000XL/DemoData"; Flags: ignoreversion recursesubdirs

[Dirs]
Name: "{userappdata}/VMPC2000XL/config"

[Icons]
Name: "{group}\VMPC2000XL"; Filename: "{app}\VMPC2000XL.exe"; IconFilename: "{app}\VMPC2000XL.exe"
Name: "{commondesktop}\VMPC2000XL"; Filename: "{app}\VMPC2000XL.exe"; IconFilename: "{app}\VMPC2000XL.exe"

[Code]
function PreviousUserDataExists: Boolean;
begin Result := False; if (DirExists(GetEnv('USERPROFILE') + '/vMPC/Stores/MPC2000XL')) then begin Result := True; end; end;

function PreviousKeyboardMappingExists: Boolean;
begin Result := False; if (FileExists(GetEnv('USERPROFILE') + '/vMPC/resources/keys.txt')) then begin Result := True; end; end;

function PreviousNvramExists: Boolean;
begin Result := False; if (FileExists(GetEnv('USERPROFILE') + '/vMPC/resources/nvram.vmp')) then begin Result := True; end; end;

function PreviousVmpcSpecificExists: Boolean;
begin Result := False; if (FileExists(GetEnv('USERPROFILE') + '/vMPC/resources/vmpc-specific.ini')) then begin Result := True; end; end;

function PreviousApplicationExists: Boolean;
begin Result := False;
  if Is64BitInstallMode then begin
    if (DirExists('C:/Program Files/vMPC')) then begin Result := True; end
    else begin
      if (DirExists('C:/Program Files (x86)/vMPC')) then begin Result := True; end;
    end;
  end;
end;

procedure DirectoryCopy(SourcePath, DestPath: string);
var
  FindRec: TFindRec;
  SourceFilePath: string;
  DestFilePath: string;
begin
  if FindFirst(SourcePath + '/*', FindRec) then
  begin
    try
      repeat
        if (FindRec.Name <> '.') and (FindRec.Name <> '..') then
        begin
          SourceFilePath := SourcePath + '\' + FindRec.Name;
          DestFilePath := DestPath + '\' + FindRec.Name;
          if FindRec.Attributes and FILE_ATTRIBUTE_DIRECTORY = 0 then
          begin
            if FileCopy(SourceFilePath, DestFilePath, False) then
            begin
              Log(Format('Copied %s to %s', [SourceFilePath, DestFilePath]));
            end
              else
            begin
              Log(Format('Failed to copy %s to %s', [SourceFilePath, DestFilePath]));
            end;
          end
            else
          begin
            if DirExists(DestFilePath) or ForceDirectories(DestFilePath) then
            begin
              Log(Format('Created %s', [DestFilePath]));
              DirectoryCopy(SourceFilePath, DestFilePath);
            end
              else
            begin
              Log(Format('Failed to create %s', [DestFilePath]));
            end;
          end;
        end;
      until not FindNext(FindRec);
    finally
      FindClose(FindRec);
    end;
  end
    else
  begin
    Log(Format('Failed to list %s', [SourcePath]));
  end;
end;

procedure CleanupOldVst3Lv2Paths32Bit;
begin
  if not Is64BitInstallMode then
  begin
    if DirExists('C:/Program Files (x86)/Common Files/VST3/VMPC2000XL.vst3') then
    begin
      DelTree('C:/Program Files (x86)/Common Files/VST3/VMPC2000XL.vst3', True, True, True);
      Log('Removed old VST3 from Program Files (x86)');
    end;

    if DirExists('C:/Program Files (x86)/Common Files/LV2/VMPC2000XL.lv2') then
    begin
      DelTree('C:/Program Files (x86)/Common Files/LV2/VMPC2000XL.lv2', True, True, True);
      Log('Removed old LV2 from Program Files (x86)');
    end;
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
      BaseResourcesPath: string;
      BaseConfigPath: string;
begin
  if CurStep = ssPostInstall then
  begin
    CleanupOldVst3Lv2Paths32Bit();
    
    BaseResourcesPath := GetEnv('USERPROFILE') + '/vMPC/resources/'
    BaseConfigPath := GetEnv('APPDATA') + '/VMPC2000XL/config/'
  
    if (WizardIsTaskSelected('import_previous_user_data')) then
    begin
      Log('========================== Importing previous user data')
      DirectoryCopy(GetEnv('USERPROFILE') + '/vMPC/Stores', GetEnv('USERPROFILE') + '/Documents/VMPC2000XL/Volumes')
    end;

    if (WizardIsTaskSelected('import_previous_keyboard_mapping')) then
    begin
      Log('========================== Importing previous keyboard mapping')
      FileCopy(BaseResourcesPath + 'keys.txt', BaseConfigPath + 'keys.txt', False)
    end;

    if (WizardIsTaskSelected('import_previous_nvram')) then
    begin
      Log('========================== Importing previous nvram')
      FileCopy(BaseResourcesPath + 'nvram.vmp', BaseConfigPath + 'nvram.vmp', False)
    end;

    if (WizardIsTaskSelected('import_previous_vmpc_specific')) then
    begin
      Log('========================== Importing previous VMPC specific settings')
      FileCopy(BaseResourcesPath + 'vmpc-specific.ini', BaseConfigPath + 'vmpc-specific.ini', False)
    end;

    if (WizardIsTaskSelected('remove_previous_user_data')) then
    begin
      Log('====================== Removing previous user data')
      DelTree(GetEnv('USERPROFILE') + '/vMPC', True, True, True)
    end;

    if (WizardIsTaskSelected('remove_previous_application')) then
    begin
      Log('====================== Removing previous application')
      if Is64BitInstallMode then begin
        DelTree('C:/Program Files/vMPC', True, True, True) end
      else begin
        DelTree('C:/Program Files (x86)/vMPC', True, true, True)
        end;
      end;
    end;
end;

