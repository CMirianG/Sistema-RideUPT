# Diagramas de Secuencia UML - Sistema RideUPT

## Requerimientos Funcionales

### RF001: Autenticar Usuario

```plantuml
@startuml RF001_Autenticar_Usuario
title RF001: Autenticar Usuario - Registro e Inicio de Sesión

actor Usuario
participant "LoginScreen\n(Flutter)" as Screen
participant "AuthProvider\n(Flutter)" as Provider
participant "ApiService\n(Flutter)" as ApiService
participant "Express Server\n(Node.js)" as Server
participant "authController\n(Node.js)" as Controller
participant "User Model\n(Mongoose)" as UserModel
participant "MongoDB" as DB
participant "bcrypt" as Crypto

Usuario -> Screen: Ingresa email y contraseña
Screen -> Provider: login(email, password)
Provider -> ApiService: postPublic('auth/login', {email, password})

ApiService -> Server: POST /api/auth/login\n{email, password}
Server -> Controller: login(req, res)

Controller -> Controller: Validar email formato
Controller -> UserModel: findOne({ email })
UserModel -> DB: Query usuarios
DB -> UserModel: Usuario encontrado
UserModel -> Controller: user object

Controller -> UserModel: comparePassword(password)
UserModel -> Crypto: bcrypt.compare(password, user.password)
Crypto -> UserModel: true/false
UserModel -> Controller: isPasswordValid

alt Contraseña válida
    Controller -> Controller: generateToken(user._id)
    Controller -> Controller: jwt.sign({id}, JWT_SECRET, {expiresIn: '30d'})
    Controller -> Server: res.json({_id, firstName, email, role, token})
    Server -> ApiService: Response JSON con token
    ApiService -> Provider: Response data
    Provider -> Provider: Guardar token en SharedPreferences
    Provider -> Provider: Guardar usuario en estado
    Provider -> Screen: Usuario autenticado
    Screen -> Usuario: Redirigir a Home
else Contraseña inválida
    Controller -> Server: res.status(401).json({message: 'Correo o contraseña inválidos'})
    Server -> ApiService: Error 401
    ApiService -> Provider: Error
    Provider -> Screen: Mostrar error
    Screen -> Usuario: Mensaje de error
end

@enduml
```

### RF002: Gestionar Conductor

```plantuml
@startuml RF002_Gestionar_Conductor
title RF002: Gestionar Conductor - Aceptación y Edición de Perfil

actor Administrador
participant "AdminPanel\n(Flutter)" as AdminScreen
participant "ApiService\n(Flutter)" as ApiService
participant "Express Server\n(Node.js)" as Server
participant "adminController\n(Node.js)" as Controller
participant "User Model\n(Mongoose)" as UserModel
participant "MongoDB" as DB
participant "NotificationService\n(Node.js)" as NotifService
participant "Firebase FCM" as FCM

== Obtener Conductores Pendientes ==
Administrador -> AdminScreen: Consulta conductores pendientes
AdminScreen -> ApiService: get('/api/admin/drivers/pending', token)
ApiService -> Server: GET /api/admin/drivers/pending\nAuthorization: Bearer token
Server -> Server: Middleware auth.js: Validar JWT
Server -> Server: Middleware: Verificar isAdmin = true
Server -> Controller: getPendingDrivers(req, res)
Controller -> UserModel: find({driverApprovalStatus: 'pending'})
UserModel -> DB: Query usuarios
DB -> UserModel: Lista de conductores
UserModel -> Controller: pendingDrivers[]
Controller -> Server: res.json({count, drivers})
Server -> ApiService: Response JSON
ApiService -> AdminScreen: Lista de conductores
AdminScreen -> Administrador: Mostrar lista

== Aprobar Conductor ==
Administrador -> AdminScreen: Selecciona conductor y aprueba
AdminScreen -> ApiService: put('/api/admin/drivers/:id/approve', token)
ApiService -> Server: PUT /api/admin/drivers/:driverId/approve
Server -> Controller: approveDriver(req, res)
Controller -> UserModel: findById(driverId)
UserModel -> DB: Query usuario
DB -> UserModel: driver object
UserModel -> Controller: driver

Controller -> Controller: Verificar documentos requeridos\n['Foto del Vehículo', 'Tarjeta de Propiedad', 'Carnet Universitario']
Controller -> Controller: Verificar vehículo registrado

alt Documentos completos y vehículo registrado
    Controller -> Controller: driver.role = 'driver'
    Controller -> Controller: driver.driverApprovalStatus = 'approved'
    Controller -> UserModel: save()
    UserModel -> DB: Update usuario
    DB -> UserModel: Usuario actualizado
    UserModel -> Controller: driver actualizado
    
    Controller -> NotifService: sendPushNotification(driverId, title, body)
    NotifService -> FCM: Enviar notificación push
    FCM -> NotifService: Notificación enviada
    NotifService -> Controller: Notificación enviada
    
    Controller -> Server: res.json({message, driver})
    Server -> ApiService: Response JSON
    ApiService -> AdminScreen: Conductor aprobado
    AdminScreen -> Administrador: Mostrar confirmación
else Documentos incompletos
    Controller -> Server: res.status(400).json({message: 'Documentos faltantes'})
    Server -> ApiService: Error 400
    ApiService -> AdminScreen: Error
    AdminScreen -> Administrador: Mostrar error
end

== Rechazar Conductor ==
Administrador -> AdminScreen: Selecciona conductor y rechaza con motivo
AdminScreen -> ApiService: put('/api/admin/drivers/:id/reject', {reason}, token)
ApiService -> Server: PUT /api/admin/drivers/:driverId/reject\n{reason}
Server -> Controller: rejectDriver(req, res)
Controller -> UserModel: findById(driverId)
UserModel -> DB: Query usuario
DB -> UserModel: driver object
UserModel -> Controller: driver

Controller -> Controller: driver.driverApprovalStatus = 'rejected'
Controller -> Controller: driver.driverRejectionReason = reason
Controller -> UserModel: save()
UserModel -> DB: Update usuario
DB -> UserModel: Usuario actualizado

Controller -> NotifService: sendPushNotification(driverId, title, body)
NotifService -> FCM: Enviar notificación push
FCM -> NotifService: Notificación enviada

Controller -> Server: res.json({message, driver})
Server -> ApiService: Response JSON
ApiService -> AdminScreen: Conductor rechazado
AdminScreen -> Administrador: Mostrar confirmación

@enduml
```

