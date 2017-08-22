<# 
Script name: HydrationCMConfiguration.PS1 
Created: 2014-04-03 
Version: 1.2 
Author       Dave Kawula 
Homepage:    http://www.checkyourlogs.net / http://www.triconelite.com 
 
Disclaimer: 
This script is provided "AS IS" with no warranties, confers no rights and  
is not supported by the authors or TriCon Elite 
Author - Dave Kawula 
    Twitter: @DaveKawula 
    Blog   : http://www.checkyourlogs.net 
     
#Load Powershell Functions 
# This Script will build the base environment that we will use for AWD 
# This is an early Version 1.0 ---> It works but not a lot of error control etc.. 
# Must Execute from the same directory as cm12_fuction_library_sp1.ps1 
# Dave Kawula - MVP 
# dkawula@triconelite.com 
# You will need to have downloaded the source media to the applicable folders prior to using this script  
#> 
 
$SiteServer = 'CM01' 
$SiteCode = 'PS1' 
$PCNum = 1..4
$CMModulePath = $Env:SMS_ADMIN_UI_PATH.SubString(0,$Env:SMS_ADMIN_UI_PATH.Length - 5) + "\ConfigurationManager.psd1" 
$AWDISOPATH = "C:\Labfiles\AWD_Software"
$AWDISOPATH1 = "C:\Labfiles\Sources\NomadBranch v5.2.100.32\DownloadMonitor"
$AWDSCRIPTPATH = "C:\Labfiles\Scripts" 

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

# Check for 1E Agent x64 setup file
Write-Host "Checking for 1E Agent x64 setup file"
If (Test-Path 'C:\Labfiles\AWD_Software\1E Agent x64\1EAgent-x64.msi'){
    Write-Host "1EAgent-x64.msi found in C:\Labfiles\AWD_Software\1E Agent x64, OK, continuing..." -ForegroundColor Green
    Write-Host ""
    } 
Else {
    Write-Warning "Oupps, 1EAgent-x64.msi not found in C:\Labfiles\AWD_Software\1E Agent x64, aborting..."
    Break
}

# Check for 1E Agent x86 setup file
Write-Host "Checking for 1E Agent x64 setup file"
If (Test-Path 'C:\Labfiles\AWD_Software\1E Agent x86\1EAgent.msi'){
    Write-Host "1EAgent.msi found in C:\Labfiles\AWD_Software\1E Agent x86, OK, continuing..." -ForegroundColor Green
    Write-Host ""
    } 
Else {
    Write-Warning "Oupps, 1EAgent.msi not found in C:\Labfiles\AWD_Software\1E Agent x86, aborting..."
    Break
}

# Check for TechSmith Snagit 11 setup file
Write-Host "Checking for TechSmith Snagit 11 setup file"
If (Test-Path 'C:\Labfiles\AWD_Software\Snagit 11\snagit.msi'){
    Write-Host "snagit.msi found in C:\Labfiles\AWD_Software\Snagit 11, OK, continuing..." -ForegroundColor Green
    Write-Host ""
    } 
Else {
    Write-Warning "Oupps, snagit.msi not found in C:\Labfiles\AWD_Software\Snagit 11, aborting..."
    Break
}

# Check for Camtasia 8 setup file
Write-Host "Checking for Camtasia 8 setup file"
If (Test-Path 'C:\Labfiles\AWD_Software\Camtasia Studio 8\camtasia.msi'){
    Write-Host "camtasia.msi found in C:\Labfiles\AWD_Software\Camtasia Studio 8, OK, continuing..." -ForegroundColor Green
    Write-Host ""
    } 
Else {
    Write-Warning "Oupps, camtasia.msi not found in C:\Labfiles\AWD_Software\Camtasia Studio 8, aborting..."
    Break
}

