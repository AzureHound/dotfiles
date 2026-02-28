#Requires -Version 5.1
#Requires -RunAsAdministrator

#------------------------------------------------------------------------------
# Windows Application Discovery Script
#
# Purpose: Detects installed applications [System, Registry, Start Menu,
#          UWP, Chocolatey, Scoop] & outputs them as a JSON list.
#------------------------------------------------------------------------------

# --- Setup ---

$systemRoot = $env:SystemRoot
$system32Path = Join-Path -Path $systemRoot -ChildPath "System32"


# --- Helper Functions ---

# Adds spaces to CamelCase or PascalCase strings [e.g., "VisualStudio" -> "Visual Studio"]
function Add-SpacesToCamelCase {
    param([string]$InputString)

    if ($null -eq $InputString -or $InputString -match '\s' -or $InputString -match '^\d+$' -or $InputString.Length -lt 3) {
        return $InputString
    }

    try {
        # Regex patterns:
        # 1. (?<=[a-z])(?=[A-Z])   : Lowercase followed by Uppercase
        # 2. (?<=[A-Z])(?=[A-Z][a-z]) : Uppercase followed by Uppercase+Lowercase (handles acronyms like "MSPaint")
        # 3. (?<=[a-zA-Z])(?=[0-9])  : Letter followed by Digit
        $pattern = '((?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])|(?<=[a-zA-Z])(?=[0-9]))'
        $spaced = $InputString -replace $pattern, ' '
        return $spaced.Trim()
    } catch {
        return $InputString
    }
}

# Gets the application name using a priority order:
# 1. Target EXE FileDescription
# 2. LNK file name (often the user-facing name)
# 3. Target file name
function Get-ApplicationName {
    param (
        [string]$targetPath,
        [string]$lnkPath = $null
    )

    $appName = $null

    # Priority 1: Target Executable's FileDescription
    if ($targetPath -and $targetPath.EndsWith('.exe', [System.StringComparison]::OrdinalIgnoreCase) -and (Test-Path $targetPath -PathType Leaf)) {
        try {
            $desc = (Get-Item $targetPath).VersionInfo.FileDescription
            # Only use description if it's not empty/whitespace
            if ($desc -and $desc.Trim()) {
                $appName = $desc.Trim() -replace '\s+', ' ' # Normalize whitespace
            }
        } catch { } # Ignore errors reading version info
    }

    # Priority 2: LNK Filename (BaseName without extension), attempt spacing
    if (-not $appName -and $lnkPath -and (Test-Path $lnkPath -PathType Leaf)) {
        $appName = Add-SpacesToCamelCase -InputString ([System.IO.Path]::GetFileNameWithoutExtension($lnkPath))
    }

    # Priority 3: Target Filename (BaseName without extension), attempt spacing
    if (-not $appName -and $targetPath -and (Test-Path $targetPath -PathType Leaf)) {
        $appName = Add-SpacesToCamelCase -InputString ([System.IO.Path]::GetFileNameWithoutExtension($targetPath))
    }

    # Final Cleanup: Remove common registered/trademark symbols & trim whitespace
    if ($appName) {
        # TODO: This breaks on CJK systems because of UTF-8, check out https://github.com/TibixDev/winboat/issues/40
        # Original line in Base64:
        # JGFwcE5hbWUgPSAkYXBwTmFtZSAtcmVwbGFjZSAnKD9pKVxzKlwoclwpfFwodG1cKXzCqXzCrnzihKInLCAnJw==
        $appName = $appName.Trim()
    }

    return $appName
}

function Get-PrettifyName {
    param (
        [string]$Name
    )

    if ($Name -match '\.([^\.]+)$') {
        $ProductName = $Matches[1]
    } else {
        # If no period is found, use the whole name.
        $ProductName = $Name
    }
    
    $PrettyName = ($ProductName -creplace  '([A-Z\W_]|\d+)(?<![a-z])',' $&').trim()

    return $PrettyName
}

# Gets the display name for a UWP app.
function Get-UWPApplicationName {
    param (
        $app # The AppxPackage object
    )
    # UWP properties are usually the best source
    if ($app.DisplayName) { 
        return $app.DisplayName.Trim()
        #Write-Host($app)
    }
    if ($app.Name) { 
        return Get-PrettifyName -Name $app.Name
    } # Often the package name, less ideal but a fallback

    return $null # Failed to get a name
}

