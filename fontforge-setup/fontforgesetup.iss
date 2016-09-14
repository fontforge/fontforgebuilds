; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "FontForge"
#define MyAppFolder "FontForgeBuilds"
#define MyAppVersion GetDateTimeString('dd-mm-yyyy', '', '');
#define MyAppPublisher "FontForgeBuilds"
#define MyAppURL "http://www.fontforge.org"
#define MyAppExeName "run_fontforge.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{56748B9C-19AE-4689-B8C5-5A45AE0A993A}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppFolder}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
LicenseFile=Licenses\license.txt
InfoBeforeFile=..\ReleasePackage\VERSION.txt
OutputDir=.
OutputBaseFilename=FontForgeSetup-{#MyAppVersion}
SetupIconFile=Graphics\fontforge-installer-icon.ico
WizardImageFile=Graphics\fontforge-wizard.bmp
WizardSmallImageFile=Graphics\fontforge-wizard.bmp
Compression=lzma2/max
SolidCompression=yes
ChangesAssociations=yes
PrivilegesRequired=poweruser

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"
Name: "catalan"; MessagesFile: "compiler:Languages\Catalan.isl"
Name: "corsican"; MessagesFile: "compiler:Languages\Corsican.isl"
Name: "czech"; MessagesFile: "compiler:Languages\Czech.isl"
Name: "danish"; MessagesFile: "compiler:Languages\Danish.isl"
Name: "dutch"; MessagesFile: "compiler:Languages\Dutch.isl"
Name: "finnish"; MessagesFile: "compiler:Languages\Finnish.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "greek"; MessagesFile: "compiler:Languages\Greek.isl"
Name: "hebrew"; MessagesFile: "compiler:Languages\Hebrew.isl"
Name: "hungarian"; MessagesFile: "compiler:Languages\Hungarian.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"
Name: "nepali"; MessagesFile: "compiler:Languages\Nepali.islu"
Name: "norwegian"; MessagesFile: "compiler:Languages\Norwegian.isl"
Name: "polish"; MessagesFile: "compiler:Languages\Polish.isl"
Name: "portuguese"; MessagesFile: "compiler:Languages\Portuguese.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "serbiancyrillic"; MessagesFile: "compiler:Languages\SerbianCyrillic.isl"
Name: "serbianlatin"; MessagesFile: "compiler:Languages\SerbianLatin.isl"
Name: "slovenian"; MessagesFile: "compiler:Languages\Slovenian.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"
Name: "ukrainian"; MessagesFile: "compiler:Languages\Ukrainian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: "..\ReleasePackage\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs; Excludes: "fontforge.bat"
Source: "fontforge.bat"; DestDir: "{app}"; Flags: ignoreversion;
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{#MyAppName} console"; Filename: "{app}\fontforge.bat"
Name: "{group}\{#MyAppName} interactive console"; Filename: "{app}\fontforge-console.bat"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Registry]
;Root: HKLM; Subkey: "Software\FontForge"; Flags: uninsdeletekey
Root: HKCR; Subkey: ".sfd"; ValueType: string; ValueName: ""; ValueData: "FontForgeProject"; Flags: uninsdeletevalue 
Root: HKCR; Subkey: "FontForgeProject"; ValueType: string; ValueName: ""; ValueData: "FontForge Project"; Flags: uninsdeletekey
Root: HKCR; Subkey: "FontForgeProject\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\share\fontforge\sfd-icon.ico"
Root: HKCR; Subkey: "FontForgeProject\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1""" 

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Code]
procedure RecursiveDelete(Folder : String; Pattern : String; Extensions : TStringList);
var
  SearchPath : String;                             
  FilePath : String;
  FindRec : TFindRec;
begin
  //First search the current folder for any files matching the pattern
  SearchPath := ExpandConstant(Folder + '\' + Pattern);
  Log('[Recursive] searching ' + SearchPath);
  if FindFirst(SearchPath, FindRec) then begin
      try
        repeat
          if FindRec.Attributes and FILE_ATTRIBUTE_DIRECTORY = 0 then begin
              if Extensions.IndexOf(ExtractFileExt(FindRec.Name)) <> -1 then begin
                FilePath := ExpandConstant(Folder + '\' + FindRec.Name);
                Log('[Recursive] Deleting ' + FilePath);
                DeleteFile(FilePath);
              end;
          end;
        until not FindNext(FindRec);
      finally
        FindClose(FindRec);
      end;
  end;

  //Now recursively search any subdirectories
  SearchPath := ExpandConstant(Folder + '\*');
  Log('[Recursive] searching ' + SearchPath);
  if FindFirst(SearchPath, FindRec) then begin 
      try
        repeat
          if ((FindRec.Attributes and FILE_ATTRIBUTE_DIRECTORY) <> 0) and
             (CompareStr(FindRec.Name, '.') <> 0) and (CompareStr(FindRec.Name, '..') <> 0) then begin
            FilePath := ExpandConstant(Folder + '\' + FindRec.Name);
            Log('[Recursive] now searching: ' + FilePath);
            RecursiveDelete(FilePath, Pattern, Extensions);
          end;
        until not FindNext(FindRec);
      finally
        FindClose(FindRec);
      end;
  end;
end;


procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var ExtensionsToDelete : TStringList;
begin
  if CurUninstallStep = usUninstall then
  begin
    if MsgBox('Do you want to remove user preferences?', mbConfirmation, MB_YESNO) = IDYES then
    begin
      DelTree(ExpandConstant('{userappdata}\FontForge'), True, True, True);
    end;

    Log('Removing Python cache files (.pyc/.pyo)...');
    ExtensionsToDelete := TStringList.Create;
    ExtensionsToDelete.Add('.pyc');
    ExtensionsToDelete.Add('.pyo');
    RecursiveDelete('{app}\lib\python2.7', '*.py*', ExtensionsToDelete);
    ExtensionsToDelete.Free;
  end;
end;

//procedure CurStepChanged(CurStep: TSetupStep);
//begin
//  if CurStep=ssPostInstall then begin
//     RegWriteStringValue(HKEY_LOCAL_MACHINE, 'Software\FontForge',
//						 'InstallPath', ExpandConstant('{app}'));
//  end;
//end;
