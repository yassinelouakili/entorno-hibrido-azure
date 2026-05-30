# Fase 3 — Group Policy Objects (GPO)

## 1. GPOs corporativas creadas

### 1.1. GPO: “Password Policy”
- Longitud mínima: 12
- Complejidad: habilitada
- Expiración: 90 días

### 1.2. GPO: “Hardening Windows”
- Deshabilitar SMBv1
- Deshabilitar PowerShell 2.0
- Activar firewall

### 1.3. GPO: “Mapeo de unidad Z”
- `\\DC01\Recursos`
- Solo para IT

### 1.4. GPO: “Windows Update”
- Windows Update for Business

## 2. Vinculación a OUs 

- IT → 3 GPOs
- RRHH → 2 GPOs
- Dirección → 2 GPOs

## 3. Verificación

### Cliente
```
gpupdate /force
gpresult /r
```
![gpreuslt1](../imgs/fase3/gpresult1.png)
![gpresult2](../imgs/fase3/gpresult2.png)

### Servidor
- GPMC muestra GPOs vinculadas
![gpmc](../imgs/fase3/gmpc.png)