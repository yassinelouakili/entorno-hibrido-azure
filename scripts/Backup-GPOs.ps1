<#
.SYNOPSIS
    Exporta todas las GPOs a una carpeta con fecha.
#>

Import-Module GroupPolicy

$Date = Get-Date -Format "yyyy-MM-dd"
$Path = "C:\GPO-Backups\$Date"

New-Item -ItemType Directory -Path $Path -Force | Out-Null

$GPOs = Get-GPO -All

foreach ($g in $GPOs) {
    Backup-GPO -Guid $g.Id -Path $Path -ErrorAction SilentlyContinue
    Write-Host "Backup: $($g.DisplayName)"
}

Write-Host "Backups completados en $Path" -ForegroundColor Green