function Get-ParseUWP {
    param ([string]$instLoc) # InstallLocation from Get-AppxPackage

    $manifestPath = Join-Path -Path $instLoc -ChildPath "AppxManifest.xml"
    if (-not (Test-Path $manifestPath -PathType Leaf)) {
        return $null # Manifest doesn't exist or isn't a file
    }

    $xmlContent = Get-Content $manifestPath -Raw -Encoding Default -ErrorAction Stop

    $appId = "App" # Default, as it works for most packages.
    if ($xmlContent -match '<Application[^>]*Id\s*=\s*"([^"]+)"') {
        $appId = $Matches[1]
    }

    return $appId
}

# --- Main Application Logic ---

# Use efficient List & HashSet for collection & deduplication
$apps = [System.Collections.Generic.List[PSCustomObject]]::new()
# Store normalized (lowercase) full paths for case-insensitive duplicate checking
$addedPaths = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)

# Helper function to validate & add an app to the list if it's unique
function Add-AppToListIfValid {
    param(
        [string]$Name,
        [string]$InputPath, # The path discovered (can be relative or contain variables)
        [string]$Source,     # Source type (e.g., 'system', 'winreg', 'startmenu')

        [string]$launchArg # optional arg
    )

    $resolved = $null
    $fullPath = $null
    $normalizedPathKey = $null

    # Step 1, handle UWP app.
    if ($Source -eq "uwp") {
        if (-not $launchArg) {
            return # launching UWP app requires Arg
        }

        $normalizedPathKey = $InputPath.ToLowerInvariant() + $launchArg.ToLowerInvariant()
        if ($addedPaths.Contains($normalizedPathKey)) {
            return # Already added this app
        }

        # UWP object
        $apps.Add([PSCustomObject]@{
            Name   = $Name
            Path   = $InputPath
            Args   = $launchArg
            Source = 'uwp'
        })
        $addedPaths.Add($normalizedPathKey) | Out-Null
        return
    }

    # 2. Resolve & Validate Path Other
    try {
        $resolved = Resolve-Path -Path $InputPath -ErrorAction SilentlyContinue
    } catch { return } # Ignore if path resolution throws error

    # Ensure resolved path exists & is a file (Leaf)
    if ($resolved -and (Test-Path -LiteralPath $resolved.ProviderPath -PathType Leaf)) {
        $fullPath = $resolved.ProviderPath
        # Create a consistent key for the HashSet (lowercase)
        $normalizedPathKey = $fullPath.ToLowerInvariant()
    } else {
        return # Skip if path doesn't resolve to a valid file
    }

    # 3. Validate Name (Basic Check)
    if (-not $Name -or $Name.Trim().Length -eq 0 -or $Name -like 'Microsoft? Windows? Operating System*') {
        return # Skip if name is empty, invalid, or generic OS name
    }

    # 4. Check for Duplicates using normalized path
    if ($addedPaths.Contains($normalizedPathKey)) {
        return # Skip if this exact executable path has already been added
    }

    # 6. Add the Application Object (matching WinApp type)
    $apps.Add([PSCustomObject]@{
        Name   = $Name
        Path   = $fullPath # Use the resolved, non-normalized path for output
        Args    = ""
        Source = $Source
    })

    # 7. Mark Path as Added
    $addedPaths.Add($normalizedPathKey) | Out-Null
}


# --- Application Discovery Sections ---

