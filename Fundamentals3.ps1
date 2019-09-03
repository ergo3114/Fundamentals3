return "For demo purposes only do not run as is"

# Get status 

$Services = 'BITS', 'Spooler'
Get-Service $Services

# We can put this script into a file and run it

$Location = 'C:\Users\cdlit\git\Fundamentals3'
Set-Location $Location

# Validate the contents of my script

Clear-Host
Get-Content .\MyScript.ps1

# The . means that you are running a process
# The process here assumes powershell is being run

. .\1MyScript.ps1

# What if we want to get the status of a different process?
# We can give the user the ability to give a parameter

Clear-Host
Get-Content .\2MyScriptwithParameters.ps1

# Lets call our script and give it a parameter

. .\2MyScriptwithParameters.ps1 -Services 'BITS'
. .\2MyScriptwithParameters.ps1 -Services 'Spooler'
. .\2MyScriptwithParameters.ps1
. .\2MyScriptwithParameters.ps1 -Services 5

# Obviously we need some validation
# 1. Accept only a string
# 2. Don't fill the screen when the user
#   does not provide a parameter

Clear-Host
Get-Content .\3MyScriptwithValidation.ps1

# Returns default value in Param block

. .\3MyScriptwithValidation.ps1

# Validates against anything that is not a string

$array = (5, 43, 'BITS')
. .\3MyScriptwithValidation.ps1 -Services $array

# Create a function

function Get-MyService {
    Param(
        [Parameter(Mandatory = $false)]
        [string[]]$Services = 'Spooler'
    )

    Get-Service $Services
}

Get-MyService
Get-MyService -Services 'Bits'

# Restrict what the user can get information for

function Get-MyService {
    Param(
        [Parameter(Mandatory = $false)]
        [ValidateSet('Spooler', 'BITS', IgnoreCase = $true)]
        [string[]]$Services = 'Spooler'
    )

    Get-Service $Services
}

# Named verses Positional parameters

function Get-MyService {
    Param(
        [Parameter(Mandatory = $false, Position = 0)]
        [ValidateSet('Spooler', 'BITS', IgnoreCase = $true)]
        [string[]]$Services = 'Spooler',

        [Parameter(Mandatory = $true, Position = 1)]
        [string]$Words
    )

    Get-Service $Services
    Write-Output $Words
}

Get-MyService -Services Spooler -Words 'Hello world'
Get-MyService Spooler 'Hello world'

# Scope
# Function scope

Get-MyService Spooler 'Hello world'
$Words

# Global scope

$Words = "This is in the global scope."
Get-MyService Spooler 'Hello world'
$Words