### RF003: Crear Viaje

```plantuml
@startuml RF003_Crear_Viaje
title RF003: Crear Viaje - Con Geolocalización Automática

actor Conductor
participant "CreateTripScreen\n(Flutter)" as Screen
participant "TripProvider\n(Flutter)" as Provider
participant "Geolocator\n(Flutter)" as Geolocator
participant "ApiService\n(Flutter)" as ApiService
participant "Express Server\n(Node.js)" as Server
participant "tripController\n(Node.js)" as Controller
participant "Trip Model\n(Mongoose)" as TripModel
participant "User Model\n(Mongoose)" as UserModel
participant "MongoDB" as DB
participant "NotificationService\n(Node.js)" as NotifService
participant "SocketService\n(Node.js)" as SocketService
participant "Firebase FCM" as FCM

Conductor -> Screen: Selecciona "Crear Viaje"
Screen -> Geolocator: requestPermission()
Geolocator -> Conductor: Solicita permiso GPS
Conductor -> Geolocator: Autoriza GPS
Geolocator -> Geolocator: getCurrentPosition()
Geolocator -> Screen: Position {latitude, longitude}

Screen -> Screen: Usuario ingresa:\n- Destino\n- Hora salida\n- Precio\n- Asientos disponibles
Screen -> Provider: createTrip(tripData)

Provider -> ApiService: post('/api/trips', tripData, token)
ApiService -> Server: POST /api/trips\nAuthorization: Bearer token\n{origin, destination, departureTime, availableSeats, pricePerSeat}
Server -> Server: Middleware auth.js: Validar JWT
Server -> Controller: createTrip(req, res)

Controller -> Controller: Validar datos requeridos
Controller -> Controller: Verificar req.user.role === 'driver'

Controller -> UserModel: findById(req.user._id)
UserModel -> DB: Query usuario
DB -> UserModel: user object
UserModel -> Controller: user

Controller -> Controller: Verificar driverApprovalStatus === 'approved'

alt Conductor aprobado
    Controller -> TripModel: findOne({driver: userId, status: ['esperando', 'completo', 'en-proceso']})
    TripModel -> DB: Query viajes activos
    DB -> TripModel: Resultado
    TripModel -> Controller: existingTrip o null
    
    alt No hay viaje activo
        Controller -> Controller: expiresAt = new Date() + 10 minutos
        Controller -> TripModel: new Trip({driver, origin, destination, departureTime, expiresAt, availableSeats, pricePerSeat})
        Controller -> TripModel: save()
        TripModel -> DB: Insert viaje
        DB -> TripModel: Viaje guardado
        TripModel -> Controller: createdTrip
        
        Controller -> TripModel: populate('driver', 'firstName lastName profilePhoto')
        Controller -> TripModel: populate('passengers.user', ...)
        
        Controller -> SocketService: initializeTripChat(tripId, driverId)
        
        Controller -> SocketService: getIo().emit('newTripAvailable', {trip})
        
        Controller -> UserModel: find({role: 'passenger', fcmToken: {$exists: true}})
        UserModel -> DB: Query pasajeros
        DB -> UserModel: passengers[]
        UserModel -> Controller: passengers
        
        loop Para cada pasajero
            Controller -> NotifService: sendPushNotification(passengerId, title, body, data)
            NotifService -> FCM: Enviar notificación push
            FCM -> NotifService: Notificación enviada
        end
        
        Controller -> Controller: setTimeout(() => expireTrip(), 10 * 60 * 1000)
        
        Controller -> Server: res.status(201).json(createdTrip)
        Server -> ApiService: Response JSON con viaje
        ApiService -> Provider: Viaje creado
        Provider -> Screen: Viaje creado exitosamente
        Screen -> Conductor: Mostrar confirmación
        
    else Ya existe viaje activo
        Controller -> Server: res.status(400).json({message: 'Ya tienes un viaje activo'})
        Server -> ApiService: Error 400
        ApiService -> Provider: Error
        Provider -> Screen: Mostrar error
        Screen -> Conductor: Mensaje de error
    end
else Conductor no aprobado
    Controller -> Server: res.status(403).json({message: 'Conductor no aprobado'})
    Server -> ApiService: Error 403
    ApiService -> Provider: Error
    Provider -> Screen: Mostrar error
    Screen -> Conductor: Mensaje de error
end

@enduml
```