# Check for Adobe Reader XI setup file
Write-Host "Checking for Adobe Reader XI setup file"
If (Test-Path 'C:\Labfiles\AWD_Software\Adobe Reader XI\AdbeRdr11000_en_US.msi'){
    Write-Host "AdbeRdr11000_en_US.msi found in C:\Labfiles\AWD_Software\Adobe Reader XI, OK, continuing..." -ForegroundColor Green
    Write-Host ""
    } 
Else {
    Write-Warning "Oupps, AdbeRdr11000_en_US.msi not found in C:\Labfiles\AWD_Software\Adobe Reader XI, aborting..."
    Break
}

# Check for Nomad Branch X64 setup file
Write-Host "Checking for Nomad Branch X64 setup file"
If (Test-Path 'C:\Labfiles\AWD_Software\1E NomadBranch x64\NomadBranch-x64.msi'){
    Write-Host "NomadBranch-x64.msi found in C:\Labfiles\AWD_Software\1E NomadBranch x64, OK, continuing..." -ForegroundColor Green
    Write-Host ""
    } 
Else {
    Write-Warning "Oupps, NomadBranch-x64.msi not found in C:\Labfiles\AWD_Software\1E NomadBranch x64, aborting..."
    Break
}

# Check for Nomad Branch X86 setup file
Write-Host "Checking for Nomad Branch X86 setup file"
If (Test-Path 'C:\Labfiles\AWD_Software\1E NomadBranch x86\NomadBranch.msi'){
    Write-Host "NomadBranch.msi found in C:\Labfiles\AWD_Software\1E NomadBranch x86, OK, continuing..." -ForegroundColor Green
    Write-Host ""
    } 
Else {
    Write-Warning "Oupps, NomadBranch.msi not found in C:\Labfiles\AWD_Software\1E NomadBranch x86, aborting..."
    Break
}

# Check for Nomad Download Monitor
Write-Host "Checking for CMTrace"
If (Test-Path 'C:\Labfiles\Sources\NomadBranch v5.2.100.32\DownloadMonitor\NomadBranchGUI.msi'){
    Write-Host "NomadBranchGUI.msi found in C:\Labfiles\Sources\NomadBranch v5.2.100.32\DownloadMonitor, OK, continuing..." -ForegroundColor Green
    Write-Host ""
    } 
Else {
    Write-Warning "Oupps, NomadBranchGUI.msi not found in C:\Labfiles\Sources\NomadBranch v5.2.100.32\DownloadMonitor, aborting..."
    Break
}



# Checks completed, starting the hydration block

 
Write-Host "... Importing CM Powershell Module" -ForegroundColor Yellow 
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process -Force
Import-Module $CMModulePath 
  
Write-Host   "... Loading Powershell Function Library" -ForegroundColor Yellow 
Set-Location $AWDSCRIPTPATH 
. .\CM12_Function_Library_SP1.ps1 -Confirm:$False 
 
#Closing the CM Console 
Get-Process microsoft.* | stop-process | Out-Null
 
# Configure the required collections
$collections = @{
                "Deploy Snagit" = "Advanced Windows Deployment";
                "Deploy Camtasia" = "Advanced Windows Deployment";
                "Deploy Adobe Reader XI" = "Advanced Windows Deployment";
                "Deploy Nomad Branch X64" = "Advanced Windows Deployment";
                "Deploy Nomad Branch x86" = "Advanced Windows Deployment";
                "Deploy CMTrace" = "Advanced Windows Deployment";
                "Deploy Nomad Download Monitor" = "Advanced Windows Deployment";
                "Deploy Windows 8.1 Refresh - Base Nomad" = "Advanced Windows Deployment";
                "Deploy Windows 8.1 Refresh - w/Core Apps and Nomad" = "Advanced Windows Deployment";
                "Deploy Windows 8.1 Refresh - w/Core Apps Dynamic Apps and Nomad" = "Advanced Windows Deployment";
                "Deploy Windows 8.1 Refresh - Nomad Bare Metal" = "Advanced Windows Deployment";
                "Deploy Nomad Software Testing Only" = "Advanced Windows Deployment";
                "Deploy Nomad App Mapping Testing Only" = "Advanced Windows Deployment";
                "Deploy Nomad OSD Pre-Cache" = "Advanced Windows Deployment";
                "Deploy Windows 8.1 Bare Metal - Base Nomad" = "Advanced Windows Deployment";
                "Deploy Windows 8.1 Refresh - w/Core Apps-PBA and Nomad" = "Advanced Windows Deployment";
                "Deploy PXE Lite" = "Advanced Windows Deployment";
                "Deploy Windows 8.1 Refresh - Shopping Self Serve - DO NOT MODIFY"= "Advanced Windows Deployment";
                "Deploy Windows 8.1 Bare Metal - DEPOT SCENARIO" = "Advanced Windows Deployment";
                "Deploy Windows 8.1 DEPOT SCENARIO-PRECACHE" = "Advanced Windows Deployment";
            }

