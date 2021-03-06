    <#
    .SYNOPSIS
      This CM12 Function Library contains many functions
    .EXAMPLE
        Add-Prerequisites
        This example installs all required CM Site Server roles/features
    .EXAMPLE
        Add-Prerequisites -DotNet -File "C:\temp\dotNetFx40_Full_x86_x64.exe" -Arguments "/Q /NoRestart"
        This example installs all required CM Site Server roles, features and DotNet also
    .EXAMPLE
        Add-Prerequisites -ConfigureFireWall
        This example configures Windows Firewall ports for SQL
    .EXAMPLE
        Add-Prerequisites -DisableFireWall
        This example disables Windows Firewall  
    .EXAMPLE
         Add-CMFolder -SiteCode PS1 -SiteServer localhost -FolderName "New Application Folder" -Type 6000
         This example adds under Applications new folder. Type 6000 means Application Folder. Object Type can be:
            Object type 2 - Package Folder
            Object type 7 - Query Folder
            Object type 9 - Software Metering Folder
            Object type 14 - Operating System Installers Folder
            Object type 17 - State Migration GFolder
            Object type 18 - Image Package Folder
            Object type 19 - Boot Image Folder
            Object type 20 - Task Sequence Folder
            Object type 23 - Driver Package Folder
            Object type 25 - Driver Folder
            Object type 2011 - Configuration Baseline Folder
            Object type 5000 - Device Collection Folder
            Object type 5001 - User Collection Folder
            Object type 6000 - Application Folder
            Object type 6001 - Configuration Item Folder
    .EXAMPLE
         Add-CMFolder -SiteCode PS1 -SiteServer localhost -FolderName "New Application test" -Type 6000 -ParentFolderID 16777244
         This example adds subfolder. If you need to create subfolders, then please use Get-CMFolder to get Folder ID(ContainerNodeID WMI property value)
    .EXAMPLE
         Get-CMFolder -SiteCode PS1 -SiteServer Localhost -Filter "Name='New Application test'"
         This example queris "New Application test" folder information
    .EXAMPLE
         Get-CMCollection -SiteCode PS1 -SiteServer Localhost
         This example queries all collections
    .EXAMPLE
         Add-CMCollection -SiteCode PS1 -SiteServer localhost -Name "New User Collection" -Type User -LimitToCollectionID SMS00002
         This example adds new User Collection and limits it All Users Collection 
    .EXAMPLE
        Add-CMCollection -SiteCode PS1 -SiteServer localhost -Name "New User Collection with schedule " -Type User -LimitToCollectionID SMS00002 -Day saturday -NumberOfWeeks 2
        This example adds new User Collection and limits it All Users Collection and creates weekly schedule
    .EXAMPLE
        Add-CMCollection -SiteCode PS1 -SiteServer localhost -Name "New Collection Under User 2" -LimitToCollectionID SMS00002 -Folder "User 2" -Type user
        This example adds new User Collection and limits it All Users Collection and moves this new collection under folder "User 2"
    .EXAMPLE
        Add-CMCollection -SiteCode PS1 -SiteServer localhost -Name "New Collection with schedule" -LimitToCollectionID SMS00002 -Type user -CustomDay 6
        This example adds new User Collection and limits it All Users Collection and creates custom schedule
    .EXAMPLE
        Add-CMCollection -SiteCode PS1 -SiteServer localhost -Name "New Collection with schedule 3" -LimitToCollectionID SMS00002 -Type user -Day wednesday -MonthName Feburary -WeekOrder second
        This example adds new User Collection and limits it All Users Collection and creates Monthly schedule
    .EXAMPLE
        Add-CMCollection -SiteCode PS1 -SiteServer localhost -Name "New Collection with schedule 4" -LimitToCollectionID SMS00002 -Type user -MonthName June -MonthDay 23
        This example adds new User Collection and limits it All Users Collection and creates Monthly schedule
    .EXAMPLE
        Add-CMCollection -SiteCode PS1 -SiteServer localhost -Name "New Collection with schedule 5" -LimitToCollectionID SMS00002 -Type user -MonthName June -MonthDay 23 -Comment "Made by PowerShell"
        This example adds new User Collection and limits it All Users Collection and creates Monthly schedule and adds comment "Made by PowerShell"
    .EXAMPLE
        Add-CMCollection -SiteCode PS1 -SiteServer localhost -Name "New Collection with incremental updates" -LimitToCollectionID SMS00002 -Type user -CustomDay 6 -Incremental
        This example adds new User Collection and limits it All Users Collection and creates custom schedule with Incremental updates
    .EXAMPLE
        Add-CMCollection -SiteCode PS1 -SiteServer localhost -Name "New DEV Col" -LimitToCollectionID SMS00001 -Type Device -Comment "PowerShell Rocks" -Folder "Device 2"
        This example adds new Device Collection and limits it All Systems Collection and moves this new collection under folder "Device 2" and adds comment "PowerShell Rocks"
    .EXAMPLE
        Move-CMItem -SiteCode PS1 -SiteServer localhost -TargetContainerName "Device Catalog" -ObjectTypeID 5000 -ObjectID TRT0000C
        This example moves Collection TRT0000C to folder "Device Catalog"
    .EXAMPLE
        Set-CMCollectionQueryRule -SiteServer localhost -SiteCode PS1 -Query 'select *  from  SMS_R_User where SMS_R_User.UserGroupName = "CORP\\SW 7-Zip Install"' -queryname "7-ZIP" -QueryType User -CollectionName "7-Zip installation"    
        This example adds query based rule to users collection.
    .EXAMPLE
        Set-CMCollectionExcludeRule -Sitecode PS1 -SiteServer localhost -collectionName "EP WRK PROD" -ExcludeCollectionName "EP pilot 1"
        This example adds exclusion rule
    .EXAMPLE
        Set-CMCollectionIncludeRule -Sitecode PS1 -SiteServer localhost -collectionName "EP WRK PROD" -IncludeCollectionName "EP Pilot Include"
        This example adds inclusion rule
    .EXAMPLE
        Set-CMCollectionDirectRule -SiteServer localhost -SiteCode PS1 -ResourceName server3 -CollectionName "EP WRK PROD"
        This example adds direct membership rule
    .EXAMPLE
        Add-CMBoundary -Name "AD NY" -Value "NY" -Type AD -SiteCode PS1 -SiteServer Localhost
        This example adds Active Directory Site boundary
    .EXAMPLE
        Add-CMBoundary -Name "IPv6" -Value "Fe80:0000:0000:0000" -Type Ipv6 -SiteCode PS1 -SiteServer Localhost
        This example adds IPv6 boundary
    .EXAMPLE
        Add-CMBoundary -Name "IpSubNet" -Value "192.168.1.0" -Type IPSubNet -SiteCode PS1 -SiteServer Localhost
        This example adds IPSubnet boundary
    .EXAMPLE
        Add-CMBoundary -Name "IpRange" -Value "192.168.10.1-192.168.10.6" -Type IPRange -SiteCode PS1 -SiteServer Localhost
        This example adds IPRange boundary
    .EXAMPLE
        Add-CMBoundaryGroup -SiteServer localhost -Sitecode PS1 -Name "New York Clients"
        This example adds boundary group "New York Clients"
    .EXAMPLE
        Add-CMBoundaryToGroup -SiteServer localhost -Sitecode PS1 -BoundaryGroup "New York Clients" -Boundary "AD NY"
        This example adds boundary "AD NY" to boundary group "New York Clients"
    .EXAMPLE
        Add-CMSiteSystemToBoundaryGroup -SiteServer localhost -Sitecode PS1 -sitesystem "server1.cm.local" -BoundaryGroup "New York Clients" -ConnectionType Slow
        This example adds site system "Server1.CM.Local" to boundary group 'New York Clients' and modifies the connection type to slow
    .EXAMPLE
        Add-CMSiteSystemToBoundaryGroup -SiteServer localhost -Sitecode PS1 -sitesystem "server2.cm.local" -BoundaryGroup "New York Clients"
        This example adds site system "Server2.CM.Local" to boundary group 'New York Clients'
    .EXAMPLE
        Create-CMAccount -MACAddress 00:15:5D:C2:A3:20 -SiteServer localhost -SiteCode PS1 -AccountName TEST6 -CollectionName "OSD Bare Metal"
        This example creates new ConfigMgr account
    .EXAMPLE
        Add-WSUS -File C:\Users\Administrator\Downloads\WSUS30-KB972455-x64.exe -arguments "/q CONTENT_LOCAL=0 DEFAULT_WEBSITE=0 CREATE_DATABASE=1 SQLINSTANCE_NAME=%Computername%"
        This example installs WSUS 3.0 SP2 to SQL default instance.
    .EXAMPLE
        Add-WDS
        By default this example installs Windows Deployment Service to system drive and configures PXE response policy. If you want to configure WDS to another partition,
        then use the parameter Folder
    .EXAMPLE
        Set-CMMaintenanceWindow -SiteCode PS1 -SiteServer localhost -CollectionName "OSD Bare Metal" -ScheduleName "PSH TEST1" -StartDate 11.01.2013 -StartTime 12:00 -EndTime 13:00 -MonthName June -MonthDay 23
    .EXAMPLE
        Set-CMMaintenanceWindow -SiteCode PS1 -SiteServer localhost -CollectionName "OSD Bare Metal" -ScheduleName "PSH TEST2" -StartDate 11.01.2013 -StartTime 04:00 -EndTime 01:00 -Day wednesday -MonthName Feburary -WeekOrder second
    .EXAMPLE
        Set-CMMaintenanceWindow -SiteCode PS1 -SiteServer localhost -CollectionName "OSD Bare Metal" -ScheduleName "PSH TEST3" -StartDate 11.01.2013 -StartTime 02:00 -EndTime 04:00 -CustomDay 6
    .EXAMPLE
        Set-CMMaintenanceWindow -SiteCode PS1 -SiteServer localhost -CollectionName "OSD Bare Metal" -ScheduleName "PSH TEST4" -StartDate 11.01.2013 -StartTime 15:25 -EndTime 19:20 -Day saturday -NumberOfWeeks 2      
    .EXAMPLE
        Set-CMMaintenanceWindow -SiteCode PS1 -SiteServer localhost -CollectionName "OSD Bare Metal" -ScheduleName "PSH TEST5" -StartDate 11.01.2013 -StartTime 19:20 -EndTime 12:20 -Day saturday -NumberOfWeeks 2 -UTC
    .EXAMPLE
        Set-CMMaintenanceWindow -SiteCode PS1 -SiteServer localhost -CollectionName "OSD Bare Metal" -ScheduleName "PSH TEST7" -StartDate 11.01.2013 -StartTime 16:20 -EndTime 14:20 -Day saturday -NumberOfWeeks 3 -TaskSequenceOnly -UTC    
    .NOTES
        Developed by Kaido Järvemets
        Version 1.0
    .LINK
        Http://depsharee.blogspot.com
        Http://blog.Coretech.dk  
    #>