### RF004: Buscar Viaje

```plantuml
@startuml RF004_Buscar_Viaje
title RF004: Buscar Viaje - Por Origen, Destino y Hora

actor Pasajero
participant "SearchTripScreen\n(Flutter)" as Screen
participant "TripProvider\n(Flutter)" as Provider
participant "ApiService\n(Flutter)" as ApiService
participant "Express Server\n(Node.js)" as Server
participant "tripController\n(Node.js)" as Controller
participant "Trip Model\n(Mongoose)" as TripModel
participant "MongoDB" as DB

Pasajero -> Screen: Ingresa origen, destino y hora
Screen -> Provider: fetchAvailableTrips()
Provider -> ApiService: get('/api/trips', token)
ApiService -> Server: GET /api/trips\nAuthorization: Bearer token
Server -> Server: Middleware auth.js: Validar JWT
Server -> Controller: getAvailableTrips(req, res)

Controller -> Controller: now = new Date()
Controller -> TripModel: find({\n  status: {$in: ['esperando', 'completo']},\n  expiresAt: {$gt: now}\n})
TripModel -> DB: Query viajes disponibles
DB -> TripModel: Viajes encontrados
TripModel -> Controller: trips[]

Controller -> TripModel: populate('driver', 'firstName lastName profilePhoto')
Controller -> TripModel: populate('passengers.user', ...)
Controller -> TripModel: sort({createdAt: -1})

TripModel -> Controller: trips con datos poblados

Controller -> Server: res.json(trips)
Server -> ApiService: Response JSON con lista de viajes
ApiService -> Provider: Lista de viajes
Provider -> Provider: Actualizar _availableTrips
Provider -> Screen: Lista de viajes disponibles
Screen -> Pasajero: Mostrar viajes filtrados

note right of Controller
  Filtros aplicados:
  - Estado: 'esperando' o 'completo'
  - expiresAt > fecha actual
  - Ordenados por fecha (más recientes primero)
end note

@enduml
```

### RF005: Enviar Notificación

