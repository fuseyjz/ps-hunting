﻿function Invoke-Detective {
<#
    .SYNOPSIS

        Author: Jayden Zheng (@fuseyjz)

        Invoke-Detective is a PowerShell script to pull Sysmon Event Logs and
        notice the user via Slack Incoming Webhook for any new events.

    .DESCRIPTION
        
        Sysmon v8.0
        
        Currently this script only filters for certain Sysmon Event IDs.
        
        It works by checking the time difference between current time and 
        the event generated time, then pull the events that are within the time difference,
        print to output and notice via Slack webhook.

        The current config is set to 10mins difference.

        This script does not do any filtering of those noisy events.
        You will need to filter in your Sysmon config file.

    .REQUIREMENT

        You will need to enter your Slack Incoming Webhook URL and
        change the username below at the Slack function.

    .EXAMPLE
        
        PS C:\> Import-Module .\Invoke-Detective.ps1
        PS C:\> Invoke-Detective
     
        Gollum APP [10:40 AM]
            Sysmon - Alert
            Event ID 3          : NetworkConnect
            Host                : JAYDENLAB\jayden
            TimeCreated         : 7/30/2018 10:34:02 AM
            ProcessId           : 800
            Image               : C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
            Protocol            : tcp
            SourceIp            : 192.168.1.247
            SourceHostname      : JAYDENLAB.lan
            SourcePort          : 49760
            DestinationIp       : 54.192.157.45
            DestinationHostname : server-54-192-157-45.sin3.r.cloudfront.net
            DestinationPort     : 443

#>
    [CmdletBinding()]
    param
    (

    )

    while($true) {
        
        try {
            EventID-1
        } catch {
            Write-Host "[-] Failed to run EventID-1"
        }
        
        try {
            EventID-3
        } catch {
            Write-Host "[-] Failed to run EventID-3"
        }

        try {
            EventID-4
        } catch {
            Write-Host "[-] Failed to run EventID-4"
        }
        
        try {
            EventID-5
        } catch {
            Write-Host "[-] Failed to run EventID-5"
        }
         
        try {
            EventID-6
        } catch {
            Write-Host "[-] Failed to run EventID-6"
        }
        
        try {
            EventID-8
        } catch {
            Write-Host "[-] Failed to run EventID-8"
        }
        
        try {
            EventID-11
        } catch {
            Write-Host "[-] Failed to run EventID-11"
        }
        
        try {
            EventID-12
        } catch {
            Write-Host "[-] Failed to run EventID-12"
        }
            
        try {
            EventID-13
        } catch {
            Write-Host "[-] Failed to run EventID-13"
        }
        
        try {
            EventID-16
        } catch {
            Write-Host "[-] Failed to run EventID-16"
        }

        # Sleep 10 mins
        Start-Sleep -Seconds 600

    }

}

function EventID-1 {

    # ProcessCreate
    $User = $env:COMPUTERNAME + "\" + $env:USERNAME
    Get-WinEvent -FilterHashtable @{LogName="Microsoft-Windows-Sysmon/Operational";id=1} | ForEach-Object {
        $TimeNow = Get-Date -Format d
        $TimeNow += " "
        $TimeNow += Get-Date -Format T
        $Diff = New-TimeSpan -Start $_.TimeCreated -End $TimeNow
        if ($Diff.Days -eq "0" -and $Diff.Hours -eq "0" -and $Diff.Minutes -lt "10") {
            $AlertDetail = New-Object PSObject
            $AlertDetail | Add-Member -MemberType Noteproperty -Name "Event ID 1" -Value ProcessCreate
            $AlertDetail | Add-Member -MemberType Noteproperty -Name Host -Value $User
            $AlertDetail | Add-Member -MemberType Noteproperty -Name TimeCreated -Value $_.TimeCreated
            $AlertDetail | Add-Member -MemberType Noteproperty -Name ProcessId -Value $_.Properties[3].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name Image -Value $_.Properties[4].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name CommandLine -Value $_.Properties[9].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name IntegrityLevel -Value $_.Properties[15].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name ParentProcessId -Value $_.Properties[18].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name ParentImage -Value $_.Properties[19].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name ParentCommandLine -Value $_.Properties[20].Value
            Write-Output $AlertDetail
            $ConvertToString = $AlertDetail | Out-String
            Slack($ConvertToString)
        }
    }

}

