# ----------------------------------------------------------------------------------------------
# Note, to allow PowerShell script to run, use the following command
# Set-ExecutionPolicy Unrestricted –Force
# ----------------------------------------------------------------------------------------------

# Validating that the script is running elevated (as administrator)
Write-Host "Checking for elevation"

If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "Oupps, you need to run this script from an elevated PowerShell prompt!`nPlease start the PowerShell prompt as an Administrator and re-run the script."
    Write-Warning "Aborting script..."
    Break
}

Write-Host "PowerShell runs elevated, OK, continuing..." -ForegroundColor Green
Write-Host ""

# Check for Visual C++ 2005 SP1 x86 setup file
Write-Host "Checking for Visual C++ 2005 SP1 x86 setup file"
If (Test-Path 'C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2005 SP1 - x86-x64\Source\vcredist_x86.exe'){
    Write-Host "vcredist_x86.exe found in C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2005 SP1 - x86-x64\Source, OK, continuing..." -ForegroundColor Green
    Write-Host ""
    } 
Else {
    Write-Warning "Oupps, vcredist_x86.exe not found in C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2005 SP1 - x86-x64\Source, aborting..."
    Break
}

# Check for Visual C++ 2005 SP1 x64 setup file
Write-Host "Checking for Visual C++ 2005 SP1 x64 setup file"
If (Test-Path 'C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2005 SP1 - x86-x64\Source\vcredist_x64.exe'){
    Write-Host "vcredist_x64.exe found in C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2005 SP1 - x86-x64\Source, OK, continuing..." -ForegroundColor Green
    Write-Host ""
    } 
Else {
    Write-Warning "Oupps, vcredist_x64.exe not found in C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2005 SP1 - x86-x64\Source, aborting..."
    Break
}

# Check for Visual C++ 2008 SP1 x86 setup file
Write-Host "Checking for Visual C++ 2008 SP1 x86 setup file"
If (Test-Path 'C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2008 SP1 - x86-x64\Source\vcredist_x86.exe'){
    Write-Host "vcredist_x86.exe found in C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2008 SP1 - x86-x64\Source, OK, continuing..." -ForegroundColor Green
    Write-Host ""
    } 
Else {
    Write-Warning "Oupps, vcredist_x86.exe not found in C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2008 SP1 - x86-x64\Source, aborting..."
    Break
}

# Check for Visual C++ 2008 SP1 x64 setup file
Write-Host "Checking for Visual C++ 2008 SP1 x64 setup file"
If (Test-Path 'C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2008 SP1 - x86-x64\Source\vcredist_x64.exe'){
    Write-Host "vcredist_x64.exe found in C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2008 SP1 - x86-x64\Source, OK, continuing..." -ForegroundColor Green
    Write-Host ""
    } 
Else {
    Write-Warning "Oupps, vcredist_x64.exe not found in C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2008 SP1 - x86-x64\Source, aborting..."
    Break
}

# Check for Visual C++ 2010 SP1 x86 setup file
Write-Host "Checking for Visual C++ 2010 SP1 x86 setup file"
If (Test-Path 'C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2010 SP1 - x86-x64\Source\vcredist_x86.exe'){
    Write-Host "vcredist_x86.exe found in C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2010 SP1 - x86-x64\Source, OK, continuing..." -ForegroundColor Green
    Write-Host ""
    } 
Else {
    Write-Warning "Oupps, vcredist_x86.exe not found in C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2010 SP1 - x86-x64\Source, aborting..."
    Break
}

# Check for Visual C++ 2010 SP1 x64 setup file
Write-Host "Checking for Visual C++ 2010 SP1 x64 setup file"
If (Test-Path 'C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2010 SP1 - x86-x64\Source\vcredist_x64.exe'){
    Write-Host "vcredist_x64.exe found in C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2010 SP1 - x86-x64\Source, OK, continuing..." -ForegroundColor Green
    Write-Host ""
    } 
Else {
    Write-Warning "Oupps, vcredist_x64.exe not found in C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2010 SP1 - x86-x64\Source, aborting..."
    Break
}

# Check for Visual C++ 2012 x86 setup file
Write-Host "Checking for Visual C++ 2012 x86 setup file"
If (Test-Path 'C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2012 - x86-x64\Source\vcredist_x86.exe'){
    Write-Host "vcredist_x86.exe found in C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2012 - x86-x64\Source, OK, continuing..." -ForegroundColor Green
    Write-Host ""
    } 
