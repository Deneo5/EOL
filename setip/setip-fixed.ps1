# Function to find the .git folder in the repository
function FindGitFolder {
    param(
        [string]$path
    )

    # Check if .git folder exists in the current directory
    if (Test-Path (Join-Path -Path $path -ChildPath ".git") -PathType Container) {
        return $path
    }

    # Recursively search for .git folder in parent directories
    $parent = Split-Path -Path $path -Parent
    if ($parent -eq $path) {
        return $null
    }

    return FindGitFolder -path $parent
}

$Global:ScriptRoot = $PSScriptRoot
$Global:ScriptName = $MyInvocation.MyCommand.Name
$Global:ScriptObj = Get-ChildItem (Join-Path $Global:ScriptRoot -ChildPath $Global:ScriptName) -ErrorAction Stop
$Global:RepoRoot = FindGitFolder $Global:ScriptObj
$modulesFolder = Join-Path -path $Global:RepoRoot -ChildPath 'modules'
Import-Module (Join-Path $modulesFolder -ChildPath "NetModule.ps1") -ErrorAction Stop
returnA #function from NetModule.ps1