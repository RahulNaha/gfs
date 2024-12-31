#define MyAppName "dem0"
#define MyAppVersion "1.0"
#define MyAppPublisher "My Company, Inc."
#define MyAppExeName "python-3.8.9-amd64.exe"
#define MyAppAssocName MyAppName + " File"
#define MyAppAssocExt ".myp"
#define MyAppAssocKey StringChange(MyAppAssocName, " ", "") + MyAppAssocExt

[Setup]
AppId={{C86E1ED2-9BE0-4563-9749-E34F5E3D8E0F}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\{#MyAppName}
ChangesAssociations=yes
DefaultGroupName={#MyAppName}
OutputDir=C:\Users\rahul\Downloads
OutputBaseFilename=mysetup
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}";
Name: "installTET"; Description: "Install TET 5.1 Components"; GroupDescription: "Optional Components"; Check: not IsTETInstalled
Name: "installVCredist"; Description: "Install VCredist_x86"; GroupDescription: "Optional Components"; Check: not IsVCredistInstalled
Name: "installWord2PDF"; Description: "Install Word2PDF"; GroupDescription: "Optional Components"; Check: not IsWord2PDFInstalled
Name: "installGS922"; Description: "Install GS922"; GroupDescription: "Optional Components"; Check: not IsGS922Installed
Name: "installGS9550"; Description: "Install GS9550"; GroupDescription: "Optional Components"; Check: not IsGS9550Installed
Name: "installAspell"; Description: "Install Aspell-0-50-3-3"; GroupDescription: "Optional Components"; Check: not IsAspellInstalled

[Files]
Source: "C:\Users\rahul\Downloads\All_Harmony_41_Softwares\All_Harmony_41_Softwares\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion; Check: not IsPythonInstalled
Source: "C:\Users\rahul\Downloads\All_Harmony_41_Softwares\All_Harmony_41_Softwares\TET-5.1-MSWin32-.NET-C-C++-Java.msi"; DestDir: "{app}"; Flags: ignoreversion; Tasks: installTET; Check: not IsTETInstalled
Source: "C:\Users\rahul\Downloads\All_Harmony_41_Softwares\All_Harmony_41_Softwares\vcredist_x86.exe"; DestDir: "{app}"; Flags: ignoreversion; Tasks: installVCredist; Check: not IsVCredistInstalled
Source: "C:\Users\rahul\Downloads\All_Harmony_41_Softwares\All_Harmony_41_Softwares\word2pdf.exe"; DestDir: "{app}"; Flags: ignoreversion; Tasks: installWord2PDF; Check: not IsWord2PDFInstalled
Source: "C:\Users\rahul\Downloads\All_Harmony_41_Softwares\All_Harmony_41_Softwares\gs922w32.exe"; DestDir: "{app}"; Flags: ignoreversion; Tasks: installGS922; Check: not IsGS922Installed
Source: "C:\Users\rahul\Downloads\All_Harmony_41_Softwares\All_Harmony_41_Softwares\gs9550w64.exe"; DestDir: "{app}"; Flags: ignoreversion; Tasks: installGS9550; Check: not IsGS9550Installed
Source: "C:\Users\rahul\Downloads\All_Harmony_41_Softwares\All_Harmony_41_Softwares\Aspell-0-50-3-3-Setup.exe"; DestDir: "{app}"; Flags: ignoreversion; Tasks: installAspell; Check: not IsAspellInstalled

[Registry]
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocExt}\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppAssocKey}"; ValueData: ""; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}"; ValueType: string; ValueName: ""; ValueData: "{#MyAppAssocName}"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},0"
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\Applications\{#MyAppExeName}\SupportedTypes"; ValueType: string; ValueName: ".myp"; ValueData: ""

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
; Primary Python installation
Filename: "{app}\{#MyAppExeName}"; Description: "Installing Python 3.8.9"; \
    Parameters: "/quiet InstallAllUsers=1 PrependPath=1"; \
    Flags: waituntilterminated runhidden; Check: not IsPythonInstalled

; Optional components installation
Filename: "msiexec.exe"; Description: "Installing TET 5.1"; \
    Parameters: "/i ""{app}\TET-5.1-MSWin32-.NET-C-C++-Java.msi"" /quiet"; \
    Flags: waituntilterminated runhidden; Tasks: installTET; Check: not IsTETInstalled

Filename: "{app}\vcredist_x86.exe"; Description: "Installing Visual C++ Redistributable"; \
    Parameters: "/install /quiet /norestart"; \
    Flags: waituntilterminated runhidden; Tasks: installVCredist; Check: not IsVCredistInstalled

Filename: "{app}\word2pdf.exe"; Description: "Installing Word2PDF"; \
    Parameters: "/VERYSILENT /SUPPRESSMSGBOXES"; \
    Flags: waituntilterminated runhidden; Tasks: installWord2PDF; Check: not IsWord2PDFInstalled

Filename: "{app}\gs922w32.exe"; Description: "Installing Ghostscript 9.22"; \
    Parameters: "/VERYSILENT /D=""{app}\gs922"""; \
    Flags: waituntilterminated runhidden; Tasks: installGS922; Check: not IsGS922Installed

Filename: "{app}\gs9550w64.exe"; Description: "Installing Ghostscript 9.55"; \
    Parameters: "/VERYSILENT /D=""{app}\gs9550"""; \
    Flags: waituntilterminated runhidden; Tasks: installGS9550; Check: not IsGS9550Installed

Filename: "{app}\Aspell-0-50-3-3-Setup.exe"; Description: "Installing Aspell"; \
    Parameters: "/VERYSILENT"; \
    Flags: waituntilterminated runhidden; Tasks: installAspell; Check: not IsAspellInstalled

[Code]
// Global variables to store installation status
var
  PythonIsInstalled: Boolean;
  TETIsInstalled: Boolean;
  VCredistIsInstalled: Boolean;
  Word2PDFIsInstalled: Boolean;
  GS922IsInstalled: Boolean;
  GS9550IsInstalled: Boolean;
  AspellIsInstalled: Boolean;

// Function to show component status message
procedure ShowComponentStatus(const ComponentName: string);
begin
  MsgBox(ComponentName + ' is already installed.' + #13#10 +
         'Installation of this component will be skipped.', 
         mbInformation, MB_OK);
end;

// Function to check registry values (handles both 32-bit and 64-bit)
function RegKeyExists32or64(const KeyName: string): Boolean;
begin
  Result := RegKeyExists(HKLM32, KeyName) or RegKeyExists(HKLM64, KeyName);
end;

function GetRegStringValue32or64(const KeyName, ValueName: string; var ResultStr: string): Boolean;
begin
  Result := RegQueryStringValue(HKLM32, KeyName, ValueName, ResultStr) or
            RegQueryStringValue(HKLM64, KeyName, ValueName, ResultStr);
end;

// Check and store installation status for all components
procedure CheckAllInstallations;
begin
  // Check Python
  PythonIsInstalled := RegKeyExists32or64('SOFTWARE\Python\PythonCore\3.8');
  if PythonIsInstalled then
    ShowComponentStatus('Python 3.8');

  // Check TET - Updated registry checks
  TETIsInstalled := RegKeyExists32or64('SOFTWARE\Classes\Installer\Products\71B6E025CA0A926429F4A4E363E318E3') or
                    RegKeyExists32or64('SOFTWARE\Classes\TET 5.1');
  if TETIsInstalled then
    ShowComponentStatus('TET 5.1');

  // Check VCredist
  VCredistIsInstalled := RegKeyExists32or64('SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x86');
  if VCredistIsInstalled then
    ShowComponentStatus('Visual C++ Redistributable');

  // Check Word2PDF
  Word2PDFIsInstalled := RegKeyExists32or64('SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Word2PDF');
  if Word2PDFIsInstalled then
    ShowComponentStatus('Word2PDF');

  // Check GS922
  GS922IsInstalled := RegKeyExists32or64('SOFTWARE\GPL Ghostscript\9.22');
  if GS922IsInstalled then
    ShowComponentStatus('Ghostscript 9.22');

  // Check GS9550
  GS9550IsInstalled := RegKeyExists32or64('SOFTWARE\GPL Ghostscript\9.55');
  if GS9550IsInstalled then
    ShowComponentStatus('Ghostscript 9.55');

  // Check Aspell
  AspellIsInstalled := RegKeyExists32or64('SOFTWARE\Aspell');
  if AspellIsInstalled then
    ShowComponentStatus('Aspell');
end;

function InitializeSetup(): Boolean;
var
  ComponentsToInstall: Boolean;
begin
  Log('Starting setup initialization...');
  CheckAllInstallations;
  
  // Check if there's anything to install
  ComponentsToInstall := not PythonIsInstalled or
                        not TETIsInstalled or
                        not VCredistIsInstalled or
                        not Word2PDFIsInstalled or
                        not GS922IsInstalled or
                        not GS9550IsInstalled or
                        not AspellIsInstalled;
                        
  if not ComponentsToInstall then
  begin
    MsgBox('All components are already installed on your system.' + #13#10 +
           'There is nothing to install.', mbInformation, MB_OK);
    Result := False;
  end
  else
  begin
    Result := True;
  end;
end;

// Simple getter functions to use in [Tasks] and [Run] section checks
function IsPythonInstalled: Boolean;
begin
  Result := PythonIsInstalled;
end;

function IsTETInstalled: Boolean;
begin
  Result := TETIsInstalled;
end;

function IsVCredistInstalled: Boolean;
begin
  Result := VCredistIsInstalled;
end;

function IsWord2PDFInstalled: Boolean;
begin
  Result := Word2PDFIsInstalled;
end;

function IsGS922Installed: Boolean;
begin
  Result := GS922IsInstalled;
end;

function IsGS9550Installed: Boolean;
begin
  Result := GS9550IsInstalled;
end;

function IsAspellInstalled: Boolean;
begin
  Result := AspellIsInstalled;
end;

// Installation progress monitoring
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssInstall then
    Log('Starting installation process...')
  else if CurStep = ssPostInstall then
  begin
    Log('Installation completed successfully.');
  end;
end;