Else {
    Write-Warning "Oupps, vcredist_x86.exe not found in C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2012 - x86-x64\Source, aborting..."
    Break
}

# Check for Visual C++ 2012 x64 setup file
Write-Host "Checking for Visual C++ 2012 x64 setup file"
If (Test-Path 'C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2012 - x86-x64\Source\vcredist_x64.exe'){
    Write-Host "vcredist_x64.exe found in C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2012 - x86-x64\Source, OK, continuing..." -ForegroundColor Green
    Write-Host ""
    } 
Else {
    Write-Warning "Oupps, vcredist_x64.exe not found in C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2012 - x86-x64\Source, aborting..."
    Break
}


# Import MDT module and connect to the MDT Build Lab deployment share
Import-Module "C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"
New-PSDrive -Name "DS001" -PSProvider MDTProvider -Root "D:\MDTBuildLab"

# Check for Microsoft folder in Applications node (Deployment Workbench) 
Write-Host "Checking for Microsoft folder in Applications node (Deployment Workbench) "
If (Test-Path 'DS001:\Applications\Microsoft'){
    Write-Host "Microsoft folder found in the Applications node (Deployment Workbench) , OK, continuing..." -ForegroundColor Green
    Write-Host ""
    } 
Else {
    Write-Warning "Oupps, Microsoft folder not found in the Applications node (Deployment Workbench) , aborting..."
    Break
}


# Import Applications
import-MDTApplication -path "DS001:\Applications\Microsoft" -enable "True" -Name "Install - Microsoft Visual C++ 2005 SP1 - x86-x64" -ShortName "Install - Microsoft Visual C++ 2005 SP1 - x86-x64" -Version "" -Publisher "" -Language "" -CommandLine "cscript.exe Install-MicrosoftVisualC2005SP1x86x64.wsf" -WorkingDirectory ".\Applications\Install - Microsoft Visual C++ 2005 SP1 - x86-x64" -ApplicationSourcePath "C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2005 SP1 - x86-x64" -DestinationFolder "Install - Microsoft Visual C++ 2005 SP1 - x86-x64" -Verbose
import-MDTApplication -path "DS001:\Applications\Microsoft" -enable "True" -Name "Install - Microsoft Visual C++ 2008 SP1 - x86-x64" -ShortName "Install - Microsoft Visual C++ 2008 SP1 - x86-x64" -Version "" -Publisher "" -Language "" -CommandLine "cscript.exe Install-MicrosoftVisualC2008SP1x86x64.wsf" -WorkingDirectory ".\Applications\Install - Microsoft Visual C++ 2008 SP1 - x86-x64" -ApplicationSourcePath "C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2008 SP1 - x86-x64" -DestinationFolder "Install - Microsoft Visual C++ 2008 SP1 - x86-x64" -Verbose
import-MDTApplication -path "DS001:\Applications\Microsoft" -enable "True" -Name "Install - Microsoft Visual C++ 2010 SP1 - x86-x64" -ShortName "Install - Microsoft Visual C++ 2010 SP1 - x86-x64" -Version "" -Publisher "" -Language "" -CommandLine "cscript.exe Install-MicrosoftVisualC2010SP1x86x64.wsf" -WorkingDirectory ".\Applications\Install - Microsoft Visual C++ 2010 SP1 - x86-x64" -ApplicationSourcePath "C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2010 SP1 - x86-x64" -DestinationFolder "Install - Microsoft Visual C++ 2010 SP1 - x86-x64" -Verbose
import-MDTApplication -path "DS001:\Applications\Microsoft" -enable "True" -Name "Install - Microsoft Visual C++ 2012 - x86-x64" -ShortName "Install - Microsoft Visual C++ 2012 - x86-x64" -Version "" -Publisher "" -Language "" -CommandLine "cscript.exe Install-MicrosoftVisualC2012x86x64.wsf" -WorkingDirectory ".\Applications\Install - Microsoft Visual C++ 2012 - x86-x64" -ApplicationSourcePath "C:\Labfiles\LTI Support Files\MDT Build Lab\Applications\Install - Microsoft Visual C++ 2012 - x86-x64" -DestinationFolder "Install - Microsoft Visual C++ 2012 - x86-x64" -Verbose