function EventID-3 {

    # NetworkConnect
    $User = $env:COMPUTERNAME + "\" + $env:USERNAME
    Get-WinEvent -FilterHashtable @{LogName="Microsoft-Windows-Sysmon/Operational";id=3} | ForEach-Object {
        $TimeNow = Get-Date -Format d
        $TimeNow += " "
        $TimeNow += Get-Date -Format T
        $Diff = New-TimeSpan -Start $_.TimeCreated -End $TimeNow
        if ($Diff.Days -eq "0" -and $Diff.Hours -eq "0" -and $Diff.Minutes -lt "10") {
            $AlertDetail = New-Object PSObject
            $AlertDetail | Add-Member -MemberType Noteproperty -Name "Event ID 3" -Value NetworkConnect
            $AlertDetail | Add-Member -MemberType Noteproperty -Name Host -Value $User
            $AlertDetail | Add-Member -MemberType Noteproperty -Name TimeCreated -Value $_.TimeCreated
            $AlertDetail | Add-Member -MemberType Noteproperty -Name ProcessId -Value $_.Properties[3].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name Image -Value $_.Properties[4].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name Protocol -Value $_.Properties[6].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name SourceIp -Value $_.Properties[9].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name SourceHostname -Value $_.Properties[10].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name SourcePort -Value $_.Properties[11].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name DestinationIp -Value $_.Properties[14].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name DestinationHostname -Value $_.Properties[15].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name DestinationPort -Value $_.Properties[16].Value
            Write-Output $AlertDetail
            $ConvertToString = $AlertDetail | Out-String
            Slack($ConvertToString)
        }
    }

}

function EventID-4 {

    # SysmonService
    $User = $env:COMPUTERNAME + "\" + $env:USERNAME
    Get-WinEvent -FilterHashtable @{LogName="Microsoft-Windows-Sysmon/Operational";id=4} | ForEach-Object {
        $TimeNow = Get-Date -Format d
        $TimeNow += " "
        $TimeNow += Get-Date -Format T
        $Diff = New-TimeSpan -Start $_.TimeCreated -End $TimeNow
        if ($Diff.Days -eq "0" -and $Diff.Hours -eq "0" -and $Diff.Minutes -lt "10") {
            $AlertDetail = New-Object PSObject
            $AlertDetail | Add-Member -MemberType Noteproperty -Name "Event ID 4" -Value SysmonService
            $AlertDetail | Add-Member -MemberType Noteproperty -Name Host -Value $User
            $AlertDetail | Add-Member -MemberType Noteproperty -Name TimeCreated -Value $_.TimeCreated
            $AlertDetail | Add-Member -MemberType Noteproperty -Name State -Value $_.Properties[1].Value
            Write-Output $AlertDetail
            $ConvertToString = $AlertDetail | Out-String
            Slack($ConvertToString)
        }
    }

}

function EventID-5 {

    # ProcessTerminate
    $User = $env:COMPUTERNAME + "\" + $env:USERNAME
    Get-WinEvent -FilterHashtable @{LogName="Microsoft-Windows-Sysmon/Operational";id=5} | ForEach-Object {
        $TimeNow = Get-Date -Format d
        $TimeNow += " "
        $TimeNow += Get-Date -Format T
        $Diff = New-TimeSpan -Start $_.TimeCreated -End $TimeNow
        if ($Diff.Days -eq "0" -and $Diff.Hours -eq "0" -and $Diff.Minutes -lt "10") {
            $AlertDetail = New-Object PSObject
            $AlertDetail | Add-Member -MemberType Noteproperty -Name "Event ID 5" -Value ProcessTerminate
            $AlertDetail | Add-Member -MemberType Noteproperty -Name Host -Value $User
            $AlertDetail | Add-Member -MemberType Noteproperty -Name TimeCreated -Value $_.TimeCreated
            $AlertDetail | Add-Member -MemberType Noteproperty -Name ProcessId -Value $_.Properties[3].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name Image -Value $_.Properties[4].Value
            Write-Output $AlertDetail
            $ConvertToString = $AlertDetail | Out-String
            Slack($ConvertToString)
        }
    }

}

