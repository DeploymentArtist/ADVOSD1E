option explicit

function UserExit(sType,Swhen,Sdetail,bSkip)
	oLogging.CreateEntry "USEREXIT:ModelAliasExit.vbs started: " & sType & " " & sWhen & " " & sDetail, LogTypeInfo 

	If ucase(oEnvironment.Item("ISVM")) = "TRUE" and oEnvironment.Item("OSVERSION") = "WinPE" then

		oLogging.CreateEntry "Load the Integration Components", LogTypeInfo
		oUtility.RunWithConsoleLogging "\KVP\devcon.exe /r install \KVP\wvmic.inf vmbus\{242ff919-07db-4180-9c2e-b86cb68c8c55}"
		CreateFakeService "TermService", "Remote Desktop Service", "FakeService.exe"
		GetObject("winmgmts:root\cimv2").Get("Win32_Service.Name='vmickvpexchange'").StartService()
		oUtility.SafeSleep 10000
		LoadVariablesFromHyperV

	End if

	' Write back an unique number to the host to let them know that the variables have been loaded.
	oUtility.RegWrite "HKLM\SOFTWARE\Microsoft\Virtual Machine\Auto\HydrationGuestStatus","eb471002-58aa-473a-850f-7b626613055f"

	Userexit=success

end function

' ---------------------------------------------------------

Function CreateFakeService (sName,sDisplayName,sPathName )

	Dim objService
	Dim objInParam

	' Obtain the definition of the Win32_Service class.
	Set objService = GetObject("winmgmts:root\cimv2").Get("Win32_Service")

	' Obtain an InParameters object specific to the Win32_Service.Create method.
	Set objInParam = objService.Methods_("Create").inParameters.SpawnInstance_()

	' Add the input parameters.
	objInParam.Properties_.item("Name") = sName
	objInParam.Properties_.item("DisplayName") = sDisplayName
	objInParam.Properties_.item("PathName") = sPathName
	objInParam.Properties_.item("ServiceType") = 16
	objInParam.Properties_.item("ErrorControl") = 0
	objInParam.Properties_.item("StartMode") = "Manual"
	objInParam.Properties_.item("DesktopInteract") = False

	' Execute the method and obtain the return status.
	CreateFakeService = objService.ExecMethod_("Create", objInParam).ReturnValue

End function

Function LoadVariablesFromHyperV

	Dim objReg
	Dim aSubValues
	Dim aValues
	Dim SubVal

	oLogging.CreateEntry "Has MDT Environment Variables in Integration Components.", LogTypeInfo
	Set objReg=GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv")
	objReg.EnumValues &H80000002, "SOFTWARE\Microsoft\Virtual Machine\External", aSubValues, aValues

	If isArray(aSubValues) then
		For Each SubVal in aSubValues
			oLogging.CreateEntry "Found Key: [" & SubVal & "]", LogTypeInfo
			oEnvironment.Item(SubVal) = oUtility.RegRead("HKLM\SOFTWARE\Microsoft\Virtual Machine\External\" & SubVal)
		Next
	End if

End Function