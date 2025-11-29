# 📋 Requerimientos Funcionales y No Funcionales - RideUPT
## Ordenados por Priorización

---

## 🔴 REQUERIMIENTOS FUNCIONALES - PRIORIDAD ALTA

| ID | Descripción | Prioridad |
|---|---|---|
| RF001 | El sistema debe permitir el registro e inicio de sesión de usuarios con credenciales válidas de estudiantes. | Alta |
| RF002 | El sistema debe permitir la aceptación (habilitación) y edición de perfiles de conductor. | Alta |
| RF003 | Los conductores deben poder crear viajes usando geolocalización automática para el origen. | Alta |
| RF004 | Los pasajeros deben poder buscar viajes disponibles por origen, destino y hora. | Alta |
| RF008 | El sistema debe permitir autenticación rápida y segura mediante cuentas de Google. | Alta |

---

## 🟡 REQUERIMIENTOS FUNCIONALES - PRIORIDAD MEDIA

| ID | Descripción | Prioridad |
|---|---|---|
| RF005 | El sistema debe enviar notificaciones en tiempo real ante cambios de estado relevantes. | Media |
| RF006 | Los usuarios deben poder acceder a un historial de viajes pasados y próximos. | Media |
| RF007 | Los viajes deben expirar automáticamente después de 10 minutos si no son tomados. | Media |

---

## 🔴 REQUERIMIENTOS NO FUNCIONALES - PRIORIDAD ALTA

| ID | Descripción | Prioridad |
|---|---|---|
| RNF001 | El sistema debe garantizar la seguridad de las contraseñas mediante hash bcrypt antes de almacenarlas. | Alta |
| RNF002 | El sistema debe implementar autenticación JWT con tokens que expiren en 30 días. | Alta |
| RNF003 | El sistema debe validar que solo usuarios con email institucional (@upt.pe, @virtual.upt.pe) puedan registrarse. | Alta |
| RNF004 | El sistema debe funcionar en múltiples plataformas: Android, iOS y Web. | Alta |
| RNF005 | El sistema debe manejar errores de conexión y proporcionar mensajes claros al usuario. | Alta |
| RNF006 | El sistema debe proteger las rutas de API mediante middleware de autenticación. | Alta |
| RNF007 | El sistema debe validar permisos de roles (passenger, driver, admin) antes de permitir acciones. | Alta |
| RNF008 | El sistema debe mantener la sesión del usuario mediante persistencia de tokens en almacenamiento local. | Alta |
| RNF009 | El sistema debe implementar CORS configurado para permitir acceso desde dominios autorizados. | Alta |
| RNF010 | El sistema debe validar que los conductores estén aprobados antes de permitir crear viajes. | Alta |

---

## 🟡 REQUERIMIENTOS NO FUNCIONALES - PRIORIDAD MEDIA

| ID | Descripción | Prioridad |
|---|---|---|
| RNF011 | El sistema debe soportar al menos 50 conexiones simultáneas a la base de datos MongoDB. | Media |
| RNF012 | El sistema debe actualizar automáticamente la lista de viajes disponibles cada 10 segundos. | Media |
| RNF013 | El sistema debe proporcionar notificaciones push en tiempo real para cambios de estado. | Media |
| RNF014 | El sistema debe implementar un sistema de diseño consistente inspirado en aplicaciones de transporte modernas. | Media |
| RNF015 | El sistema debe cumplir con estándares de accesibilidad WCAG 2.1 para contraste y legibilidad. | Media |
| RNF016 | El sistema debe soportar temas claro y oscuro con cambio automático según preferencias del sistema. | Media |
| RNF017 | El sistema debe manejar reconexión automática de WebSockets en caso de pérdida de conexión. | Media |
| RNF018 | El sistema debe implementar timeout de 20 segundos para peticiones HTTP. | Media |
| RNF019 | El sistema debe validar documentos de conductores (Foto del Vehículo, Tarjeta de Propiedad, Carnet Universitario). | Media |
| RNF020 | El sistema debe permitir la edición de perfiles de usuario (edad, género, biografía). | Media |
| RNF021 | El sistema debe calcular y mostrar tiempo restante de expiración de viajes en tiempo real. | Media |
| RNF022 | El sistema debe implementar chat en tiempo real para comunicación durante viajes. | Media |
| RNF023 | El sistema debe cerrar automáticamente el chat cuando un viaje expira o se completa. | Media |
| RNF024 | El sistema debe proporcionar un panel de administración para gestionar conductores y estadísticas. | Media |
| RNF025 | El sistema debe implementar un sistema de calificaciones con promedio y total de calificaciones. | Media |

---

## 🟢 REQUERIMIENTOS NO FUNCIONALES - PRIORIDAD BAJA

| ID | Descripción | Prioridad |
|---|---|---|
| RNF026 | El sistema debe optimizar consultas a la base de datos mediante índices geoespaciales para búsquedas de ubicación. | Baja |
| RNF027 | El sistema debe implementar logging detallado para debugging y monitoreo. | Baja |
| RNF028 | El sistema debe soportar despliegue mediante Docker con configuración para desarrollo y producción. | Baja |
| RNF029 | El sistema debe implementar configuración mediante variables de entorno para diferentes ambientes. | Baja |
| RNF030 | El sistema debe proporcionar documentación técnica de la arquitectura y estructura del código. | Baja |
| RNF031 | El sistema debe implementar manejo de errores global con mensajes personalizados según el tipo de error. | Baja |
| RNF032 | El sistema debe validar que las placas de vehículos sean únicas en el sistema. | Baja |
| RNF033 | El sistema debe implementar geocodificación inversa para convertir coordenadas GPS en nombres de ubicación. | Baja |
| RNF034 | El sistema debe calcular distancias entre origen y destino usando fórmula de Haversine. | Baja |
| RNF035 | El sistema debe sugerir precios basados en la distancia calculada del viaje. | Baja |
| RNF036 | El sistema debe implementar validación de precios entre S/. 1.00 y S/. 3.00 por asiento. | Baja |
| RNF037 | El sistema debe validar que el número de asientos disponibles esté entre 1 y 20. | Baja |
| RNF038 | El sistema debe implementar auto-refresh de la lista de viajes con indicador visual de carga. | Baja |
| RNF039 | El sistema debe proporcionar estados de carga (skeleton loaders) durante la obtención de datos. | Baja |
| RNF040 | El sistema debe implementar pull-to-refresh para actualizar manualmente las listas. | Baja |

---

## 📊 Resumen por Prioridad

### Requerimientos Funcionales
- **Prioridad Alta:** 5 requerimientos
- **Prioridad Media:** 3 requerimientos
- **Total:** 8 requerimientos funcionales

### Requerimientos No Funcionales
- **Prioridad Alta:** 10 requerimientos
- **Prioridad Media:** 15 requerimientos
- **Prioridad Baja:** 15 requerimientos
- **Total:** 40 requerimientos no funcionales

### Total General
- **Total de Requerimientos:** 48
- **Alta:** 15 requerimientos
- **Media:** 18 requerimientos
- **Baja:** 15 requerimientos

---

## 📝 Notas

1. **Prioridad Alta:** Requerimientos críticos para el funcionamiento básico del sistema y seguridad.
2. **Prioridad Media:** Requerimientos importantes que mejoran la experiencia de usuario y funcionalidad.
3. **Prioridad Baja:** Requerimientos de optimización, mejoras y características adicionales.

---

**Fecha de Creación:** 2024  
**Versión:** 1.0.0