# 1. Hardcoded Common System Tools
$systemTools = @(
    @{N = "Task Manager"; P = Join-Path $system32Path "Taskmgr.exe"},
    @{N = "Control Panel"; P = Join-Path $system32Path "control.exe"},
    @{N = "File Explorer"; P = Join-Path $env:WINDIR "explorer.exe"},
    @{N = "Command Prompt"; P = Join-Path $system32Path "cmd.exe"},
    @{N = "PowerShell"; P = Join-Path $system32Path "WindowsPowerShell\v1.0\powershell.exe"},
    @{N = "Notepad"; P = Join-Path $system32Path "notepad.exe"},
    @{N = "Paint"; P = Join-Path $system32Path "mspaint.exe"},
    @{N = "Registry Editor"; P = Join-Path $env:WINDIR "regedit.exe"},
    @{N = "Services"; P = Join-Path $system32Path "services.msc"},
    @{N = "Device Manager"; P = Join-Path $system32Path "devmgmt.msc"},
    @{N = "Computer Management"; P = Join-Path $system32Path "compmgmt.msc"},
    @{N = "Disk Management"; P = Join-Path $system32Path "diskmgmt.msc"},
    @{N = "Snipping Tool"; P = Join-Path $system32Path "SnippingTool.exe"}, # Legacy version
    @{N = "Calculator"; P = Join-Path $system32Path "win32calc.exe"},    # Legacy version
    @{N = "Remote Desktop Connection"; P = Join-Path $system32Path "mstsc.exe"}
)
foreach ($tool in $systemTools) {
    # Use the predefined name 'N' for system tools
    Add-AppToListIfValid -Name $tool.N -InputPath $tool.P -Source "system"
}


# 2. Windows Registry (App Paths - HKLM & HKCU)
try {
    $regRoots = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths",
                "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths"

    # Get properties from all matching keys under both roots
    $regEntries = foreach ($regRoot in $regRoots) {
        if (Test-Path $regRoot) {
            Get-ItemProperty "$regRoot\*" -ErrorAction SilentlyContinue
        }
    }

    # Process each found registry entry
    foreach ($entry in $regEntries) {
        $keyName = $entry.PSChildName # e.g., msedge.exe, devenv.exe
        $pathValue = $null

        # Check if the (default) value exists & is not empty
        if ($entry.PSObject.Properties['(default)'] -and $entry.'(default)') {
            try {
                # Expand environment variables & remove surrounding quotes
                $pathValue = $ExecutionContext.InvokeCommand.ExpandString($entry.'(default)'.Trim('"'))
            } catch { } # Ignore errors expanding variables
        }

        if ($pathValue) {
            # Get name using standard function (tries FileDescription first)
            $appName = Get-ApplicationName -targetPath $pathValue
            # Fallback: If Get-ApplicationName fails, use the spaced registry key name
            if (-not $appName) {
                $appName = Add-SpacesToCamelCase -InputString ([System.IO.Path]::GetFileNameWithoutExtension($keyName))
            }
            # Add if name is valid
            if ($appName) {
                Add-AppToListIfValid -Name $appName -InputPath $pathValue -Source "winreg"
            }
        }
    }
} catch { } # Ignore errors during registry scan


# 3. Start Menu Shortcuts (All Users + All User Profiles)
$startMenuPaths = @()

# Add global Start Menu path
$startMenuPaths += "C:\ProgramData\Microsoft\Windows\Start Menu\Programs"

# Add Start Menu paths for all user profiles (when running as SYSTEM)
try {
    $usersPath = "C:\Users"
    if (Test-Path $usersPath -PathType Container) {
        Get-ChildItem $usersPath -Directory -ErrorAction SilentlyContinue | 
            Where-Object { $_.Name -ne "Public" -and $_.Name -ne "All Users" -and $_.Name -ne "Default" -and $_.Name -ne "Default User" } |
            ForEach-Object {
                $userStartMenuPath = Join-Path $_.FullName "AppData\Roaming\Microsoft\Windows\Start Menu\Programs"
                if (Test-Path $userStartMenuPath -PathType Container) {
                    $startMenuPaths += $userStartMenuPath
                }
            }
    }
} catch {
    # Fallback: If C:\Users scan fails, try WMI approach
    try {
        Get-WmiObject Win32_UserProfile -ErrorAction SilentlyContinue | 
            Where-Object { -not $_.Special -and $_.LocalPath -and $_.LocalPath -notlike "*\Public" -and $_.LocalPath -notlike "*\Default*" } | 
            ForEach-Object {
                $userStartMenuPath = Join-Path $_.LocalPath "AppData\Roaming\Microsoft\Windows\Start Menu\Programs"
                if (Test-Path $userStartMenuPath -PathType Container) {
                    $startMenuPaths += $userStartMenuPath
                }
            }
    } catch { } # If both methods fail, just use global path
}

