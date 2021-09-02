# OSG
# ⌨ >= ⚔
# Juvenal.ps1
# Powershell V 7/5
# This script tests for Powershell execution policy, transcription, scriptblock and module logging, and version 2.


#Requires -Version 2.0
Set-Location \
try {
    # If scriptblock logging true
    if( (Get-ItemProperty Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging -ErrorAction Stop).EnableScriptBlockLogging) {
        Write-Host "ScriptBlock Logging Enabled" -ForegroundColor Red
    }
    else{
        Write-Host "ScriptBlock Logging off" -ForegroundColor Green
    }
    
}

catch [System.Management.Automation.ItemNotFoundException] {
    Write-Host "ScriptBlock Logging not configured (off)" -ForegroundColor Green
}

# If Module logging true 
try {
     if ( (Get-ItemProperty Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging -ErrorAction Stop).EnableModuleLogging) {
        Write-Host "Module Logging Enabled" -ForegroundColor Red
    }
    else{
        Write-Host "Module Logging off" -ForegroundColor Green
    }
}

catch [System.Management.Automation.ItemNotFoundException] {
    Write-Host "Module Logging not configured (off)" -ForegroundColor Green
}

 # if transcription true
 try{
     if( (Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription -ErrorAction Stop).EnableTranscripting) {
         Write-Host "Transcription Enabled" -ForegroundColor Red
     }
     else{
        Write-Host "Transcription off" -ForegroundColor Green
    }
}
catch [System.Management.Automation.ItemNotFoundException]{
        Write-Host "PS Transcription not configured (off)" -ForegroundColor Green
}

 # if powershell version 2
 try{
     if ( ((Get-ItemProperty Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\PowerShellEngine -ErrorAction stop).PowerShellVersion ) -eq '2.0'){
         Write-Host "`nPowershell V 2 installed`n" -ForegroundColor Green
     }
 }
catch{
    Write-Host "`nCould not locate V 2`n" -ForegroundColor Yellow
}

Write-Host "Policy: " -NoNewline
Get-executionPolicy
Write-Host "Whoami: " -NoNewline
whoami
whoami /priv
