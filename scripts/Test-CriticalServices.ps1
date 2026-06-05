<#
.SYNOPSIS
    Verifica que los servicios críticos del dominio están activos.
#>

$services = @(
    "NTDS",     # Active Directory Domain Services
    "DNS",      # DNS Server
    "DHCPServer"
)

foreach ($s in $services) {
    $status = Get-Service -Name $s -ErrorAction SilentlyContinue

    if ($status.Status -eq "Running") {
        Write-Host "$s OK" -ForegroundColor Green
    } else {
        Write-Host "$s NO FUNCIONA" -ForegroundColor Red
    }
}