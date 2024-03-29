# OSG
# ⌨ >= ⚔
# Juvenal.ps1
# Powershell V 7/5/2
# This script tests for Powershell execution policy, transcription, scriptblock and module logging, and version 2.

#                One man
#              gets a cross
#              for his crime
#             /    , the other
#             ) (>  a  Crown.
#            /        ,    /
#            L,           /
#             (__        | 
#             (          |
#              ---\      |
#                  |     |                


$HKLM_Read = 1
$HKCU_Read = 1
$Path = "HKLM"
$HistoryPath = (Get-PSReadLineOption).HistorySavePath
$whoami = whoami 

# Test to see if script block logging is enabled:
for ($i = 0; $i -lt 2; $i++) {
    if($i -eq 1){
        $Path="HKCU"
    }
    try {
        if (Test-Path Registry::$Path\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging){
            # true
            if ((Get-ItemProperty Registry::$Path\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging -ErrorAction Stop).EnableScriptBlockLogging){
                Write-Host "Script Block Enabled -$Path" -ForegroundColor Green
            }
            else{
                Write-Host "Script Block Disabled -$Path" -ForegroundColor Red
            }
        }
        else{
            Write-Host "Script Block not configured (off) -$Path" -ForegroundColor Red;
        }
    }
    catch [System.UnauthorizedAccessException]{
        Write-Host "$Path Read unauthorized (Script Block)" -ForegroundColor Green
        if($i -eq 0){
        $HKLM_Read=0
        }
        else{
            $HKCU_Read=0
        }
    }
    catch [System.Security.SecurityException]{
        Write-Host "$Path Read unauthorized (Script Block)" -ForegroundColor Green
        if($i -eq 0){
            $HKLM_Read=0
            }
        else{
            $HKCU_Read=0
        }
    }
    catch [System.Management.Automation.PSArgumentException]{
        Write-Host "Script Block registry key property missing! ($Path)" -ForegroundColor Yellow
    }
}

$Path="HKLM"

# Test to see if module logging is enabled:
for ($i = 0; $i -lt 2; $i++) {
    if($i -eq 1){
        $Path="HKCU"
    }
    try{
        if (Test-Path Registry::$Path\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging) {
            #true
            if ((Get-ItemProperty Registry::$Path\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging -ErrorAction Stop).EnableModuleLogging){
                Write-Host "Module Logging Enabled -$Path" -ForegroundColor Green 
            }
            else{
                Write-Host "Module Logging disabled -$Path" -ForegroundColor Red
            }
        }
        else{
            Write-Host "Module Logging not configured (off) -$Path" -ForegroundColor Red
        }
    }

    catch [System.UnauthorizedAccessException]{
        Write-Host "$Path Read unauthorized (Script Block)" -ForegroundColor Green
        if($i -eq 0){
            $HKLM_Read=0
        }
        else{
            $HKCU_Read=0
        }
    }
    catch [System.Security.SecurityException]{
        Write-Host "$Path Read unauthorized (Module Logging)" -ForegroundColor Green
        if($i -eq 0){
            $HKLM_Read=0
        }
        else{
            $HKCU_Read=0
        }
    }
    catch [System.Management.Automation.PSArgumentException]{
        Write-Host "Module Logging registry key property missing! ($Path)" -ForegroundColor Yellow
    }

}

$Path = "HKLM"

#  Test to see if transcription is enabled:
for ($i = 0; $i -lt 2; $i++) {
    if($i -eq 1){
        $Path="HKCU"
    }
    try{
        if(Test-Path Registry::$Path\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription){
            #true
            if( (Get-ItemProperty Registry::$Path\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription -ErrorAction Stop).EnableTranscripting) {
                Write-Host "Transcription Enabled -$Path" -ForegroundColor Green
            }
            else{
                Write-Host "Transcription off -$Path" -ForegroundColor Red
            }
        }
        else{
            Write-Host "Transcription not configured (off) -$Path" -ForegroundColor Red
        }
    }

    catch [System.UnauthorizedAccessException]{
        Write-Host "$Path Read unauthorized (Transcription)" -ForegroundColor Green
        if($i -eq 0){
            $HKLM_Read=0
        }
        else{
            $HKCU_Read=0
        }
    }
    catch [System.Security.SecurityException]{
        Write-Host "$Path Read unauthorized (Transcription)" -ForegroundColor Green
        if($i -eq 0){
            $HKLM_Read=0
        }
        else{
            $HKCU_Read=0
        }
    }
    catch [System.Management.Automation.PSArgumentException]{
        Write-Host "Transcription registry key property missing! ($Path)" -ForegroundColor Yellow 
    }
}

# Test to see if logs are retained:
try{ 
    if ( (Get-ItemProperty 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\Windows Powershell' -ErrorAction Stop).Retention){
    Write-Host "Logs Retained" -ForegroundColor Green
    }
    else {
        Write-Host "Logs may not be retained" -ForegroundColor Yellow
    }
}

catch [System.Management.Automation.PSArgumentException]{
    Write-Host "Log Retention registry key property missing!" -ForegroundColor Yellow 
}

catch [System.UnauthorizedAccessException]{
    Write-Host "Registry Read Unauthorized!" -ForegroundColor Green
}

# Test to see if log files are configured to be auto-exported:
try {
    if( ((Get-ItemProperty 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\Windows Powershell' -ErrorAction Stop).AutoBackupLogFiles) ){
        Write-Host "Logs auto-exported" -ForegroundColor Green
    }
    else {
        Write-Host "Logs may not be auto-exported" -ForegroundColor Yellow
    }
}

catch [System.Management.Automation.PSArgumentException]{
    Write-Host "Log export registry key property missing" -ForegroundColor Yellow 
}
catch [System.UnauthorizedAccessException]{
    Write-Host "Registry Read Unauthorized! (Log Files)" -ForegroundColor Green
}

 # if powershell version 2
try{
    if ( ((Get-ItemProperty Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\PowerShellEngine -ErrorAction Stop).PowerShellVersion ) -eq '2.0'){
        Write-Host "`nPowershell V 2 installed`n" -ForegroundColor Red
    }
}

catch{
    Write-Host "`nCould not locate V 2`n" -ForegroundColor Yellow
}

finally{

Write-Host " ##### History permissions #####" -NoNewline
(Get-Acl -Path "$HistoryPath").Access | Where-Object {$_.IdentityReference -like $whoami} | Format-Table -AutoSize FileSystemRights,AccessControlType
Write-Host "`n"
Write-Host "Execution Policy: " -NoNewline
Get-executionPolicy
Write-Host "Language Mode: " -NoNewline
$ExecutionContext.SessionState.LanguageMode
Write-Host "Whoami: $whoami"

whoami /priv
}
# All wish to possess knowledge, but few, comparatively speaking, are willing to pay the price.
