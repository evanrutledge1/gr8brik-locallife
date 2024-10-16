# Chromium Portable — PortableApps.com Installer custom code
# © 2015, Aluísio Augusto Silva Gonçalves
# Use of this source code is governed by a BSD-style license that can be
# found in the Other\Source\License.txt file of this distribution.


!include "Languages\English.nsh"
!include "Languages\PortugueseBR.nsh"


!macro CustomCodePreInstall
	StrCpy $R0 "$INSTDIR\App\Chromium\32\Data"
	${If} ${FileExists} $R0
		#MessageBox MB_OK|MB_ICONEXCLAMATION "We have detected user data in the application folder, at $R0.  This likely means at some point the Chromium executable has been run directly, bypassing the launcher (ChromiumPortable.exe).$\r$\nIf you always use the launcher, please visit chrome://version/ in Chromium Portable and make sure your profile path is not under the App directory, then remove $R0.$\r$\nOtherwise, please note that not using the launcher is unsupported "
	${EndIf}
!macroend

!macro CustomCodePostInstall
	# Keep this in sync with whatever the Installer does to check whether to execute CustomCodeOptionalCleanup.
	SectionGetFlags 1 $R0
	IntOp $R0 $R0 & ${SF_SELECTED}
	${If} $R0 != ${SF_SELECTED}
		DeleteINIStr "$INSTDIR\App\AppInfo\Launcher\ChromiumPortable.ini" "Launch" "ProgramExecutable64"
	${EndIf}
!macroend