```plantuml
@startuml RF005_Enviar_Notificacion
title RF005: Enviar Notificación - En Tiempo Real ante Cambios de Estado

participant "Sistema\n(Evento)" as Sistema
participant "tripController\n(Node.js)" as Controller
participant "NotificationService\n(Node.js)" as NotifService
participant "SocketService\n(Node.js)" as SocketService
participant "User Model\n(Mongoose)" as UserModel
participant "MongoDB" as DB
participant "Firebase FCM" as FCM
participant "Socket.io\n(WebSocket)" as WebSocket
participant "Cliente\n(Flutter)" as Cliente

== Notificación Push (FCM) ==
Sistema -> Controller: Evento: Nuevo viaje creado
Controller -> UserModel: find({role: 'passenger', fcmToken: {$exists: true}})
UserModel -> DB: Query pasajeros con FCM token
DB -> UserModel: passengers[]
UserModel -> Controller: passengers

loop Para cada pasajero
    Controller -> NotifService: sendPushNotification(userId, title, body, data)
    NotifService -> UserModel: findById(userId)
    UserModel -> DB: Query usuario
    DB -> UserModel: user object con fcmToken
    UserModel -> NotifService: user
    
    NotifService -> FCM: admin.messaging().send({\n  notification: {title, body},\n  data: data,\n  token: fcmToken\n})
    FCM -> NotifService: Notificación enviada
    NotifService -> Controller: Notificación enviada
end

== Notificación WebSocket (Tiempo Real) ==
Sistema -> Controller: Evento: Cambio de estado
Controller -> SocketService: getIo().emit('tripUpdated', tripData)
SocketService -> WebSocket: Emit evento a todos los clientes conectados
WebSocket -> Cliente: Evento 'tripUpdated' recibido

Cliente -> Cliente: Actualizar UI automáticamente

== Notificación a Usuario Específico ==
Sistema -> Controller: Evento: Solicitud aceptada/rechazada
Controller -> SocketService: getIo().to(userId).emit('bookingStatusChanged', {status})
SocketService -> WebSocket: Emit evento a sala del usuario
WebSocket -> Cliente: Evento 'bookingStatusChanged' recibido

Cliente -> Cliente: Actualizar estado de reserva

== Notificación Global ==
Sistema -> Controller: Evento: Nuevo viaje disponible
Controller -> SocketService: getIo().emit('newTripAvailable', {trip})
SocketService -> WebSocket: Broadcast a todos los clientes
WebSocket -> Cliente: Evento 'newTripAvailable' recibido

Cliente -> Cliente: Mostrar notificación en tiempo real

note right of NotifService
  Tipos de notificaciones:
  - NEW_TRIP_AVAILABLE
  - BOOKING_STATUS_UPDATE
  - TRIP_STARTED
  - TRIP_COMPLETED
  - DRIVER_APPROVED
  - DRIVER_REJECTED
end note

@enduml
```

### RF006: Consultar Historial

```plantuml
@startuml RF006_Consultar_Historial
title RF006: Consultar Historial - Viajes Pasados y Próximos

actor Usuario
participant "MyTripsScreen\n(Flutter)" as Screen
participant "TripProvider\n(Flutter)" as Provider
participant "ApiService\n(Flutter)" as ApiService
participant "Express Server\n(Node.js)" as Server
participant "tripController\n(Node.js)" as Controller
participant "Trip Model\n(Mongoose)" as TripModel
participant "MongoDB" as DB

Usuario -> Screen: Selecciona "Mis Viajes"
Screen -> Provider: fetchMyTrips()

alt Usuario es Conductor
    Provider -> ApiService: get('/api/trips/my-driver-trips', token)
    ApiService -> Server: GET /api/trips/my-driver-trips\nAuthorization: Bearer token
    Server -> Server: Middleware auth.js: Validar JWT
    Server -> Controller: getMyDriverTrips(req, res)
    
    Controller -> TripModel: find({\n  driver: req.user._id,\n  status: {$in: ['en-proceso', 'completado', 'esperando', 'completo']}\n})
    TripModel -> DB: Query viajes del conductor
    DB -> TripModel: trips[]
    TripModel -> Controller: trips
    
else Usuario es Pasajero
    Provider -> ApiService: get('/api/trips/my-passenger-trips', token)
    ApiService -> Server: GET /api/trips/my-passenger-trips\nAuthorization: Bearer token
    Server -> Server: Middleware auth.js: Validar JWT
    Server -> Controller: getMyPassengerTrips(req, res)
    
    Controller -> TripModel: find({\n  'passengers.user': req.user._id,\n  'passengers.status': 'confirmed',\n  status: {$in: ['en-proceso', 'completado', 'esperando', 'completo']}\n})
    TripModel -> DB: Query viajes donde es pasajero
    DB -> TripModel: trips[]
    TripModel -> Controller: trips
end

Controller -> TripModel: populate('driver', 'firstName lastName vehicle')
Controller -> TripModel: populate('passengers.user', 'firstName lastName university profilePhoto')
Controller -> TripModel: sort({createdAt: -1})

TripModel -> Controller: trips con datos poblados

Controller -> Server: res.json(trips)
Server -> ApiService: Response JSON con lista de viajes
ApiService -> Provider: Lista de viajes
Provider -> Provider: Actualizar _myTrips

Provider -> Provider: Separar viajes:\n- Viajes en proceso (en-proceso)\n- Viajes completados (completado)\n- Viajes próximos (esperando, completo)

Provider -> Screen: Viajes organizados
Screen -> Screen: Mostrar pestañas:\n- En Curso\n- Historial
Screen -> Usuario: Mostrar viajes pasados y próximos

note right of Provider
  Filtros aplicados en frontend:
  - Viajes completados: status === 'completado'
  - Viajes próximos: status === 'esperando' o 'completo'
  - Ordenados por fecha (más recientes primero)
  - Últimos 10 viajes completados
end note

@enduml
```

