<#
.SYNOPSIS
    Lista usuarios inactivos en los últimos 30 días.
#>

param(
    [int]$Days = 30
)

Import-Module ActiveDirectory

$limit = (Get-Date).AddDays(-$Days)

Get-ADUser -Filter * -Properties LastLogonDate |
    Where-Object { $_.LastLogonDate -lt $limit -or !$_.LastLogonDate } |
    Select-Object Name, SamAccountName, LastLogonDate |
    Sort-Object LastLogonDate