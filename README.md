# Infraestructura Híbrida de Identidad y Seguridad (Active Directory + Azure Entra ID)

## Resumen

Diseño e implementación de una infraestructura de identidad híbrida para una empresa mediana, simulando un entorno **Zero Trust**. El objetivo principal es la centralización de identidades, la sincronización segura con la nube y la implementación de controles de acceso modernos para reducir riesgos asociados a la gestión de identidades y accesos.

---

## Arquitectura de la Solución

```text
┌─────────────────────────────────────────────┐
│                                             │
│  ┌─────────────────┐   ┌─────────────────┐  │
│  │   DC01          │   │   WIN10 / WIN11 │  │
│  │   Windows       │◄──│   Clientes      │  │
│  │   Server 2025   │   │   del dominio   │  │
│  │                 │   │                 │  │
│  │  · AD DS        │   │ · GPOs aplicadas│  │
│  │  · DNS          │   │ · Unidad Z:     │  │
│  │  · DHCP         │   │   mapeada       │  │
│  │  · File Server  │   │                 │  │
│  │  · Entra Connect│   └─────────────────┘  │
│  └────────┬────────┘                        │
└───────────┼─────────────────────────────────┘
            │ Sincronización (Entra Connect)
            ▼
┌─────────────────────────────────────────────┐
│                  Azure                      │
│                                             │
│  Entra ID                                   │
│  · Usuarios sincronizados                   │
│  · MFA · Conditional Access                 │
│  · Identity Protection · PIM                │
│  · Access Reviews (Governance)              │
│  · Entra Connect Health                     │
│                                             │
│  Administración cloud                       │
│  · Resource Groups · RBAC                   │
│  · Azure Policy · Storage Account           │
│  · Azure Monitor + Alertas                  │
└─────────────────────────────────────────────┘
```

---

## Objetivos Técnicos

* Implementar una identidad híbrida entre Active Directory y Azure Entra ID.
* Automatizar la gestión de usuarios mediante PowerShell.
* Aplicar controles de seguridad basados en Zero Trust.
* Reducir privilegios administrativos mediante RBAC y PIM.
* Centralizar la monitorización y auditoría de identidades.
* Validar escenarios reales de despliegue, operación y recuperación.

---

## Decisiones de Diseño

### Principio de Menor Privilegio

En lugar de utilizar una cuenta con privilegios elevados para la sincronización, se configuró una cuenta de servicio dedicada (`svc_EntraConnect`) con permisos específicos de replicación necesarios para Azure Entra Connect.

### Identidad Híbrida

Implementación de:

* Password Hash Synchronization (PHS)
* Seamless Single Sign-On (SSO)

Este enfoque proporciona una experiencia de usuario fluida manteniendo el control de las identidades locales.

### Seguridad por Capas

La arquitectura incorpora controles en distintos niveles:

* Hardening mediante GPOs.
* MFA para acceso a recursos cloud.
* Conditional Access.
* RBAC.
* PIM.
* Azure Policy.
* Monitorización y alertado.

---

## Fases del Proyecto

| Fase | Área                          | Estado      |
| ---- | ----------------------------- | ----------- |
| 1    | Infraestructura base          | Completada  |
| 2    | Active Directory y DNS        | Completada  |
| 3    | GPOs y hardening              | Completada  |
| 4    | DHCP, File Server y auditoría | Completada  |
| 5    | Automatización PowerShell     | Completada  |
| 6    | Azure Entra Connect           | Completada  |
| 7    | MFA y Conditional Access      | En progreso |
| 8    | PIM y Access Reviews          | Pendiente   |
| 9    | Gobernanza Cloud              | Pendiente   |
| 10   | Hardening avanzado            | Pendiente   |

---

## Stack Tecnológico

### On-Premise

* Windows Server 2025
* Active Directory Domain Services
* DNS
* DHCP
* File Services

### Cloud

* Azure Entra ID
* Azure Monitor
* Azure Storage
* Azure Policy

### Seguridad

* Multi-Factor Authentication
* Conditional Access
* Identity Protection
* Privileged Identity Management (PIM)

### Automatización

* PowerShell
* Scripts de provisión y administración de usuarios

---

## Incidente de Seguridad y Lecciones Aprendidas

Durante la fase de implementación de MFA y Acceso Condicional se produjo un incidente de configuración que resultó especialmente útil desde el punto de vista formativo.

### Descripción

Se desplegó una política de Acceso Condicional con el objetivo de bloquear métodos de autenticación heredados (Legacy Authentication).

Debido a una configuración excesivamente restrictiva, la política terminó afectando a todas las cuentas administrativas del tenant, provocando una pérdida completa de acceso administrativo al entorno de Azure Entra ID.

### Impacto

* Bloqueo de acceso a cuentas administrativas.
* Imposibilidad de modificar políticas desde el portal.
* Interrupción temporal de la fase de implementación de MFA.

### Lecciones Aprendidas

* Nunca desplegar políticas de Acceso Condicional sin cuentas break-glass.
* Probar nuevas políticas en grupos piloto antes de aplicarlas globalmente.
* Utilizar el modo Report-only cuando sea posible.
* Mantener al menos dos cuentas Global Administrator excluidas de políticas críticas.
* Documentar procedimientos de recuperación ante errores de configuración.

### Valor del Incidente

Este incidente permitió comprender de forma práctica los riesgos operativos asociados a Zero Trust y reforzó la importancia de diseñar mecanismos de recuperación antes de aplicar controles de seguridad restrictivos.

---

## Principales Aprendizajes

* Delegación segura de permisos para Azure Entra Connect.
* Resolución de incidencias de sincronización híbrida.
* Diseño de GPOs de endurecimiento.
* Automatización mediante PowerShell.
* Implementación de controles Zero Trust.
* Gestión de identidades híbridas.
* Recuperación y mitigación ante errores de configuración de acceso.

---

## Documentación

* Fase 2: AD DS y DNS
* Fase 3: GPOs y Seguridad
* Fase 4: DHCP, File Server y Auditoría
* Fase 5: Automatización PowerShell
* Fase 6: Azure Entra Connect

---

## Autor

**Yassine Elouakili El Mahdati**

Proyecto orientado a la adquisición de competencias prácticas en administración de sistemas, identidad híbrida, automatización y seguridad Zero Trust.
