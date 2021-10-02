# Project-Juvenal
#### Who will watch the watchers?

![GitHub top language](https://img.shields.io/github/languages/top/Operational-Sciences-Group/Project-Juvenal?label=PowerShell&logo=powershell&style=plastic)
![Version](https://img.shields.io/badge/Version-1.0-sucess?style=plastic)
![GitHub issues](https://img.shields.io/github/issues/Operational-Sciences-Group/Project-Juvenal?logo=Github&style=plastic)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/Operational-Sciences-Group/Project-Juvenal?style=plastic)

Juvenal is a PowerShell (Version 7/5/2) script that enumerates Windows [PowerShell logging](https://devblogs.microsoft.com/powershell/powershell-the-blue-team/) group policies by reading the registry. It also checks for Powershell Version 2.



## Table of contents

1. [About](https://github.com/Operational-Sciences-Group/Project-Juvenal/blob/main/README.md#about)
2. [Installation /usage](https://github.com/Operational-Sciences-Group/Project-Juvenal/blob/main/README.md#installation--usage)
3. [Disclaimer / Warning](https://github.com/Operational-Sciences-Group/Project-Juvenal/blob/main/README.md#disclaimer--warning)
4. [License](https://github.com/Operational-Sciences-Group/Project-Juvenal/blob/main/README.md#license)

## About

Have you ever felt like you are being watched?

If so, Juvenal is for you.


Juvenal makes it easy for blue (and red) teams to identify Windows PowerShell group-policy mis-configurations.
The script looks at HKEY_LOCAL_MACHINE and HKEY_CURRENT_USER keys to determine if PowerShell is being [logged](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_logging_windows?view=powershell-7.1&viewFallbackFrom=powershell-5.1).

PowerShell logging is seperated into three "main" types:

* Script Block Logging
  - Logs the raw script supplied through the command line, a function, script, workflow, etc.
* Module Logging
  - Allows auditing of specific PowerShell modules when used.
* Transcription
  - Logs commands run (and their output)

Juvenal checks for all of these in HKLM and HKCU and provides a color coded output (Red for danger). Then it displays the execution policy, [language mode](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_language_modes?view=powershell-7.1), and current user priviliges. 

#### Screenshot
<a href="https://ibb.co/cyjrZqz"><img src="https://i.ibb.co/0nxG65P/Juvenal.png" alt="Juvenal" border="0"></a>

## Installation / Usage

**PowerShell V3.0+ One-liner:**

```Invoke-Expression (Invoke-WebRequest 'https://tinyurl.com/Juv3nal')```

**To install and use locally using PowerShell V3.0+:**

1. Navigate to the desired install path:

&emsp;```Set-Location <install\path>```

2. Place Juvenal.ps1 into path:

        (Invoke-WebRequest -URI "https://raw.githubusercontent.com/Operational-Sciences-Group/Project-Juvenal/main/Juvenal.ps1").Content > Juvenal.ps1
        
3. Run Juvenal.ps1:

&emsp;```.\Juvenal.ps1```


## Disclaimer / Warning
All the contents of this repository should be used for authorized and/or educational purposes only. Any misuse of this repository will not be the responsibility of the author or of any other collaborator.


## License

[GPL 3.0](https://github.com/Operational-Sciences-Group/Project-Juvenal/blob/main/LICENSE)
