if not exist "%ALLUSERSPROFILE%\Application Data\1E\PXELite\TftpRoot\Images" echo y | md "%ALLUSERSPROFILE%\Application Data\1E\PXELite\TftpRoot"
xcopy boot.sdi "%ALLUSERSPROFILE%\Application Data\1E\PXELite\TftpRoot\" /Y
xcopy boot\*.* "%ALLUSERSPROFILE%\Application Data\1E\PXELite\TftpRoot\boot\" /Y /E
if not exist "%ALLUSERSPROFILE%\Application Data\1E\PXELite\TftpRoot\Images" echo y | md "%ALLUSERSPROFILE%\Application Data\1E\PXELite\TftpRoot\Images"