##----------------------------------------------------------------------------------------------------
##  Function: Set-ServiceState
##  Purpose: This function configures service start mode
##----------------------------------------------------------------------------------------------------
Function Set-ServiceState
{
   [CmdLetBinding()]
   Param(
        [Parameter(Mandatory=$True, HelpMessage = "Please enter Service name")]
            $ServiceName,
        [Parameter(Mandatory=$True, HelpMessage = "Please enter Service Start mode")]
            $StartMode
        )
   
   Try {
        $ServiceQuery = Get-WmiObject -Class Win32_Service -ErrorAction STOP -Filter "Name='$ServiceName'"
        $Return = $ServiceQuery.ChangeStartMode("$StartMode")
    
        If($Return.ReturnValue -eq 0){
            Write-Host " - Successfully $StartMode $ServiceName Service"
        }
        Else{
            Write-Host "Something went wrong"
        }
    }
    Catch{
         Write-Host "Error: $($_.Exception.Message)"
    }
}

##----------------------------------------------------------------------------------------------------
##  Function: Create-WindowsFWRules
##  Purpose: This function configures Windows Firewall rules
##----------------------------------------------------------------------------------------------------
Function Create-WindowsFWRules
{

 $PROTOCOL_TCP = 6

 $FireWall = New-Object -ComObject HNetCfg.FwMgr
 $SQLServePort = New-Object -ComObject HNetCfg.FWOpenPort
 $SQLServerBrokerPort = New-Object -ComObject HNetCfg.FWOpenPort

    $SQLServePort.Name = "SQL Server (TCP 1433)" 
    $SQLServePort.Port = 1433
    $SQLServePort.Protocol = $PROTOCOL_TCP
    $SQLServerBrokerPort.Name = "SQL Service Broker (TCP 4022)"
    $SQLServerBrokerPort.Port = 4022
    $SQLServerBrokerPort.Protocol = $PROTOCOL_TCP

 $DomainProfile = $FireWall.LocalPolicy.GetProfileByType(0)
 $DomainProfile.GloballyOpenPorts.Add($SQLServePort)
 $DomainProfile.GloballyOpenPorts.Add($SQLServerBrokerPort)

} 

##----------------------------------------------------------------------------------------------------
##  Function: Add-Prerequisites
##  Purpose: This function installs Prerequisites components for CM12 Site Server
##----------------------------------------------------------------------------------------------------
Function Add-Prerequisites
{
    [CmdLetBinding(DefaultParameterSetName = "None")]
    Param(
          [Parameter(Mandatory=$True,ParameterSetName='DotNet')]
            [Switch]$DotNet,
          [Parameter(Mandatory=$True,HelpMessage="Please enter DotNet installation file location",ParameterSetName='DotNet')]
            $File,
          [Parameter(Mandatory=$True,HelpMessage="Please enter DotNet installation parameters",ParameterSetName='DotNet')]
            $Arguments,
          [Parameter(Mandatory=$False)]  
            [Switch]$ConfigureFireWall,
          [Parameter(Mandatory=$False)]
            [Switch]$DisableFireWall
          )
                                            
   $Roles = @("Web-Server", "Web-Asp-Net", "Web-ASP", "Web-Windows-Auth", "Web-Metabase", "Web-WMI", "BITS", "RDC", "NET-Framework-Core","NET-HTTP-Activation")
                                                 
   Try{
       Write-Host " -  Loading Server Manager PowerShell Module"
       Import-Module servermanager -ErrorAction STOP  
   }
   Catch{
       Write-Host "Failed to load Server Manager PowerShell Module"
   }
       
       Try{
           Write-Host " - Adding Server Roles and Features"
           Add-WindowsFeature $Roles -ErrorAction STOP
       }
       Catch{
             Write-Host "Error: $($_.Exception.Message)"
       }
                                                                                                                                                                                                                                                                       
         If($DotNet){
              Try{
                  Write-Host " - Installing DotNet 4.0 "
                    $Install = Start-Process $File -ArgumentList $Arguments -ErrorAction STOP -Wait -PassThru 
                  Write-Host " - Installation Return Code:$($Install.ExitCode)"
               }
               Catch{
                  Write-Host "Error: $($_.Exception.Message)"
               }
        }
            
    If($ConfigureFireWall){
         Create-WindowsFWRules
    }
      
    If($DisableFireWall){
         Set-ServiceState -ServiceName MpsSvc -StartMode disabled
    }          
}

##----------------------------------------------------------------------------------------------------
##  Function: Get-CMFolder
##  Purpose: This function retrieves CM folder information
##----------------------------------------------------------------------------------------------------
Function Get-CMFolder
{
    [CmdLetBinding()]
    Param(
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site code")]
                    $SiteCode,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Name")]
            [String]$SiteServer,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter filter")]
            [String]$Filter
         )
     
     $Class = "SMS_ObjectContainerNode" 
     
     Try{
        Get-WmiObject -Namespace "root\SMS\Site_$SiteCode" -Class $Class -Filter $Filter -ErrorAction STOP -ComputerName $SiteServer
     }
     Catch{
        Write-Host "Error: $($_.Exception.Message)"
     }
} 

##----------------------------------------------------------------------------------------------------
##  Function: Add-CMFolder
##  Purpose: This function adds CM12 folder
##----------------------------------------------------------------------------------------------------
Function Add-CMFolder
{
     [CmdLetBinding()]
    Param(
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site code")]
                    $SiteCode,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Name")]
            [String]$SiteServer,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter folder name")]
            [String]$FolderName,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter folder type")]  
         [ValidateSet(2,7,9,14,17,18,19,20,23,25,2011,5000,5001,6000,6001)]         
                    $Type,
         [Parameter(Mandatory=$False)]           
                    $ParentFolderID = 0
        )
         
    $Class = "SMS_ObjectContainerNode" 
    $Arguments = @{Name="$FolderName";ObjectType="$Type";ParentContainerNodeId="$ParentFolderID"}
    
    If((Get-CMFolder -SiteCode $SiteCode -SiteServer $SiteServer -Filter "Name='$FolderName' and ObjectType='$Type'") -ne $Null){

        Write-Host "Folder already exists"
    }
    Else{
        Try{
            Set-WmiInstance -Namespace "root\sms\site_$SiteCode" -Class $Class -Arguments $Arguments -ComputerName $SiteServer -ErrorAction STOP
        }
        Catch{
            Write-Host "Error: $($_.Exception.Message)"
        }
    }
}


##----------------------------------------------------------------------------------------------------
##  Function: Get-CMCollection
##  Purpose: This function queries all CM Collections
##----------------------------------------------------------------------------------------------------
Function Get-CMCollection
{
    [CmdletBinding()]
    Param(
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Site code")]
            $SiteCode,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server name")]
            $SiteServer,
         [Parameter(Mandatory=$False,HelpMessage="Please Enter Query Filter")]   
            $Filter
         )
         
    $Class = "SMS_Collection"
    
    Try{
        Get-WmiObject -Namespace "root\SMS\Site_$SiteCode" -Class $Class -Filter $Filter -ErrorAction STOP -ComputerName $SiteServer
    }
    Catch{
        Write-Host "Error: $($_.Exception.Message)"
    }
}

