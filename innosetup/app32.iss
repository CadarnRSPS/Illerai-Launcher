[Setup]
AppName=Illerai Launcher
AppPublisher=Illerai
UninstallDisplayName=Illerai
AppVersion=${project.version}
AppSupportURL=https://illerai.com/
DefaultDirName={localappdata}\Illerai

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x86 x64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/app_small.bmp
WizardImageFile=${basedir}/left.bmp
SetupIconFile=${basedir}/app.ico
UninstallDisplayIcon={app}\Illerai.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=IlleraiSetup32

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\native-win32\Illerai.exe"; DestDir: "{app}"
Source: "${basedir}\native-win32\Illerai.jar"; DestDir: "{app}"
Source: "${basedir}\native\build32\Release\launcher_x86.dll"; DestDir: "{app}"
Source: "${basedir}\native-win32\config.json"; DestDir: "{app}"
Source: "${basedir}\native-win32\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Illerai\Illerai"; Filename: "{app}\Illerai.exe"
Name: "{userprograms}\Illerai\Illerai (configure)"; Filename: "{app}\Illerai.exe"; Parameters: "--configure"
Name: "{userprograms}\Illerai\Illerai (safe mode)"; Filename: "{app}\Illerai.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Illerai"; Filename: "{app}\Illerai.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Illerai.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Illerai.exe"; Description: "&Open Illerai"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Illerai.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.illerai\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"