# Configure the required Packages and their Programs
$packages = @()
$packages += @{"Name"="CMTrace-AWD"; "Description"="Copy CMTrace to c:\Windows"; "Manufacturer"="Advanced Windows Deployment"; "Version"="1.0"; "Path"="\\CM01\SCCM_Sources$\AWD_Software\Cmtrace"
                    "Programs" = @(
                            @{"StandardProgramName" = "Per-system Unattended"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "powershell.exe -executionPolicy bypass -command copy-item cmtrace.exe -destination c:\windows" 
                            },
                            @{"StandardProgramName" = "Per-system Unattended-SMSNomad"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "powershell.exe -executionPolicy bypass -command copy-item cmtrace.exe -destination c:\windows"
                            }
                        )}
$packages += @{"Name"="1E Agent x64-AWD"; "Description"="1E Agent x64"; "Manufacturer"="1E Software"; "Version"="6.5"; "Path"="\\CM01\SCCM_Sources$\AWD_Software\1E Agent x64"
                    "Programs" = @(
                            @{"StandardProgramName" = "Per-system Unattended"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "msiexec.exe /i '1EAgent-x64.msi' LOGOFFACTION=ACTIVE REPORTINGSERVER=MDT01 /qn" 
                            },
                            @{"StandardProgramName" = "Per-system Unattended-SMSNomad"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "smsnomad.exe msiexec.exe /i '1EAgent-x64.msi' LOGOFFACTION=ACTIVE REPORTINGSERVER=MDT01 /qn"
                            },
                            @{"StandardProgramName" = "Per-system Uninstall"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "msiexec.exe /q /m MSIMPDAH /x '1EAgent-x64.msi'"
                            }
                        )}
$packages += @{"Name"="1E Agent x86-AWD"; "Description"="1E Agent x86"; "Manufacturer"="1E Software"; "Version"="6.5"; "Path"="\\CM01\SCCM_Sources$\AWD_Software\1E Agent x86"
                    "Programs" = @(
                            @{"StandardProgramName" = "Per-system Unattended"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "msiexec.exe /i '1EAgent.msi' LOGOFFACTION=ACTIVE REPORTINGSERVER=MDT01 /qn"
                            },
                            @{"StandardProgramName" = "Per-system Unattended-SMSNomad"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "smsnomad.exe msiexec.exe /i '1EAgent.msi' LOGOFFACTION=ACTIVE REPORTINGSERVER=MDT01 /qn"
                            },
                            @{"StandardProgramName" = "Per-system uninstall"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "msiexec.exe /q /m MSIMPDAH /x '1EAgent.msi'"
                            }
                        )}
$packages += @{"Name"="1E Nomad Branch x64-AWD"; "Description"="1E Nomad Branch x64"; "Manufacturer"="1E Software"; "Version"="5.2"; "Path"="\\CM01\SCCM_Sources$\AWD_Software\1E NomadBranch x64"
                   "Programs" = @(
                            @{"StandardProgramName" = "Per-system Unattended"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "msiexec.exe /qn /I NomadBranch-x64.msi SPECIALNETSHARE=8272 MULTICASTSUPPORT=0 PLATFORMURL=http://activeefficiency/activeefficiency SSDENABLED=3"
                            },
                            @{"StandardProgramName" = "Per-system uninstall"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "msiexec.exe /q /m MSIKNBTP /x 'NomadBranch-x64.msi'"
                            }
                        )}