### RF007: Expirar Viaje

```plantuml
@startuml RF007_Expirar_Viaje
title RF007: Expirar Viaje - Automáticamente después de 10 minutos

participant "Sistema\n(Timer)" as Sistema
participant "tripController\n(Node.js)" as Controller
participant "Trip Model\n(Mongoose)" as TripModel
participant "MongoDB" as DB
participant "SocketService\n(Node.js)" as SocketService
participant "TripChatService\n(Node.js)" as ChatService
participant "Socket.io\n(WebSocket)" as WebSocket
participant "Cliente\n(Flutter)" as Cliente

== Crear Viaje y Programar Expiración ==
Sistema -> Controller: createTrip() - Viaje creado
Controller -> Controller: expiresAt = new Date() + 10 minutos
Controller -> TripModel: save(trip)
TripModel -> DB: Guardar viaje con expiresAt
DB -> TripModel: Viaje guardado

Controller -> Controller: setTimeout(async () => {\n  expireTrip()\n}, 10 * 60 * 1000)

== Expiración Automática (10 minutos después) ==
Sistema -> Controller: setTimeout callback ejecutado
Controller -> TripModel: findById(tripId)
TripModel -> DB: Query viaje
DB -> TripModel: trip object
TripModel -> Controller: trip

Controller -> Controller: Verificar status === 'esperando' o 'completo'

alt Viaje aún no iniciado
    Controller -> Controller: trip.status = 'expirado'
    Controller -> TripModel: save()
    TripModel -> DB: Update viaje
    DB -> TripModel: Viaje actualizado
    
    Controller -> ChatService: closeTripChat(tripId)
    ChatService -> SocketService: Cerrar sala de chat
    
    Controller -> SocketService: getIo().emit('tripExpired', {tripId})
    SocketService -> WebSocket: Broadcast evento
    WebSocket -> Cliente: Evento 'tripExpired' recibido
    
    Controller -> SocketService: getIo().to(roomName).emit('tripChatClosed', {reason: 'expirado'})
    SocketService -> WebSocket: Notificar participantes
    WebSocket -> Cliente: Evento 'tripChatClosed' recibido
    
    Cliente -> Cliente: Actualizar UI\nRemover viaje de lista
    
    note right of Controller
      El viaje se marca como expirado
      si no tiene pasajeros confirmados
      o no ha sido iniciado después
      de 10 minutos de su creación
    end note
else Viaje ya iniciado o completado
    Controller -> Controller: No expirar (viaje ya en progreso)
end

== Verificación en Búsqueda ==
note over Controller,DB
  Al buscar viajes disponibles,
  se filtra automáticamente:
  expiresAt: {$gt: new Date()}
  
  Los viajes expirados no aparecen
  en las búsquedas
end note

@enduml
```

### RF008: Autenticar con Google

