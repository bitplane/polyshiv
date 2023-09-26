#!/bin/bash

# This bit runs in Windows
: '
powershell -Command {

    $POLYGLOT_MODE="POWERSHELL"

    # Detect Windows architecture
    $arch = if ([IntPtr]::Size -eq 8) { "amd64" } else { "386" }

    # Detect if Windows is ARM
    if ((Get-WmiObject -Class Win32_Processor).Architecture -eq 5) {
        $arch = "arm"
    } elseif ((Get-WmiObject -Class Win32_Processor).Architecture -eq 12) {
        $arch = "arm64"
    }

    Write-Host "windows-$arch"

    # Exit from PowerShell to prevent running bash part
    exit
}
'

false @"
false "
# This bit runs on Unices

# Detect Linux/Mac and architecture
platform="unknown"
case $(uname -s) in
    Linux*) platform="linux" ;;
    Darwin*) platform="darwin" ;;
esac

arch="unknown"
case $(uname -m) in
    x86_64) arch="amd64" ;;
    i386) arch="386" ;;
    armv7*) arch="arm" ;;
    aarch64) arch="arm64" ;;
esac

echo "$platform-$arch"

exit

false "@
false \"