$packages += @{"Name"="1E Nomad Branch x86-AWD"; "Description"="1E Nomad Branch x86"; "Manufacturer"="1E Software"; "Version"="5.2"; "Path"="\\CM01\SCCM_Sources$\AWD_Software\1E NomadBranch x86"
                  "Programs" = @(
                            @{"StandardProgramName" = "Per-system Unattended"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "msiexec.exe /qn /I NomadBranch.msi SPECIALNETSHARE=8272 MULTICASTSUPPORT=0 PLATFORMURL=http://activeefficiency/activeefficiency SSDENABLED=3"
                            },
                            @{"StandardProgramName" = "Per-system uninstall"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "msiexec.exe /q /m MSIKNBTP /x 'NomadBranch.msi'"
                            }
                        )}
$packages += @{"Name"="Adobe Reader XI-AWD"; "Description"="Adobe Reader XI 11.0"; "Manufacturer"="Adobe"; "Version"="11.0"; "Path"="\\CM01\SCCM_Sources$\AWD_Software\Adobe Reader XI"
                            "Programs" = @(
                            @{"StandardProgramName" = "Per-system Unattended"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "msiexec.exe /qn /i AdbeRdr11000_en_US.msi"
                            },
                            @{"StandardProgramName" = "Per-system Unattended-SMSNomad"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "CollectionName" = "Deploy Adobe Reader XI"; "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "smsnomad.exe msiexec.exe /qn /i AdbeRdr11000_en_US.msi"
                            },
                            @{"StandardProgramName" = "Per-system uninstall"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "msiexec.exe /q /m MSIVCRCK /x 'AdbeRdr11000_en_US.msi'"
                            }
                        )}
$packages += @{"Name"="Camtasia Studio-AWD"; "Description"="Camtasia Studio"; "Manufacturer"="TechSmith"; "Version"="8.0"; "Path"="\\CM01\SCCM_Sources$\AWD_Software\Camtasia Studio 8"
                           "Programs" = @(
                            @{"StandardProgramName" = "Per-system Unattended"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "CollectionName" = "Deploy CamTasia"; "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "msiexec.exe /qn /i camtasia.msi"
                            },
                            @{"StandardProgramName" = "Per-system Unattended-SMSNomad"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "smsnomad.exe msiexec.exe /qn /i camtasia.msi"
                            },
                            @{"StandardProgramName" = "Per-system uninstall"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "msiexec.exe /q /m MSIQACSE /x camtasia.msi" 
                            }
                        )}
$packages += @{"Name"="Nomad Download Monitor-AWD"; "Description"="Nomad Download Monitor"; "Manufacturer"="1E Software"; "Version"="1.0"; "Path"="\\CM01\SCCM_Sources$\AWD_Software\DownloadMonitor"
                          "Programs" = @(
                            @{"StandardProgramName" = "Per-system Unattended"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "msiexec.exe /qn /i NomadBranchGUI.msi UI=1"
                            },
                            @{"StandardProgramName" = "Per-system Unattended-SMSNomad"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "CollectionName" = "Deploy Nomad Download Monitor"; "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "smsnomad.exe msiexec.exe /qn /i NomadBranchGUI.msi /UI=1"
                            },
                            @{"StandardProgramName" = "Per-system uninstall"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "msiexec.exe /q /m MSIDOHBX /x NomadBranchGUI.msi" 
                            }
                        )}
$packages += @{"Name"="Snagit-AWD"; "Description"="Snagit"; "Manufacturer"="TechSmith"; "Version"="11"; "Path"="\\CM01\SCCM_Sources$\AWD_Software\Snagit 11.0"
                  "Programs" = @(
                            @{"StandardProgramName" = "Per-system Unattended"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "CollectionName" = "Deploy Snagit"; "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "msiexec.exe /q /m MSITLIES /x 'snagit.msi'"
                            },
                            @{"StandardProgramName" = "Per-system uninstall"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "smsnomad.exe msiexec.exe /q ALLUSERS=2 /m MSITLIES /i 'snagit.msi'"
                            }
                        )}
