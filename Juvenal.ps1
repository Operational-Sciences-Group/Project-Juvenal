# OSG
# ⌨ >= ⚔
# Juvenal.ps1
# Powershell V 7/5/2
# This script tests for Powershell execution policy, transcription, scriptblock and module logging, and version 2.

$HKLM_Read=1
$HKCU_Read=1

try{
    # HKLM script block
    if (Test-Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging){
        # true
        if ((Get-ItemProperty Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging -ErrorAction Stop).EnableScriptBlockLogging){
            Write-Host "Script Block Enabled -HKLM" -ForegroundColor Red
        }
        else{
            Write-Host "Script Block Disabled -HKLM" -ForegroundColor Green
        }
    }
    else{
        Write-Host "Script Block not configured (off) - HKLM" -ForegroundColor Green
    }
}

catch [System.UnauthorizedAccessException]{
    Write-Host "HKLM Read unauthorized (Script Block)" -ForegroundColor Red
    $HKLM_Read=0
}
catch [System.Security.SecurityException]{
    Write-Host "HKLM Read unauthorized (Script Block)" -ForegroundColor Red
    $HKLM_Read=0
}
catch [System.Management.Automation.PSArgumentException]{
    Write-Host "Script Block registry pey property missing! (HKLM)" -ForegroundColor Yellow
}

try{
    # HKCU script block
    if (Test-Path Registry::HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging){
        # true
        if ((Get-ItemProperty Registry::HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging -ErrorAction Stop).EnableScriptBlockLogging){
            Write-Host "Script Block Enabled -HKCU" -ForegroundColor Red
        }
        else{
            Write-Host "Script Block Disabled -HKCU" -ForegroundColor Green
        }
    }
    else{
        Write-Host "Script Block not configured (off) - HKCU" -ForegroundColor Green
    }
}

catch [System.UnauthorizedAccessException]{
    Write-Host "HKCU Read unauthorized" -ForegroundColor Red
        $HKCU_Read=0
}
catch [System.Security.SecurityException]{
    Write-Host "HKCU Read unauthorized" -ForegroundColor Red
    $HKCU_Read=0
}
catch [System.Management.Automation.PSArgumentException]{
   Write-Host "Script Block registry pey property missing! (HKCU)" -ForegroundColor Yellow
}

try{
    # HKLM module logging 
    if (Test-Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging) {
        #true
        if ((Get-ItemProperty Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging -ErrorAction Stop).EnableModuleLogging){
            Write-Host "Module Logging Enabled -HKLM" -ForegroundColor Red 
        }
        else{
            Write-Host "Module Logging disabled -HKLM" -ForegroundColor Green
        }
    }
    else{
        Write-Host "Module Logging not configured (off) -HKLM" -ForegroundColor Green
    }
}

catch [System.UnauthorizedAccessException]{
    if ($HKLM_Read -eq 0){
        #Do nothing
    }
    else{
        Write-Host "HKLM Read unauthorized (Module Logging)" -ForegroundColor Red
        $HKLM_Read=0
    }
}
catch [System.Security.SecurityException]{
    if ($HKLM_Read -eq 0){
        #Do nothing
    }
    else{
        Write-Host "HKLM Read unauthorized (Module Logging)" -ForegroundColor Red
        $HKLM_Read=0
    }
}
catch [System.Management.Automation.PSArgumentException]{
    Write-Host "Module Logging registry key property missing! (HKLM)" -ForegroundColor Yellow
}

try {
    # HKCU module logging 
    if (Test-Path Registry::HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging) {
        #true
        if ((Get-ItemProperty Registry::HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging -ErrorAction Stop).EnableModuleLogging){
            Write-Host "Module Logging Enabled -HKCU" -ForegroundColor Red
        }
        else{
            Write-Host "Module Logging off -HKCU" -ForegroundColor Green
        }
    }
    else{
        Write-Host "Module Logging not configured (off) - HKCU" -ForegroundColor Green
    }
}
catch [System.UnauthorizedAccessException]{
    if ($HKCU_Read -eq 0){
        #Do nothing
    }
    else{
        Write-Host "HKCU Read unauthorized (Module Logging)" -ForegroundColor Red
        $HKCU_Read=0
    }
}
catch [System.Security.SecurityException]{
    if ($HKCU_Read -eq 0){
        #Do nothing
    }
    else{
        Write-Host "HKCU Read unauthorized (Module Logging)" -ForegroundColor Red
        $HKCU_Read=0
    }
}
catch [System.Management.Automation.PSArgumentException]{
    Write-Host "Module Logging registry key property missing! (HKCU)" -ForegroundColor Yellow
}

try{
    # HKLM transcription
    if(Test-Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription){
        #true
        if( (Get-ItemProperty Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription -ErrorAction Stop).EnableTranscripting) {
            Write-Host "Transcription Enabled -HKLM" -ForegroundColor Red
        }
        else{
            Write-Host "Transcription off -HLKM" -ForegroundColor Green
        }
     }
     else{
        Write-Host "Transcription not configured (off) - HKLM" -ForegroundColor Green
    }
}

catch [System.UnauthorizedAccessException]{
    if ($HKLM_Read -eq 0){
        #Do nothing
    }
    else{
        Write-Host "HKLM Read unauthorized (transcription)" -ForegroundColor Red
        $HKLM_Read=0
    }
}
catch [System.Security.SecurityException]{
    if ($HKLM_Read -eq 0){
        #Do nothing
    }
    else{
        Write-Host "HKLM Read unauthorized (transcription)" -ForegroundColor Red
        $HKLM_Read=0
    }
}
catch [System.Management.Automation.PSArgumentException]{
    Write-Host "Transcription registry key property missing!" -ForegroundColor Yellow 
}

try{
    # HKCU transcription
    if(Test-Path HKCU:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription){
        #true
        if( (Get-ItemProperty HKCU:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription -ErrorAction Stop).EnableTranscripting) {
            Write-Host "Transcription Enabled -HKCU" -ForegroundColor Red
        }
        else{
            Write-Host "Transcription off -HKCU"
        }
     }
     else{
        Write-Host "Transcription not configured (off) - HKCU" -ForegroundColor Green
    }
}

catch [System.UnauthorizedAccessException]{
    if ($HKCU_Read -eq 0){
        #Do nothing
    }
    else{
        Write-Host "HKCU Read unauthorized" -ForegroundColor Red
    }
}
catch [System.Security.SecurityException]{
    if ($HKCU_Read -eq 0){
        #Do nothing
    }
    else{
        Write-Host "HKCU Read unauthorized" -ForegroundColor Red
    }
}
catch [System.Management.Automation.PSArgumentException]{
    Write-Host "Transcription registry key property missing! -HKCU" -ForegroundColor Yellow 
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
