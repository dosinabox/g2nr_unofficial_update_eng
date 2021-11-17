###################################
##      Headers                  ##
###################################

!include "MUI.nsh"
!include "FileFunc.nsh"

###################################
##            Main               ##
###################################

!define MOD_VERSION "26_eng"
!define MOD_DATE "9.19"
!define MOD_NAME "G2a_NR_ScriptPatch_v${MOD_VERSION}"
!define MOD_NAME_RU "G2 NotR Script-Patch"
!define MOD_DETAILED_VERSION "1.26.${MOD_DATE}"
!define MOD_AUTHOR "Fizzban, Efectivo, Dimus, D36, Kvincius, N1kX, GaroK"
!define INSTALLER_NAME "${MOD_NAME}_install"
!define UNINSTALLER_NAME "${MOD_NAME}_uninstall"
!define REGISTRY_PATH "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MOD_NAME}"

Name "${MOD_NAME}"
OutFile "${INSTALLER_NAME}.exe"

VIProductVersion "${MOD_DETAILED_VERSION}"
VIAddVersionKey "FileVersion" "${INSTALLER_VERSION}"
VIAddVersionKey "LegalCopyright" "© ${MOD_AUTHOR}"
VIAddVersionKey "FileDescription" "${MOD_NAME_RU}"
VIAddVersionKey "ProductVersion" "1.${MOD_VERSION}"

Unicode true
SetCompressor lzma

###################################
##      Interface                ##
###################################

!define MUI_ICON "${MOD_NAME}.ico"
!define MUI_UNICON "${MOD_NAME}.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "logo_eng.bmp"
!define MUI_HEADERIMAGE_UNBITMAP "logo_eng.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP "pic_eng.bmp"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "pic_eng.bmp"

Caption "${MOD_NAME_RU} (v${MOD_VERSION}) - install"
!define MUI_TEXT_WELCOME_INFO_TITLE " "
!define MUI_TEXT_WELCOME_INFO_TEXT "Script-Patch fixes a large of bugs and shortcomings of the original game while adding quality of life features. You need SystemPack/Union + PlayerKit in order to play. Old save files are not supported - new game is required!"

!define MUI_TEXT_DIRECTORY_SUBTITLE " "
DirText "Script-Patch will be installed in the following folder. \
$\n$\nTo install in a different folder, click Browse and select desired folder. If 'Next' is greyed out, you need to install PlayerKit - official mod starter."

!define MUI_TEXT_COMPONENTS_TITLE "Choose components."
!define MUI_TEXT_COMPONENTS_SUBTITLE " "
!define MUI_COMPONENTSPAGE_TEXT_TOP "Select the components you wish to install. Click 'Install' to continue. "
!define MUI_COMPONENTSPAGE_TEXT_COMPLIST "Components to install:"
!define MUI_COMPONENTSPAGE_SMALLDESC

!define MUI_TEXT_INSTALLING_TITLE "Installing..."
!define MUI_TEXT_INSTALLING_SUBTITLE " "

!define MUI_TEXT_FINISH_INFO_TITLE "$\t   $\n$\tCompleted!"
!define MUI_TEXT_FINISH_INFO_TEXT "Have a nice game! Click 'Finish' to complete the installation."

UninstallCaption "${MOD_NAME_RU} (v${MOD_VERSION}) - uninstall"

!define MUI_UNTEXT_COMPONENTS_TITLE "Choose components to uninstall"
!define MUI_UNTEXT_COMPONENTS_SUBTITLE " "

!define MUI_UNTEXT_FINISH_INFO_TITLE " "
!define MUI_UNTEXT_FINISH_INFO_TEXT "All of the Script-Patch components you selected have been removed. Click 'Finish' to complete."

BrandingText " "

###################################
##     Страницы  инсталлятора    ##
###################################

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

###################################
##    Страницы  деинсталлятора   ##
###################################

!define MUI_COMPONENTSPAGE_TEXT_TOP "Select Script-Patch components that you wish to remove. Click 'Remove' to continue."
!define MUI_COMPONENTSPAGE_TEXT_COMPLIST "Components to remove:"
!insertmacro MUI_UNPAGE_COMPONENTS
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

###################################
##           Languages           ##
###################################

!insertmacro MUI_LANGUAGE "English"

###################################
##          Инсталляция          ##
###################################