$packages += @{"Name"="1E PXE Lite-TaskSequenceOnly"; "Description"="1E PXE Lite Installer for use in a Task Sequence Only"; "Manufacturer"="Advanced Windows Deployment"; "Version"="1.0"; "Path"="\\CM01\SCCM_Sources$\AWD_Software\1E PXE Lite"
                         "Programs" = @(
                            @{"StandardProgramName" = "Per-system Unattended"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "msiexec.exe /i PXELiteLocal.msi CONFIGSERVERURL=http://cm01/pxelite/pxeliteconfiguration.asmx /qn /l*v %temp%\pxeliteinstaller.log"
                            },
                            @{"StandardProgramName" = "Copy Files"; "RunType" = "Normal"; "ProgramRunType" = "WhetherOrNotUserIsLoggedOn";
                             "RunMode" = "RunWithAdministrativeRights"; "CommandLine" = "cmd /c copyPXELitefiles.bat"
                            }
                        )}

#Create Collections for Nomad Software Deployment Testing 
Set-Location PS1: 
Write-Host .... Creating Folder for AWD -ForegroundColor Yellow 
$folder = Add-CMFolder -SiteCode $Sitecode -SiteServer $SiteServer -FolderName "AWD" -Type 5000 
$folder = Add-CMFolder -SiteCode $Sitecode -SiteServer $SiteServer -FolderName "Software" -Type 5000 
$folder = Add-CMFolder -SiteCode $Sitecode -SiteServer $SiteServer -FolderName "AWD" -Type 2 

Write-Host ".... Creating Base Device Collections in Folder"
foreach ($collectionKey in $collections.Keys) {
    Write-Host "... Creating Collections $($collectionKey)"
    $collection = Add-CmCollection -Type Device -Name $collectionKey -LimitToCollectionID SMS00001 -Comment $collections[$collectionKey] -SiteCode $sitecode -SiteServer $siteserver -folder AWD
    Write-Host "...... Adding Members to the Deployment Collections for for $($collectionKey)" -ForegroundColor Yellow
    $PCNum | Foreach-Object { Set-CMCollectionDirectRule -siteserver $siteserver -SiteCode $sitecode -Resourcename Pc000$_ -CollectionName $collectionKey }
}  
 
# Copy Software Source Files from <AwdISOPath> to D:\SCCM_Sources\AWD_Software  
Write-Host Copying Sources Files to AWD_Software -ForegroundColor Yellow 
New-PSDrive -Name CM01FS -PSProvider FileSystem -Root \\cm01\sms_ps1 | Out-Null
New-Item -ItemType Directory "D:\sccm_sources\AWD_Software\Cmtrace" -Force | Out-Null
Copy-Item -Path $AWDISOPATH -Destination D:\sccm_sources\ -Recurse -Force
Copy-Item -Path $AWDISOPATH1 -Destination D:\sccm_sources\AWD_Software -Recurse -Force
Copy-Item -Path CM01FS:\tools\cmtrace.exe -Destination D:\sccm_sources\AWD_software\CMTrace 
Copy-Item -Path CM01FS:\tools\cmtrace.exe -Destination C:\Windows\System32 
 
#Creating CM Packages and Programs 
Set-Location PS1: 
Write-Host ".... Creating packages Programs and Deployments" -ForegroundColor Yellow 
$cmPackages = @()
foreach ($package in $packages) {
    Write-Host "Creating Package $($package.Name)"
    $cmPackage = New-CMPackage -Name $package.Name -Description $package.Description -Manufacturer $package.Manufacturer -Version $package.Version -Path $package.Path
    Move-CMObject -FolderPath:PS1:\Package\AWD -ObjectId $cmPackage.PackageID 
    $cmPackages += $cmPackage
}