function EventID-6 {

    # DriverLoad
    $User = $env:COMPUTERNAME + "\" + $env:USERNAME
    Get-WinEvent -FilterHashtable @{LogName="Microsoft-Windows-Sysmon/Operational";id=6} | ForEach-Object {
        $TimeNow = Get-Date -Format d
        $TimeNow += " "
        $TimeNow += Get-Date -Format T
        $Diff = New-TimeSpan -Start $_.TimeCreated -End $TimeNow
        if ($Diff.Days -eq "0" -and $Diff.Hours -eq "0" -and $Diff.Minutes -lt "10") {
            $AlertDetail = New-Object PSObject
            $AlertDetail | Add-Member -MemberType Noteproperty -Name "Event ID 6" -Value DriverLoad
            $AlertDetail | Add-Member -MemberType Noteproperty -Name Host -Value $User
            $AlertDetail | Add-Member -MemberType Noteproperty -Name TimeCreated -Value $_.TimeCreated
            $AlertDetail | Add-Member -MemberType Noteproperty -Name ImageLoaded -Value $_.Properties[2].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name Signed -Value $_.Properties[4].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name Signature -Value $_.Properties[5].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name SignatureStatus -Value $_.Properties[6].Value
            Write-Output $AlertDetail
            $ConvertToString = $AlertDetail | Out-String
            Slack($ConvertToString)
        }
    }

}

function EventID-8 {

    # CreateRemoteThread
    $User = $env:COMPUTERNAME + "\" + $env:USERNAME
    Get-WinEvent -FilterHashtable @{LogName="Microsoft-Windows-Sysmon/Operational";id=8} | ForEach-Object {
        $TimeNow = Get-Date -Format d
        $TimeNow += " "
        $TimeNow += Get-Date -Format T
        $Diff = New-TimeSpan -Start $_.TimeCreated -End $TimeNow
        if ($Diff.Days -eq "0" -and $Diff.Hours -eq "0" -and $Diff.Minutes -lt "10") {
            $AlertDetail = New-Object PSObject
            $AlertDetail | Add-Member -MemberType Noteproperty -Name "Event ID 8" -Value CreateRemoteThread
            $AlertDetail | Add-Member -MemberType Noteproperty -Name Host -Value $User
            $AlertDetail | Add-Member -MemberType Noteproperty -Name TimeCreated -Value $_.TimeCreated
            $AlertDetail | Add-Member -MemberType Noteproperty -Name SourceProcessId -Value $_.Properties[3].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name SourceImage -Value $_.Properties[4].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name TargetProcessId -Value $_.Properties[6].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name TargetImage -Value $_.Properties[7].Value
            Write-Output $AlertDetail
            $ConvertToString = $AlertDetail | Out-String
            Slack($ConvertToString)
        }
    }

}

function EventID-11 {

    # FileCreate
    $User = $env:COMPUTERNAME + "\" + $env:USERNAME
    Get-WinEvent -FilterHashtable @{LogName="Microsoft-Windows-Sysmon/Operational";id=11} | ForEach-Object {
        $TimeNow = Get-Date -Format d
        $TimeNow += " "
        $TimeNow += Get-Date -Format T
        $Diff = New-TimeSpan -Start $_.TimeCreated -End $TimeNow
        if ($Diff.Days -eq "0" -and $Diff.Hours -eq "0" -and $Diff.Minutes -lt "10") {
            $AlertDetail = New-Object PSObject
            $AlertDetail | Add-Member -MemberType Noteproperty -Name "Event ID 11" -Value FileCreate
            $AlertDetail | Add-Member -MemberType Noteproperty -Name Host -Value $User
            $AlertDetail | Add-Member -MemberType Noteproperty -Name TimeCreated -Value $_.TimeCreated
            $AlertDetail | Add-Member -MemberType Noteproperty -Name ProcessId -Value $_.Properties[3].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name Image -Value $_.Properties[4].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name TargetFilename -Value $_.Properties[5].Value
            Write-Output $AlertDetail
            $ConvertToString = $AlertDetail | Out-String
            Slack($ConvertToString)
        }
    }

}

