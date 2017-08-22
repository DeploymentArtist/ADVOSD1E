@ECHO OFF
call "C:\Program Files (x86)\Windows Kits\8.1\Assessment and Deployment Kit\Deployment Tools\DandISetEnv.bat"
IF %1.==. GOTO :INPUTERROR

SET TARGETPATH=%1

IF EXIST "%tmp%\winpe" rd "%tmp%\winpe" /s /q
md "%tmp%\winpe"
IF NOT EXIST "%TARGETPATH%\Boot" md "%TARGETPATH%\Boot"
IF NOT EXIST "%TARGETPATH%\Boot\x86" md "%TARGETPATH%\Boot\x86"
IF NOT EXIST "%TARGETPATH%\Boot\Fonts" md "%TARGETPATH%\Boot\Fonts"

imagex /mount "c:\Program Files (x86)\Windows Kits\8.1\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\en-us\winpe.wim" 1 "%tmp%\winpe%"

xcopy "C:\Program Files (x86)\Windows Kits\8.1\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\Media\Boot\boot.sdi" "%TARGETPATH%\" /y
xcopy "C:\Program Files (x86)\Windows Kits\8.1\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\Media\Boot\Fonts\wgl4_boot.ttf" "%TARGETPATH%\Boot\Fonts\" /y
xcopy "%tmp%\winpe\Windows\Boot\PXE\abortpxe.com" "%TARGETPATH%\Boot\x86\" /y 
xcopy "%tmp%\winpe\Windows\Boot\PXE\bootmgr.exe" "%TARGETPATH%\Boot\x86\" /y
xcopy "%tmp%\winpe\Windows\Boot\PXE\pxeboot.com" "%TARGETPATH%\Boot\x86\" /y 
xcopy "%tmp%\winpe\Windows\Boot\PXE\pxeboot.n12" "%TARGETPATH%\Boot\x86\" /y

imagex /unmount "%tmp%\winpe"
GOTO DONE

:INPUTERROR
ECHO Please Specify the path to where to create TFTRoot files
ECHO. ECHO Example: ExtractADKFiles.cmd D:\ADKFiles
ECHO. 

GOTO :EOF

:DONE
CD /D %1