#Creating Programs for Packages 
Write-Host ....Creating Programs for Packages -ForegroundColor Yellow 
foreach ($package in $packages) {
    Write-Host "..Creating Programs for $($package.Name)"
    foreach ($program in $package.Programs) {
        Write-Host ".... Creating Program: $($program.StandardProgramName)"
        $cmProgram = New-CMProgram -PackageName $package.Name -StandardProgramName $program.StandardProgramName -RunType $program.RunType -ProgramRunType $program.ProgramRunType -RunMode $program.RunMode -CommandLine $program.CommandLine
    }
}
 
# Enable All Programs / Applications to be used in a Task Sequence 
Write-Host "... Selecting the Allow Deployment via Task Sequence Button....." -ForegroundColor Yellow 
Write-Host "... This step takes a minute so be patient......." -ForegroundColor Yellow  
Get-CMProgram | Foreach-Object {Set-CMProgram -StandardProgramName $_.ProgramName -Id $_.PackageID -EnableTaskSequence $true} 
 
Write-Host "... Programs are done now working on the applications" -ForegroundColor Yellow 
Get-CMApplication | Foreach-Object { Set-CMApplication -Id $_.CI_ID -AutoInstall $true } 
Write-Host "... Applications are done...." -ForegroundColor Yellow 

Write-Host "... Adding a Boundary for DEPOT Imaging..." -ForegroundColor Yellow 
$boundary = New-CMBoundary -name "DEPOT SITE" -BoundaryType IPSubnet -value "192.168.20.0/24" 
# $boundarygroup = New-CMBoundaryGroup -Name "HQ Assignment" 
$addBoundaryGroup = Add-CMBoundaryToGroup -BoundaryGroup "HQ Assignment" -Boundary "DEPOT SITE" -SiteCode $sitecode -siteserver $siteserver 
 
# Now lets distribute the new packages to the DP 
Write-Host ... Distrubuting Content to our Distribution Points -ForegroundColor Yellow 
# $dpGroup = New-CMDistributionPointGroup -name "HQ DP Group" 
$addDpGroup = Add-CMDistributionPointToGroup -DistributionPointName "CM01.corp.viamonstra.com" -DistributionPointGroupName "HQ DP Group"  
foreach ($cmPackage in $cmPackages) {
    Write-Host "... Distributing $($cmPackage.Name)"
    Start-CMContentDistribution -DistributionPointGroupName "HQ DP Group" -PackageId $cmPackage.PackageID
}
 
#Fixing a locking issue I found in the testing --> Needs some debugging to figure out why this happened.... 
foreach ($cmPackage in $cmPackages) {
    Unlock-CmObject $(Get-CmPackage -Name $cmPackage.Name) 
}
 
#Need to add CM01.Corp.ViaMonstra.Com DP to the Distribution Group HQ DP Group 
# Write-Host ".... Adding DP to HQ DP Group...." -ForegroundColor Yellow 
# Add-CMDistributionPointToGroup -DistributionPointName CM01.Corp.viamonstra.com -DistributionPointGroupName "HQ DP Group" 
 
# Next we need to add some Deployments so we can see Nomad in Action when we are ready... All Deployments will be made available so the 
# Only Show up in Software Center 
Write-Host "... Finding Packages that are not Nomad Enabled....." -ForegroundColor Yellow 

$completed = @() 
(gwmi -Namespace root\sms\site_$sitecode -Class SMS_PackageBaseClass -ComputerName $siteserver | % { 
    $package = $_;
    $pkgs = [wmi] $_.__Path 
    if (($pkgs.AlternateContentProviders|Out-String) -notlike "*nomad*"){ 
        $obj = New-Object psobject 
        $obj | add-member NoteProperty Class $package.__Class 
        $obj | add-member NoteProperty ID $package.PackageID 
        $obj | add-member NoteProperty Name $package.Name 
        $obj | add-member NoteProperty Version $package.version 
        $obj | add-member NoteProperty Path $package.PkgSourcePath 
        $completed += $obj
    }
 }) | Out-Null 
