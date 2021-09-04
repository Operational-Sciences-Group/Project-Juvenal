# OSG
# ⌨ >= ⚔
# Juvenal.ps1
# Powershell V 7/5/2
# This script tests for Powershell execution policy, transcription, scriptblock and module logging, and version 2.

# If scriptblock logging true
try {
    if( (Get-ItemProperty Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging -ErrorAction Stop).EnableScriptBlockLogging) {
        Write-Host "ScriptBlock Logging Enabled" -ForegroundColor Red
    }
    else{
        Write-Host "ScriptBlock Logging off" -ForegroundColor Green
    }
}

catch [System.Management.Automation.ActionPreferenceStopException]{
    if ($PSVersionTable.PSVersion.Major -eq 2){
         Write-Host "ScriptBlock Logging not configured (off)" -ForegroundColor Green -NoNewline 
         Write-Host " -Version 2"
    }
    else{
        Write-Host "ScriptBlock Logging not configured (off)" -ForegroundColor Green
    }
 }

catch [System.UnauthorizedAccessException]{
    Write-Host "Registry Read Unauthorized!" -ForegroundColor Red
}

catch [System.Management.Automation.PSArgumentException]{
   Write-Host "Script Block registry pey property missing!" -ForegroundColor Yellow
}

# If module logging true
try {
    if ( (Get-ItemProperty Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging -ErrorAction Stop).EnableModuleLogging) {
        Write-Host "Module Logging Enabled" -ForegroundColor Red
    }
    else{
        Write-Host "Module Logging off" -ForegroundColor Green
    }
}

catch [System.Management.Automation.ActionPreferenceStopException]{
    if ($PSVersionTable.PSVersion.Major -eq 2){
         Write-Host "Module logging not configured (off)" -ForegroundColor Green -NoNewline 
         Write-Host " -Version 2"
    }
    else{
        Write-Host "Module logging not configured (off)" -ForegroundColor Green
    }
 }

catch [System.UnauthorizedAccessException]{
    Write-Host "Registry Read Unauthorized!" -ForegroundColor Red
}

catch [System.Management.Automation.PSArgumentException]{
    Write-Host "Module Logging registry key property missing!" -ForegroundColor Yellow
}

 # If transcription true
 try{
     if( (Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription -ErrorAction Stop).EnableTranscripting) {
         Write-Host "Transcription Enabled" -ForegroundColor Red
     }
     else{
        Write-Host "Transcription off" -ForegroundColor Green
    }
}
catch [System.Management.Automation.ActionPreferenceStopException]{
    if ($PSVersionTable.PSVersion.Major -eq 2){
         Write-Host "Transcription not configured (off)" -ForegroundColor Green
    }
    else{
        Write-Host "Transcription not configured (off)" -ForegroundColor Green
    }
 }

catch [System.UnauthorizedAccessException]{
    Write-Host "Registry Read Unauthorized!" -ForegroundColor Red
}

catch [System.Management.Automation.PSArgumentException]{
    Write-Host "Transcription registry key property missing!" -ForegroundColor Yellow 
 }

# If logs retained
try{ 
    if ( (Get-ItemProperty 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\Windows Powershell' -ErrorAction Stop).Retention){
    Write-Host "Logs Retained" -ForegroundColor Red
    }
    else {
        Write-Host "Logs may not be retained" -ForegroundColor Green
    }
}

catch [System.Management.Automation.PSArgumentException]{
    Write-Host "Log Retention registry key property missing!" -ForegroundColor Yellow 
}

catch [System.UnauthorizedAccessException]{
    Write-Host "Registry Read Unauthorized!" -ForegroundColor Red
}

 # If log files auto-exported
try {
    if( ((Get-ItemProperty 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\Windows Powershell' -ErrorAction Stop).AutoBackupLogFiles) ){
        Write-Host "Logs auto-exported" -ForegroundColor Red
    }
    else {
        Write-Host "Logs may not be auto-exported" -ForegroundColor Green
    }
    
}

catch [System.Management.Automation.PSArgumentException]{
    Write-Host "Log export registry key property missing" -ForegroundColor Yellow 
}

catch [System.UnauthorizedAccessException]{
    Write-Host "Registry Read Unauthorized!" -ForegroundColor Red
}

 # if powershell version 2
try{
    if ( ((Get-ItemProperty Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\PowerShellEngine -ErrorAction Stop).PowerShellVersion ) -eq '2.0'){
        Write-Host "`nPowershell V 2 installed`n" -ForegroundColor Green
    }
}
catch{
    Write-Host "`nCould not locate V 2`n" -ForegroundColor Yellow
}

finally{
Write-Host "Policy: " -NoNewline
Get-executionPolicy
Write-Host "Whoami: " -NoNewline
whoami
whoami /priv
}
# All wish to possess knowledge, but few, comparatively speaking, are willing to pay the price.
