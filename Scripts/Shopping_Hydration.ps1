<#
Script name: Shopping_Hydration.ps1
Created:	 2014-04-03
Version:	 1.0
Author       Dave Kawula
Homepage:    http://www.checkyourlogs.net / http://www.triconelite.com

Disclaimer:
This script is provided "AS IS" with no warranties, confers no rights and 
is not supported by the authors or DeploymentArtist.

Author - Dave Kawula
    Twitter: @DaveKawula
    Blog   : http://www.checkyourlogs.net

#>

$ShoppingServer = 'MDT01'
$DC = 'DC01'


Install-WindowsFeature -Name RSAT-ADDS -IncludeAllSubFeature
Write-Host Getting PowerShell Version -ForegroundColor Yellow
(Get-host).Version
Write-Host Starting new PS Session -ForegroundColor Yellow
# Prepare the DC PowerShell Session
Clear-DnsClientCache
Write-Host "Creating a PS Session to $dc" -ForegroundColor Yellow 
$Username = "VIAMONSTRA\Administrator" 
$Password = "P@ssw0rd" 
$pass = ConvertTo-SecureString -AsPlainText $Password -Force 
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass 
$s = New-PSSession -ComputerName $dc -Credential $Cred

$modules = @("ActiveDirectory", "DnsServer", "DhcpServer")
Write-Host "Importing Modules $modules on $dc...." -ForegroundColor Yellow 
Import-Module $modules -PSSession $s

#Creating AD Groups for 1E SHopping

write-host Creating Shopping AD Groups ........ -ForegroundColor Yellow

new-adgroup -Path "OU=Security Groups,OU=ViaMonstra,DC=Corp,DC=ViaMonstra,DC=com" -Name 1E_Shopping_Admins -Description "Group used to control 1E Shopping Admin Access"  -GroupScope Global  -GroupCategory Security
new-adgroup -Path "OU=Security Groups,OU=ViaMonstra,DC=Corp,DC=ViaMonstra,DC=com" -Name 1E_Shopping_CMDB -Description "Group used to Access Configuration Manager's DB"  -GroupScope Global  -GroupCategory Security
new-adgroup -Path "OU=Security Groups,OU=ViaMonstra,DC=Corp,DC=ViaMonstra,DC=com" -Name 1E_Shopping_LimitedDB -Description "Group used to control 1E Shopping DB"  -GroupScope Global  -GroupCategory Security
new-adgroup -Path "OU=Security Groups,OU=ViaMonstra,DC=Corp,DC=ViaMonstra,DC=com" -Name 1E_Shopping_Report_Viewers -Description "Group used to control 1E Shopping Report Viewer Access"  -GroupScope Global  -GroupCategory Security
new-adgroup -Path "OU=Security Groups,OU=ViaMonstra,DC=Corp,DC=ViaMonstra,DC=com" -Name 1E_Shopping_License_Viewers -Description "Group used to control 1E Shopping License Viewer Access"  -GroupScope Global  -GroupCategory Security
new-adgroup -Path "OU=Security Groups,OU=ViaMonstra,DC=Corp,DC=ViaMonstra,DC=com" -Name 1E_Shopping_FullDB -Description "Group used to control 1E Shopping Full Database Access"  -GroupScope Global  -GroupCategory Security
new-adgroup -Path "OU=Security Groups,OU=ViaMonstra,DC=Corp,DC=ViaMonstra,DC=com" -Name 1E_Shopping_Receivers -Description "Group used on the CM Server to perform Shopping Functions"  -GroupScope Global  -GroupCategory Security

Write-Host Checking new AD groups .... -ForegroundColor Yellow

get-adgroup -SearchBase "dc=corp,dc=viamonstra,dc=com" -filter { name -like "1E_*"} | select Name

Write-Host Creating Service Accounts for Shopping...... -ForegroundColor Yellow

New-ADUser –Name "1E_Shopping_Receiver" –SamAccountName 1E_Shopping_Receiver –DisplayName "1E_Shopping_Receiver" -Description "Account Used for the Shopping Receiver Service on the CM Server" –Enabled $true -PasswordNeverExpires $true  –ChangePasswordAtLogon $false -AccountPassword (ConvertTo-SecureString "P@ssw0rd" -AsPlainText -force) -PassThru -path "OU=Service Accounts,OU=ViaMonstra,DC=Corp,DC=ViaMonstra,DC=com"

write-host Checking new Service Accounts .... -ForegroundColor Yellow

Get-ADUser -SearchBase "dc=corp,dc=viamonstra,dc=com" -Filter {name -like "1e*"} | select Name

Write-host Adding Service Accounts to the Shopping Recievers Group --> Required for App Mapping Later On -ForegroundColor Yellow

Add-ADGroupMember -Identity 1E_SHopping_Receivers -Members cm_naa,1e_shopping_receiver

write-host Getting 1E_Shopping_Recivers membership -ForegroundColor Yellow

Get-ADGroupMember -Identity 1e_shopping_receivers | select name


Write-host Adding Shopping Receivers Group to the Set Local Admins Group -ForegroundColor Yellow

Add-ADGroupMember -Identity "Set Local Admins" -Members 1E_Shopping_Receivers


Write-host Adding Administrator to 1E_Shopping_FullAdmins -ForegroundColor Yellow

Add-ADGroupMember -Identity 1E_Shopping_Admins -Members Administrator

write-host Getting 1E_Shopping_Admins membership -ForegroundColor Yellow

Get-ADGroupMember -Identity 1e_shopping_Admins | select name

Write-Host Importing DNS Module... -ForegroundColor Yellow

Import-Module DNSServer -PSSession $s

#get-command -Module DNSServer

Write-Host Adding DNS Records for Shopping server... -ForegroundColor Yellow

Add-DnsServerResourceRecordA -Name AppShop -IPv4Address 192.168.1.210 -ZoneName "corp.viamonstra.com"

Write-Host testing the new appshop record -ForegroundColor Yellow

ping appshop.corp.viamonstra.com

Write-Host .... Installing Require Roles and Features on $ShoppingServer.... -ForegroundColor Yellow
get-windowsfeature -ComputerName $ShoppingServer | Select Displayname,name
Install-WindowsFeature -ComputerName $ShoppingServer -Name net-framework-core,web-server,web-http-redirect,web-asp-net,web-windows-auth,web-mgmt-console,web-metabase,web-wmi,web-lgcy-scripting
get-windowsfeature -computername $shoppingserver | select Displayname,name

Write-Host .... "As we don't have an Exchange Server in the lab we will install the SMTP Server role on the $ShoppingServer" -ForegroundColor Yellow

Install-WindowsFeature -ComputerName $shoppingServer -Name SMTP-Server
