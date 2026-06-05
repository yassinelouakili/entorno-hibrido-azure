# Fase 5 — Scripts PowerShell

## Scripts 
Todos códigos se encuentran en [~/scripts/...](../scripts/)

Añadidos:
### 1. New-UsersFromCSV.ps1
Crea usuarios desde un CSV con:
- Nombre
- Apellido
- Departamento
- OU destino
[New-UsersFromCSV.ps1](../scripts/New-UsersFromCSV.ps1)

### 2. Get-InactiveUsers.ps1
Lista usuarios sin login en 30 días.
[Get-InactiveUsers.ps1](../scripts/Get-InactiveUsers.ps1)

### 3. Backup-GPOs.ps1
Exporta todas las GPOs a una carpeta con fecha.
[Backup-GPOs.ps1](../scripts/Backup-GPOs.ps1)

### 4. Get-DomainInventory.ps1
Inventario de:
- Nombre del equipo
- IP
- SO
- Último inicio de sesión
[Get-DomainInventory.ps1](../scripts/Get-DomainInventory.ps1)

### 5. Test-CriticalServices.ps1
Verifica:
- AD DS
- DNS
- DHCP
[Test-CriticalServices.ps1](../scripts/Test-CriticalServices.ps1)
