#!/usr/bin/env bash
# Runs Microsoft's recommmnedation for installation of PowerShell on Linux.
## See https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7.1#red-hat-enterprise-linux-rhel-7

set -o nounset
set -o errexit

# Register the Microsoft RedHat repository
curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo

# Install PowerShell
sudo yum install --assumeyes powershell

# Start PowerShell
which pwsh 
pwsh --version