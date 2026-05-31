# Fase 4 — DHCP, File Server y Auditoría

## 1. DHCP

### Configuración del scope
- Rango: 192.168.56.100–200
- Gateway: 192.168.56.1
- DNS: 192.168.56.10
![DHCP scope1](../imgs/fase4/scopescliente.png)
![DHCP scope2](../imgs/fase4/opciones_scope.png)

## 2. File Server

### Carpetas
- `\\DC01\IT`
- `\\DC01\RRHH`
- `\\DC01\Direccion`

### Permisos NTFS
- IT → Full Control
- RRHH → Modify
- Dirección → Read
![File Server](../imgs/fase4/file_Server.png)
## 3. Auditoría de seguridad

### Activación
- Local Security Policy → Audit Policy
- Success + Failure
![Directivas auditoria](../imgs/fase4/directivas_seguridad.png)

### Eventos clave
- 4624: inicio de sesión exitoso
![Event 4624](../imgs/fase4/event4624.png)
- 4625: fallo de autenticación
![Event 4625](../imgs/fase4/event4625.png)