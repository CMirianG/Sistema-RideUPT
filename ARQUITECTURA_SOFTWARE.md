# Sistema RideUPT - Plataforma de viajes compartidos Universitarios, Tacna, 2025

## Documento de Arquitectura del Software

**Versión:** 1.0  
**Fecha:** 2025  
**Elaborado por:** Equipo de Desarrollo RideUPT

---

## Contenido

1. [INTRODUCCIÓN](#1-introducción)
   - 1.1. Propósito (Diagrama 4+1)
   - 1.2. Alcance
   - 1.3. Definición, siglas y abreviaturas
   - 1.4. Organización del documento

2. [OBJETIVOS Y RESTRICCIONES ARQUITECTÓNICAS](#2-objetivos-y-restricciones-arquitectónicas)
   - 2.1.1. Requerimientos Funcionales
   - 2.1.2. Requerimientos No Funcionales – Atributos de Calidad

3. [REPRESENTACIÓN DE LA ARQUITECTURA DEL SISTEMA](#3-representación-de-la-arquitectura-del-sistema)
   - 3.1. Vista de Caso de uso
     - 3.1.1. Diagramas de Casos de uso
   - 3.2. Vista Lógica
     - 3.2.1. Diagrama de Subsistemas (paquetes)
     - 3.2.2. Diagrama de Secuencia (vista de diseño)
     - 3.2.3. Diagrama de Colaboración (vista de diseño)
     - 3.2.4. Diagrama de Objetos
     - 3.2.5. Diagrama de Clases
     - 3.2.6. Diagrama de Base de datos (relacional o no relacional)
   - 3.3. Vista de Implementación (vista de desarrollo)
     - 3.3.1. Diagrama de arquitectura software (paquetes)
     - 3.3.2. Diagrama de arquitectura del sistema (Diagrama de componentes)
   - 3.4. Vista de procesos
     - 3.4.1. Diagrama de Procesos del sistema (diagrama de actividad)
   - 3.5. Vista de Despliegue (vista física)
     - 3.5.1. Diagrama de despliegue

4. [ATRIBUTOS DE CALIDAD DEL SOFTWARE](#4-atributos-de-calidad-del-software)
   - 4.1. Escenario de Funcionalidad
   - 4.2. Escenario de Usabilidad
   - 4.3. Escenario de confiabilidad
   - 4.4. Escenario de rendimiento
   - 4.5. Escenario de mantenibilidad
   - 4.6. Otros Escenarios

---

## 1. INTRODUCCIÓN

### 1.1. Propósito (Diagrama 4+1)

Este documento describe la arquitectura del software del sistema **RideUPT**, una plataforma de viajes compartidos para la comunidad universitaria de la Universidad Privada de Tacna. La arquitectura se presenta mediante múltiples vistas que permiten entender el sistema desde diferentes perspectivas.

El documento sigue el modelo de vistas arquitectónicas **"4+1"** propuesto por Philippe Kruchten, que organiza las descripciones arquitectónicas en múltiples vistas complementarias:

#### Diagrama 4+1 de Vistas Arquitectónicas

```
┌─────────────────────────────────────────────────────────────────┐
│                        VISTA LÓGICA                              │
│              (Funcionalidad y estructura del sistema)            │
│  • Diagrama de Clases                                            │
│  • Diagrama de Subsistemas                                       │
│  • Diagrama de Objetos                                           │
└─────────────────────────────────────────────────────────────────┘
                              ▲
                              │
        ┌─────────────────────┼─────────────────────┐
        │                     │                     │
┌───────┴────────┐   ┌────────┴────────┐  ┌────────┴────────┐
│ VISTA DE       │   │ VISTA DE        │  │ VISTA DE        │
│ PROCESOS       │   │ IMPLEMENTACIÓN  │  │ DESPLIEGUE      │
│                │   │                 │  │                 │
│ • Diagrama de  │   │ • Diagrama de   │  │ • Diagrama de   │
│   Actividad    │   │   Componentes   │  │   Despliegue    │
│ • Flujo de     │   │ • Paquetes      │  │ • Infraestruct. │
│   Procesos     │   │ • Módulos       │  │   Física        │
└────────────────┘   └─────────────────┘  └─────────────────┘
        │                     │                     │
        └─────────────────────┼─────────────────────┘
                              │
                    ┌─────────▼─────────┐
                    │  VISTA DE CASOS   │
                    │      DE USO       │
                    │                   │
                    │ • Casos de Uso    │
                    │ • Escenarios      │
                    └───────────────────┘
```

**Vista de Casos de Uso (+1)**: Esta vista conecta todas las demás vistas, mostrando cómo los casos de uso se realizan mediante la colaboración de los elementos de las otras vistas.

**Vista Lógica**: Describe la funcionalidad del sistema desde la perspectiva del desarrollador. Incluye clases, subsistemas, paquetes y sus relaciones.

**Vista de Procesos**: Describe los aspectos dinámicos del sistema, flujos de ejecución, concurrencia y sincronización.

**Vista de Implementación**: Organiza los módulos de código fuente, bibliotecas, componentes y sus dependencias.

**Vista de Despliegue**: Describe la distribución física del sistema en nodos de hardware, servidores y redes.

### 1.2. Alcance

Este documento de arquitectura cubre:

- **Sistema**: RideUPT - Plataforma de viajes compartidos universitarios
- **Componentes**: Frontend (Flutter), Backend (Node.js), Base de Datos (MongoDB), Servicios Externos (Firebase, Google Maps)
- **Alcance funcional**: Autenticación, gestión de conductores, creación y búsqueda de viajes, notificaciones, historial, expiración automática
- **Alcance técnico**: Arquitectura cliente-servidor, API REST, WebSockets, autenticación JWT, notificaciones push
- **Público objetivo**: Desarrolladores, arquitectos de software, stakeholders técnicos del proyecto

### 1.3. Definición, siglas y abreviaturas

| Abreviatura | Significado |
|-------------|-------------|
| **API** | Application Programming Interface (Interfaz de Programación de Aplicaciones) |
| **JWT** | JSON Web Token (Token Web JSON) |
| **REST** | Representational State Transfer (Transferencia de Estado Representacional) |
| **HTTP/HTTPS** | Hypertext Transfer Protocol / Secure (Protocolo de Transferencia de Hipertexto / Seguro) |
| **FCM** | Firebase Cloud Messaging (Mensajería en la Nube de Firebase) |
| **ODM** | Object Document Mapper (Mapeador de Objetos a Documentos) |
| **VPS** | Virtual Private Server (Servidor Privado Virtual) |
| **SSL/TLS** | Secure Sockets Layer / Transport Layer Security (Capa de Sockets Seguros / Seguridad de Capa de Transporte) |
| **UI/UX** | User Interface / User Experience (Interfaz de Usuario / Experiencia de Usuario) |
| **QA** | Quality Assurance (Aseguramiento de Calidad) |
| **SDK** | Software Development Kit (Kit de Desarrollo de Software) |
| **UPT** | Universidad Privada de Tacna |
| **RNF** | Requerimiento No Funcional |
| **RF** | Requerimiento Funcional |

### 1.4. Organización del documento

Este documento está organizado en las siguientes secciones principales:

1. **Introducción**: Propósito, alcance, definiciones y organización del documento
2. **Objetivos y Restricciones Arquitectónicas**: Requerimientos funcionales y no funcionales que guían la arquitectura
3. **Representación de la Arquitectura del Sistema**: Múltiples vistas arquitectónicas:
   - Vista de Caso de Uso
   - Vista Lógica
   - Vista de Implementación
   - Vista de Procesos
   - Vista de Despliegue
4. **Atributos de Calidad del Software**: Escenarios de calidad que el sistema debe cumplir

Cada vista arquitectónica contiene diagramas específicos que ilustran diferentes aspectos del sistema desde diversas perspectivas.

---

## 2. OBJETIVOS Y RESTRICCIONES ARQUITECTÓNICAS

### 2.1.1. Requerimientos Funcionales

El sistema RideUPT debe cumplir con los siguientes requerimientos funcionales priorizados:

| ID | Nombre | Descripción | Prioridad |
|----|--------|-------------|-----------|
| **RF001** | Autenticar Usuario | El sistema debe permitir el registro e inicio de sesión de usuarios con credenciales válidas de estudiantes. | Alta |
| **RF002** | Gestionar Conductor | El sistema debe permitir la aceptación (habilitación) y edición de perfiles de conductor. | Alta |
| **RF003** | Crear Viaje | Los conductores deben poder crear viajes usando geolocalización automática para el origen. | Alta |
| **RF004** | Buscar Viaje | Los pasajeros deben poder buscar viajes disponibles por origen, destino y hora. | Alta |
| **RF005** | Enviar Notificación | El sistema debe enviar notificaciones en tiempo real ante cambios de estado relevantes. | Media |
| **RF006** | Consultar Historial | Los usuarios deben poder acceder a un historial de viajes pasados y próximos. | Media |
| **RF007** | Expirar Viaje | Los viajes deben expirar automáticamente después de 10 minutos si no son tomados. | Media |
| **RF008** | Autenticar con Google | El sistema debe permitir autenticación rápida y segura mediante cuentas de Google. | Alta |

**Total**: 8 requerimientos funcionales
- **Prioridad Alta**: 5 requerimientos (RF001, RF002, RF003, RF004, RF008)
- **Prioridad Media**: 3 requerimientos (RF005, RF006, RF007)

### 2.1.2. Requerimientos No Funcionales – Atributos de Calidad

El sistema RideUPT debe cumplir con los siguientes requerimientos no funcionales que garantizan la calidad del software:

| ID | Requerimiento | Descripción | Prioridad |
|----|---------------|-------------|-----------|
| **RNF001** | Usabilidad | Interfaz intuitiva con tiempo de aprendizaje < 3 minutos | Alta |
| **RNF002** | Rendimiento | Tiempo de respuesta < 2 segundos para operaciones principales | Alta |
| **RNF003** | Disponibilidad | 99.5% uptime objetivo | Alta |
| **RNF004** | Seguridad | Encriptación AES-256 y autenticación JWT | Alta |
| **RNF005** | Escalabilidad | Arquitectura preparada para crecimiento de usuarios | Media |

**Total**: 5 requerimientos no funcionales
- **Prioridad Alta**: 4 requerimientos (RNF001, RNF002, RNF003, RNF004)
- **Prioridad Media**: 1 requerimiento (RNF005)

#### Restricciones Arquitectónicas

Las siguientes restricciones influyen en las decisiones arquitectónicas:

1. **Restricción Tecnológica**: 
   - Frontend debe ser multiplataforma (Android, iOS, Web) → Solución: Flutter
   - Backend debe soportar tiempo real → Solución: Node.js con Socket.io

2. **Restricción de Seguridad**:
   - Autenticación mediante correo institucional de la UPT
   - Validación de identidad de usuarios obligatoria

3. **Restricción de Infraestructura**:
   - Utilizar servicios cloud para reducir costos iniciales
   - Base de datos NoSQL para soportar datos geoespaciales

4. **Restricción de Tiempo**:
   - Desarrollo en 3 meses
   - Uso de tecnologías maduras y frameworks establecidos

5. **Restricción de Escalabilidad**:
   - Arquitectura debe soportar crecimiento de usuarios sin cambios mayores
   - Separación frontend/backend permite escalado independiente

---

## 3. REPRESENTACIÓN DE LA ARQUITECTURA DEL SISTEMA

### 3.1. Vista de Caso de uso

Esta vista describe la funcionalidad del sistema desde la perspectiva de los usuarios finales, mostrando las interacciones entre actores y el sistema.

#### 3.1.1. Diagramas de Casos de uso

**Actores del Sistema:**

- **Estudiante (Pasajero)**: Usuario que busca y reserva viajes compartidos
- **Estudiante (Conductor)**: Usuario que publica y gestiona viajes compartidos
- **Administrador**: Usuario que gestiona conductores y supervisa el sistema
- **Sistema**: Procesos automáticos del sistema (expiración de viajes, notificaciones)

**Diagrama de Casos de Uso General:**

```
┌─────────────────────────────────────────────────────────────────────┐
│                         SISTEMA RIDEUPT                              │
│                                                                       │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │                    AUTENTICACIÓN                             │   │
│  │  ┌──────────────────┐          ┌──────────────────┐         │   │
│  │  │ RF001: Autenticar│          │ RF008: Autenticar│         │   │
│  │  │ Usuario          │          │ con Google       │         │   │
│  │  └──────────────────┘          └──────────────────┘         │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                            ▲                                         │
│                            │                                         │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │              GESTIÓN DE PERFIL                               │   │
│  │  ┌──────────────────┐          ┌──────────────────┐         │   │
│  │  │ RF002: Gestionar │          │ Editar Perfil    │         │   │
│  │  │ Conductor        │          │                  │         │   │
│  │  └──────────────────┘          └──────────────────┘         │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                            ▲                                         │
│                            │                                         │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │              GESTIÓN DE VIAJES                               │   │
│  │  ┌──────────────────┐  ┌──────────────────┐                │   │
│  │  │ RF003: Crear     │  │ RF004: Buscar    │                │   │
│  │  │ Viaje            │  │ Viaje            │                │   │
│  │  └──────────────────┘  └──────────────────┘                │   │
│  │                                                              │   │
│  │  ┌──────────────────┐  ┌──────────────────┐                │   │
│  │  │ Reservar Asiento │  │ RF006: Consultar │                │   │
│  │  │                  │  │ Historial        │                │   │
│  │  └──────────────────┘  └──────────────────┘                │   │
│  │                                                              │   │
│  │  ┌──────────────────┐                                      │   │
│  │  │ RF007: Expirar   │                                      │   │
│  │  │ Viaje (Auto)     │                                      │   │
│  │  └──────────────────┘                                      │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                            ▲                                         │
│                            │                                         │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │              NOTIFICACIONES                                  │   │
│  │  ┌──────────────────┐                                       │   │
│  │  │ RF005: Enviar    │                                       │   │
│  │  │ Notificación     │                                       │   │
│  │  └──────────────────┘                                       │   │
│  └─────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────┘
        ▲                    ▲                    ▲
        │                    │                    │
┌───────┴────────┐  ┌────────┴────────┐  ┌────────┴────────┐
│   ESTUDIANTE   │  │   ESTUDIANTE    │  │  ADMINISTRADOR  │
│  (PASAJERO)    │  │   (CONDUCTOR)   │  │                 │
└────────────────┘  └─────────────────┘  └─────────────────┘
```

**Casos de Uso Detallados:**

**CU001: Autenticar Usuario (RF001)**
- **Actor Principal**: Estudiante
- **Precondición**: Usuario no autenticado
- **Flujo Principal**:
  1. Usuario ingresa correo institucional y contraseña
  2. Sistema valida credenciales
  3. Sistema genera token JWT
  4. Sistema autentica al usuario
- **Postcondición**: Usuario autenticado en el sistema

**CU002: Autenticar con Google (RF008)**
- **Actor Principal**: Estudiante
- **Precondición**: Usuario no autenticado
- **Flujo Principal**:
  1. Usuario selecciona "Iniciar con Google"
  2. Sistema redirige a autenticación Google
  3. Usuario autoriza aplicación
  4. Sistema valida correo institucional
  5. Sistema autentica al usuario
- **Postcondición**: Usuario autenticado en el sistema

**CU003: Gestionar Conductor (RF002)**
- **Actor Principal**: Administrador
- **Precondición**: Usuario ha solicitado ser conductor, Administrador autenticado
- **Flujo Principal**:
  1. Administrador consulta solicitudes pendientes
  2. Administrador revisa documentos del conductor
  3. Administrador aprueba o rechaza solicitud
  4. Sistema notifica al usuario del resultado
- **Postcondición**: Estado del conductor actualizado

**CU004: Crear Viaje (RF003)**
- **Actor Principal**: Estudiante (Conductor)
- **Precondición**: Conductor autenticado y aprobado
- **Flujo Principal**:
  1. Conductor selecciona "Crear Viaje"
  2. Sistema obtiene ubicación actual (geolocalización automática)
  3. Conductor ingresa destino, horario, precio y asientos disponibles
  4. Sistema valida datos y crea viaje
  5. Sistema programa expiración (10 minutos)
  6. Sistema notifica a pasajeros potenciales
- **Postcondición**: Viaje creado y visible para búsqueda

**CU005: Buscar Viaje (RF004)**
- **Actor Principal**: Estudiante (Pasajero)
- **Precondición**: Pasajero autenticado
- **Flujo Principal**:
  1. Pasajero ingresa origen, destino y hora
  2. Sistema busca viajes disponibles que coincidan
  3. Sistema muestra lista de viajes filtrados
  4. Pasajero selecciona viaje de interés
- **Postcondición**: Lista de viajes disponibles mostrada

**CU006: Enviar Notificación (RF005)**
- **Actor Principal**: Sistema
- **Precondición**: Cambio de estado relevante
- **Flujo Principal**:
  1. Sistema detecta cambio de estado (nuevo viaje, solicitud aceptada, etc.)
  2. Sistema identifica usuarios a notificar
  3. Sistema envía notificación push (FCM)
  4. Sistema envía notificación vía WebSocket
- **Postcondición**: Usuario notificado

**CU007: Consultar Historial (RF006)**
- **Actor Principal**: Estudiante
- **Precondición**: Usuario autenticado
- **Flujo Principal**:
  1. Usuario selecciona "Historial"
  2. Sistema consulta viajes del usuario
  3. Sistema muestra viajes pasados y próximos filtrados
- **Postcondición**: Historial de viajes mostrado

**CU008: Expirar Viaje (RF007)**
- **Actor Principal**: Sistema
- **Precondición**: Viaje creado hace 10 minutos sin pasajeros
- **Flujo Principal**:
  1. Sistema detecta tiempo de expiración alcanzado
  2. Sistema cambia estado del viaje a "expirado"
  3. Sistema notifica al conductor
  4. Sistema elimina viaje de búsquedas activas
- **Postcondición**: Viaje expirado y no disponible

---

### 3.2. Vista Lógica

Esta vista describe la funcionalidad del sistema desde la perspectiva del desarrollador, mostrando la estructura estática del sistema en términos de clases, subsistemas, paquetes y sus relaciones.

#### 3.2.1. Diagrama de Subsistemas (paquetes)

```
┌──────────────────────────────────────────────────────────────────┐
│                    SISTEMA RIDEUPT                                │
│                                                                    │
│  ┌──────────────────────────────┐  ┌──────────────────────────┐ │
│  │    FRONTEND (Flutter)        │  │   BACKEND (Node.js)      │ │
│  │                              │  │                          │ │
│  │  ┌────────────────────┐     │  │  ┌────────────────────┐ │ │
│  │  │ Presentation Layer │     │  │  │   Routes Layer     │ │ │
│  │  │ - Screens          │     │  │  │   - auth.js        │ │ │
│  │  │ - Widgets          │     │  │  │   - trips.js       │ │ │
│  │  │ - Themes           │     │  │  │   - users.js       │ │ │
│  │  └────────────────────┘     │  │  └────────────────────┘ │ │
│  │           ▲                 │  │           │              │ │
│  │           │                 │  │           ▼              │ │
│  │  ┌────────────────────┐     │  │  ┌────────────────────┐ │ │
│  │  │ State Management   │     │  │  │  Controllers Layer │ │ │
│  │  │ - AuthProvider     │     │  │  │  - authController  │ │ │
│  │  │ - TripProvider     │     │  │  │  - tripController  │ │ │
│  │  └────────────────────┘     │  │  │  - userController  │ │ │
│  │           ▲                 │  │  └────────────────────┘ │ │
│  │           │                 │  │           │              │ │
│  │  ┌────────────────────┐     │  │           ▼              │ │
│  │  │ Services Layer     │     │  │  ┌────────────────────┐ │ │
│  │  │ - ApiService       │─────┼──┼──│  Services Layer    │ │ │
│  │  │ - SocketService    │     │  │  │  - socketService   │ │ │
│  │  │ - NotificationSvc  │     │  │  │  - notificationSvc │ │ │
│  │  └────────────────────┘     │  │  └────────────────────┘ │ │
│  │           ▲                 │  │           │              │ │
│  │           │                 │  │           ▼              │ │
│  │  ┌────────────────────┐     │  │  ┌────────────────────┐ │ │
│  │  │ Models Layer       │     │  │  │  Models Layer      │ │ │
│  │  │ - User             │     │  │  │  - User            │ │ │
│  │  │ - Trip             │     │  │  │  - Trip            │ │ │
│  │  │ - Rating           │     │  │  │  - Rating          │ │ │
│  │  └────────────────────┘     │  │  └────────────────────┘ │ │
│  └──────────────────────────────┘  └──────────────────────────┘ │
│                    │                    │                         │
│                    └──────────┬─────────┘                         │
│                               ▼                                    │
│                    ┌─────────────────────┐                        │
│                    │   BASE DE DATOS     │                        │
│                    │   MongoDB Atlas     │                        │
│                    │   - Users           │                        │
│                    │   - Trips           │                        │
│                    │   - Ratings         │                        │
│                    └─────────────────────┘                        │
│                               ▲                                    │
│                    ┌──────────┴─────────┐                         │
│                    │                    │                         │
│      ┌─────────────▼─────┐  ┌──────────▼──────────┐             │
│      │   FIREBASE        │  │   GOOGLE SERVICES   │             │
│      │   - Auth          │  │   - Maps API        │             │
│      │   - FCM           │  │   - Geocoding       │             │
│      │   - Hosting       │  │                     │             │
│      └───────────────────┘  └──────────────────────┘             │
└──────────────────────────────────────────────────────────────────┘
```

#### 3.2.2. Diagrama de Secuencia (vista de diseño)

**CU004: Crear Viaje - Secuencia detallada**

```
Pasajero    Frontend      ApiService    Backend        TripController    MongoDB    NotificationService    FCM
    │           │              │            │                │              │              │                │
    │           │              │            │                │              │              │                │
    │    Crear Viaje          │            │                │              │              │                │
    ├──────────>│              │            │                │              │              │                │
    │           │              │            │                │              │              │                │
    │           │   Obtener    │            │                │              │              │                │
    │           │  Ubicación   │            │                │              │              │                │
    │           ├─────────────>│            │                │              │              │                │
    │           │              │            │                │              │              │                │
    │           │   POST /api/trips         │                │              │              │                │
    │           ├──────────────────────────>│                │              │              │                │
    │           │              │            │                │              │              │                │
    │           │              │            │   createTrip() │              │              │                │
    │           │              │            ├───────────────>│              │              │                │
    │           │              │            │                │              │              │                │
    │           │              │            │   Validar Conductor          │              │                │
    │           │              │            ├─────────────────────────────>│              │                │
    │           │              │            │                │              │              │                │
    │           │              │            │   Guardar Viaje              │              │                │
    │           │              │            ├─────────────────────────────>│              │                │
    │           │              │            │                │              │              │                │
    │           │              │            │   <── Viaje guardado ───     │              │                │
    │           │              │            │                │              │              │                │
    │           │              │            │   Programar Expiración (10min)│              │                │
    │           │              │            │                │              │              │                │
    │           │              │            │   Notificar Pasajeros        │              │                │
    │           │              │            ├────────────────────────────────────────────>│                │
    │           │              │            │                │              │              │                │
    │           │              │            │                │              │              │   Enviar Push  │
    │           │              │            │                │              │              ├───────────────>│
    │           │              │            │                │              │              │                │
    │           │              │            │   <── Notificación enviada ──│              │                │
    │           │              │            │                │              │              │                │
    │           │              │            │   <── Viaje creado ───        │              │                │
    │           │              │            │<──────────────────────────────│              │                │
    │           │              │            │                │              │              │                │
    │           │   Viaje creado           │                │              │              │                │
    │           │<─────────────────────────│                │              │              │                │
    │           │              │            │                │              │              │                │
    │   Viaje creado exitosamente          │                │              │              │                │
    │<──────────│              │            │                │              │              │                │
```

#### 3.2.3. Diagrama de Colaboración (vista de diseño)

**RF004: Buscar Viaje - Colaboración entre objetos**

```
┌──────────┐      ┌──────────┐      ┌──────────┐      ┌──────────┐      ┌──────────┐
│ Pasajero │      │ TripList │      │ApiService│      │TripCtrlr │      │ MongoDB  │
│  Screen  │      │  Widget  │      │          │      │          │      │          │
└─────┬────┘      └─────┬────┘      └─────┬────┘      └─────┬────┘      └─────┬────┘
      │                  │                  │                  │                  │
      │ 1: buscarViaje() │                  │                  │                  │
      ├─────────────────>│                  │                  │                  │
      │                  │                  │                  │                  │
      │                  │ 2: fetchTrips()  │                  │                  │
      │                  ├─────────────────>│                  │                  │
      │                  │                  │                  │                  │
      │                  │                  │ 3: GET /api/trips│                  │
      │                  │                  ├─────────────────>│                  │
      │                  │                  │                  │                  │
      │                  │                  │                  │ 4: getAvailableTrips()│
      │                  │                  │                  ├─────────────────>│
      │                  │                  │                  │                  │
      │                  │                  │                  │ 5: Query trips   │
      │                  │                  │                  ├─────────────────>│
      │                  │                  │                  │                  │
      │                  │                  │                  │ 6: Trips data    │
      │                  │                  │                  │<─────────────────┤
      │                  │                  │                  │                  │
      │                  │                  │ 7: Trips list    │                  │
      │                  │                  │<─────────────────┤                  │
      │                  │                  │                  │                  │
      │                  │ 8: Trips list    │                  │                  │
      │                  │<─────────────────┤                  │                  │
      │                  │                  │                  │                  │
      │ 9: mostrarViajes │                  │                  │                  │
      │<─────────────────┤                  │                  │                  │
```

#### 3.2.4. Diagrama de Objetos

**Ejemplo: Sistema con Viaje Activo**

```
┌─────────────────────────────────────────────────────────────────┐
│                    INSTANCIA DEL SISTEMA                        │
│                                                                   │
│  ┌──────────────────┐      ┌──────────────────┐                │
│  │  u1: User        │      │  t1: Trip        │                │
│  │  id: "user123"   │      │  id: "trip456"   │                │
│  │  firstName: "Juan"│      │  driver: u1      │                │
│  │  lastName: "Pérez"│      │  origin: {       │                │
│  │  email: "juan@upt"│      │    lat: -18.0153 │                │
│  │  role: "driver"   │      │    lng: -70.2511 │                │
│  │  vehicle: v1      │      │    name: "Campus"│                │
│  └────────┬─────────┘      │  }               │                │
│           │                 │  destination: {  │                │
│           │                 │    lat: -18.0135 │                │
│           │                 │    lng: -70.2495 │                │
│           │                 │    name: "Centro"│                │
│           │                 │  }               │                │
│  ┌────────▼─────────┐      │  status: "espera"│                │
│  │  v1: Vehicle     │      │  passengers: [   │                │
│  │  make: "Toyota"  │      │    p1            │                │
│  │  model: "Yaris"  │      │  ]               │                │
│  │  plate: "ABC123" │      └──────────────────┘                │
│  │  seats: 5        │             ▲                            │
│  └──────────────────┘             │                            │
│                                   │                            │
│  ┌────────────────────────────────┼──────────────────┐        │
│  │  p1: Passenger                │                  │        │
│  │  user: u2                     │                  │        │
│  │  status: "confirmed"          │                  │        │
│  │  bookedAt: "2025-01-15 08:00" │                  │        │
│  └───────────────────────────────┘                  │        │
│                                                      │        │
│  ┌──────────────────┐                               │        │
│  │  u2: User        │                               │        │
│  │  id: "user789"   │                               │        │
│  │  firstName: "María"                              │        │
│  │  lastName: "García"                              │        │
│  │  email: "maria@upt"                              │        │
│  │  role: "passenger"                               │        │
│  └──────────────────┘                               │        │
└─────────────────────────────────────────────────────────────────┘
```

#### 3.2.5. Diagrama de Clases

**Modelo de Datos Principal**

```
┌──────────────────────────────────────────────────────────────────┐
│                           USER                                    │
├──────────────────────────────────────────────────────────────────┤
│ - _id: ObjectId                                                   │
│ - firstName: String                                               │
│ - lastName: String                                                │
│ - email: String (unique)                                          │
│ - password: String (hashed)                                       │
│ - phone: String                                                   │
│ - university: String                                              │
│ - studentId: String                                               │
│ - role: Enum['passenger', 'driver']                               │
│ - isAdmin: Boolean                                                │
│ - driverApprovalStatus: Enum['pending', 'approved', 'rejected']   │
│ - vehicle: Vehicle                                                │
│ - driverDocuments: List<DriverDocument>                           │
│ - fcmToken: String                                                │
│ - averageRating: Number                                           │
│ - totalRatings: Number                                            │
├──────────────────────────────────────────────────────────────────┤
│ + comparePassword(password: String): Boolean                      │
│ + getFullName(): String                                           │
└──────────────────────────────────────────────────────────────────┘
                            ▲
                            │ 1
                            │
                            │ *
┌───────────────────────────┴──────────────────────────────────────┐
│                           VEHICLE                                 │
├──────────────────────────────────────────────────────────────────┤
│ - make: String                                                    │
│ - model: String                                                   │
│ - year: Number                                                    │
│ - color: String                                                   │
│ - licensePlate: String (unique)                                   │
│ - totalSeats: Number                                              │
└──────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────┐
│                           TRIP                                    │
├──────────────────────────────────────────────────────────────────┤
│ - _id: ObjectId                                                   │
│ - driver: ObjectId (ref: User)                                    │
│ - origin: GeoPoint {                                              │
│     type: 'Point',                                                │
│     coordinates: [Number, Number],                                │
│     name: String                                                  │
│   }                                                               │
│ - destination: GeoPoint {                                         │
│     type: 'Point',                                                │
│     coordinates: [Number, Number],                                │
│     name: String                                                  │
│   }                                                               │
│ - departureTime: Date                                             │
│ - expiresAt: Date                                                 │
│ - availableSeats: Number                                          │
│ - seatsBooked: Number                                             │
│ - pricePerSeat: Number                                            │
│ - description: String                                             │
│ - status: Enum['esperando', 'completo', 'en-proceso',            │
│                'completado', 'expirado', 'cancelado']            │
│ - passengers: List<Passenger>                                     │
│ - createdAt: Date                                                 │
│ - updatedAt: Date                                                 │
├──────────────────────────────────────────────────────────────────┤
│ + isExpired(): Boolean                                            │
│ + hasAvailableSeats(): Boolean                                    │
│ + addPassenger(userId: ObjectId): Boolean                         │
└──────────────────────────────────────────────────────────────────┘
                            ▲
                            │ 1
                            │
                            │ *
┌───────────────────────────┴──────────────────────────────────────┐
│                         PASSENGER                                 │
├──────────────────────────────────────────────────────────────────┤
│ - user: ObjectId (ref: User)                                      │
│ - status: Enum['pending', 'confirmed', 'rejected', 'cancelled']   │
│ - bookedAt: Date                                                  │
│ - inVehicle: Boolean                                              │
└──────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────┐
│                           RATING                                  │
├──────────────────────────────────────────────────────────────────┤
│ - _id: ObjectId                                                   │
│ - trip: ObjectId (ref: Trip)                                      │
│ - rater: ObjectId (ref: User)                                     │
│ - rated: ObjectId (ref: User)                                     │
│ - rating: Number (1-5)                                            │
│ - comment: String                                                 │
│ - role: Enum['driver', 'passenger']                               │
│ - createdAt: Date                                                 │
├──────────────────────────────────────────────────────────────────┤
│ + calculateAverageRating(userId: ObjectId): Number                │
└──────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────┐
│                       DRIVERDOCUMENT                              │
├──────────────────────────────────────────────────────────────────┤
│ - tipoDocumento: Enum['Foto del Vehículo', 'Tarjeta de           │
│                     Propiedad', 'Carnet Universitario',          │
│                     'Selfie del Conductor']                       │
│ - urlImagen: String                                               │
│ - subidoEn: Date                                                  │
└──────────────────────────────────────────────────────────────────┘
```

#### 3.2.6. Diagrama de Base de datos (relacional o no relacional)

**Modelo de Datos MongoDB (NoSQL)**

```
┌──────────────────────────────────────────────────────────────────┐
│                      MONGODB DATABASE: rideupt                   │
│                                                                   │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │                     COLLECTION: users                       │ │
│  │  {                                                          │ │
│  │    _id: ObjectId,                                          │ │
│  │    firstName: String,                                      │ │
│  │    lastName: String,                                       │ │
│  │    email: String (unique, indexed),                        │ │
│  │    password: String (hashed),                              │ │
│  │    phone: String,                                          │ │
│  │    university: String,                                     │ │
│  │    studentId: String,                                      │ │
│  │    role: String,                                           │ │
│  │    isAdmin: Boolean,                                       │ │
│  │    driverApprovalStatus: String,                           │ │
│  │    vehicle: {                                              │ │
│  │      make: String,                                         │ │
│  │      model: String,                                        │ │
│  │      year: Number,                                         │ │
│  │      color: String,                                        │ │
│  │      licensePlate: String (unique, indexed),               │ │
│  │      totalSeats: Number                                    │ │
│  │    },                                                       │ │
│  │    driverDocuments: [                                      │ │
│  │      {                                                      │ │
│  │        tipoDocumento: String,                              │ │
│  │        urlImagen: String,                                  │ │
│  │        subidoEn: Date                                      │ │
│  │      }                                                      │ │
│  │    ],                                                       │ │
│  │    fcmToken: String,                                       │ │
│  │    averageRating: Number,                                  │ │
│  │    totalRatings: Number,                                   │ │
│  │    createdAt: Date,                                        │ │
│  │    updatedAt: Date                                         │ │
│  │  }                                                          │ │
│  │  Indexes: email (unique), vehicle.licensePlate (unique)    │ │
│  └────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │                     COLLECTION: trips                       │ │
│  │  {                                                          │ │
│  │    _id: ObjectId,                                          │ │
│  │    driver: ObjectId (ref: users),                          │ │
│  │    origin: {                                               │ │
│  │      type: "Point",                                        │ │
│  │      coordinates: [Number, Number], (2dsphere index)       │ │
│  │      name: String                                          │ │
│  │    },                                                       │ │
│  │    destination: {                                          │ │
│  │      type: "Point",                                        │ │
│  │      coordinates: [Number, Number], (2dsphere index)       │ │
│  │      name: String                                          │ │
│  │    },                                                       │ │
│  │    departureTime: Date,                                    │ │
│  │    expiresAt: Date,                                        │ │
│  │    availableSeats: Number,                                 │ │
│  │    seatsBooked: Number,                                    │ │
│  │    pricePerSeat: Number,                                   │ │
│  │    description: String,                                    │ │
│  │    status: String,                                         │ │
│  │    passengers: [                                           │ │
│  │      {                                                      │ │
│  │        user: ObjectId (ref: users),                        │ │
│  │        status: String,                                     │ │
│  │        bookedAt: Date,                                     │ │
│  │        inVehicle: Boolean                                  │ │
│  │      }                                                      │ │
│  │    ],                                                       │ │
│  │    createdAt: Date,                                        │ │
│  │    updatedAt: Date                                         │ │
│  │  }                                                          │ │
│  │  Indexes: origin (2dsphere), destination (2dsphere),       │ │
│  │           driver, status, expiresAt (TTL)                  │ │
│  └────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │                    COLLECTION: ratings                      │ │
│  │  {                                                          │ │
│  │    _id: ObjectId,                                          │ │
│  │    trip: ObjectId (ref: trips),                            │ │
│  │    rater: ObjectId (ref: users),                           │ │
│  │    rated: ObjectId (ref: users),                           │ │
│  │    rating: Number (1-5),                                   │ │
│  │    comment: String,                                        │ │
│  │    role: String,                                           │ │
│  │    createdAt: Date                                         │ │
│  │  }                                                          │ │
│  │  Indexes: trip, rater, rated                                │ │
│  └────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  Relationships:                                                  │
│  • users._id ←→ trips.driver (1:N)                              │
│  • users._id ←→ trips.passengers[].user (1:N)                   │
│  • trips._id ←→ ratings.trip (1:N)                              │
│  • users._id ←→ ratings.rater (1:N)                             │
│  • users._id ←→ ratings.rated (1:N)                             │
└──────────────────────────────────────────────────────────────────┘
```

---

### 3.3. Vista de Implementación (vista de desarrollo)

Esta vista organiza los módulos de código fuente, bibliotecas, componentes y sus dependencias.

#### 3.3.1. Diagrama de arquitectura software (paquetes)

**Estructura de Paquetes Frontend (Flutter)**

```
rideupt_app/
│
├── lib/
│   ├── api/
│   │   └── api_service.dart           [Paquete: API Communication]
│   │
│   ├── models/                        [Paquete: Data Models]
│   │   ├── user.dart
│   │   ├── trip.dart
│   │   ├── rating.dart
│   │   └── driver_document.dart
│   │
│   ├── providers/                     [Paquete: State Management]
│   │   ├── auth_provider.dart
│   │   └── trip_provider.dart
│   │
│   ├── screens/                       [Paquete: Presentation]
│   │   ├── auth/
│   │   │   ├── login_screen.dart
│   │   │   └── register_screen.dart
│   │   ├── home/
│   │   │   └── home_screen.dart
│   │   ├── trips/
│   │   │   ├── create_trip_screen.dart
│   │   │   ├── search_trip_screen.dart
│   │   │   └── trip_detail_screen.dart
│   │   ├── profile/
│   │   │   └── profile_screen.dart
│   │   └── admin/
│   │       └── admin_panel_screen.dart
│   │
│   ├── services/                      [Paquete: Business Logic]
│   │   ├── socket_service.dart
│   │   ├── notification_service.dart
│   │   ├── google_auth_service.dart
│   │   └── chat_service.dart
│   │
│   ├── widgets/                       [Paquete: UI Components]
│   │   ├── trip_card.dart
│   │   ├── rating_widget.dart
│   │   └── admin/
│   │
│   ├── utils/                         [Paquete: Utilities]
│   │   ├── app_config.dart
│   │   └── directions_service.dart
│   │
│   └── theme/                         [Paquete: Theming]
│       └── app_theme.dart
│
└── pubspec.yaml                       [Dependencies Management]
```

**Estructura de Paquetes Backend (Node.js)**

```
rideupt-backend/
│
├── config/                            [Paquete: Configuration]
│   ├── database.js
│   ├── storage.js
│   └── firebase-service-account.json
│
├── controllers/                       [Paquete: Business Logic]
│   ├── authController.js
│   ├── userController.js
│   ├── tripController.js
│   ├── ratingController.js
│   ├── adminController.js
│   └── dashboardController.js
│
├── models/                            [Paquete: Data Models]
│   ├── User.js
│   ├── Trip.js
│   └── Rating.js
│
├── routes/                            [Paquete: API Routes]
│   ├── auth.js
│   ├── users.js
│   ├── trips.js
│   ├── ratings.js
│   ├── admin.js
│   └── dashboard.js
│
├── services/                          [Paquete: External Services]
│   ├── socketService.js
│   ├── notificationService.js
│   └── tripChatService.js
│
├── middleware/                        [Paquete: Middleware]
│   ├── auth.js
│   └── errorHandler.js
│
├── server.js                          [Entry Point]
└── package.json                       [Dependencies Management]
```

#### 3.3.2. Diagrama de arquitectura del sistema (Diagrama de componentes)

```
┌──────────────────────────────────────────────────────────────────┐
│                   COMPONENTES DEL SISTEMA                        │
│                                                                   │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │           COMPONENTE: CLIENTE (Flutter App)                │ │
│  │  ┌──────────────────────────────────────────────────────┐  │ │
│  │  │  Subcomponente: Presentation Layer                   │  │ │
│  │  │  • Screens, Widgets, Themes                          │  │ │
│  │  └──────────────────────────────────────────────────────┘  │ │
│  │  ┌──────────────────────────────────────────────────────┐  │ │
│  │  │  Subcomponente: State Management                     │  │ │
│  │  │  • AuthProvider, TripProvider                        │  │ │
│  │  └──────────────────────────────────────────────────────┘  │ │
│  │  ┌──────────────────────────────────────────────────────┐  │ │
│  │  │  Subcomponente: Services                             │  │ │
│  │  │  • ApiService, SocketService, NotificationService    │  │ │
│  │  └──────────────────────────────────────────────────────┘  │ │
│  └────────────────────────────────────────────────────────────┘ │
│                            │                                     │
│              ┌─────────────┴─────────────┐                      │
│              │                           │                      │
│      ┌───────▼────────┐          ┌───────▼────────┐            │
│      │  REST API      │          │  WebSocket     │            │
│      │  (HTTPS)       │          │  (Socket.io)   │            │
│      └───────┬────────┘          └───────┬────────┘            │
│              │                           │                      │
│  ┌───────────┴───────────────────────────┴──────────┐          │
│  │      COMPONENTE: SERVIDOR (Node.js)              │          │
│  │  ┌────────────────────────────────────────────┐  │          │
│  │  │  Subcomponente: API Layer                  │  │          │
│  │  │  • Routes, Controllers, Middleware         │  │          │
│  │  └────────────────────────────────────────────┘  │          │
│  │  ┌────────────────────────────────────────────┐  │          │
│  │  │  Subcomponente: Business Logic             │  │          │
│  │  │  • Trip Management, User Management        │  │          │
│  │  └────────────────────────────────────────────┘  │          │
│  │  ┌────────────────────────────────────────────┐  │          │
│  │  │  Subcomponente: Services                   │  │          │
│  │  │  • SocketService, NotificationService      │  │          │
│  │  └────────────────────────────────────────────┘  │          │
│  │  ┌────────────────────────────────────────────┐  │          │
│  │  │  Subcomponente: Data Access                │  │          │
│  │  │  • Mongoose ODM, Models                    │  │          │
│  │  └────────────────────────────────────────────┘  │          │
│  └──────────────────────────────────────────────────┘          │
│                            │                                     │
│              ┌─────────────┴─────────────┐                      │
│              │                           │                      │
│      ┌───────▼────────┐          ┌───────▼────────┐            │
│      │   MONGODB      │          │   FIREBASE     │            │
│      │   Atlas        │          │   Services     │            │
│      │                │          │                │            │
│      │ • Users        │          │ • Auth         │            │
│      │ • Trips        │          │ • FCM          │            │
│      │ • Ratings      │          │ • Hosting      │            │
│      └────────────────┘          └────────────────┘            │
│                                                                   │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │      COMPONENTE: SERVICIOS EXTERNOS                        │ │
│  │  • Google Maps API                                         │ │
│  │  • Google Geocoding API                                    │ │
│  │  • Firebase Cloud Messaging                                │ │
│  └────────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────────┘

Interfaces entre Componentes:
• Cliente ↔ Servidor: REST API (HTTP/HTTPS), WebSocket (Socket.io)
• Servidor ↔ MongoDB: Mongoose ODM
• Servidor ↔ Firebase: Firebase Admin SDK
• Cliente ↔ Firebase: Firebase SDK (Auth, FCM)
• Cliente ↔ Google Maps: Google Maps SDK
```

---

### 3.4. Vista de procesos

Esta vista describe los aspectos dinámicos del sistema, flujos de ejecución, concurrencia y sincronización.

#### 3.4.1. Diagrama de Procesos del sistema (diagrama de actividad)

**Proceso: Crear y Gestionar Viaje Completo**

```
┌─────────────────────────────────────────────────────────────────┐
│              PROCESO: CREAR Y GESTIONAR VIAJE                   │
└─────────────────────────────────────────────────────────────────┘

                    [Inicio]
                       │
                       ▼
        ┌──────────────────────────────┐
        │ Conductor inicia creación    │
        │ de viaje                     │
        └──────────────┬───────────────┘
                       │
                       ▼
        ┌──────────────────────────────┐
        │ ¿Conductor aprobado?         │
        └──────────────┬───────────────┘
                       │
            ┌──────────┴──────────┐
           NO                     SÍ
            │                      │
            ▼                      ▼
    ┌───────────────┐    ┌────────────────────┐
    │ Mostrar error │    │ Obtener ubicación  │
    │               │    │ actual (GPS)       │
    └───────┬───────┘    └─────────┬──────────┘
            │                      │
            │                      ▼
            │          ┌────────────────────┐
            │          │ ¿Ubicación válida? │
            │          └─────────┬──────────┘
            │                    │
            │          ┌─────────┴──────────┐
            │         NO                    SÍ
            │          │                     │
            │          ▼                     ▼
            │    ┌──────────────┐   ┌──────────────────┐
            │    │ Solicitar    │   │ Conductor ingresa│
            │    │ permiso GPS  │   │ destino, hora,   │
            │    └──────────────┘   │ precio, asientos │
            │                       └────────┬─────────┘
            │                                │
            │                                ▼
            │                    ┌────────────────────┐
            │                    │ Validar datos de   │
            │                    │ viaje              │
            │                    └────────┬───────────┘
            │                             │
            │                    ┌─────────┴──────────┐
            │                   NO                    SÍ
            │                    │                     │
            │                    ▼                     ▼
            │            ┌──────────────┐   ┌──────────────────┐
            │            │ Mostrar      │   │ Guardar viaje    │
            │            │ errores      │   │ en MongoDB       │
            │            └──────────────┘   └────────┬─────────┘
            │                                       │
            │                                       ▼
            │                           ┌──────────────────┐
            │                           │ Calcular         │
            │                           │ expiresAt = now  │
            │                           │ + 10 minutos     │
            │                           └────────┬─────────┘
            │                                    │
            │                                    ▼
            │                           ┌──────────────────┐
            │                           │ Programar        │
            │                           │ expiración       │
            │                           │ (timer 10 min)   │
            │                           └────────┬─────────┘
            │                                    │
            │                                    ▼
            │                           ┌──────────────────┐
            │                           │ Enviar           │
            │                           │ notificaciones   │
            │                           │ push a pasajeros │
            │                           └────────┬─────────┘
            │                                    │
            │                                    ▼
            │                           ┌──────────────────┐
            │                           │ Emitir evento    │
            │                           │ 'newTrip' vía    │
            │                           │ WebSocket        │
            │                           └────────┬─────────┘
            │                                    │
            └────────────────────────────────────┘
                       │
                       ▼
        ┌──────────────────────────────┐
        │ Viaje disponible para        │
        │ búsqueda                     │
        └──────────────┬───────────────┘
                       │
                       ▼
        ┌──────────────────────────────┐
        │ ¿Pasajero solicita reserva?  │
        └──────────────┬───────────────┘
                       │
            ┌──────────┴──────────┐
          NO                     SÍ
            │                      │
            │                      ▼
            │          ┌────────────────────┐
            │          │ Agregar pasajero   │
            │          │ con status         │
            │          │ 'pending'          │
            │          └─────────┬──────────┘
            │                    │
            │                    ▼
            │          ┌────────────────────┐
            │          │ Notificar          │
            │          │ conductor          │
            │          └─────────┬──────────┘
            │                    │
            │                    ▼
            │          ┌────────────────────┐
            │          │ ¿Conductor acepta? │
            │          └─────────┬──────────┘
            │                    │
            │          ┌─────────┴──────────┐
            │         NO                    SÍ
            │          │                     │
            │          ▼                     ▼
            │    ┌──────────────┐   ┌──────────────────┐
            │    │ Rechazar     │   │ Cambiar status   │
            │    │ solicitud    │   │ a 'confirmed'    │
            │    │              │   │                  │
            │    │              │   │ Incrementar      │
            │    │              │   │ seatsBooked      │
            │    └──────┬───────┘   └────────┬─────────┘
            │           │                    │
            │           │                    ▼
            │           │          ┌──────────────────┐
            │           │          │ ¿Viaje completo? │
            │           │          │ (seatsBooked =   │
            │           │          │ availableSeats)  │
            │           │          └────────┬─────────┘
            │           │                   │
            │           │          ┌─────────┴──────────┐
            │           │         NO                    SÍ
            │           │          │                     │
            │           │          │                     ▼
            │           │          │          ┌──────────────────┐
            │           │          │          │ Cambiar status   │
            │           │          │          │ a 'completo'     │
            │           │          │          └────────┬─────────┘
            │           │          │                   │
            │           └──────────┴───────────────────┘
            │                      │
            │                      ▼
            │          ┌────────────────────┐
            │          │ Notificar          │
            │          │ todos los          │
            │          │ participantes      │
            │          └─────────┬──────────┘
            │                    │
            │                    ▼
            │          ┌────────────────────┐
            │          │ ¿Han pasado        │
            │          │ 10 minutos?        │
            │          └─────────┬──────────┘
            │                    │
            │          ┌─────────┴──────────┐
            │         NO                    SÍ
            │          │                     │
            │          │                     ▼
            │          │          ┌──────────────────┐
            │          │          │ ¿Hay pasajeros?  │
            │          │          └────────┬─────────┘
            │          │                   │
            │          │          ┌─────────┴──────────┐
            │          │         SÍ                    NO
            │          │          │                     │
            │          │          │                     ▼
            │          │          │          ┌──────────────────┐
            │          │          │          │ Cambiar status   │
            │          │          │          │ a 'expirado'     │
            │          │          │          │                  │
            │          │          │          │ Notificar        │
            │          │          │          │ conductor        │
            │          │          │          └────────┬─────────┘
            │          │          │                   │
            │          └──────────┴───────────────────┘
            │                      │
            └──────────────────────┘
                       │
                       ▼
                   [Fin]
```

---

### 3.5. Vista de Despliegue (vista física)

Esta vista describe la distribución física del sistema en nodos de hardware, servidores y redes.

#### 3.5.1. Diagrama de despliegue

```
┌──────────────────────────────────────────────────────────────────┐
│                    INFRAESTRUCTURA FÍSICA                        │
│                                                                   │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │                    INTERNET                                │ │
│  └───────────────────────────┬────────────────────────────────┘ │
│                              │                                    │
│                ┌─────────────┴─────────────┐                    │
│                │                           │                    │
│  ┌─────────────▼──────────┐   ┌────────────▼──────────┐       │
│  │  DISPOSITIVOS CLIENTE  │   │  SERVIDORES CLOUD     │       │
│  │                         │   │                       │       │
│  │  ┌──────────────────┐  │   │  ┌──────────────────┐ │       │
│  │  │ Android Device   │  │   │  │ VPS/Cloud Server │ │       │
│  │  │ • Flutter App    │  │   │  │ (Node.js Backend)│ │       │
│  │  │ • Google Maps    │  │   │  │                  │ │       │
│  │  │ • Firebase SDK   │  │   │  │ • Express Server │ │       │
│  │  └──────────────────┘  │   │  │ • Socket.io      │ │       │
│  │                         │   │  │ • Nginx          │ │       │
│  │  ┌──────────────────┐  │   │  │ • SSL/TLS        │ │       │
│  │  │ iOS Device       │  │   │  └────────┬─────────┘ │       │
│  │  │ • Flutter App    │  │   │           │           │       │
│  │  │ • Google Maps    │  │   │           │           │       │
│  │  │ • Firebase SDK   │  │   │           │           │       │
│  │  └──────────────────┘  │   │           │           │       │
│  │                         │   │           │           │       │
│  │  ┌──────────────────┐  │   │  ┌────────▼─────────┐ │       │
│  │  │ Web Browser      │  │   │  │ MongoDB Atlas    │ │       │
│  │  │ • Flutter Web    │  │   │  │ (Cloud Database) │ │       │
│  │  │ • Firebase Host  │  │   │  │                  │ │       │
│  │  └──────────────────┘  │   │  │ • Cluster M0/M10 │ │       │
│  │                         │   │  │ • Replicación    │ │       │
│  └─────────────────────────┘   │  │ • Backups        │ │       │
│                                 │  └──────────────────┘ │       │
│                                 │                       │       │
│                                 │  ┌──────────────────┐ │       │
│                                 │  │ Firebase Cloud   │ │       │
│                                 │  │                  │ │       │
│                                 │  │ • Authentication │ │       │
│                                 │  │ • Cloud Messaging│ │       │
│                                 │  │ • Hosting (Web)  │ │       │
│                                 │  │ • Storage        │ │       │
│                                 │  └──────────────────┘ │       │
│                                 │                       │       │
│                                 │  ┌──────────────────┐ │       │
│                                 │  │ Google Cloud     │ │       │
│                                 │  │                  │ │       │
│                                 │  │ • Maps API       │ │       │
│                                 │  │ • Geocoding API  │ │       │
│                                 │  │ • Directions API │ │       │
│                                 │  └──────────────────┘ │       │
│                                 │                       │       │
│                                 └───────────────────────┘       │
│                                                                   │
│  Comunicación:                                                   │
│  • Cliente ↔ Servidor: HTTPS (Puerto 443), WebSocket            │
│  • Servidor ↔ MongoDB: mongodb+srv (Puerto 27017)               │
│  • Servidor ↔ Firebase: HTTPS (API REST)                        │
│  • Cliente ↔ Firebase: HTTPS, WebSocket (FCM)                   │
│  • Cliente ↔ Google Maps: HTTPS (API REST)                      │
└──────────────────────────────────────────────────────────────────┘

Especificaciones de Despliegue:

Servidor Backend:
• Tipo: VPS o Cloud Instance (DigitalOcean, AWS, Azure)
• CPU: Mínimo 2 vCPU
• RAM: Mínimo 2GB
• Almacenamiento: 20GB SSD
• Sistema Operativo: Ubuntu 20.04 LTS o superior
• Runtime: Node.js 18.x
• Proxy: Nginx con SSL/TLS

MongoDB Atlas:
• Plan: M0 (Gratis) o M10 ($57/mes)
• Región: América del Sur
• Replicación: 3 nodos
• Backups: Automáticos diarios

Firebase:
• Plan: Spark (Gratis) o Blaze (Pay as you go)
• Límites generosos para uso inicial

Google Cloud:
• API Keys para Maps, Geocoding
• Límites gratuitos disponibles
```

---

## 4. ATRIBUTOS DE CALIDAD DEL SOFTWARE

Esta sección describe los escenarios de calidad que el sistema debe cumplir, basados en los Requerimientos No Funcionales (RNF).

### 4.1. Escenario de Funcionalidad

**Atributo**: Funcionalidad  
**Requerimiento**: RNF001 (Implícito en RF001-RF008)

**Escenario**: El sistema debe cumplir con todos los requerimientos funcionales especificados.

**Estímulo**: Usuario interactúa con el sistema para realizar operaciones funcionales.

**Ambiente**: Sistema en operación normal, usuario autenticado.

**Respuesta**:
- Todas las funcionalidades (RF001-RF008) están disponibles y operativas
- El sistema procesa correctamente todas las operaciones
- Los datos se almacenan y recuperan correctamente

**Medición**:
- Cobertura de requerimientos funcionales: 100% (8/8 RF implementados)
- Tasa de éxito de operaciones: > 99%
- Errores funcionales: < 1%

**Justificación**: El sistema implementa completamente los 8 requerimientos funcionales priorizados, garantizando que todas las funcionalidades críticas estén disponibles.

---

### 4.2. Escenario de Usabilidad

**Atributo**: Usabilidad  
**Requerimiento**: RNF001

**Escenario**: Un nuevo usuario debe poder usar el sistema efectivamente con un tiempo de aprendizaje menor a 3 minutos.

**Estímulo**: Usuario nuevo accede al sistema por primera vez.

**Ambiente**: Usuario con conocimiento básico de aplicaciones móviles, sin experiencia previa con RideUPT.

**Respuesta**:
- Interfaz intuitiva con navegación clara
- Mensajes y guías visuales claras
- Tiempo de aprendizaje < 3 minutos
- Onboarding guiado para nuevos usuarios
- Feedback visual inmediato en todas las acciones

**Medición**:
- Tiempo promedio de aprendizaje: < 3 minutos
- Tasa de completación de onboarding: > 90%
- Satisfacción del usuario (SUS Score): > 80
- Errores de usuario: < 5%

**Justificación**: Flutter Material Design proporciona componentes estándar familiares, y un diseño UX cuidadoso garantiza que usuarios nuevos puedan usar el sistema rápidamente sin capacitación extensa.

---

### 4.3. Escenario de confiabilidad

**Atributo**: Confiabilidad (Disponibilidad)  
**Requerimiento**: RNF003

**Escenario**: El sistema debe mantener un uptime del 99.5%, estando disponible 24/7 para la comunidad universitaria.

**Estímulo**: Usuario intenta acceder al sistema en cualquier momento.

**Ambiente**: Sistema en producción, bajo carga normal, servicios cloud operativos.

**Respuesta**:
- Sistema disponible 99.5% del tiempo
- Tiempo de recuperación ante fallos < 5 minutos
- Backups automáticos diarios
- Monitoreo continuo con alertas
- Redundancia en servicios críticos

**Medición**:
- Uptime objetivo: 99.5% (máximo 43.8 horas de downtime anual)
- Tiempo medio de recuperación (MTTR): < 5 minutos
- Tiempo medio entre fallos (MTBF): > 720 horas
- Frecuencia de backups: Diario automático

**Justificación**: 
- Firebase Hosting garantiza 99.95% uptime
- MongoDB Atlas M10+ ofrece 99.95% SLA
- Servidor VPS con monitoreo y auto-recovery
- Health checks y alertas proactivas

---

### 4.4. Escenario de rendimiento

**Atributo**: Rendimiento  
**Requerimiento**: RNF002

**Escenario**: Las operaciones principales del sistema deben responder en menos de 2 segundos.

**Estímulo**: Usuario realiza operación principal (búsqueda de viajes, creación de viaje, autenticación).

**Ambiente**: Sistema bajo carga normal (100-500 usuarios concurrentes), conexión a internet estable.

**Respuesta**:
- Tiempo de respuesta para operaciones principales: < 2 segundos
- Búsqueda de viajes: < 1 segundo
- Autenticación: < 1.5 segundos
- Creación de viaje: < 2 segundos
- Notificaciones push: < 1 segundo

**Medición**:
- Tiempo promedio de respuesta API: < 2 segundos
- Tiempo p95 (95% de requests): < 3 segundos
- Tiempo p99 (99% de requests): < 5 segundos
- Throughput: > 100 requests/segundo

**Justificación**:
- Índices optimizados en MongoDB (geoespacial, estado, fecha)
- Pool de conexiones configurado (máx 50 conexiones)
- Caché en cliente (SharedPreferences)
- Compresión de respuestas HTTP
- Lazy loading en frontend

---

### 4.5. Escenario de mantenibilidad

**Atributo**: Mantenibilidad  
**Requerimiento**: Implícito (mejoras continuas)

**Escenario**: El sistema debe ser fácilmente mantenible y extensible para agregar nuevas funcionalidades.

**Estímulo**: Desarrollador necesita agregar nueva funcionalidad o corregir un bug.

**Ambiente**: Código fuente organizado, documentación disponible, equipo de desarrollo familiarizado.

**Respuesta**:
- Código modular y bien organizado
- Separación clara de responsabilidades (MVC, Provider Pattern)
- Documentación técnica completa
- Tests unitarios y de integración
- Facilidad para agregar nuevas funcionalidades

**Medición**:
- Cobertura de código con tests: > 70%
- Complejidad ciclomática promedio: < 10
- Tiempo para agregar nueva funcionalidad: < 1 semana
- Tasa de bugs después de cambios: < 5%

**Justificación**:
- Arquitectura modular con separación frontend/backend
- Uso de patrones de diseño establecidos (Provider, MVC)
- Código documentado y comentado
- Estructura de carpetas clara y consistente
- Control de versiones (Git) con ramas bien definidas

---

### 4.6. Otros Escenarios

#### 4.6.1. Escenario de Seguridad

**Atributo**: Seguridad  
**Requerimiento**: RNF004

**Escenario**: El sistema debe proteger los datos personales y garantizar la seguridad de las transacciones.

**Estímulo**: Usuario autenticado realiza operaciones, atacante intenta acceso no autorizado.

**Ambiente**: Sistema en producción, conexiones seguras, autenticación activa.

**Respuesta**:
- Autenticación JWT con expiración
- Encriptación HTTPS/TLS para datos en tránsito
- Contraseñas hasheadas con bcrypt
- Validación de entrada en todos los endpoints
- CORS configurado para orígenes permitidos
- Rate limiting para prevenir ataques

**Medición**:
- Tasa de autenticaciones fallidas: < 1%
- Incidentes de seguridad: 0
- Vulnerabilidades críticas: 0
- Cumplimiento de protección de datos: 100%

**Justificación**:
- JWT tokens con expiración de 30 días
- HTTPS obligatorio en todas las comunicaciones
- Bcrypt con salt rounds = 10
- Validación con express-validator
- Firebase Auth con encriptación end-to-end

---

#### 4.6.2. Escenario de Escalabilidad

**Atributo**: Escalabilidad  
**Requerimiento**: RNF005

**Escenario**: El sistema debe soportar el crecimiento de usuarios sin degradación significativa del rendimiento.

**Estímulo**: Número de usuarios concurrentes aumenta de 100 a 1000.

**Ambiente**: Infraestructura cloud escalable, sistema en producción.

**Respuesta**:
- Arquitectura stateless permite escalado horizontal
- Base de datos escalable (MongoDB Atlas)
- Pool de conexiones configurables
- Caché para reducir carga en base de datos
- Balanceador de carga para múltiples instancias

**Medición**:
- Capacidad de usuarios concurrentes: > 1000
- Tiempo de respuesta bajo carga: < 3 segundos
- Escalado horizontal: Posible sin cambios arquitectónicos
- Utilización de recursos: < 70% bajo carga normal

**Justificación**:
- API stateless permite múltiples instancias
- MongoDB Atlas escala automáticamente
- Pool de conexiones configurado dinámicamente
- Arquitectura cloud-native preparada para crecimiento

---

#### 4.6.3. Escenario de Portabilidad

**Atributo**: Portabilidad

**Escenario**: El sistema debe funcionar en múltiples plataformas (Android, iOS, Web) con un solo código base.

**Estímulo**: Usuario accede desde diferentes dispositivos y plataformas.

**Ambiente**: Diferentes sistemas operativos, diferentes navegadores.

**Respuesta**:
- Funcionalidad idéntica en todas las plataformas
- Adaptación automática a diferentes tamaños de pantalla
- Compatibilidad con Android 6.0+, iOS 12.0+, navegadores modernos

**Medición**:
- Cobertura de plataformas: Android, iOS, Web
- Tasa de compatibilidad: > 95% en dispositivos objetivo
- Bugs específicos de plataforma: < 5%

**Justificación**:
- Flutter permite desarrollo multiplataforma con un solo código
- Material Design adaptativo
- Testing en múltiples dispositivos y navegadores
- SDKs nativos para funcionalidades específicas

---

**Versión del Documento**: 1.0  
**Fecha**: 2025  
**Elaborado por**: Equipo de Desarrollo RideUPT  
**Revisado por**: Departamento de TI - UPT  
**Aprobado por**: Dirección de la Universidad Privada de Tacna

