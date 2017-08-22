Function Load-Form
{
$Form.Controls.Add($TBComputerName)
$Form.Controls.Add($GBComputerName)
$Form.Controls.Add($ButtonOK)
$Form.Add_Shown({$Form.Activate()})
[void] $Form.ShowDialog()
}
Function Set-PBAComputerName
{
$ErrorProvider.Clear()
if ($TBComputerName.Text.Length -eq 0)
{
$ErrorProvider.SetError($GBComputerName, "Enter computer name of previous backup.")
}
 
elseif ($TBComputerName.Text.Length -gt 15)
{
$ErrorProvider.SetError($GBComputerName, "Computer name cannot be more than 15 characters.")
}
 
#Validation Rule for computer names.
elseif ($TBComputerName.Text -match "^[-_]|[^a-zA-Z0-9-_]")
{
$ErrorProvider.SetError($GBComputerName, "Computer name invalid, please correct the computer name.")
}
 
else
{
$PBAComputerName = $TBComputerName.Text.ToUpper()
$TSEnv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$TSEnv.Value("PBAComputerName") = "$($PBAComputerName)"
$Form.Close()
}
}
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
$Global:ErrorProvider = New-Object System.Windows.Forms.ErrorProvider
$Form = New-Object System.Windows.Forms.Form
$Form.Size = New-Object System.Drawing.Size(285,140)
$Form.MinimumSize = New-Object System.Drawing.Size(325,140)
$Form.MaximumSize = New-Object System.Drawing.Size(325,140)
$Form.StartPosition = "CenterScreen"
$Form.SizeGripStyle = "Hide"
$Form.Text = "Enter computer name of previous backup"
$Form.ControlBox = $false
$Form.TopMost = $true
$TBComputerName = New-Object System.Windows.Forms.TextBox
$TBComputerName.Location = New-Object System.Drawing.Size(25,30)
$TBComputerName.Size = New-Object System.Drawing.Size(235,50)
$TBComputerName.TabIndex = "1"
$GBComputerName = New-Object System.Windows.Forms.GroupBox
$GBComputerName.Location = New-Object System.Drawing.Size(20,10)
$GBComputerName.Size = New-Object System.Drawing.Size(245,50)
$GBComputerName.Text = "Computer name:"
$ButtonOK = New-Object System.Windows.Forms.Button
$ButtonOK.Location = New-Object System.Drawing.Size(205,70)
$ButtonOK.Size = New-Object System.Drawing.Size(50,20)
$ButtonOK.Text = "OK"
$ButtonOK.TabIndex = "2"
$ButtonOK.Add_Click({Set-PBAComputerName})
 
$Form.KeyPreview = $True
$Form.Add_KeyDown({if ($_.KeyCode -eq "Enter"){Set-PBAComputerName}})
 
Load-Form 