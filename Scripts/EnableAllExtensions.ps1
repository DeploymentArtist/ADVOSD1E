function EnableAllExtensions()
{
	$ahPath = "$((Get-WmiObject Win32_OperatingSystem).SystemDirectory)\inetsrv\config\applicationHost.config"
	if (-not [IO.File]::Exists($ahPath)) { return } # If file doesn't exist, return
	$xd = New-Object Xml.XmlDocument
	$xd.Load($ahPath)
	$nodes = $xd.SelectNodes("/configuration/system.webServer/security/requestFiltering/fileExtensions/add")
	foreach ($child in $nodes)
	{
		$child.SetAttribute("allowed", "true")
	}
	$xd.Save($ahPath)
}

EnableAllExtensions