# Collect .lnk files from all valid Start Menu directories
$lnkFiles = @()
foreach ($startMenuPath in $startMenuPaths) {
    if (Test-Path $startMenuPath -PathType Container) {
        try {
            $pathLnkFiles = Get-ChildItem -Path $startMenuPath -Recurse -Filter *.lnk -File -ErrorAction SilentlyContinue
            if ($pathLnkFiles) {
                $lnkFiles += $pathLnkFiles
            }
        } catch { } # Ignore errors for individual paths
    }
}

if ($lnkFiles) {
    try {
        # Use strict mode for COM object for better error catching
        $shell = New-Object -ComObject WScript.Shell -Strict
        try {
            foreach ($lnk in $lnkFiles) {
                $target = $null
                $appName = $null

                    # Parse the shortcut file
                    try {
                        $link = $shell.CreateShortcut($lnk.FullName)
                        $rawTarget = $link.TargetPath
                        # Resolve path if contains environment variables
                        if ($rawTarget) {
                            $target = try { $ExecutionContext.InvokeCommand.ExpandString($rawTarget) } catch { $rawTarget }

                            # Handle case where SYSTEM user resolves paths to SYSTEM profile instead of actual user
                            $systemProfilePath = "C:\WINDOWS\system32\config\systemprofile"
                            if ($target -like "$systemProfilePath*") {
                                # Extract the relative path after the profile directory
                                $relativePath = $target -replace [regex]::Escape($systemProfilePath), ""

                                # Try to find this app in actual user profiles
                                $userBasePath = Split-Path (Split-Path $lnk.FullName) # Get user's start menu base path
                                if ($userBasePath -like "*\Users\*\AppData\Roaming\Microsoft\Windows\Start Menu\Programs") {
                                    # Extract username from the path
                                    if ($userBasePath -match "\\Users\\([^\\]+)\\") {
                                        $userName = $matches[1]
                                        $userTarget = "C:\Users\$userName$relativePath"
                                        if (Test-Path $userTarget -PathType Leaf) {
                                            $target = $userTarget
                                        }
                                    }
                                }
                            }
                        }
                    } catch { continue } # Skip malformed or unreadable shortcuts

                # Skip if no target or looks like an uninstaller
                if (-not $target -or $target -like '*uninstall*' -or $target -like '*unins000*') {
                    continue
                }

                # Get name using standard function (FileDesc > LNK Name > Target Name)
                $appName = Get-ApplicationName -targetPath $target -lnkPath $lnk.FullName

                # Refinement: If target is NOT an exe & name defaulted to target filename, prefer LNK filename
                if ($target -notlike '*.exe' -and $appName -eq (Add-SpacesToCamelCase ([System.IO.Path]::GetFileNameWithoutExtension($target))) ) {
                    $lnkNameOnly = Add-SpacesToCamelCase -InputString ([System.IO.Path]::GetFileNameWithoutExtension($lnk.FullName))
                    if ($lnkNameOnly -ne $appName) { $appName = $lnkNameOnly }
                }

                # Add if name is valid
                if ($appName) {
                    Add-AppToListIfValid -Name $appName -InputPath $target -Source "startmenu"
                }
            }
        } finally {
            # Ensure COM object is released
            if ($shell) {
                [System.Runtime.InteropServices.Marshal]::ReleaseComObject($shell) | Out-Null
                Remove-Variable shell -ErrorAction SilentlyContinue # Clean up variable
                [System.GC]::Collect()
                [System.GC]::WaitForPendingFinalizers()
            }
        }
    } catch { } # Ignore errors during Start Menu scan
}


# 4. UWP Apps
if (Get-Command Get-AppxPackage -ErrorAction SilentlyContinue) {
    try {
        Get-AppxPackage -AllUsers -ErrorAction SilentlyContinue |
            Where-Object {
                $_.IsFramework -eq $false -and
                $_.IsResourcePackage -eq $false -and
                $_.SignatureKind -ne 'System' -and       # Exclude core system packages
                $_.SignatureKind -ne 'Developer' -and    # Exclude "developer" packages
                $_.InstallLocation                       # Must have an install location
            } |
            ForEach-Object {
                $app = $_
                $pathValue = "explorer.exe"

                # Get appId from manifest
                $appId = Get-ParseUWP -instLoc $app.InstallLocation
                $launchArgs = "shell:AppsFolder\" + $app.PackageFamilyName + '!' + $appId

                if ($appId) { # check if we have appId
                    # Get the best display name (UWP properties preferred)
                    $name = Get-UWPApplicationName -app $app
                    if ($name) {
                        Add-AppToListIfValid -Name $name -InputPath $pathValue -Source "uwp" -launchArg $launchArgs
                    }
                }
            }
    } catch { } # Ignore errors during UWP scan
}