function EventID-12 {

    # RegistryEvent
    $User = $env:COMPUTERNAME + "\" + $env:USERNAME
    Get-WinEvent -FilterHashtable @{LogName="Microsoft-Windows-Sysmon/Operational";id=12} | ForEach-Object {
        $TimeNow = Get-Date -Format d
        $TimeNow += " "
        $TimeNow += Get-Date -Format T
        $Diff = New-TimeSpan -Start $_.TimeCreated -End $TimeNow
        if ($Diff.Days -eq "0" -and $Diff.Hours -eq "0" -and $Diff.Minutes -lt "10") {
            $AlertDetail = New-Object PSObject
            $AlertDetail | Add-Member -MemberType Noteproperty -Name "Event ID 12" -Value RegistryEvent
            $AlertDetail | Add-Member -MemberType Noteproperty -Name Host -Value $User
            $AlertDetail | Add-Member -MemberType Noteproperty -Name TimeCreated -Value $_.TimeCreated
            $AlertDetail | Add-Member -MemberType Noteproperty -Name ProcessId -Value $_.Properties[3].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name Image -Value $_.Properties[4].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name TargetObject -Value $_.Properties[5].Value
            Write-Output $AlertDetail
            $ConvertToString = $AlertDetail | Out-String
            Slack($ConvertToString)
        }
    }

}

function EventID-13 {

    # RegistryEvent
    $User = $env:COMPUTERNAME + "\" + $env:USERNAME
    Get-WinEvent -FilterHashtable @{LogName="Microsoft-Windows-Sysmon/Operational";id=13} | ForEach-Object {
        $TimeNow = Get-Date -Format d
        $TimeNow += " "
        $TimeNow += Get-Date -Format T
        $Diff = New-TimeSpan -Start $_.TimeCreated -End $TimeNow
        if ($Diff.Days -eq "0" -and $Diff.Hours -eq "0" -and $Diff.Minutes -lt "10") {
            $AlertDetail = New-Object PSObject
            $AlertDetail | Add-Member -MemberType Noteproperty -Name "Event ID 13" -Value RegistryEvent
            $AlertDetail | Add-Member -MemberType Noteproperty -Name Host -Value $User
            $AlertDetail | Add-Member -MemberType Noteproperty -Name TimeCreated -Value $_.TimeCreated
            $AlertDetail | Add-Member -MemberType Noteproperty -Name ProcessId -Value $_.Properties[3].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name Image -Value $_.Properties[4].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name TargetObject -Value $_.Properties[5].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name Details -Value $_.Properties[6].Value
            Write-Output $AlertDetail
            $ConvertToString = $AlertDetail | Out-String
            Slack($ConvertToString)
        }
    }

}

function EventID-16 {

    # SysmonConfig
    $User = $env:COMPUTERNAME + "\" + $env:USERNAME
    Get-WinEvent -FilterHashtable @{LogName="Microsoft-Windows-Sysmon/Operational";id=16} | ForEach-Object {
        $TimeNow = Get-Date -Format d
        $TimeNow += " "
        $TimeNow += Get-Date -Format T
        $Diff = New-TimeSpan -Start $_.TimeCreated -End $TimeNow
        if ($Diff.Days -eq "0" -and $Diff.Hours -eq "0" -and $Diff.Minutes -lt "10") {
            $AlertDetail = New-Object PSObject
            $AlertDetail | Add-Member -MemberType Noteproperty -Name "Event ID 16" -Value SysmonConfig
            $AlertDetail | Add-Member -MemberType Noteproperty -Name Host -Value $User
            $AlertDetail | Add-Member -MemberType Noteproperty -Name TimeCreated -Value $_.TimeCreated
            $AlertDetail | Add-Member -MemberType Noteproperty -Name Configuration -Value $_.Properties[1].Value
            $AlertDetail | Add-Member -MemberType Noteproperty -Name ConfigurationFileHash -Value $_.Properties[2].Value
            Write-Output $AlertDetail
            $ConvertToString = $AlertDetail | Out-String
            Slack($ConvertToString)
        }
    }

}

function Slack($s_text) {

    $webhook = "slack incoming webhook"

    $attachments = @(@{
                    "fallback" = "Detective - Alert"
                    "color" = "#BA55D3"
                    "title" = "Sysmon - Alert"
                    "text" = $s_text
                    "footer" = "Detective"
                    "footer_icon" = "https://emoji.slack-edge.com/T4UQX9PSB/gollum/b9539387d6b2e0af.png"
                    })

    $payload = @{
            "channel" = "@username"
            "username" = "Gollum"
            "icon_emoji" = ":gollum:"
            "attachments" = $attachments
    }
  
    Invoke-WebRequest `
        -Body (ConvertTo-Json -Compress -InputObject $payload) `
        -Method Post `
        -UseBasicParsing `
        -Uri $webhook | Out-Null

}