##----------------------------------------------------------------------------------------------------
##  Function: Move-Item
##  Purpose: This function moves CM12 objects
##----------------------------------------------------------------------------------------------------
Function Move-CMItem
{
   [CmdletBinding()]
   Param(
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Site code")]
            $SiteCode,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Name")]
            $SiteServer,
            $ContainerNodeID = 0,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Object ID")]
            $ObjectID,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Object Type")]
            $ObjectTypeID,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter target container name")]
            [String]$TargetContainerName
         )
         
     $Method = "MoveMembers"  
     $Class = "SMS_objectContainerItem"
     $colon = ":"

     $FolderID = Get-CMFolder -SiteCode $SiteCode -SiteServer $SiteServer -Filter "Name='$TargetContainerName' and ObjectType='$ObjectTypeID'"
     
     If($FolderID -ne $Null){
        Try{
            $WMIConnection = [WMIClass]"\\$SiteServer\root\SMS\Site_$SiteCode$Colon$Class"
                $MoveItem = $WMIConnection.psbase.GetMethodParameters($Method)
                $MoveItem.ContainerNodeID = $ContainerNodeID
                $MoveItem.InstanceKeys = $ObjectID
                $MoveItem.ObjectType = $ObjectTypeID
                $MoveItem.TargetContainerNodeID = $FolderID.ContainerNodeID
            $Return = $WMIConnection.psbase.InvokeMethod($Method,$MoveItem,$null)
            
            if($Return.ReturnValue -eq 0){
                Write-Host "Object Successfully moved to new location" -ForegroundColor Green
            }
         }
         Catch{
            Write-Host "Error: $($_.Exception.Message)"
         }
    }
    Else{
        Write-Host "Cannot move item because there is no such Folder" -ForegroundColor RED
    }
    
}
##----------------------------------------------------------------------------------------------------
##  Function: Convert-DayNumbersToDayName
##  Purpose: This function converts Day number to Text
##----------------------------------------------------------------------------------------------------
Function Convert-DayNumbersToDayName
{
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$True,HelpMessage="Please Enter month number")]
         [String]$DayNumber
         )
        
    Switch ($DayNumber)
    {
          "1" {$DayName = "Sunday"}
          "2" {$DayName = "Monday"}
          "3" {$DayName = "TuesDay"}
          "4" {$DayName = "WednesDay"}
          "5" {$DayName = "ThursDay"}
          "6" {$DayName = "FriDay"}
          "7" {$DayName = "Saturday"}

    }
    
    Return $DayName
}

##----------------------------------------------------------------------------------------------------
##  Function: Convert-MonthNumbersToText
##  Purpose: This function converts month number to text
##----------------------------------------------------------------------------------------------------
Function Convert-MonthNumbersToText
{
    [CmdletBinding()]
    Param(
         [String]$MonthNumber
         )
        
    Switch ($MonthNumber)
    {
          "1" {$MonthName = "January"}
          "2" {$MonthName = "Feburary"}
          "3" {$MonthName = "March"}
          "4" {$MonthName = "April"}
          "5" {$MonthName = "May"}
          "6" {$MonthName = "June"}
          "7" {$MonthName = "July"}
          "8" {$MonthName = "August"}
          "9" {$MonthName = "September"}
          "10" {$MonthName = "October"}
          "11" {$MonthName = "November"} 
          "12" {$MonthName = "December"}
    }
    
    Return $MonthName
}

##----------------------------------------------------------------------------------------------------
##  Function: Convert-WeekOrderNumber
##  Purpose: This function converts week order number to text
##----------------------------------------------------------------------------------------------------
Function Convert-WeekOrderNumber
{
    [CmdletBinding()]
    Param(
         [String]$WeekOrderNumber
         )
        
    Switch ($WeekOrderNumber)
    {
          0 {$WeekOrderName = "Last"}
          1 {$WeekOrderName = "First"}
          2 {$WeekOrderName = "Second"}
          3 {$WeekOrderName = "Third"}
          4 {$WeekOrderName = "Fourth"}

    }
    
    Return $WeekOrderName
}

##----------------------------------------------------------------------------------------------------
##  Function: Convert-MonthToNumbers
##  Purpose: This function converts Month names to numbers
##----------------------------------------------------------------------------------------------------
Function Convert-MonthToNumbers
{
    [CmdletBinding()]
    Param(
         [String]$MonthName
         )
        
    Switch ($MonthName)
    {
          "January" {$MonthNumber = 1}
          "Feburary" {$MonthNumber = 2}
          "March" {$MonthNumber = 3}
          "April" {$MonthNumber = 4}
          "May" {$MonthNumber = 5}
          "June" {$MonthNumber = 6}
          "July" {$MonthNumber = 7}
          "August" {$MonthNumber = 8}
          "September" {$MonthNumber = 9}
          "October" {$MonthNumber = 10}
          "November" {$MonthNumber = 11} 
          "December" {$MonthNumber = 12}
    }
    
    Return $MonthNumber
}

##----------------------------------------------------------------------------------------------------
##  Function: Convert-DayNameToNumbers
##  Purpose: This function converts week days to numbers
##----------------------------------------------------------------------------------------------------
Function Convert-DayNameToNumbers
{
    [CmdletBinding()]
    Param(
         [String]$Day
         )
        
    Switch ($Day)
    {
          "Sunday" {$DayNumber = 1}
          "Monday" {$DayNumber = 2}
          "TuesDay" {$DayNumber = 3}
          "WednesDay" {$DayNumber = 4}
          "ThursDay" {$DayNumber = 5}
          "FriDay" {$DayNumber = 6}
          "Saturday" {$DayNumber = 7}

    }
    
    Return $DayNumber
}

##----------------------------------------------------------------------------------------------------
##  Function: Convert-WeekOrder
##  Purpose: This function converts week order to numbers
##----------------------------------------------------------------------------------------------------
Function Convert-WeekOrder
{
    [CmdletBinding()]
    Param(
         [String]$WeekOrder
         )
        
    Switch ($WeekOrder)
    {
          "Last" {$WeekNumber = 0}
          "First" {$WeekNumber = 1}
          "Second" {$WeekNumber = 2}
          "Third" {$WeekNumber = 3}
          "Fourth" {$WeekNumber = 4}

    }
    
    Return $WeekNumber
}

##----------------------------------------------------------------------------------------------------
##  Function: Convert-ScheduleString
##  Purpose: This function converts schduled token string to text
##----------------------------------------------------------------------------------------------------
Function Convert-ScheduleString
{
    [CmdletBinding()]
    Param(
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Site code")]
            $SiteCode,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server name")]
            $SiteServer,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Schedule string data")]
            $ScheduleString  
         )   
     
     $Class = "SMS_ScheduleMethods"
     $Method = "ReadFromString"
     $Colon = ":"
     $WMIConnection = [WMIClass]"\\$SiteServer\root\SMS\Site_$SiteCode$Colon$Class"
     $String = $WMIConnection.psbase.GetMethodParameters($Method)
     $String.StringData = $ScheduleString
     $ScheduleData = $WMIConnection.psbase.InvokeMethod($Method,$String,$null)
     
     $ScheduleClass = $ScheduleData.TokenData

     switch($ScheduleClass[0].__CLASS)
     {
        "SMS_ST_RecurWeekly" 
                           {
                             $ScheduleText = "Occurs every: $($ScheduleClass[0].ForNumberOfWeeks) weeks on " + (Convert-DayNumbersToDayName -DayNumber $ScheduleClass[0].Day)
                             Return $ScheduleText
                           }
       
       "SMS_ST_RecurInterval"
                           {
                            $ScheduleText = "Occures every $($ScheduleClass[0].DaySpan) days"
                            Return $ScheduleText
                           }
                           
       "SMS_ST_RecurMonthlyByDate"
                           {

                               If($ScheduleClass[0].MonthDay -eq 0){
                              
                                    $ScheduleText = "Occures the last day of every " + (Convert-MonthNumbersToText -MonthNumber $ScheduleClass[0].ForNumberOfMonths)
                                    Return $ScheduleText
                               }
                               Else{
                                    $ScheduleText = "Occures day $($ScheduleClass[0].MonthDay) of every " + (Convert-MonthNumbersToText -MonthNumber $ScheduleClass[0].ForNumberOfMonths)
                                    Return $ScheduleText
                               }
                           }
                           
       "SMS_ST_RecurMonthlyByWeekday"    
                           {
                               $ScheduleText = "Occures the " + (Convert-WeekOrderNumber -weekordernumber $ScheduleClass[0].WeekOrder) + " " + (Convert-DayNumbersToDayName -DayNumber $ScheduleClass[0].Day) + " of every " + (Convert-MonthNumbersToText -MonthNumber $ScheduleClass[0].ForNumberOfMonths)
                               Return $ScheduleText
                           }                 
      
      "SMS_ST_NonRecurring"
                           {
                            $ScheduleText = "No Schedule"
                            Return $ScheduleText
                           }                     
     }
    
}

##----------------------------------------------------------------------------------------------------
##  Function: Write-SchedToString
##  Purpose: This function Scheduled token to String
##----------------------------------------------------------------------------------------------------
Function Write-SchedToString
{
    [CmdletBinding()]
    Param(
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Site code")] 
         $SiteCode,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Name")] 
         $SiteServer,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Token Information")] 
         $TokenData
         )
              
     $Method = "WriteToString"  
     $Class = "SMS_ScheduleMethods"
     
     Try{
         $WMIConnection = ([WMIClass]"\\$SiteServer\root\SMS\Site_$($SiteCode):$Class")
         $schedule = $WMIConnection.psbase.GetMethodParameters($Method)
         $schedule.TokenData = $TokenData
         $StringData = $WMIConnection.psbase.InvokeMethod($Method,$schedule,$null)
         
         Return $StringData.StringData
    }
    Catch{
        Write-Host "Error: $($_.Exception.Message)"
    }
}

