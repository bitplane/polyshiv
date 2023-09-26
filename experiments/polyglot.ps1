#!/bin/bash
echo \" <<'POWERSHELL_SCRIPT' >/dev/null # " | Out-Null


# ===== PowerShell Script Begin =====

    # Detect Windows architecture
    $arch = if ([IntPtr]::Size -eq 8) { "amd64" } else { "386" }

    # Detect if Windows is ARM
    if ((Get-WmiObject -Class Win32_Processor).Architecture -eq 5) {
        $arch = "arm"
    } elseif ((Get-WmiObject -Class Win32_Processor).Architecture -eq 12) {
        $arch = "arm64"
    }

    Write-Host "windows-$arch"

# ====== PowerShell Script End ======


while ( ! $MyInvocation.MyCommand.Source ) { $input_line = Read-Host }
exit
<#
POWERSHELL_SCRIPT
set +o histexpand 2>/dev/null
# ===== Bash Script Begin =====

    # Detect Linux/Mac and architecture
    platform="unknown"
    case $(uname -s) in
        Linux*) platform="linux" ;;
        Darwin*) platform="darwin" ;;
    esac

    arch=$(uname -m)
    case $(uname -m) in
        x86_64) arch="amd64" ;;
        i386) arch="386" ;;
        armv7*) arch="arm" ;;
        aarch64) arch="arm64" ;;
    esac

    echo "$platform-$arch"

# ====== Bash Script End ======
case $- in *"i"*) cat /dev/stdin >/dev/null ;; esac
exit
#>
