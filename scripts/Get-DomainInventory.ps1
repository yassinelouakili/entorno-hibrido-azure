<#
.SYNOPSIS
    Inventario de equipos del dominio.
#>

Import-Module ActiveDirectory

$computers = Get-ADComputer -Filter * -Properties IPv4Address, OperatingSystem, LastLogonDate

$computers | Select-Object `
    Name,
    IPv4Address,
    OperatingSystem,
    LastLogonDate |
    Sort-Object Name