##----------------------------------------------------------------------------------------------------
##  Function: New-ScheduleToken
##  Purpose: This function creates Scheduled token
##----------------------------------------------------------------------------------------------------
Function New-ScheduleToken
{
    [CmdLetBinding()]
    Param(
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Day Name",ParameterSetName='RecurWeekly')]
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Day Name",ParameterSetName='RecurMonthlyWeekDay')]
        [ValidateSet("Sunday","Monday","TuesDay","WednesDay","ThursDay","FriDay","SaturDay")]
            [String]$Day,
        [Parameter(Mandatory=$True,HelpMessage="Please Enter week number",ParameterSetName='RecurWeekly')]
        [ValidateRange(1,4)]
            [Int]$NumberOfWeeks,
        [Parameter(Mandatory=$True,HelpMessage="Please Enter month name",ParameterSetName='RecurMonthly')]
        [Parameter(Mandatory=$True,HelpMessage="Please Enter month name",ParameterSetName='RecurMonthlyWeekDay')]
        [ValidateSet("January","Feburary","March","April","May","June","July","August","September","October","November","December")]
            [String]$MonthName,
        [Parameter(Mandatory=$True,HelpMessage="Please Enter month day in numbers",ParameterSetName='RecurMonthly')]
        [ValidateRange(0,31)]
            [Int]$MonthDay,
        [Parameter(Mandatory=$True,HelpMessage="Please Enter week ",ParameterSetName='RecurMonthlyWeekDay')]
        [ValidateSet("First","Second","Third","Fourth","Last")]
            [String]$WeekOrder,
        [Parameter(Mandatory=$True,HelpMessage="Please Enter month day in numbers",ParameterSetName='CustomDay')]
        [ValidateRange(0,31)]
            [Int]$CustomDay,
            [Switch]$String,
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Site code",ParameterSetName='RecurWeekly')]    
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Site code",ParameterSetName='RecurMonthlyWeekDay')]
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Site code",ParameterSetName='CustomDay')]
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Site code",ParameterSetName='RecurMonthly')]      
            $SiteCode,
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Name",ParameterSetName='RecurWeekly')]    
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Name",ParameterSetName='RecurMonthly')]    
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Name",ParameterSetName='RecurMonthlyWeekDay')]    
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Name",ParameterSetName='CustomDay')]    
            $SiteServer,
        [Parameter(Mandatory=$False,HelpMessage="Please Enter Site Server Name",ParameterSetName='RecurWeekly')]    
        [Parameter(Mandatory=$False,HelpMessage="Please Enter Site Server Name",ParameterSetName='RecurMonthly')]    
        [Parameter(Mandatory=$False,HelpMessage="Please Enter Site Server Name",ParameterSetName='RecurMonthlyWeekDay')]    
        [Parameter(Mandatory=$False,HelpMessage="Please Enter Site Server Name",ParameterSetName='CustomDay')]    
            $StartTime,
        [Parameter(Mandatory=$False,HelpMessage="Please Enter Site Server Name",ParameterSetName='RecurWeekly')]    
        [Parameter(Mandatory=$False,HelpMessage="Please Enter Site Server Name",ParameterSetName='RecurMonthly')]    
        [Parameter(Mandatory=$False,HelpMessage="Please Enter Site Server Name",ParameterSetName='RecurMonthlyWeekDay')]    
        [Parameter(Mandatory=$False,HelpMessage="Please Enter Site Server Name",ParameterSetName='CustomDay')]     
            $HourDuration,
        [Parameter(Mandatory=$False,HelpMessage="Please Enter Site Server Name",ParameterSetName='RecurWeekly')]    
        [Parameter(Mandatory=$False,HelpMessage="Please Enter Site Server Name",ParameterSetName='RecurMonthly')]    
        [Parameter(Mandatory=$False,HelpMessage="Please Enter Site Server Name",ParameterSetName='RecurMonthlyWeekDay')]    
        [Parameter(Mandatory=$False,HelpMessage="Please Enter Site Server Name",ParameterSetName='CustomDay')]      
            $UTC = $False,
        [Parameter(Mandatory=$False,HelpMessage="Please Enter Site Server Name",ParameterSetName='RecurWeekly')]    
        [Parameter(Mandatory=$False,HelpMessage="Please Enter Site Server Name",ParameterSetName='RecurMonthly')]    
        [Parameter(Mandatory=$False,HelpMessage="Please Enter Site Server Name",ParameterSetName='RecurMonthlyWeekDay')]    
        [Parameter(Mandatory=$False,HelpMessage="Please Enter Site Server Name",ParameterSetName='CustomDay')]      
            $MinuteDuration            
    )
  
    Switch($PsCmdlet.ParameterSetName)
    {
            "RecurWeekly" 
                    {
                        Try{
                            $Class = "SMS_ST_RecurWeekly"
                            $ScheduledToken = ([WMIClass]"\\$SiteServer\root\SMS\Site_$($SiteCode):$Class").CreateInstance()
                            $ScheduledToken.Day = Convert-DayNameToNumbers -Day $Day
                            $ScheduledToken.ForNumberOfWeeks = $NumberOfWeeks
                            $ScheduledToken.HourDuration = $HourDuration
                            $ScheduledToken.MinuteDuration = $MinuteDuration
                            $ScheduledToken.StartTime = $StartTime
                            $ScheduledToken.IsGMT = $UTC
                            
                            If($String){
                                Write-SchedToString -sitecode $siteCode -siteserver $Siteserver -Tokendata $ScheduledToken
                            }
                            Else{
                                Return $ScheduledToken
                            }
                         }
                         Catch{
                            Write-Host "Error: $($_.Exception.Message)"
                         }
                    }
            "RecurMonthlyWeekDay" 
                    {
                        Try{
                            $Class = "SMS_ST_RecurMonthlyByWeekDay"
                            $ScheduledToken = ([WMIClass]"\\$SiteServer\root\SMS\Site_$($SiteCode):$Class").CreateInstance()
                            $ScheduledToken.Day = Convert-DayNameToNumbers -Day $Day
                            $ScheduledToken.WeekOrder = Convert-WeekOrder -WeekOrder $WeekOrder
                            $ScheduledToken.ForNumberOfMonths = Convert-MonthToNumbers -MonthName $MonthName
                            $ScheduledToken.HourDuration = $HourDuration
                            $ScheduledToken.MinuteDuration = $MinuteDuration
                            $ScheduledToken.StartTime = $StartTime
                            $ScheduledToken.IsGMT = $UTC
                            
                            If($String){
                                Write-SchedToString -sitecode $siteCode -siteserver $Siteserver -Tokendata $ScheduledToken
                            }
                            Else{
                                Return $ScheduledToken
                            }
                        }
                        Catch{
                            Write-Host "Error: $($_.Exception.Message)"
                         }
                    }
            "RecurMonthly" 
                    {
                        Try{
                            $Class = "SMS_ST_RecurMonthlyByDate"
                            $ScheduledToken = ([WMIClass]"\\$SiteServer\root\SMS\Site_$($SiteCode):$Class").CreateInstance()
                            $ScheduledToken.MonthDay = $MonthDay
                            $ScheduledToken.ForNumberOfMonths = Convert-MonthToNumbers -MonthName $MonthName
                            $ScheduledToken.HourDuration = $HourDuration
                            $ScheduledToken.MinuteDuration = $MinuteDuration
                            $ScheduledToken.StartTime = $StartTime
                            $ScheduledToken.IsGMT = $UTC
                            
                            If($String){
                                Write-SchedToString -sitecode $siteCode -siteserver $Siteserver -Tokendata $ScheduledToken
                            }
                            Else{
                                Return $ScheduledToken
                            }
                        }
                        Catch{
                            Write-Host "Error: $($_.Exception.Message)"
                         }
                    }
            "CustomDay" 
                    {
                        Try{
                            $Class = "SMS_ST_RecurInterval"
                            $ScheduledToken = ([WMIClass]"\\$SiteServer\root\SMS\Site_$($SiteCode):$Class").CreateInstance()
                            $ScheduledToken.DaySpan = $CustomDay
                            $ScheduledToken.HourDuration = $HourDuration
                            $ScheduledToken.MinuteDuration = $MinuteDuration
                            $ScheduledToken.StartTime = $StartTime
                            $ScheduledToken.IsGMT = $UTC
                            
                            If($String){
                                Write-SchedToString -sitecode $siteCode -siteserver $Siteserver -Tokendata $ScheduledToken
                            }
                            Else{
                                Return $ScheduledToken
                            }
                        }
                        Catch{
                            Write-Host "Error: $($_.Exception.Message)"
                         }
                    }
     
    }
}

Function Get-CMCollectionSettings
{
    [CmdletBinding()]
    Param(
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Site code")] 
            $SiteCode,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server name")]
            $SiteServer,
         [Parameter(Mandatory=$False,HelpMessage="Please Enter Query Filter")]   
            $Filter
         )
         
    $Class = "SMS_CollectionSettings"
    
    Try{
        Get-WmiObject -Namespace "root\SMS\Site_$SiteCode" -Class $Class -Filter $Filter -ErrorAction STOP -ComputerName $SiteServer
    }
    Catch{
        Write-Host "Error: $($_.Exception.Message)"
    }
}

