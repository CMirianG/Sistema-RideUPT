# 🏗️ Arquitectura del Sistema RideUPT

## 📋 Tabla de Contenidos

1. [Visión General](#visión-general)
2. [Arquitectura General](#arquitectura-general)
3. [Arquitectura Frontend (Flutter)](#arquitectura-frontend-flutter)
4. [Arquitectura Backend (Node.js)](#arquitectura-backend-nodejs)
5. [Patrones de Diseño](#patrones-de-diseño)
6. [Flujo de Datos](#flujo-de-datos)
7. [Comunicación entre Componentes](#comunicación-entre-componentes)
8. [Base de Datos](#base-de-datos)
9. [Servicios Externos](#servicios-externos)
10. [Estructura de Carpetas](#estructura-de-carpetas)

---

## 🎯 Visión General

RideUPT es una aplicación de carpooling universitario desarrollada con una **arquitectura cliente-servidor** que separa completamente el frontend del backend, permitiendo escalabilidad y mantenibilidad.

### Stack Tecnológico Principal

```
Frontend:  Flutter (Dart) - Multiplataforma (Android, iOS, Web)
Backend:   Node.js + Express.js - API REST + WebSockets
Base de Datos: MongoDB (Mongoose ODM)
Comunicación: REST API + Socket.io (WebSockets)
Autenticación: JWT + Firebase Auth
Notificaciones: Firebase Cloud Messaging (FCM)
Almacenamiento: Google Cloud Storage / Firebase Storage
```

---

## 🏛️ Arquitectura General

### Diagrama de Alto Nivel

```
┌─────────────────────────────────────────────────────────────┐
│                    CLIENTE (Flutter App)                     │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │   Android    │  │     iOS      │  │     Web      │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐  │
│  │         Provider (State Management)                  │  │
│  │  ┌──────────────┐         ┌──────────────┐          │  │
│  │  │AuthProvider  │         │TripProvider  │          │  │
│  │  └──────────────┘         └──────────────┘          │  │
│  └─────────────────────────────────────────────────────┘  │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐  │
│  │              Services Layer                           │  │
│  │  ApiService │ SocketService │ NotificationService     │  │
│  └─────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                            │
                    ┌───────┴───────┐
                    │               │
            ┌───────▼──────┐ ┌──────▼──────┐
            │   REST API   │ │  WebSockets │
            │  (HTTP/HTTPS)│ │ (Socket.io)│
            └───────┬──────┘ └──────┬──────┘
                    │               │
┌───────────────────▼───────────────▼───────────────────────┐
│                  BACKEND (Node.js)                          │
│  ┌─────────────────────────────────────────────────────┐  │
│  │              Express Server                           │  │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐           │  │
│  │  │ Routes   │  │Middleware│  │Controllers│           │  │
│  │  └──────────┘  └──────────┘  └──────────┘           │  │
│  └─────────────────────────────────────────────────────┘  │
│                                                              │
│  ┌─────────────────────────────────────────────────────┐  │
│  │              Services Layer                           │  │
│  │  SocketService │ NotificationService │ ChatService   │  │
│  └─────────────────────────────────────────────────────┘  │
│                                                              │
│  ┌─────────────────────────────────────────────────────┐  │
│  │              Models (Mongoose)                        │  │
│  │  User │ Trip │ Rating │ DriverDocument               │  │
│  └─────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────┘
                            │
                    ┌───────┴───────┐
                    │               │
        ┌───────────▼──────┐ ┌──────▼──────────┐
        │    MongoDB        │ │  Firebase       │
        │   (Base de Datos) │ │  (Auth, FCM)    │
        └───────────────────┘ └─────────────────┘
```

---

## 📱 Arquitectura Frontend (Flutter)

### Patrón Arquitectónico: **Provider Pattern (State Management)**

El frontend utiliza el patrón **Provider** de Flutter para la gestión de estado, siguiendo una arquitectura en capas:

```
┌─────────────────────────────────────────┐
│         Presentation Layer               │
│  (Screens, Widgets, UI Components)      │
└─────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────┐
│         State Management Layer           │
│  (Providers: AuthProvider, TripProvider) │
└─────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────┐
│         Service Layer                   │
│  (ApiService, SocketService, etc.)     │
└─────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────┐
│         Data Layer                      │
│  (Models, API Calls, Local Storage)     │
└─────────────────────────────────────────┘
```

### Componentes Principales

#### 1. **Providers (Gestión de Estado)**
- **`AuthProvider`**: Maneja autenticación, sesión de usuario, tokens
- **`TripProvider`**: Gestiona viajes disponibles, mis viajes, operaciones de viajes

**Características:**
- Heredan de `ChangeNotifier`
- Notifican cambios a los widgets suscritos
- Manejan estados de carga y errores
- Persisten datos en `SharedPreferences`

#### 2. **Services (Capa de Servicios)**
- **`ApiService`**: Cliente HTTP para comunicación REST
- **`SocketService`**: Cliente WebSocket para tiempo real
- **`NotificationService`**: Gestión de notificaciones push
- **`GoogleAuthService`**: Autenticación con Google
- **`ChatService`**: Servicio de chat en tiempo real
- **`RatingService`**: Gestión de calificaciones

#### 3. **Models (Modelos de Datos)**
- **`User`**: Modelo de usuario
- **`Trip`**: Modelo de viaje con helpers de estado
- **`Rating`**: Modelo de calificación
- **`DriverDocument`**: Modelo de documento de conductor

#### 4. **Screens (Pantallas)**
Organizadas por funcionalidad:
- `auth/`: Autenticación y login
- `home/`: Pantalla principal y navegación
- `trips/`: Gestión de viajes
- `profile/`: Perfil de usuario
- `admin/`: Panel de administración
- `chat/`: Chat de viajes

#### 5. **Widgets (Componentes Reutilizables)**
- Componentes UI reutilizables
- Widgets específicos (TripCard, RatingWidget, etc.)
- Widgets de administración para web

### Flujo de Estado en Frontend

```
Usuario Interactúa
        │
        ▼
┌───────────────┐
│   Screen/UI   │
└───────┬───────┘
        │
        ▼
┌───────────────┐
│   Provider    │ ──► Cambia estado
└───────┬───────┘
        │
        ▼
┌───────────────┐
│   Service     │ ──► Llama API/WebSocket
└───────┬───────┘
        │
        ▼
┌───────────────┐
│   Backend     │ ──► Procesa y responde
└───────┬───────┘
        │
        ▼
┌───────────────┐
│   Provider    │ ──► Actualiza estado
└───────┬───────┘
        │
        ▼
┌───────────────┐
│   Screen/UI   │ ──► Se actualiza automáticamente
└───────────────┘
```

---

## 🖥️ Arquitectura Backend (Node.js)

### Patrón Arquitectónico: **MVC (Model-View-Controller)**

El backend sigue el patrón **MVC** con una estructura modular:

```
┌─────────────────────────────────────────┐
│         Routes Layer                    │
│  (Definición de endpoints REST)         │
└─────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────┐
│         Middleware Layer                 │
│  (Auth, Error Handling, Validation)     │
└─────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────┐
│         Controllers Layer                │
│  (Lógica de negocio)                     │
└─────────────────────────────────────────┘
                    │
        ┌───────────┴───────────┐
        │                       │
        ▼                       ▼
┌───────────────┐      ┌───────────────┐
│   Models      │      │   Services    │
│  (Mongoose)   │      │ (Business)    │
└───────────────┘      └───────────────┘
        │                       │
        └───────────┬───────────┘
                    ▼
┌─────────────────────────────────────────┐
│         Database (MongoDB)               │
└─────────────────────────────────────────┘
```

### Componentes Principales

#### 1. **Routes (Rutas)**
Definen los endpoints de la API:
- `routes/auth.js`: Autenticación
- `routes/users.js`: Gestión de usuarios
- `routes/trips.js`: Gestión de viajes
- `routes/ratings.js`: Calificaciones
- `routes/admin.js`: Panel de administración
- `routes/dashboard.js`: Dashboard
- `routes/driverDocuments.js`: Documentos de conductores

#### 2. **Controllers (Controladores)**
Contienen la lógica de negocio:
- `authController.js`: Login, registro, Google Sign-In
- `userController.js`: CRUD de usuarios, perfil de conductor
- `tripController.js`: Crear, buscar, gestionar viajes
- `ratingController.js`: Calificaciones
- `adminController.js`: Aprobación de conductores, estadísticas
- `dashboardController.js`: Estadísticas del dashboard

#### 3. **Models (Modelos)**
Esquemas de Mongoose:
- `User.js`: Usuario con roles (passenger/driver)
- `Trip.js`: Viaje con geolocalización
- `Rating.js`: Calificaciones

#### 4. **Services (Servicios)**
Lógica de negocio compleja:
- `socketService.js`: Gestión de WebSockets
- `notificationService.js`: Notificaciones push (FCM)
- `tripChatService.js`: Chat de viajes

#### 5. **Middleware**
- `auth.js`: Autenticación JWT
- `errorHandler.js`: Manejo global de errores

#### 6. **Config**
- `database.js`: Conexión a MongoDB
- `storage.js`: Configuración de almacenamiento

### Flujo de Petición en Backend

```
Cliente envía petición HTTP
        │
        ▼
┌───────────────┐
│   Express     │ ──► Recibe petición
└───────┬───────┘
        │
        ▼
┌───────────────┐
│   CORS        │ ┌─► Valida origen
│   Middleware  │
└───────┬───────┘
        │
        ▼
┌───────────────┐
│   Auth        │ ┌─► Valida token JWT
│   Middleware  │
└───────┬───────┘
        │
        ▼
┌───────────────┐
│   Route       │ ┌─► Enruta a controlador
└───────┬───────┘
        │
        ▼
┌───────────────┐
│  Controller   │ ┌─► Ejecuta lógica de negocio
└───────┬───────┘
        │
        ▼
┌───────────────┐
│   Model       │ ┌─► Interactúa con MongoDB
│   / Service   │
└───────┬───────┘
        │
        ▼
┌───────────────┐
│   Response    │ ┌─► Retorna JSON
└───────────────┘
```

---

## 🎨 Patrones de Diseño

### Frontend

1. **Provider Pattern (State Management)**
   - Gestión centralizada del estado
   - Reactividad automática
   - Separación de lógica y UI

2. **Repository Pattern (Implícito)**
   - `ApiService` actúa como repositorio
   - Abstrae la comunicación con el backend

3. **Service Layer Pattern**
   - Servicios especializados por funcionalidad
   - Reutilización de código
   - Fácil testing

4. **Widget Composition**
   - Componentes reutilizables
   - Separación de responsabilidades

### Backend

1. **MVC (Model-View-Controller)**
   - Separación clara de responsabilidades
   - Mantenibilidad

2. **Middleware Pattern**
   - Autenticación, validación, manejo de errores
   - Reutilización de lógica transversal

3. **Service Layer Pattern**
   - Lógica de negocio compleja en servicios
   - Controllers delgados

4. **Repository Pattern (Implícito)**
   - Mongoose abstrae el acceso a datos

---

## 🔄 Flujo de Datos

### Autenticación

```
1. Usuario ingresa credenciales
        │
        ▼
2. Frontend: AuthProvider.login()
        │
        ▼
3. ApiService.post('/auth/login')
        │
        ▼
4. Backend: authController.login()
        │
        ▼
5. Valida credenciales en MongoDB
        │
        ▼
6. Genera token JWT
        │
        ▼
7. Retorna token al frontend
        │
        ▼
8. Frontend guarda token en SharedPreferences
        │
        ▼
9. Inicializa SocketService con token
```

### Creación de Viaje

```
1. Conductor completa formulario
        │
        ▼
2. Frontend: Geolocator obtiene ubicación
        │
        ▼
3. TripProvider.createTrip()
        │
        ▼
4. ApiService.post('/api/trips')
        │
        ▼
5. Backend: tripController.createTrip()
        │
        ├─► Valida conductor aprobado
        ├─► Calcula expiresAt (10 min)
        ├─► Guarda en MongoDB
        ├─► Programa timeout de expiración
        └─► Envía notificaciones push
        │
        ▼
6. Retorna viaje creado
        │
        ▼
7. Frontend actualiza lista de viajes
        │
        ▼
8. Socket.io emite evento 'newTrip'
```

### Búsqueda de Viajes

```
1. Pasajero abre pantalla de búsqueda
        │
        ▼
2. TripProvider.fetchAvailableTrips()
        │
        ▼
3. ApiService.get('/api/trips')
        │
        ▼
4. Backend: tripController.getAvailableTrips()
        │
        ├─► Filtra por estado: ['esperando', 'completo']
        ├─► Filtra por expiresAt > now
        ├─► Popula datos de conductor y pasajeros
        └─► Ordena por fecha (más recientes)
        │
        ▼
5. Retorna lista de viajes
        │
        ▼
6. Frontend muestra viajes disponibles
        │
        ▼
7. Auto-refresh cada 10 segundos
```

---

## 📡 Comunicación entre Componentes

### REST API

**Protocolo:** HTTP/HTTPS  
**Formato:** JSON  
**Autenticación:** JWT Bearer Token

**Endpoints Principales:**
```
POST   /api/auth/register      - Registro
POST   /api/auth/login          - Login
POST   /api/auth/google         - Google Sign-In
GET    /api/users/profile       - Perfil de usuario
PUT    /api/users/driver-profile - Actualizar perfil conductor
GET    /api/trips               - Listar viajes disponibles
POST   /api/trips               - Crear viaje
GET    /api/trips/:id           - Detalle de viaje
PUT    /api/trips/:id/bookings/:passengerId - Gestionar solicitud
PUT    /api/trips/:id/start     - Iniciar viaje
PUT    /api/trips/:id/complete  - Completar viaje
GET    /api/ratings             - Calificaciones
POST   /api/ratings             - Crear calificación
GET    /api/admin/drivers        - Listar conductores (admin)
PUT    /api/admin/drivers/:id/approve - Aprobar conductor
```

### WebSockets (Socket.io)

**Protocolo:** WebSocket con fallback a polling  
**Autenticación:** JWT en handshake

**Eventos Principales:**
```javascript
// Cliente → Servidor
'sendChatMessage'      - Enviar mensaje de chat
'joinTripChat'         - Unirse al chat de un viaje
'leaveTripChat'        - Salir del chat

// Servidor → Cliente
'newChatMessage'       - Nuevo mensaje recibido
'tripUpdated'          - Viaje actualizado
'bookingStatusChanged' - Estado de solicitud cambió
'tripStarted'          - Viaje iniciado
'tripExpired'          - Viaje expirado
'tripChatClosed'       - Chat cerrado
```

### Notificaciones Push (FCM)

**Protocolo:** Firebase Cloud Messaging  
**Plataformas:** Android, iOS

**Tipos de Notificaciones:**
- Nuevo viaje disponible
- Solicitud aceptada/rechazada
- Viaje iniciado
- Nuevo mensaje de chat
- Conductor aprobado/rechazado

---

## 🗄️ Base de Datos

### MongoDB (NoSQL)

**ODM:** Mongoose  
**Índices Geoespaciales:** Para búsqueda por ubicación

### Esquemas Principales

#### User (Usuario)
```javascript
{
  firstName: String,
  lastName: String,
  email: String (único, lowercase),
  password: String (hasheado),
  phone: String,
  university: String,
  studentId: String,
  role: ['passenger', 'driver'],
  isAdmin: Boolean,
  driverApprovalStatus: ['pending', 'approved', 'rejected'],
  vehicle: {
    make: String,
    model: String,
    year: Number,
    color: String,
    licensePlate: String (único),
    totalSeats: Number
  },
  driverDocuments: [{
    tipoDocumento: String,
    urlImagen: String,
    subidoEn: Date
  }],
  fcmToken: String,
  averageRating: Number,
  totalRatings: Number,
  timestamps: true
}
```

#### Trip (Viaje)
```javascript
{
  driver: ObjectId (ref: User),
  origin: {
    type: 'Point',
    coordinates: [longitude, latitude],
    name: String
  },
  destination: {
    type: 'Point',
    coordinates: [longitude, latitude],
    name: String
  },
  departureTime: Date,
  expiresAt: Date,
  availableSeats: Number,
  seatsBooked: Number,
  pricePerSeat: Number,
  description: String,
  status: ['esperando', 'completo', 'en-proceso', 'completado', 'expirado', 'cancelado'],
  passengers: [{
    user: ObjectId (ref: User),
    status: ['pending', 'confirmed', 'rejected', 'cancelled'],
    bookedAt: Date,
    inVehicle: Boolean
  }],
  timestamps: true
}
```

#### Rating (Calificación)
```javascript
{
  trip: ObjectId (ref: Trip),
  rater: ObjectId (ref: User),
  rated: ObjectId (ref: User),
  rating: Number (1-5),
  comment: String,
  role: ['driver', 'passenger'],
  timestamps: true
}
```

### Índices

- `User.email`: Único
- `User.vehicle.licensePlate`: Único
- `Trip.origin`: Índice geoespacial 2dsphere
- `Trip.destination`: Índice geoespacial 2dsphere

---

## 🔌 Servicios Externos

### Firebase

1. **Firebase Authentication**
   - Google Sign-In
   - Verificación de tokens

2. **Firebase Cloud Messaging (FCM)**
   - Notificaciones push
   - Tokens de dispositivo

3. **Firebase Storage** (Opcional)
   - Almacenamiento de imágenes
   - Documentos de conductores

### Google Services

1. **Google Maps API**
   - Visualización de mapas
   - Geocodificación
   - Cálculo de rutas

2. **Google Sign-In**
   - Autenticación OAuth
   - Obtención de perfil

### Geolocalización

- **Geolocator** (Flutter): Obtención de ubicación GPS
- **Geocoding** (Flutter): Conversión coordenadas ↔ direcciones

---

## 📁 Estructura de Carpetas

### Frontend (`rideupt_app/lib/`)

```
lib/
├── api/
│   └── api_service.dart          # Cliente HTTP REST
├── models/
│   ├── user.dart                 # Modelo de usuario
│   ├── trip.dart                 # Modelo de viaje
│   ├── rating.dart               # Modelo de calificación
│   └── driver_document.dart      # Modelo de documento
├── providers/
│   ├── auth_provider.dart        # Estado de autenticación
│   └── trip_provider.dart        # Estado de viajes
├── screens/
│   ├── auth/                     # Autenticación
│   ├── home/                     # Pantalla principal
│   ├── trips/                    # Gestión de viajes
│   ├── profile/                  # Perfil de usuario
│   ├── admin/                    # Panel de administración
│   └── chat/                     # Chat de viajes
├── services/
│   ├── api_service.dart          # (duplicado en api/)
│   ├── socket_service.dart       # Cliente WebSocket
│   ├── notification_service.dart # Notificaciones push
│   ├── google_auth_service.dart  # Google Sign-In
│   └── chat_service.dart         # Servicio de chat
├── widgets/
│   ├── trip_card.dart            # Tarjeta de viaje
│   ├── rating_widget.dart        # Widget de calificación
│   └── admin/                    # Widgets de admin
├── utils/
│   ├── app_config.dart           # Configuración de la app
│   └── directions_service.dart   # Servicio de direcciones
└── theme/
    └── app_theme.dart            # Tema de la aplicación
```

### Backend (`rideupt-backend/`)

```
rideupt-backend/
├── config/
│   ├── database.js               # Conexión MongoDB
│   ├── storage.js                 # Configuración almacenamiento
│   └── firebase-service-account.json
├── controllers/
│   ├── authController.js         # Autenticación
│   ├── userController.js         # Gestión de usuarios
│   ├── tripController.js         # Gestión de viajes
│   ├── ratingController.js        # Calificaciones
│   ├── adminController.js         # Panel de administración
│   └── dashboardController.js    # Dashboard
├── models/
│   ├── User.js                   # Esquema de usuario
│   ├── Trip.js                   # Esquema de viaje
│   └── Rating.js                 # Esquema de calificación
├── routes/
│   ├── auth.js                   # Rutas de autenticación
│   ├── users.js                  # Rutas de usuarios
│   ├── trips.js                  # Rutas de viajes
│   ├── ratings.js                # Rutas de calificaciones
│   └── admin.js                  # Rutas de administración
├── services/
│   ├── socketService.js          # Servicio WebSocket
│   ├── notificationService.js    # Notificaciones push
│   └── tripChatService.js        # Chat de viajes
├── middleware/
│   ├── auth.js                   # Middleware de autenticación
│   └── errorHandler.js           # Manejo de errores
├── server.js                     # Punto de entrada
└── package.json                  # Dependencias
```

---

## 🔐 Seguridad

### Autenticación y Autorización

1. **JWT (JSON Web Tokens)**
   - Tokens firmados con secreto
   - Expiración de 30 días
   - Validación en cada petición

2. **Firebase Auth**
   - Verificación de tokens de Google
   - Validación de email institucional

3. **Middleware de Autenticación**
   - Verificación de token en cada petición protegida
   - Extracción de información del usuario

### Validaciones

1. **Backend**
   - Express-validator para validación de datos
   - Validación de email institucional
   - Validación de permisos (rol, estado de aprobación)

2. **Frontend**
   - Validación de formularios
   - Validación de permisos antes de acciones

### CORS

- Configuración de orígenes permitidos
- Diferentes políticas para desarrollo y producción

---

## 🚀 Despliegue

### Frontend

- **Android:** APK generado con Flutter
- **iOS:** Build para App Store
- **Web:** Compilación con `flutter build web`
- **Hosting Web:** Firebase Hosting

### Backend

- **Docker:** Contenedores para desarrollo y producción
- **Nginx:** Reverse proxy y SSL
- **HTTPS:** Certificados SSL configurados
- **Variables de Entorno:** Configuración por ambiente

---

## 📊 Escalabilidad

### Frontend

- **State Management:** Provider permite escalar estado
- **Código Modular:** Fácil agregar nuevas funcionalidades
- **Multiplataforma:** Un solo código para múltiples plataformas

### Backend

- **Pool de Conexiones:** MongoDB configurado para 50 conexiones máximas
- **WebSockets:** Socket.io maneja múltiples conexiones
- **Stateless API:** Fácil escalar horizontalmente
- **Índices:** Optimizados para consultas frecuentes

---

## 🔄 Flujos de Sincronización

### Tiempo Real

1. **WebSockets:** Cambios instantáneos en chat y estado de viajes
2. **Notificaciones Push:** Alertas inmediatas
3. **Auto-refresh:** Frontend actualiza cada 10 segundos

### Persistencia

1. **SharedPreferences:** Tokens y preferencias locales
2. **MongoDB:** Datos persistentes en servidor
3. **Firebase:** Tokens FCM y autenticación

---

## 📝 Conclusión

La arquitectura de RideUPT está diseñada para:

✅ **Separación de responsabilidades** entre frontend y backend  
✅ **Escalabilidad** horizontal y vertical  
✅ **Mantenibilidad** con código modular y bien organizado  
✅ **Tiempo real** con WebSockets y notificaciones push  
✅ **Multiplataforma** con Flutter  
✅ **Seguridad** con JWT y validaciones robustas  

Esta arquitectura permite el crecimiento del sistema y la adición de nuevas funcionalidades de manera ordenada y eficiente.

---

**Versión del Documento:** 1.0.0  
**Última Actualización:** 2024  
**Mantenido por:** Equipo de Desarrollo RideUPT

