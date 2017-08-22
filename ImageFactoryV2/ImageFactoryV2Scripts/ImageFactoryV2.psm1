<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
.INPUTS
   Inputs to this cmdlet (if any)
.OUTPUTS
   Output from this cmdlet (if any)
.NOTES
   General notes
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>
<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
# Read Settings from XML
[xml]$Global:Settings = Get-Content .\ImageFactoryV2.xml
$Global:DeploymentShare = $Global:Settings.Settings.DeploymentShare
$Global:StartUpRAM = 1024*1024*1024*$Global:Settings.Settings.StartUpRAM
$Global:VHDSize = 1024*1024*1024*$Global:Settings.Settings.VHDSize
$Global:SWitchName = $Global:Settings.Settings.HyperVHostNetwork
$Global:VMLocation = $Global:Settings.Settings.HyperVStorage
$Global:HyperVISOFolder = $Global:Settings.Settings.HyperVISOFolder
$Global:TaskSequenceFolder = $Global:Settings.Settings.TaskSequenceFolder
$Global:VLANID = $Global:Settings.Settings.VLANID

function New-AutoGenRefImages{
    Process
    {

    #Connect to MDT:
    Add-PSSnapIn Microsoft.BDD.PSSnapIn -ErrorAction Stop
    Remove-PSDrive MDT -ErrorAction SilentlyContinue
    $Null = New-PSDrive -Name MDT -PSProvider MDTProvider -Root $Global:DeploymentShare -Force
    $MDTSettings = Get-ItemProperty MDT:
    $ISO = $MDTSettings.'Boot.x86.LiteTouchISOName'

    #Check if ISO exists
    $ISOFileExist = Test-Path "$($Global:DeploymentShare)\Boot\$($ISO)"  -ErrorAction SilentlyContinue
        If($ISOFileExist -like 'False'){
        Write-Host "Unable to find ISO, exit"
        BREAK
        }

    #Create Folders
    $Null = New-Item -Path $HyperVISOFolder -ItemType Directory -Force -ErrorAction SilentlyContinue

    #Copy the BootImage from MDTServer to Hyper-VHost
    Copy-Item "$($Global:DeploymentShare)\Boot\$($ISO)" $Global:HyperVISOFolder\ -Container -Force -ErrorAction Stop

    #Check if ISO exists
    $ISOFileExist = Test-Path ($Global:HyperVISOFolder + "\" + $ISO) -ErrorAction Stop
        If($ISOFileExist -like 'False'){
        Write-Host "Unable to find ISO, exit"
        BREAK
        }

    #Check if VMSwitch on host exists
    $VMSwitchExist = Get-VMSwitch -Name $Global:SWitchName -ErrorAction SilentlyContinue
        If($VMSwitchExist.Name -ne $Global:SWitchName){
        Write-Host "Unable to find VMSwitch, exit"
        BREAK
        }

    #Create the VMs
    $RefTS = Get-ChildItem $Global:TaskSequenceFolder -Recurse
        Foreach($TS in $RefTS){

        #Set VMName to ID
        $VMName = $TS.ID

        #Check if VM exists
        $VMexist = Get-VM -Name $VMName -ErrorAction SilentlyContinue
            If($VMexist.Name -like $VMName){
            Write-Host "VM already exist, exit"
            BREAK
            }

        $VM = New-VM –Name $VMname –MemoryStartupBytes $Global:StartUpRAM -SwitchName $Global:SWitchName -NewVHDPath "$Global:VMLocation\$VMName\Virtual Hard Disks\$VMName.vhdx" -NewVHDSizeBytes $Global:VHDSize -Path $Global:VMLocation
        Add-VMDvdDrive -VM $VM -Path ($Global:HyperVISOFolder + "\" + $ISO)

        #Set
        Get-VM -Name $VMName | Set-VMProcessor -CompatibilityForMigrationEnabled $True
        Get-VM -Name $VMName | Set-VMProcessor -Count 2
            If($Global:VLANID -notlike "0"){
            Get-VM -Name $VMName | Get-VMNetworkAdapter | Set-VMNetworkAdapterVlan -Access -VlanId $VLANID
            }
        }
        Foreach($TS in $RefTS){
        #Set VMName to ID
        $VMName = $TS.ID
        $VM = Get-VM -Name $VMName
        $VM | Start-VM
        Start-Sleep "10"
        while($VM.State -like "Running"){
        Write-Output "Waiting for $VMName to finish."
        Start-Sleep "120"}
        Write-Output "$VMName is done, checking for more"
        }
    }
}
function Remove-AutoGenRefImages{
    Process
    {

    #Connect to MDT:
    $Null = Add-PSSnapIn Microsoft.BDD.PSSnapIn -ErrorAction SilentlyContinue
    Remove-PSDrive MDT -ErrorAction SilentlyContinue
    $Null = New-PSDrive -Name MDT -PSProvider MDTProvider -Root $Global:DeploymentShare -Force
    $MDTSettings = Get-ItemProperty MDT:
    $ISO = $MDTSettings.'Boot.x86.LiteTouchISOName'

        #Remove the VMs
        $RefTS = Get-ChildItem $Global:TaskSequenceFolder -Recurse
        Foreach($TS in $RefTS){

            #Set VMName to ID
            $VMName = $TS.ID

            #Check if VM exists
            $VMexist = Get-VM -Name $VMName -ErrorAction SilentlyContinue
            If($VMexist.Name -like $VMName){
            Write-Host "Removing $VMName"
            $VMToRemove = Get-VM -Name $VMName
            $FolderPath = $VMToRemove.path
            if($VMToRemove.state -like "Running"){Stop-VM $VMToRemove -Force}
            $VMToRemove | Remove-VM -Force
            $FolderPath | Remove-Item -Force -Recurse
            }
        }
    }
}
function New-RefImage{
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        [Parameter(Mandatory=$false, 
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true, 
        ValueFromRemainingArguments=$false, 
        Position=0)]
        [String]
        $TaskSequenceID
    )
    
    Process
    {

    #Connect to MDT:
    Add-PSSnapIn Microsoft.BDD.PSSnapIn -ErrorAction Stop
    Remove-PSDrive MDT -ErrorAction SilentlyContinue
    $Null = New-PSDrive -Name MDT -PSProvider MDTProvider -Root $Global:DeploymentShare -Force
    $MDTSettings = Get-ItemProperty MDT:
    $ISO = $MDTSettings.'Boot.x86.LiteTouchISOName'

    #Check if ISO exists
    $ISOFileExist = Test-Path "$($Global:DeploymentShare)\Boot\$($ISO)"  -ErrorAction SilentlyContinue
        If($ISOFileExist -like 'False'){
        Write-Host "Unable to find ISO, exit"
        BREAK
        }

    #Create Folders
    $null = New-Item -Path $HyperVISOFolder -ItemType Directory -Force -ErrorAction SilentlyContinue

    #Copy the BootImage from MDTServer to Hyper-VHost
    Copy-Item "$($Global:DeploymentShare)\Boot\$($ISO)" $Global:HyperVISOFolder\ -Container -Force -ErrorAction Stop

    #Check if ISO exists
    $ISOFileExist = Test-Path ($Global:HyperVISOFolder + "\" + $ISO) -ErrorAction Stop
        If($ISOFileExist -like 'False'){
        Write-Host "Unable to find ISO, exit"
        BREAK
        }

    #Check if VMSwitch on host exists
    $VMSwitchExist = Get-VMSwitch -Name $Global:SWitchName -ErrorAction SilentlyContinue
        If($VMSwitchExist.Name -ne $Global:SWitchName){
        Write-Host "Unable to find VMSwitch, exit"
        BREAK
        }

    #Check if VM exists
    $VMexist = Get-VM -Name $VMName -ErrorAction SilentlyContinue
        If($VMexist.Name -like $VMName){
        Write-Host "VM already exist, exit"
        BREAK
        }

    $VM = New-VM –Name $TaskSequenceID –MemoryStartupBytes $Global:StartUpRAM -SwitchName $Global:SWitchName -NewVHDPath "$Global:VMLocation\$TaskSequenceID\Virtual Hard Disks\$TaskSequenceID.vhdx" -NewVHDSizeBytes $Global:VHDSize -Path $Global:VMLocation
    Add-VMDvdDrive -VM $VM -Path ($Global:HyperVISOFolder + "\" + $ISO)

    #Set
    Get-VM -Name $TaskSequenceID | Set-VMProcessor -CompatibilityForMigrationEnabled $True -VM $VM

    #Set
    Get-VM -Name $TaskSequenceID | Set-VMProcessor -Count 2

    #Set
        If($VLANID -notlike "0"){
        Get-VM -Name $TaskSequenceID | Get-VMNetworkAdapter | Set-VMNetworkAdapterVlan -Access -VlanId $VLANID
        }

    }

}
function Remove-RefImage{
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        [Parameter(Mandatory=$false, 
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true, 
        ValueFromRemainingArguments=$false, 
        Position=0)]
        [String]
        $VMName
    )
    Process
    {

    #Check if VM exists
    $VMexist = Get-VM -Name $VMName -ErrorAction SilentlyContinue
        If($VMexist.Name -like $VMName){
        Write-Host "Removing $VMName"
        $VMToRemove = Get-VM -Name $VMName
        $FolderPath = $VMToRemove.path
        if($VMToRemove.state -like "Running"){Stop-VM $VMToRemove -Force}
        $VMToRemove | Remove-VM -Force
        $FolderPath | Remove-Item -Force -Recurse
        }
    }
}
function Get-RefTaskSequence{
    Process
    {

    #Connect to MDT:
    Add-PSSnapIn Microsoft.BDD.PSSnapIn -ErrorAction Stop
    Remove-PSDrive MDT -ErrorAction SilentlyContinue
    $Null = New-PSDrive -Name MDT -PSProvider MDTProvider -Root $Global:DeploymentShare -Force
    $MDTSettings = Get-ItemProperty MDT:
    $ISO = $MDTSettings.'Boot.x86.LiteTouchISOName'

        #Get TS
        $RefTS = Get-ChildItem $Global:TaskSequenceFolder -Recurse
        Foreach($TS in $RefTS){
            New-Object PSObject -Property @{ 
            TaskSequenceID = $TS.ID
            Name = $TS.Name
            Comments = $TS.Comments
            Version = $TS.Version
            Enabled = $TS.enable
            LastModified = $TS.LastModifiedTime
            } 
        }
    }
}

Export-ModuleMember -function * 