##----------------------------------------------------------------------------------------------------
##  Function: Add-CMCollection
##  Purpose: This function adds collection
##----------------------------------------------------------------------------------------------------
Function Add-CMCollection
{
    [CmdLetBinding(DefaultParameterSetName = "None")]
    Param(
        [Parameter(Mandatory=$False,HelpMessage="Please Enter Day Name",ParameterSetName='RecurWeekly')]
        [Parameter(Mandatory=$False,HelpMessage="Please Enter Day Name",ParameterSetName='RecurMonthlyWeekDay')]
        [ValidateSet("Sunday","Monday","TuesDay","WednesDay","ThursDay","FriDay","SaturDay")]
            [String]$Day,
        [Parameter(Mandatory=$False,HelpMessage="Please Enter week number",ParameterSetName='RecurWeekly')]
        [ValidateRange(1,4)]
            [Int]$NumberOfWeeks,
        [Parameter(Mandatory=$False,HelpMessage="Please Enter month name",ParameterSetName='RecurMonthly')]
        [Parameter(Mandatory=$False,HelpMessage="Please Enter month name",ParameterSetName='RecurMonthlyWeekDay')]
        [ValidateSet("January","Feburary","March","April","May","June","July","August","September","October","November","December")]
            [String]$MonthName,
        [Parameter(Mandatory=$False,HelpMessage="Please Enter month day in numbers",ParameterSetName='RecurMonthly')]
        [ValidateRange(0,31)]
            [Int]$MonthDay,
        [Parameter(Mandatory=$False,HelpMessage="Please Enter week ",ParameterSetName='RecurMonthlyWeekDay')]
        [ValidateSet("First","Second","Third","Fourth","Last")]
            [String]$WeekOrder,
        [Parameter(Mandatory=$False,HelpMessage="Please Enter month day in numbers",ParameterSetName='CustomDay')]
        [ValidateRange(0,31)]
            [Int]$CustomDay,
            [Switch]$String,
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Site code")]    
            $SiteCode,   
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Name")]
            $SiteServer,
        [Parameter(Mandatory=$true,HelpMessage="Please Enter Collection Name")]
            $Name,
        [Parameter(Mandatory=$true,HelpMessage="Please Enter Limiting Collection ID")]
            $LimitToCollectionID,
        [Parameter(Mandatory=$true,HelpMessage="Please Enter Collection Type, eg. Device or User")]    
        [ValidateSet("Device","User")]
            $Type,
            $Folder,
            $Comment = "",
            [Switch]$Incremental
         )
    
    $Class = "SMS_Collection"

    If($Incremental){
        [int]$RefreshType = $RefreshType + 4
    }
    
    Switch ($Type)
    {
        "Device" {$ColType = 2}
        "User" {$ColType = 1}
    }
    
    $Arguments = @{Name="$Name";Comment=$Comment;CollectionType="$ColType";LimitToCollectionID=$LimitToCollectionID}  
    

    Switch($PsCmdlet.ParameterSetName)
    {
            "RecurWeekly" 
                    {

                        [Array]$RefreshScedule = New-ScheduleToken -Day $Day -NumberOfWeeks $NumberOfWeeks -SiteCode $SiteCode -SiteServer $SiteServer
                        $Arguments += @{RefreshSchedule = $RefreshScedule;RefreshType=$RefreshType+2}
                    }
            "RecurMonthlyWeekDay" 
                    {
                        [Array]$RefreshScedule = New-ScheduleToken -Day $Day -MonthName $MonthName -WeekOrder $WeekOrder -SiteCode $SiteCode -SiteServer $SiteServer
                        $Arguments += @{RefreshSchedule = $RefreshScedule;RefreshType=$RefreshType+2}
                    }
            "RecurMonthly" 
                    {
                        [Array]$RefreshScedule = New-ScheduleToken -MonthName $MonthName -MonthDay $MonthDay -SiteCode $SiteCode -SiteServer $SiteServer
                        $Arguments += @{RefreshSchedule = $RefreshScedule;RefreshType=$RefreshType+2}
                    }
            "CustomDay" 
                    {
                        [Array]$RefreshScedule = New-ScheduleToken -CustomDay $CustomDay -SiteCode $SiteCode -SiteServer $SiteServer
                        $Arguments += @{RefreshSchedule = $RefreshScedule;RefreshType=$RefreshType+2}
                    }
            "None" 
                    {
                        $Arguments += @{RefreshType=1}
                    }
    }
    

    If((Get-CMCollection -SiteCode $SiteCode -SiteServer $SiteServer -Filter "Name='$Name'") -ne $Null){

        Write-Host "Collection with this name already exists"
    }
    Else{
        Try{
            Set-WmiInstance -Namespace "root\sms\site_$SiteCode" -Class $Class -Arguments $Arguments -ErrorAction STOP -ComputerName $SiteServer
                
                If($Folder.length -gt 0){
                
                    $Collection = Get-CMCollection -SiteCode $SiteCode -SiteServer $SiteServer -Filter "Name='$Name'"
                    Start-Sleep 5
                    
                        Switch ($ColType)
                        {
                            1 {$objectType = 5001}
                            2 {$objectType = 5000}
                        }
                        
                    Move-CMItem -SiteCode $SiteCode -SiteServer $SiteServer -objectID $Collection.CollectionID -objectTypeID $objectType -TargetContainerName $Folder
                }
        }
        Catch{
            Write-Host "Error: $($_.Exception.Message)"
        }
    }
    
}

##----------------------------------------------------------------------------------------------------
##  Function: Add-WSUS
##  Purpose: This function installs WSUS 
##----------------------------------------------------------------------------------------------------
Function Add-WSUS
{
    [CmdLetBinding()]
    Param(
    [Parameter(Mandatory=$True)]
         [String]$Arguments,
    [Parameter(Mandatory=$True)]
         [String]$File
         )
   Try{ 
       $Install = Start-Process $File -ArgumentList $Arguments -Wait -PassThru -ErrorAction STOP
       
       If($Install.ExitCode -eq 0){
            Write-Host "Installation was successful"
       }
       Else{
            Write-Host "Installation Failed $($Install.ExitCode)"
       }
   }
   Catch{
            Write-Host "Error: $($_.Exception.Message)"
   }
}

##----------------------------------------------------------------------------------------------------
##  Function: Add-WDS
##  Purpose: This function installs WDS and configures PXE response policy
##----------------------------------------------------------------------------------------------------
Function Add-WDS
{
    [CmdLetBinding()]
    Param(
        $Folder = "$env:Systemdrive\RemoteInstall"
    )
   
   $Role = "WDS"
                                                 
   Try{
       Write-Host " -  Loading Server Manager PowerShell Module"
       Import-Module servermanager -ErrorAction STOP  
   }
   Catch{
       Write-Host "Failed to load Server Manager PowerShell Module"
   }
       
       Try{
           Write-Host " - Adding WDS Server Role"
           Add-WindowsFeature $Role -ErrorAction STOP
       }
       Catch{
             Write-Host "Error: $($_.Exception.Message)"
       }
                                                                                                                                                                                                                                                                       
      Write-Host " - Setting up $Folder"
      Try{      
          $SetUpServer = Start-Process WDSUtil -ArgumentList "/Initialize-Server /RemInst:""$($Folder)""" -Wait -PassThru -ErrorAction STOP
          If($SetUpServer.ExitCode -eq 0){
                Write-Host " - $Folder configured correctly"
          }
          Else{
                Write-Host " - Something went wrong: $($SetUpServer.ExitCode)"
          }
      }
      Catch{
            Write-Host "Error: $($_.Exception.Message)"
      }
      
      Write-Host " - Configuring PXE Response Policy"
      Try{      
          $EnableAllClients = Start-Process WDSUtil -ArgumentList "/set-server /AnswerClients:ALL" -Wait -PassThru -ErrorAction STOP
          
          If($EnableAllClients.ExitCode -eq 0){
                Write-Host " - PXE Response Policy configured successfully"
          }
          Else{
                Write-Host "-Something went wrong: $($EnableAllClients.ExitCode)"
          }
      }
      Catch{
            Write-Host "Error: $($_.Exception.Message)"
      }
}

##----------------------------------------------------------------------------------------------------
##  Function: Get-CMBoundary
##  Purpose: This function queries all CM boundaries
##----------------------------------------------------------------------------------------------------
Function Get-CMBoundary
{
    [CmdLetBinding()]
    Param(
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site code")]
                    $SiteCode,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Name")]
            [String]$SiteServer,
         [Parameter(Mandatory=$False)]
            [String]$Filter
         )
     
     $Class = "SMS_Boundary" 
     
     Try{
        Get-WmiObject -Namespace "root\SMS\Site_$SiteCode" -Class $Class -Filter $Filter -ErrorAction STOP -ComputerName $SiteServer
     }
     Catch{
        Write-Host "Error: $($_.Exception.Message)"
     }
}

##----------------------------------------------------------------------------------------------------
##  Function: Add-CMBoundary
##  Purpose: This function adds CM Boundary
##----------------------------------------------------------------------------------------------------
Function Add-CMBoundary
{
    [CmdLetBinding()]
    Param(
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Boundary Name")]
            [String]$Name,
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Boundary value")]    
            [String]$Value,
        [Parameter(Mandatory=$True,HelpMessage="Please Boundary Type eg. IPSubNet,AD,IPV6 or IPRange")]    
            [ValidateSet("IPSubNet","AD","IPV6","IPRange")]
            $Type,
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site code")]    
            $SiteCode,
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Name")]   
            [String]$SiteServer
        )
    
   Switch($Type)
   {
    "IPSubNet" {$TypeNumber = 0}
    "AD" {$TypeNumber = 1}
    "IPV6" {$TypeNumber = 2}
    "IPRange" {$TypeNumber = 3}
   }
   
   $Class = "SMS_Boundary"
   
   $Arguments = @{BoundaryType=$TypeNumber;DisplayName=$Name;Value=$Value}
      
    If((Get-CMBoundary -SiteCode $SiteCode -SiteServer $SiteServer -Filter "Value='$Value'") -ne $Null){

        Write-Host "The specified boundary already exists!"
    }
    Else{
        Try{       
            Set-WmiInstance -Namespace "root\sms\site_$SiteCode" -Class $Class -Arguments $Arguments -ComputerName $SiteServer -ErrorAction STOP
        }
        Catch{
            Write-Host "Error: $($_.Exception.Message)"
       }
    }  
}