$completed | where-Object {$_.Class -notlike "*updates*" -and $_.class -notlike "*driver*"} | Out-Gridview -Title "Nomad Packages - Require Enabling"

# Next we Should Enable Nomad on all Packages... 
foreach ($cmPackage in $cmPackages) {
    Write-Host "Setting Nomad Settings on $($cmPackage.Name)" -ForegroundColor Yellow 
    #First we are going to clear off the Nomad Branch Settings to ensure everything is consistent     
    $priorityCache = "1"
    if ($cmPackage.Name -match ".*TaskSequence.*") {
        $priorityCache = "5"
    }
    $cmPackage.Get()
    $cmPackage.AlternateContentProviders = "<AlternateDownloadSettings SchemaVersion=""1.0"">"
    $cmPackage.AlternateContentProviders += "<Provider Name=""NomadBranch""><Data><ProviderSettings />"
    $cmPackage.AlternateContentProviders += "<pc>$priorityCache</pc><wr>80</wr></Data></Provider></AlternateDownloadSettings>"
    $cmPackage.Put()
}
 
# Quickly validate that the packages have been Nomad Enabled 
$completed = @() 
(gwmi -Namespace root\sms\site_$sitecode -Class SMS_PackageBaseClass -ComputerName $siteserver | % { 
    $package = $_;
    $pkgs = [wmi] $_.__Path 
    if (($pkgs.AlternateContentProviders|Out-String) -like "*nomad*"){ 
        $obj = New-Object psobject 
        $obj | add-member NoteProperty Class $package.__Class 
        $obj | add-member NoteProperty ID $package.PackageID 
        $obj | add-member NoteProperty Name $package.Name 
        $obj | add-member NoteProperty Version $package.version 
        $obj | add-member NoteProperty Path $package.PkgSourcePath 
        $completed += $obj
    }
 }) | Out-Null 
$completed | where-Object {$_.Class -notlike "*updates*" -and $_.class -notlike "*driver*"} | Out-Gridview -Title "Nomad Packages - ENABLED"

# Create Deployments for the new Packages  
Write-Host Deploying Pacakges -ForegroundColor Yellow 
foreach ($package in $packages) {
    foreach ($program in $package.Programs) {
        if ($program.CollectionName -ne $null) {
            Write-Host Deplying "$($package.Name)....." -ForegroundColor Yellow 
            $packagedeployment = Start-CMPackageDeployment -PackageName $package.Name -StandardProgramName "Per-system Unattended" -CollectionName $program.CollectionName -DeployPurpose Available 
        }
    }
}

Write-Host Deploying CMTrace Package -ForegroundColor Yellow
Start-CMPackageDeployment -PackageName CMTrace-AWD -StandardProgramName "Per-system Unattended" -CollectionName "Deploy CMTrace" -DeployPurpose Available




Write-Host "... Checking Deployments...." -ForegroundColor Yellow 
Get-CmDeployment | Select CollectionName,SoftwareName,CollectionID 

# Write-Host ".... Configuring a couple of packages for the lab to distribute content to the Copy Content to DP" -ForegroundColor Yellow
# Write Host " This is a requirement to get Dynamic Packages to work with Nomad in a Sequence" -ForegroundColor Yellow
# $Legacy = Get-WmiObject -Class sms_package -Namespace root\sms\site_ps1 -Filter "Name = 'Adobe Reader XI-AWD'"
# $Legacy.pkgflags = 128
# $Legacy.Put()
# $Legacy = Get-WmiObject -Class sms_package -Namespace root\sms\site_ps1 -Filter "Name = 'Camtasia Studio-AWD'"
# $Legacy.pkgflags = 128
# $Legacy.Put()
# $Legacy = Get-WmiObject -Class sms_package -Namespace root\sms\site_ps1 -Filter "Name = 'CMTrace-AWD'"
# $Legacy.pkgflags = 128
# $Legacy.Put()