# 5. Chocolatey Installed Apps (via Shims)
$chocoDir = "C:\ProgramData\chocolatey\bin"
if (Test-Path $chocoDir -PathType Container) {
    try {
        Get-ChildItem -Path $chocoDir -Filter *.exe -File -ErrorAction SilentlyContinue |
            ForEach-Object {
                $shim = $_
                $exePath = $null
                $name = $null

                # Resolve shim target using Get-Command
                try {
                    $cmdInfo = Get-Command $shim.FullName -ErrorAction SilentlyContinue
                    # Ensure it resolved to a different path (not the shim itself)
                    if ($cmdInfo -and $cmdInfo.Source -ne $shim.FullName) {
                        $exePath = $cmdInfo.Source
                    }
                } catch { } # Ignore resolution errors

                if ($exePath) { # Path must resolve
                    # Get name (FileDesc preferred)
                    $name = Get-ApplicationName -targetPath $exePath
                    # Fallback to spaced shim name if needed
                    if (-not $name) { $name = Add-SpacesToCamelCase -InputString $shim.BaseName }

                    if ($name) {
                        Add-AppToListIfValid -Name $name -InputPath $exePath -Source "choco"
                    }
                }
            }
    } catch { } # Ignore errors during Choco scan
}


# 6. Scoop Installed Apps (via Shims)
# Check both common user & global scoop shim paths
$scoopDir = @(
    Join-Path $env:USERPROFILE "scoop\shims"
    "C:\ProgramData\scoop\shims"
) | Where-Object { Test-Path $_ -PathType Container } | Select-Object -First 1

if ($scoopDir) {
    try {
        Get-ChildItem -Path $scoopDir -File -ErrorAction SilentlyContinue |
            Where-Object { $_.Name -ne 'scoop.ps1' } | # Exclude scoop runner itself
            ForEach-Object {
                $shim = $_
                $exePath = $null
                $name = $null

                # Attempt to resolve target using Get-Command first
                try {
                    $cmdInfo = Get-Command $shim.FullName -ErrorAction SilentlyContinue
                    if ($cmdInfo -and $cmdInfo.Source -ne $shim.FullName) {
                        $exePath = $cmdInfo.Source
                    }
                } catch { } # Ignore resolution errors

                # Fallback: Very basic content scan for text-based shims if Get-Command fails
                if (-not $exePath -and $shim.Extension -in '.cmd', '.ps1', '') {
                    try {
                        # Read first 5 lines, look for "path/to/something.exe" pattern
                        $content = Get-Content $shim.FullName -Raw -TotalCount 5 -ErrorAction SilentlyContinue
                        if ($content -match '(?<=")([^"]+?\.exe)(?=")') {
                            $relativePath = $Matches[1] -replace '%~dp0', $shim.DirectoryName
                            $exePath = try { (Resolve-Path $relativePath -ErrorAction SilentlyContinue).Path } catch {}
                        }
                    } catch {}
                }

                if ($exePath) { # Path must resolve
                    # Get name (FileDesc preferred)
                    $name = Get-ApplicationName -targetPath $exePath
                    # Fallback to spaced shim name
                    if (-not $name) { $name = Add-SpacesToCamelCase -InputString $shim.BaseName }

                    if ($name) {
                        Add-AppToListIfValid -Name $name -InputPath $exePath -Source "scoop"
                    }
                }
            }
    } catch { } # Ignore errors during Scoop scan
}


# --- Output ---

# Convert the final list of application objects to a compressed JSON string.
# This is the only output sent to the standard output stream.

$outputPath = "\\host.lan\Data\apps.json"
$apps | ConvertTo-Json -Depth 5 -Compress | Out-File -FilePath $outputPath -Encoding UTF8 -Force
