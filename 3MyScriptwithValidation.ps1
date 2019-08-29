Param(
    [Parameter(Mandatory = $false)]
    [string[]]$Services = 'Spooler'
)

Get-Service $Services