##----------------------------------------------------------------------------------------------------
##  Function: Get-CMBoundaryGroup
##  Purpose: This function queries CM Boundary groups
##----------------------------------------------------------------------------------------------------
Function Get-CMBoundaryGroup
{
    [CmdLetBinding()]
    Param(
          [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site code")]
                    $SiteCode,
          [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Name")]
            [String]$SiteServer,
          [Parameter(Mandatory=$False)]
            [String]$Filter
         )
     
     $Class = "SMS_BoundaryGroup" 
     
     Try{
        Get-WmiObject -Namespace "root\SMS\Site_$SiteCode" -Class $Class -Filter $Filter -ErrorAction STOP -ComputerName $SiteServer
     }
     Catch{
        Write-Host "Error: $($_.Exception.Message)"
     }
}

##----------------------------------------------------------------------------------------------------
##  Function:  Add-CMBoundaryGroup
##  Purpose: This function adds CM Boundary group
##----------------------------------------------------------------------------------------------------
Function Add-CMBoundaryGroup
{
    [CmdLetBinding()]
    Param(
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Boundary Group Name")]
            [String]$Name,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site code")]    
            $SiteCode,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Name")]   
            [String]$SiteServer
        )
    
   
   $Class = "SMS_BoundaryGroup"
   
   $Arguments = @{Name=$Name}
      
    If((Get-CMBoundaryGroup -SiteCode $SiteCode -SiteServer $SiteServer -Filter "Name='$Name'") -ne $Null){

        Write-Host "The Boundary Group Name is already in use. Enter a different name!"
    }
    Else{
        Try{       
            Set-WmiInstance -Namespace "root\sms\site_$SiteCode" -Class $Class -Arguments $Arguments -ComputerName $SiteServer -ErrorAction STOP
        }
        Catch{
            Write-Host "Error: $($_.Exception.Message)"
       }
    }  
}

##----------------------------------------------------------------------------------------------------
##  Function:  Add-CMBoundaryToGroup
##  Purpose: This function adds CM Boundary to Boundary group
##----------------------------------------------------------------------------------------------------
Function Add-CMBoundaryToGroup
{
    [CmdLetBinding()]
    Param(
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Boundary Group Name")]
            [String]$BoundaryGroup,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Boundary Name")]
            [String]$Boundary,    
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site code")]    
            $SiteCode,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Name")]   
            [String]$SiteServer
        )
    
   $Class = "SMS_BoundaryGroup"
    
   If((Get-CMBoundaryGroup -SiteCode $SiteCode -SiteServer $SiteServer -Filter "Name='$BoundaryGroup'") -eq $Null){

        Write-Host "There is no such Boundary Group like: $BoundaryGroup"
    }
    ElseIF(($BoundaryQuery = Get-CMBoundary -SiteCode $SiteCode -SiteServer $SiteServer -Filter "DisplayName='$Boundary'") -eq $Null){
    
        Write-Host "There is no such Boundary like: $Boundary"
    }
        Else{
              Try{ 
                $BoundaryGroupQuery = Get-WmiObject -Namespace "root\sms\site_$SiteCode" -Class $Class -ComputerName $SiteServer -ErrorAction STOP -Filter "Name='$BoundaryGroup'"  
                $ReturnCode = $BoundaryGroupQuery.AddBoundary($BoundaryQuery.BoundaryID)
                    If($ReturnCode.ReturnValue -eq 0){
                        Write-Host " - Successfully added $Boundary boundary to $BoundaryGroup group"
                    }
               
              }
              Catch{
                Write-Host "Error: $($_.Exception.Message)"
            }
        }
    
}

##----------------------------------------------------------------------------------------------------
##  Function:  Get-CMSiteSystem
##  Purpose: This function queries all CM site systems
##----------------------------------------------------------------------------------------------------
Function Get-CMSiteSystem
{
    [CmdLetBinding()]
    Param(
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site code")]    
            $SiteCode,
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Name")]   
            [String]$SiteServer,
        [Parameter(Mandatory=$False)]
            [String]$Filter    
        )
    
    $Class = "SMS_SystemResourceList"
    
     Try{
        Get-WmiObject -Namespace "root\SMS\Site_$SiteCode" -Class $Class -Filter $Filter -ErrorAction STOP -ComputerName $SiteServer | Select-Object ServerName,ServerRemoteName,SiteCode,InternetEnabled,SslState,InternetShared,NALPath,ResourceType,RoleName
     }
     Catch{
        Write-Host "Error: $($_.Exception.Message)"
     }
}

##----------------------------------------------------------------------------------------------------
##  Function:  Add-CMSiteSystemToBoundaryGroup
##  Purpose: This function adds CM site system to Boundary group
##----------------------------------------------------------------------------------------------------
Function Add-CMSiteSystemToBoundaryGroup
{
    [CmdLetBinding()]
    Param(
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Boundary Group Name")]
            [String]$BoundaryGroup,    
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Site System FQDN Name")]
            [String]$SiteSystem,
        [Parameter(Mandatory=$False,HelpMessage="Please Enter Site System connection type")]
        [ValidateSet("Fast","Slow")]
            [String]$ConnectionType = "Fast",            
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site code")]    
            $SiteCode,
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Name")]   
            [String]$SiteServer
        )
    
   
   Switch($ConnectionType)
   {
    "Fast" {$ConnectionNumber = 0}
    "Slow" {$ConnectionNumber = 1}
   }
   
   $Class = "SMS_BoundaryGroup"
    
   If((Get-CMBoundaryGroup -SiteCode $SiteCode -SiteServer $SiteServer -Filter "Name='$BoundaryGroup'") -eq $Null){

        Write-Host "There is no such Boundary Group like: $BoundaryGroup"
    }
    ElseIF(($SiteSystemQuery = Get-CMSiteSystem -sitecode $SiteCode -siteserver $SiteServer -Filter "RoleName='SMS Distribution Point' and ServerName='$SiteSystem'") -eq $Null){
    
        Write-Host "There is no such Site System like: $SiteSystem"
    }
        Else{
              Try{ 
                $BoundaryGroupQuery = Get-WmiObject -Namespace "root\sms\site_$SiteCode" -Class $Class -ComputerName $SiteServer -ErrorAction STOP -Filter "Name='$BoundaryGroup'"  

                $ReturnCode = $BoundaryGroupQuery.AddSiteSystem($SiteSystemQuery.NALPath,$ConnectionNumber)
                    If($ReturnCode.ReturnValue -eq 0){
                        Write-Host " - Successfully added $($SiteSystemQuery.NALPath) to $BoundaryGroup group"
                    }
               
              }
              Catch{
                Write-Host "Error: $($_.Exception.Message)"
            }
        }
    
}

##----------------------------------------------------------------------------------------------------
##  Function:  Get-CMCircularDependency
##  Purpose: This function validates Include & Exclude collection Circular Dependency
##----------------------------------------------------------------------------------------------------
Function Get-CMCircularDependency
{
    [CmdletBinding()]
    Param(
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site Server")]
                $SiteServer,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site code")]
                $SiteCode,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter the main collection name ")]
                $CollectionName,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter exclude collection name that you want to verify")]
                $ExcIncCollectionName
         )
         
    $Method = "VerifyNoCircularDependencies"  
    $Class = "SMS_Collection"
     
    Try{
        $ParentCollection = Get-WmiObject -Namespace "root\sms\Site_$SiteCode" -Class $Class -Filter "Name='$CollectionName'" -ComputerName $SiteServer -ErrorAction STOP
    }
    Catch{
        Write-Host "Error: $($_.Exception.Message)"
    }
    
    Try{
        $SubCollection = Get-WmiObject -Namespace "root\sms\Site_$SiteCode" -Class $Class -Filter "Name='$ExcIncCollectionName'" -ComputerName $SiteServer -ErrorAction STOP
    }
    Catch{
        Write-Host "Error: $($_.Exception.Message)"
    }
    
    Try{
        $VerifyDependency = Invoke-WmiMethod -Namespace "root\sms\Site_$SiteCode" -Class $Class -Name $Method -ArgumentList @($ParentCollection.__PATH,$SubCollection.__PATH,$null) -ErrorAction STOP
        Return $VerifyDependency.Result
    }
    Catch{
        Write-Host "Error: $($_.Exception.Message)"
    }
}

##----------------------------------------------------------------------------------------------------
##  Function:  Set-CMCollectionExcludeRule
##  Purpose: This function adds Exclude collection rule
##----------------------------------------------------------------------------------------------------
Function Set-CMCollectionExcludeRule
{
    [CmdletBinding()]
    Param(
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site Server")]
                $SiteServer,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site code")]
                $SiteCode,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter collection name where do you want to set new rule")]
                $CollectionName,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter collection name that you want to exclude")]
                $ExcludeCollectionName
         )
     
     $Class = "SMS_CollectionRuleExcludeCollection"
     [Array]$ColRules
     
     If(($RuleCollection = Get-CMCollection -SiteCode $SiteCode -SiteServer $SiteServer -Filter "Name='$CollectionName'") -eq $Null){
         Write-Host "There is no such collection like: $CollectionName"
     }
     ElseIf(($ExcludeCollection = Get-CMCollection -SiteCode $SiteCode -SiteServer $SiteServer -Filter "Name='$ExcludeCollectionName'") -eq $Null){
         Write-Host "There is no such collection like: $ExcludeCollectionName"
     }
     Else{
     
        If((Get-CMCircularDependency -SiteCode $SiteCode -SiteServer $SiteServer -CollectionName $CollectionName -ExcIncCollectionName $ExcludeCollectionName)){
               
            $ColRules += ([WMI]$RuleCollection.__PATH).CollectionRules
            
            Try{       
                $NewRule = ([WMIClass]"\\$SiteServer\root\SMS\Site_$($SiteCode):$Class").CreateInstance()
                $NewRule.ExcludeCollectionID = $ExcludeCollection.CollectionID
                $NewRule.RuleName = $ExcludeCollection.Name
                       
                  $ColRules += [System.Management.ManagementBaseObject]$NewRule
                   
                $RuleCollection.CollectionRules = $ColRules
                $RuleCollection.Put()
            }
            Catch{
                Write-Host "Error: $($_.Exception.Message)"
            }
         }
         Else{
            Write-Host "The selected collection '$ExcludeCollectionName' will create a circular dependency"
         }

     }

}

##----------------------------------------------------------------------------------------------------
##  Function:  Set-CMCollectionIncludeRule
##  Purpose: This function adds Include collection rule
##----------------------------------------------------------------------------------------------------
Function Set-CMCollectionIncludeRule
{
    [CmdletBinding()]
    Param(
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site Server")]
                $SiteServer,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site code")]
                $SiteCode,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter collection name where do you want to set new rule")]
                $CollectionName,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter collection name that you want to include")]
                $IncludeCollectionName
         )
     
     $Class = "SMS_CollectionRuleIncludeCollection"
     [Array]$ColRules
     
     If(($RuleCollection = Get-CMCollection -SiteCode $SiteCode -SiteServer $SiteServer -Filter "Name='$CollectionName'") -eq $Null){
         Write-Host "There is no such collection like: $CollectionName"
     }
     ElseIf(($IncludeCollection = Get-CMCollection -SiteCode $SiteCode -SiteServer $SiteServer -Filter "Name='$IncludeCollectionName'") -eq $Null){
         Write-Host "There is no such collection like: $IncludeCollectionName"
     }
     Else{
     
        If((Get-CMCircularDependency -SiteCode $SiteCode -SiteServer $SiteServer -CollectionName $CollectionName -ExcIncCollectionName $IncludeCollectionName)){
               
            $ColRules += ([WMI]$RuleCollection.__PATH).CollectionRules
            
            Try{       
                $NewRule = ([WMIClass]"\\$SiteServer\root\SMS\Site_$($SiteCode):$Class").CreateInstance()
                $NewRule.IncludeCollectionID = $IncludeCollection.CollectionID
                $NewRule.RuleName = $IncludeCollection.Name
                       
                  $ColRules += [System.Management.ManagementBaseObject]$NewRule
                   
                $RuleCollection.CollectionRules = $ColRules
                $RuleCollection.Put()

            }
            Catch{
                Write-Host "Error: $($_.Exception.Message)"
            }
         }
         Else{
            Write-Host "The selected collection '$IncludeCollectionName' will create a circular dependency"
         }

     }

}

##----------------------------------------------------------------------------------------------------
##  Function:  Set-CMCollectionIncludeRule
##  Purpose: This function validates Query Expression
##----------------------------------------------------------------------------------------------------
Function Get-CMQueryValidation
{
    [CmdletBinding()]
    Param(
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site Server")]
                $SiteServer,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site code")]
                $SiteCode,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter the query string for validation ")]
                $Query
         )
    
    $Class = "SMS_CollectionRuleQuery"
    $Method = "ValidateQuery"    
      
    Try{
        $Validate = Invoke-WmiMethod -Namespace "root\sms\site_$SiteCode" -Class $Class -Name $Method -ArgumentList $Query -ComputerName $SiteServer -ErrorAction STOP
        Return $Validate.ReturnValue
        
    }
    Catch{
        Write-Host "Error: $($_.Exception.Message)"
    }

}

##----------------------------------------------------------------------------------------------------
##  Function:  Get-ResourceID
##  Purpose: This function queries Resource ID
##----------------------------------------------------------------------------------------------------
Function Get-ResourceID
{
    [CmdletBinding()]
    Param(
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site Server")]
                $SiteServer,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site code")]
                $SiteCode,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter the computer name that you want to add")]
                $ResourceName
         )
   
   $Class = "SMS_R_System"
   
    Try{
        Get-WmiObject -Namespace "Root\sms\Site_$SiteCode" -Class $Class -Filter "Name='$ResourceName'" -ErrorAction STOP -computername $SiteServer
    }
    Catch{
        Write-Host "Error: $($_.Exception.Message)"
    }
}

##----------------------------------------------------------------------------------------------------
##  Function:  Set-CMUserCollectionQueryRule
##  Purpose: This function adds standard query rule to users collection
##----------------------------------------------------------------------------------------------------
Function Set-CMCollectionQueryRule
{
    [CmdletBinding()]
    Param(
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site Server")]
                $SiteServer,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site code")]
                $SiteCode,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter the query for collection")]
                $Query,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter the query name")]
                $QueryName,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter the query type eg. User or Device")]
         [ValidateSet("User","Device")]
                $QueryType,       
         [Parameter(Mandatory=$True,HelpMessage="Please Enter the collection name where do you want to set new rule")]
                $CollectionName     
         )
         
     $Class = "SMS_CollectionRuleQuery"
     [Array]$ColRules
     
     Switch($QueryType)
     {
        "User" {$QueryTypeNumber = 1}
        "Device" {$QueryTypeNumber = 2}
     }
     
     If(($RuleCollection = Get-CMCollection -SiteCode $SiteCode -SiteServer $SiteServer -Filter "Name='$CollectionName' and CollectionType='$QueryTypeNumber'") -eq $Null){
         Write-Host "There is no such $QueryType collection like: $CollectionName"
     }
     Else{
     
        If((Get-CMQueryValidation -SiteCode $SiteCode -SiteServer $SiteServer -Query $Query)){
               
            $ColRules += ([WMI]$RuleCollection.__PATH).CollectionRules
            
            Try{       
                $NewRule = ([WMIClass]"\\$SiteServer\root\SMS\Site_$($SiteCode):$Class").CreateInstance()
                $NewRule.QueryExpression = $Query
                $NewRule.RuleName = $QueryName
                       
                  $ColRules += [System.Management.ManagementBaseObject]$NewRule
                   
                $RuleCollection.CollectionRules = $ColRules
                $RuleCollection.Put()
            }
            Catch{
                Write-Host "Error: $($_.Exception.Message)"
            }
         }
         Else{
            Write-Host "Please check your query rule syntax"
         }

     }
      

}

##----------------------------------------------------------------------------------------------------
##  Function:  Set-CMCollectionDirectRule
##  Purpose: This function adds direct membership for collection
##----------------------------------------------------------------------------------------------------
Function Set-CMCollectionDirectRule
{
    [CmdletBinding()]
    Param(
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site Server")]
                $SiteServer,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site code")]
                $SiteCode,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter the computer name that you want to add")]
                $ResourceName,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter collection name where do you want to set new rule")]
                $CollectionName         
         )
         
     $Class = "SMS_CollectionRuleDirect"
     [Array]$ColRules
     
     If(($RuleCollection = Get-CMCollection -SiteCode $SiteCode -SiteServer $SiteServer -Filter "Name='$CollectionName'") -eq $Null){
         Write-Host "There is no such collection like: $CollectionName"
     }
     Else{
     
       If(($ResourceQuery = Get-ResourceID -SiteServer $SiteServer -SiteCode $SiteCode -ResourceName $ResourceName) -ne $Null){
               
            $ColRules += ([WMI]$RuleCollection.__PATH).CollectionRules
            
            Try{       
                $NewRule = ([WMIClass]"\\$SiteServer\root\SMS\Site_$($SiteCode):$Class").CreateInstance()
                $NewRule.ResourceClassName = "SMS_R_SYSTEM"
                $NewRule.ResourceID = $ResourceQuery.ResourceID
                $NewRule.Rulename = $ResourceName
                       
                  $ColRules += [System.Management.ManagementBaseObject]$NewRule
                   
                $RuleCollection.CollectionRules = $ColRules
                $RuleCollection.Put()
            }
            Catch{
                Write-Host "Error: $($_.Exception.Message)"
            }
         }
         Else{
            Write-Host "There is no such computer like: '$ResourceName'" 
         }

     }
      
}

##----------------------------------------------------------------------------------------------------
##  Function:  Create-CMAccount
##  Purpose: This function creates new ConfigMgr account
##----------------------------------------------------------------------------------------------------
Function Create-CMAccount
{
    [CmdletBinding()]
    Param(
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site Server")]
                $SiteServer,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Primary Server Site code")]
                $SiteCode,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter the CM account name")]
                $AccountName,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter the CM account MAC Address")]
         [ValidatePattern('^([0-9a-fA-F]{2}[:-]{0,1}){5}[0-9a-fA-F]{2}$')]
                $MACAddress,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter the collecton name")]
                $CollectionName      
         )
    
    $Class = "SMS_Site"
    $Method = "ImportMachineEntry"    

   Try{
         $WMIConnection = ([WMIClass]"\\$SiteServer\root\SMS\Site_$($SiteCode):$Class")
         $NewEntry = $WMIConnection.psbase.GetMethodParameters($Method)
         $NewEntry.MACAddress = $MACAddress
         $NewEntry.NetbiosName = $AccountName
         $NewEntry.OverwriteExistingRecord = $True
         
         $WMIConnection.psbase.InvokeMethod($Method,$NewEntry,$null)
         
    }
    Catch{
        Write-Host "Error: $($_.Exception.Message)"
    }
    
    Set-CMCollectionDirectRule -SiteServer $SiteServer -SiteCode $SiteCode -ResourceName $AccountName -CollectionName $CollectionName

}

##----------------------------------------------------------------------------------------------------
##  Function:  Get-CMCollectionSettings
##  Purpose: This function queries CM collection settings
##----------------------------------------------------------------------------------------------------
Function Get-CMCollectionSettings
{
    [CmdletBinding()]
    Param(
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Site code")] 
            $SiteCode,
         [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server name")]
            $SiteServer,
         [Parameter(Mandatory=$False,HelpMessage="Please Enter Query Filter")]   
            $Filter
         )
         
    $Class = "SMS_CollectionSettings"
    
    Try{
        Get-WmiObject -Namespace "root\SMS\Site_$SiteCode" -Class $Class -Filter $Filter -ErrorAction STOP -ComputerName $SiteServer
    }
    Catch{
        Write-Host "Error: $($_.Exception.Message)"
    }
}

##----------------------------------------------------------------------------------------------------
##  Function:  Set-CMMaintenanceWindow 
##  Purpose: This function sets CM collection Maintenance Windows settings
##----------------------------------------------------------------------------------------------------
Function Set-CMMaintenanceWindow 
{
    [CmdLetBinding(DefaultParameterSetName = "None")]
    Param( 
        [Parameter(Mandatory=$False,HelpMessage="Please Enter Day Name",ParameterSetName='RecurWeekly')]
        [Parameter(Mandatory=$False,HelpMessage="Please Enter Day Name",ParameterSetName='RecurMonthlyWeekDay')]
        [ValidateSet("Sunday","Monday","TuesDay","WednesDay","ThursDay","FriDay","SaturDay")]
            [String]$Day,
        [Parameter(Mandatory=$False,HelpMessage="Please Enter week number",ParameterSetName='RecurWeekly')]
        [ValidateRange(1,4)]
            [Int]$NumberOfWeeks,
        [Parameter(Mandatory=$False,HelpMessage="Please Enter month name",ParameterSetName='RecurMonthly')]
        [Parameter(Mandatory=$False,HelpMessage="Please Enter month name",ParameterSetName='RecurMonthlyWeekDay')]
        [ValidateSet("January","Feburary","March","April","May","June","July","August","September","October","November","December")]
            [String]$MonthName,
        [Parameter(Mandatory=$False,HelpMessage="Please Enter month day in numbers",ParameterSetName='RecurMonthly')] 
        [ValidateRange(0,31)]
            [Int]$MonthDay,
        [Parameter(Mandatory=$False,HelpMessage="Please Enter week ",ParameterSetName='RecurMonthlyWeekDay')]
        [ValidateSet("First","Second","Third","Fourth","Last")]
            [String]$WeekOrder,
        [Parameter(Mandatory=$False,HelpMessage="Please Enter month day in numbers",ParameterSetName='CustomDay')]
        [ValidateRange(0,31)]
            [Int]$CustomDay,
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Site code")]    
            $SiteCode,   
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Site Server Name")]
            $SiteServer,
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Collection Name")]
            $CollectionName,
        [Parameter(Mandatory=$True,HelpMessage="Please Enter Schedule Name")]
            $ScheduleName,
        [Parameter(Mandatory=$True,HelpMessage="Please Enter start date")]
        [ValidatePattern('^(0?[1-9]|[12][0-9]|3[01])[\.](0?[1-9]|1[012])[\.](19|20)\d\d$')]
            $StartDate,
        [Parameter(Mandatory=$True,HelpMessage="Please Enter start time")]
        [ValidatePattern('^(2[0-3]|[01]?[0-9]):([0-5]?[0-9])$')]
            $StartTime,
        [Parameter(Mandatory=$True,HelpMessage="Please Enter end time")]
        [ValidatePattern('^(2[0-3]|[01]?[0-9]):([0-5]?[0-9])$')]
            $EndTime,         
            [Switch]$TaskSequenceOnly,
            [Switch]$UTC
         )
       
        If($StartTime -gt $EndTime){
            $Date1 = (Get-Date $StartTime)
            $Date2 = (Get-Date $EndTime).AddDays(+1)
            $Minutes = $Date2 - $Date1

        }
        Elseif($StartTime -eq $EndTime){
            $Minutes = New-Object PSObject
            $Minutes | Add-Member -MemberType NoteProperty -Name "Hours" -Value 24
            $Minutes | Add-Member -MemberType NoteProperty -Name "Minutes" -Value 0
            $Minutes | Add-Member -MemberType NoteProperty -Name "TotalMinutes" -Value 1440
        }
 
        Elseif($StartTime -lt $EndTime){
            $Minutes = New-TimeSpan $(Get-date -h (Get-Date $StartTime).Hour -Minute (Get-Date $StartTime).Minute) $(Get-Date -h (Get-Date $EndTime).Hour -Minute (Get-Date $EndTime).Minute)
        }

       $StartSplit = $StartTime.Split(":")
       $WMIDate = ([System.Management.ManagementDateTimeconverter]::ToDmtfDateTime((Get-Date $StartDate -hour $StartSplit[0] -minute $StartSplit[1]))).TrimEnd('+180')
       $ConvertWMIDate = "$($WMIDate.split(".")[0]).000000+***"
       Try{
           $Class = "SMS_ServiceWindow"
           $NewMWindow = ([WMIClass]"\\$SiteServer\root\SMS\Site_$($SiteCode):$Class").CreateInstance()
                $NewMWindow.Name = $ScheduleName
                $NewMWindow.Duration = [MATH]::Round($Minutes.TotalMinutes)
                #$NewMWindow.StartTime = "$($WMIDate)000000+***"
                $NewMWindow.StartTime = $ConvertWMIDate
                $NewMWindow.IsEnabled = $True
                $NewMWindow.IsGMT = $UTC
            
      If($TaskSequenceOnly){     
           $NewMWindow.ServiceWindowType = 5
      }
      Else{
           $NewMWindow.ServiceWindowType = 1
      }      

      Switch($PsCmdlet.ParameterSetName)
      {
            "RecurWeekly" 
                    {

                        [Array]$RefreshScedule = New-ScheduleToken -Day $Day -NumberOfWeeks $NumberOfWeeks -SiteCode $SiteCode -SiteServer $SiteServer -StartTime $ConvertWMIDate -HourDuration $Minutes.Hours -MinuteDuration $Minutes.Minutes -UTC $UTC -String
                        $NewMWindow.Description = Convert-ScheduleString -SiteCode $SiteCode -SiteServer $SiteServer -ScheduleString $RefreshScedule
                        $NewMWindow.ServiceWindowSchedules = $RefreshScedule
                        $NewMWindow.RecurrenceType = 3
                    }
            "RecurMonthlyWeekDay" 
                    {
                        [Array]$RefreshScedule = New-ScheduleToken -Day $Day -MonthName $MonthName -WeekOrder $WeekOrder -SiteCode $SiteCode -SiteServer $SiteServer -StartTime $ConvertWMIDate -HourDuration $Minutes.Hours -MinuteDuration $Minutes.Minutes -UTC $UTC -String
                        $NewMWindow.Description = Convert-ScheduleString -SiteCode $SiteCode -SiteServer $SiteServer -ScheduleString $RefreshScedule
                        $NewMWindow.ServiceWindowSchedules = $RefreshScedule
                        $NewMWindow.RecurrenceType = 4
                    }
            "RecurMonthly" 
                    {
                        [Array]$RefreshScedule = New-ScheduleToken -MonthName $MonthName -MonthDay $MonthDay -SiteCode $SiteCode -SiteServer $SiteServer -StartTime $ConvertWMIDate -HourDuration $Minutes.Hours -MinuteDuration $Minutes.Minutes -UTC $UTC -String
                        $NewMWindow.Description = Convert-ScheduleString -SiteCode $SiteCode -SiteServer $SiteServer -ScheduleString $RefreshScedule
                        $NewMWindow.ServiceWindowSchedules = $RefreshScedule
                        $NewMWindow.RecurrenceType = 5
                    }
            "CustomDay" 
                    {
                        [Array]$RefreshScedule = New-ScheduleToken -CustomDay $CustomDay -SiteCode $SiteCode -SiteServer $SiteServer -StartTime $ConvertWMIDate -HourDuration $Minutes.Hours -MinuteDuration $Minutes.Minutes -UTC $UTC -String
                        $NewMWindow.Description = Convert-ScheduleString -SiteCode $SiteCode -SiteServer $SiteServer -ScheduleString $RefreshScedule
                        $NewMWindow.ServiceWindowSchedules = $RefreshScedule
                        $NewMWindow.RecurrenceType = 2
                    }      

        }

    If(($ColID = Get-CMCollection -SiteCode $SiteCode -SiteServer $SiteServer -Filter "Name='$CollectionName' and CollectionType='2'") -eq $Null){

        Write-Host "There is no such collection"
    }
    Else{
        $ColSettings = Get-CMCollectionSettings -SiteCode $SiteCode -SiteServer $SiteServer -Filter "CollectionID='$($ColID.CollectionID)'"
            
            If($ColSettings -eq $Null){
              Try{  
                $ColSettings = Set-WmiInstance -Namespace "Root\SMS\Site_$SiteCode" -Class SMS_CollectionSettings -ErrorAction STOP -Arguments @{CollectionID = $ColID.CollectionID} -ComputerName $SiteServer
              }
              Catch{
                Write-Host "Error: $($_.Exception.Message)"
              }
            }
            
         $ColSettings.Get()
         $ScheduleNameCheck = $ColSettings.ServiceWindows | foreach-Object {$_.Name -eq $ScheduleName}

             If($ScheduleNameCheck -eq $True){
                 Write-Host "The maintenance window name already exists"
             }
             Else{
                 $ColSettings.ServiceWindows += $NewMWindow.psobject.baseobject
                 $ColSettings.Put()
             }

    }
    }
      Catch{
        Write-Host "Error: $($_.Exception.Message)"
      }   
        
}