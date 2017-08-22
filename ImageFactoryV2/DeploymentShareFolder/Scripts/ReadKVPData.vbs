'//----------------------------------------------------------------------------
'// Version: 1.0 - Jan 04, 2013 - Mikael Nystrom
'// Twitter @mikael_nystrom
'// Blog http://deploymentbunny.com
'// This script is provided "AS IS" with no warranties, confers no rights and 
'// is not supported by the author
'//----------------------------------------------------------------------------
' //            
' // Usage:     Modify CustomSettings.ini similar to this:
' //              [Settings]
' //              Priority=SetAlias, Default 
' //              Properties=VMNameAlias
' // 
' //              [SetAlias]
' //              VMNameAlias=#SetVMNameAlias()#
' // ***** End Header *****

Function UserExit(sType, sWhen, sDetail, bSkip)

    oLogging.CreateEntry "UserExit: started: " & sType & " " & sWhen & " " & sDetail, LogTypeInfo
    UserExit = Success

End Function

Function SetVMNameAlias()
    oLogging.CreateEntry "UserExit: Running function SetVMNameAlias ", LogTypeInfo
    SetVMNameAlias = ""
    SetVMNameAlias = oShell.RegRead("HKLM\SOFTWARE\Microsoft\Virtual Machine\Guest\Parameters\VirtualMachineName") 
    oLogging.CreateEntry "UserExit: SetVMNameAlias has been set to " & SetVMNameAlias, LogTypeInfo
    oLogging.CreateEntry "UserExit: Departing...", LogTypeInfo
End Function