```plantuml
@startuml RF008_Autenticar_Google
title RF008: Autenticar con Google - Autenticación Rápida y Segura

actor Usuario
participant "LoginScreen\n(Flutter)" as Screen
participant "GoogleAuthService\n(Flutter)" as GoogleAuth
participant "Firebase Auth\n(SDK Flutter)" as FirebaseAuth
participant "ApiService\n(Flutter)" as ApiService
participant "Express Server\n(Node.js)" as Server
participant "authController\n(Node.js)" as Controller
participant "Firebase Admin\n(Node.js)" as FirebaseAdmin
participant "User Model\n(Mongoose)" as UserModel
participant "MongoDB" as DB

Usuario -> Screen: Selecciona "Iniciar con Google"
Screen -> GoogleAuth: signInWithGoogle()

GoogleAuth -> FirebaseAuth: GoogleSignIn().signIn()
FirebaseAuth -> Usuario: Muestra selector de cuenta Google
Usuario -> FirebaseAuth: Selecciona cuenta Google
FirebaseAuth -> FirebaseAuth: Autentica con Google OAuth
FirebaseAuth -> GoogleAuth: GoogleSignInAccount

GoogleAuth -> FirebaseAuth: FirebaseAuth.signInWithCredential(googleAuthCredential)
FirebaseAuth -> FirebaseAuth: Autentica con Firebase
FirebaseAuth -> GoogleAuth: UserCredential con idToken

GoogleAuth -> ApiService: post('/api/auth/google', {idToken})
ApiService -> Server: POST /api/auth/google\n{idToken}
Server -> Controller: googleSignIn(req, res)

Controller -> Controller: Extraer idToken del body

Controller -> FirebaseAdmin: admin.auth().verifyIdToken(idToken)
FirebaseAdmin -> FirebaseAdmin: Verifica token con Firebase
FirebaseAdmin -> Controller: decodedToken {email, name, uid, picture}

Controller -> Controller: Verificar email.endsWith('@virtual.upt.pe')

alt Email institucional válido
    Controller -> UserModel: findOne({ email })
    UserModel -> DB: Query usuario
    DB -> UserModel: Resultado
    UserModel -> Controller: user o null
    
    alt Usuario existente
        Controller -> Controller: generateToken(user._id)
        Controller -> Server: res.json({\n  _id, firstName, lastName, email, role, token, isNewUser: false\n})
        Server -> ApiService: Response JSON con token
        ApiService -> GoogleAuth: Usuario autenticado
        GoogleAuth -> Screen: Login exitoso
        
    else Usuario nuevo
        Controller -> Controller: Extraer firstName, lastName de name
        Controller -> Controller: Extraer studentId de email\n(expresión regular)
        Controller -> UserModel: create({\n  firstName, lastName, email, password: uid,\n  phone: 'Pendiente', university: 'UPT', studentId, profilePhoto: picture, role: 'passenger'\n})
        UserModel -> DB: Insert nuevo usuario
        DB -> UserModel: Usuario creado
        UserModel -> Controller: newUser
        
        Controller -> Controller: generateToken(newUser._id)
        Controller -> Server: res.status(201).json({\n  _id, firstName, lastName, email, role, token, isNewUser: true, needsPhoneNumber: true\n})
        Server -> ApiService: Response JSON con token
        ApiService -> GoogleAuth: Usuario registrado
        GoogleAuth -> Screen: Registro exitoso
        Screen -> Screen: Mostrar pantalla de bienvenida\nSolicitar teléfono
    end
    
    Screen -> Screen: Guardar token en SharedPreferences
    Screen -> Screen: Guardar usuario en estado
    Screen -> Usuario: Redirigir a Home
    
else Email no institucional
    Controller -> Server: res.status(400).json({message: 'Solo correos institucionales permitidos'})
    Server -> ApiService: Error 400
    ApiService -> GoogleAuth: Error
    GoogleAuth -> Screen: Mostrar error
    Screen -> Usuario: Mensaje de error
end

@enduml
```

---

## Resumen de Diagramas

Los diagramas de secuencia anteriores representan el flujo completo de los 8 requerimientos funcionales según la implementación real del código:

1. **RF001 - Autenticar Usuario**: Flujo completo de login con validación de credenciales y generación de JWT
2. **RF002 - Gestionar Conductor**: Proceso de aprobación/rechazo de conductores por administradores
3. **RF003 - Crear Viaje**: Creación de viaje con geolocalización automática, validaciones y notificaciones
4. **RF004 - Buscar Viaje**: Búsqueda de viajes disponibles con filtros de estado y expiración
5. **RF005 - Enviar Notificación**: Sistema dual de notificaciones (FCM push + WebSocket tiempo real)
6. **RF006 - Consultar Historial**: Consulta de viajes propios separados por estado
7. **RF007 - Expirar Viaje**: Expiración automática mediante setTimeout programado
8. **RF008 - Autenticar con Google**: Flujo completo de OAuth con Firebase y validación de email institucional

Todos los diagramas están basados en el código real del proyecto y reflejan la arquitectura cliente-servidor con Flutter, Node.js, MongoDB y Firebase.

