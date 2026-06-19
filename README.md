# Infraestructura Híbrida de Identidad y Seguridad (Active Directory + Azure Entra ID)

## Resumen 
Diseño e implementación de una infraestructura de identidad híbrida para una empresa mediana, simulando un entorno **Zero Trust**. El objetivo principal es la centralización de identidades, la sincronización segura con la nube y la implementación de controles de acceso modernos para mitigar riesgos.

---

## Arquitectura de la Solución
```
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

## Decisiones de Diseño
Para este proyecto, he priorizado estándares de la industria sobre configuraciones por defecto:

* **Principio de Menor Privilegio:** En lugar de usar cuentas de Administrador de Dominio para la sincronización, configuré una **cuenta de servicio dedicada (`svc_EntraConnect`)** con permisos específicos de replicación. Esto minimiza la superficie de ataque del entorno on-premise.
* **Identidad Híbrida:** Implementación de *Password Hash Sync* con *Seamless SSO* para ofrecer una experiencia de usuario fluida sin comprometer la integridad de las contraseñas, equilibrando seguridad y usabilidad.
* **Seguridad Moderna:** Diseño enfocado en capas: desde el hardening del servidor local (GPOs) hasta políticas de acceso condicional y MFA en Azure.

---

## Fases del Proyecto (Milestones)

| Fase | Área | Objetivo |
| :--- | :--- | :--- |
| **1-4** | On-Premise | Base: AD DS, DNS/DHCP, File Server y GPOs de endurecimiento. |
| **5** | Automatización | Scripts PowerShell para inventario y gestión de usuarios masiva. |
| **6** | Híbrido | Despliegue de Entra Connect y sincronización de identidades. |
| **7** | Seguridad | MFA y Directivas de Acceso Condicional (Zero Trust). |
| **8-9** | Governance | PIM, Access Reviews y Gobernanza cloud con RBAC/Azure Policy. |
| **10** | Hardening | Bloqueo de autenticación legacy y separación de roles administrativos. |

---

## Stack Tecnológico
* **Core:** Windows Server 2025, Active Directory DS.
* **Cloud:** Microsoft Entra ID (P2), Azure Monitor, Storage.
* **Seguridad:** Conditional Access, MFA, Identity Protection.
* **Automatización:** PowerShell (gestión de lifecycle de identidades).

---

##  Desafíos y Aprendizajes (Key Takeaways)

* **Sincronización:** Durante la primera iteración, enfrenté errores de sincronización por configuración de permisos de la cuenta de servicio. Esto me obligó a profundizar en la delegación de permisos de AD y entender el funcionamiento del agente de Entra Connect, lo cual fue clave para fortalecer la seguridad de la arquitectura.
* **Resolución de Problemas:** El trabajo con GPOs y DNS me enseñó que la infraestructura IT es un ecosistema interconectado; un error de resolución de nombres puede invalidar capas enteras de seguridad.

---

## Documentación Detallada
Para ver el detalle técnico de cada fase, consulta la carpeta `/docs`:
- [Fase 2: AD DS & DNS](docs/fase-2-active-directory.md)
- [Fase 3: GPOs y Seguridad](docs/fase-3-gpo.md)
- [Fase 4: Infraestructura y Auditoría](docs/fase-4-dhcp-fileserver-auditoria.md)
- [Fase 5: Automatización PowerShell](docs/fase-5-powershell.md)
- [Fase 6: Sincronización Híbrida](docs/fase-6-entra-connect.md)

---
*Autor: Yassine Elouakili El Mahdati*