Section "Main files" SecMain
	SectionIn RO
	CreateDirectory "$INSTDIR\saves_${MOD_NAME}\current"

	SetOutPath "$INSTDIR\Data\ModVDF"
	File "g2a_nr_scriptpatch_v${MOD_VERSION}.mod"
	File "g2a_nr_scriptpatch_v${MOD_VERSION}_scripts.mod"
	File "g2a_nr_scriptpatch_v${MOD_VERSION}_plugins.mod"

	SetOutPath "$INSTDIR\system"
	File "${MOD_NAME}.ico"
	File "${MOD_NAME}.ini"
	File "${MOD_NAME}.rtf"

	SetOutPath "$INSTDIR\_work\Data\Music\newworld"
	File "KAS_Loop_DayStd.sgt"

	SetOutPath $INSTDIR
	File "Changelog_${MOD_NAME}.txt"
	WriteUninstaller "$INSTDIR\${UNINSTALLER_NAME}.exe"

	WriteRegStr HKCU "Software\${MOD_NAME}" "InstallLocation" $INSTDIR
	WriteRegStr HKLM "${REGISTRY_PATH}" "DisplayName" "${MOD_NAME_RU} (v${MOD_VERSION})" 
	WriteRegStr HKLM "${REGISTRY_PATH}" "DisplayVersion" "${MOD_DETAILED_VERSION}" 
	WriteRegStr HKLM "${REGISTRY_PATH}" "InstallLocation" $INSTDIR
	WriteRegStr HKLM "${REGISTRY_PATH}" "UninstallString" "$INSTDIR\${UNINSTALLER_NAME}.exe"
	WriteRegStr HKLM "${REGISTRY_PATH}" "HelpLink" "https://worldofplayers.ru/threads/36817"
	WriteRegStr HKLM "${REGISTRY_PATH}" "Publisher" "${MOD_AUTHOR}"
	WriteRegStr HKLM "${REGISTRY_PATH}" "DisplayIcon" "$INSTDIR\system\${MOD_NAME}.ico"
	WriteRegDWORD HKLM "${REGISTRY_PATH}" "EstimatedSize" "255700"
SectionEnd

Section "Additional english speech files" SecAdditional_1
	SetOutPath "$INSTDIR\Data\ModVDF"
	File "g2a_nr_scriptpatch_v${MOD_VERSION}_speech_add.mod"
SectionEnd

Section /o "Extended Valley of Mines" SecAdditional_2
	SetOutPath "$INSTDIR\Data\ModVDF"
	File "g2a_nr_scriptpatch_v${MOD_VERSION}_wasteland.mod"
SectionEnd

###################################
##         Деинсталляция         ##
###################################

Section "Un.Unistall modification" SecUninstall_Main
	SectionIn RO
	Delete "$INSTDIR\system\${MOD_NAME}.ico"
	Delete "$INSTDIR\system\${MOD_NAME}.ini"
	Delete "$INSTDIR\system\${MOD_NAME}.rtf"
	Delete "$INSTDIR\_work\Data\Music\newworld\KAS_Loop_DayStd.sgt"
	Delete "$INSTDIR\Data\ModVDF\g2a_nr_scriptpatch_v${MOD_VERSION}.mod"
	Delete "$INSTDIR\Data\ModVDF\g2a_nr_scriptpatch_v${MOD_VERSION}_scripts.mod"
	Delete "$INSTDIR\Data\ModVDF\g2a_nr_scriptpatch_v${MOD_VERSION}_plugins.mod"
	Delete "$INSTDIR\Data\ModVDF\g2a_nr_scriptpatch_v${MOD_VERSION}_speech_add.mod"
	Delete "$INSTDIR\Data\ModVDF\g2a_nr_scriptpatch_v${MOD_VERSION}_wasteland.mod"
	Delete "$INSTDIR\Data\ModVDF\g2a_nr_scriptpatch_v${MOD_VERSION}_hotfix.mod"
	Delete "$INSTDIR\Changelog_${MOD_NAME}.txt"
	Delete "$INSTDIR\${UNINSTALLER_NAME}.exe"
	DeleteRegKey HKLM "${REGISTRY_PATH}"
SectionEnd

Section /o "Un.Delete saves" SecUninstall_Saves
	RMDir /r "$INSTDIR\saves_${MOD_NAME}"
SectionEnd

###################################
##     Описание компонентов      ##
###################################

LangString DESC_SecMain ${LANG_ENGLISH} "Main files."
LangString DESC_SecAdditional_1 ${LANG_ENGLISH} "Uncheck if you want to play without english speech."
LangString DESC_SecAdditional_2 ${LANG_ENGLISH} "Wasteland Mod - restores Valley of Mines areas from Gothic 1."

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SecMain} $(DESC_SecMain)
!insertmacro MUI_DESCRIPTION_TEXT ${SecAdditional_1} $(DESC_SecAdditional_1)
!insertmacro MUI_DESCRIPTION_TEXT ${SecAdditional_2} $(DESC_SecAdditional_2)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

###################################
##          Functions            ##
###################################

Function .onInit
	SetSilent normal
	!insertmacro MUI_LANGDLL_DISPLAY
	ReadRegStr $INSTDIR HKCU "Software\${MOD_NAME}" "InstallLocation"
	StrCmp $INSTDIR "" "" InstallPathIsFound
	StrCpy $INSTDIR "$PROGRAMFILES\JoWooD\Gothic II"
	InstallPathIsFound:
FunctionEnd

Function .onVerifyInstDir
	IfFileExists "$INSTDIR\system\GothicStarter.exe" CheckIsSuccessful
	Abort
	CheckIsSuccessful:
FunctionEnd
