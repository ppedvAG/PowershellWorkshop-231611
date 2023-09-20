<#
.SYNOPSIS
 Kurzbeschreibung
.DESCRIPTIOn
 LAnge Bechreibung
.PARAMETER EventId
 4624 Anmeldung
 4625 fehlgeschlagene Anmeldung
 4634 Abmeldung
.EXAMPLE
.\Get-SecEvents.ps1 -EventId 4634 -Newest 7

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
  589563 Sep 20 16:02  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
  589562 Sep 20 16:02  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
  589561 Sep 20 16:02  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
  589558 Sep 20 16:02  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
  589555 Sep 20 16:02  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
  589554 Sep 20 16:02  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
  589543 Sep 20 16:01  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
.LINK
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-5.1
#>
[cmdletBinding(PositionalBinding=$false)]
param(

[Parameter(Mandatory=$true)]
[ValidateSet(4624,4625,4634)]
[int]$EventId,

[ValidateRange(5,10)]
[int]$Newest = 5,

[ValidateScript({Test-NetConnection -Computername $PSITem -CommonTCPPort WinRm})]
[string]$Computername = "localhost"
)

Write-Verbose -Message "Vom User wurden folgende Werte übergeben $Eventid , $Newest , $Computername"
Write-Debug -Message "Vor Abfrage"
$geteventlogerror = ""
try
{
    Get-EventLog -LogName Security -ComputerName $Computername -ErrorVariable geteventlogerror -ErrorAction Stop | Where-Object EventId -eq $EventId | Select-Object -First $Newest 
}
catch
{
    Out-File -InputObject $geteventlogerror -FilePath C:\Testfiles\geteventlogerror.log -Append
}

Out-File -InputObject $Error -FilePath C:\Testfiles\allerror.log -Append
