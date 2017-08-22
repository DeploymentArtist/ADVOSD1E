# Hydrate the lab
param (
    [int]$NumberOfWorkstations = 4,
    [string]$VMNetwork = "AWD_Internal",
    [string]$HydrationISO = "C:\HydrationCM2012R2-1E\ISO\HydrationCM2012R2-1E.iso",
    [switch]$DeleteLabVMs = $false
)

# Check for Hydration ISO
Write-Host "Checking for Hydration ISO"
If (Test-Path $HydrationISO){
    Write-Host "Hydration ISO found, OK, continuing..." -ForegroundColor Green
    Write-Host ""
    } 
Else {
    Write-Warning "Oupps, cannot find Hydration ISO. Please review the Appendix A section in the book"
    Break
}

$serverVmList = @("DC01", "CM01", "MDT01")
$largestDrive = (Get-Partition  | where {$_.DriveLetter -ne ""} | Sort-Object -Property Size -Descending | Select-Object -First 1).DriveLetter
$VMLocation = "$($largestDrive):\VMs"

# Create an Array of Workstation Names
$workstationVmList = @()
for ($counter=1; $counter -le $NumberOfWorkstations; $counter++) {
    $workstationVmList += "PC" + $counter.ToString().PadLeft(4, "0")
}

if ($DeleteLabVMs -eq $false) {
    # Create Virtual Switch if needed
    Write-Host "Checking for Hyper-V switch"
    $VMSwitchNameCheck = Get-VMSwitch | Where-Object -Property Name -eq $VMNetwork
    if ($VMSwitchNameCheck.Name -eq $VMNetwork)
        {
        Write-Host "Hyper-V switch exist, OK, continuing..." -ForegroundColor Green
        Write-Host ""
        }
    Else
        {
        Write-Host "Hyper-V switch didn't exist."
        Write-Host "Creating Internal vSwitch ($VMNetwork) ..."
        Write-Host ""
        $vswitch = New-VMSwitch -Name $VMNetwork -SwitchType Internal
    }

    # Create "x" Amount of Empty Generic Skelteton VMs on the Local Hyper-V Server
    $NumberOfVMs = $serverVmList.Count + $NumberOfWorkstations
    New-Item -ItemType Directory -Path $VMLocation -ErrorAction SilentlyContinue | Out-Null
    for ($counter=1; $counter -le $NumberOfVMs; $counter++) {
        Write-Host "Creating VM $counter of $NumberOfVMs"
        $VMName = "LAB-HYD-" + ($counter.ToString()).PadLeft(3, "0")
        $vm = New-VM -Name $VMName -MemoryStartupBytes 1024MB -generation 1 -SwitchName $VMNetwork -Path $VMLocation -NewVHDSizeBytes 127GB -NewVHDPath "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx"
        $vm = Set-VMMemory -VMName $VMName -DynamicMemoryEnabled $False
        $vmdrive = Set-VMDvdDrive $VMname -Path $HydrationISO
    }



    # Rename Server VMs
    for ($counter=1; $counter -le $serverVmList.Count; $counter++) {
        Rename-VM -name "Lab-Hyd-$($counter.ToString().PadLeft(3, "0"))" -NewName $serverVmList[$counter - 1]
    }

    # Rename Workstation VMs
    for ($counter=1; $counter -le $workstationVmList.Count ; $counter++) {
        Rename-VM -name "Lab-Hyd-$(($counter + $serverVmList.Count).ToString().PadLeft(3, "0"))" -NewName $workstationVmList[$counter - 1]
    }

    Write-Host "Customizing Memory Allocation for special VMs..."
    Write-Host ""
    $vm = Set-VMMemory -VMName "CM01" -StartupBytes 6144MB
    $vm = Set-VMMemory -VMName "MDT01" -StartupBytes 4096MB

    Write-Host "Resizing disks for special VMs..."
    Write-Host ""
    get-vm "CM01" | select -expand HardDrives | select -first 1 | resize-vhd -SizeBytes 300GB 
    get-vm "MDT01" | select -expand HardDrives | select -first 1 | resize-vhd -SizeBytes 300GB 
        
    Write-Host "Starting VMs..."
    ($serverVmList + $workstationVmList)| Get-VM | Start-VM

    Write-Host "Post Script Configuration - Connect to VMs and choose the correct task sequence"
} else {
    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes",""
    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No",""
    $choices = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
    $choice = $Host.UI.PromptForChoice("-=Delete the lab=-", "Are you sure you want to delete the lab and all the associated VMs?", $choices, 1)
    if ($choice -eq 0) {
        Write-Host -ForegroundColor Red "DELETING AND REMOVING ALL LAB VMs"

        $vms = ($serverVmList + $workstationVmList) | Get-VM -ErrorAction SilentlyContinue
        $vms | Get-Vm | Stop-VM -TurnOff -Force -WarningAction SilentlyContinue
        $vms | Remove-VM -Force
        ($vms).Path | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

        $VmsUsingSwitch = Get-VMNetworkAdapter -VMName * | Where {$_.SwitchName -eq $VMNetwork}
        if ($VmsUsingSwitch.Count -gt 0) {
            Write-Host -ForegroundColor Red "$($VmsUsingSwitch.Count) VMs are using the Virtual Switch named $VMNetwork. Skipping Switch Removal"
        } else {
            Remove-VMSwitch -Name $VMNetwork -Force
        }
    }
}
