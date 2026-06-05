<#
.SYNOPSIS
    Crea usuarios en Active Directory desde un archivo CSV.
.DESCRIPTION
    El CSV debe contener las columnas: Nombre, Apellido, Departamento, OU
    La contraseña se solicita de forma segura al ejecutar el script.
.EXAMPLE
    .\New-UsersFromCSV.ps1 -CSVPath ".\usuarios.csv"
#>
param(
    [Parameter(Mandatory=$true)]
    [string]$CSVPath,

    [Parameter(Mandatory=$true)]
    [SecureString]$Password
)

Import-Module ActiveDirectory

# Cargar CSV
try {
    $users = Import-Csv $CSVPath
} catch {
    Write-Error "No se pudo leer el CSV: $_"
    exit
}

foreach ($u in $users) {

    # Generar SamAccountName (máx. 20 caracteres)
    $Sam = ($u.Nombre.Substring(0,1) + $u.Apellido).ToLower()
    $Sam = $Sam -replace '\s',''
    $Sam = $Sam.Substring(0, [Math]::Min($Sam.Length, 20))

    $OU = $u.OU

    # Resolver OU
    if ($OU -notlike "OU=*") {
        $domainDN = (Get-ADDomain).DistinguishedName
        $OU = "OU=$OU,$domainDN"
    }

    # Verificar que la OU existe usando -Identity
    try {
        Get-ADOrganizationalUnit -Identity $OU -ErrorAction Stop | Out-Null
    } catch {
        Write-Host "OU no encontrada, saltando $Sam`: $OU" -ForegroundColor Yellow
        continue
    }

    # Verificar si el usuario ya existe
    if (Get-ADUser -Filter "SamAccountName -eq '$Sam'" -ErrorAction SilentlyContinue) {
        Write-Host "Usuario ya existe, saltando: $Sam" -ForegroundColor Yellow
        continue
    }

    # Crear usuario
    try {
        New-ADUser `
            -Name "$($u.Nombre) $($u.Apellido)" `
            -GivenName $u.Nombre `
            -Surname $u.Apellido `
            -SamAccountName $Sam `
            -UserPrincipalName "$Sam@labyee.local" `
            -Department $u.Departamento `
            -Path $OU `
            -AccountPassword $Password `
            -Enabled $true `
            -ChangePasswordAtLogon $true

        Write-Host "Usuario creado: $Sam" -ForegroundColor Green
    }
    catch {
        Write-Host "Error creando $Sam`: $_" -ForegroundColor Red
    }
}