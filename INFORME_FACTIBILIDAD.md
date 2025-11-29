# Sistema RideUPT - Plataforma de viajes compartidos Universitarios, Tacna, 2025

## Informe de Factibilidad

**Versión:** 1.0

---

## CONTROL DE VERSIONES

| Versión | Hecha por | Revisada por | Aprobada por | Fecha | Motivo |
|---------|-----------|--------------|--------------|-------|--------|
| 1.0 | MPV | ELV | ARV | 10/10/2020 | Versión Original |

---

## ÍNDICE GENERAL

1. [Descripción del Proyecto](#1-descripción-del-proyecto)
2. [Riesgos](#2-riesgos)
3. [Análisis de la Situación actual](#3-análisis-de-la-situación-actual)
4. [Estudio de Factibilidad](#4-estudio-de-factibilidad)
   - 4.1 Factibilidad Técnica
   - 4.2 Factibilidad económica
   - 4.3 Factibilidad Operativa
   - 4.4 Factibilidad Legal
   - 4.5 Factibilidad Social
   - 4.6 Factibilidad Ambiental
5. [Análisis Financiero](#5-análisis-financiero)
6. [Conclusiones](#6-conclusiones)

---

## 1. Descripción del Proyecto

### 1.1 Nombre del proyecto

**RideUPT – Plataforma de viajes compartidos universitarios para la Universidad Privada de Tacna, Tacna – 2025**

### 1.2 Duración del proyecto

**3 meses**

### 1.3 Descripción

RideUPT es una plataforma digital diseñada para facilitar viajes compartidos entre estudiantes, docentes y personal administrativo de la Universidad Privada de Tacna. La aplicación permitirá a los conductores publicar viajes y a los pasajeros buscar, reservar y gestionar sus traslados de manera segura y eficiente, utilizando correos institucionales para garantizar identidad y confianza. El sistema incluirá funcionalidades de geolocalización, notificaciones en tiempo real y un sistema de reservas integrado.

### 1.4 Objetivos

#### 1.4.1 Objetivo general

Desarrollar una plataforma segura y eficiente de viajes compartidos exclusiva para la comunidad universitaria de la UPT, que optimice la movilidad, reduzca costos de transporte y fomente la sostenibilidad.

#### 1.4.2 Objetivos Específicos

• Implementar un sistema de autenticación seguro mediante correo institucional.

• Permitir la publicación de viajes con detalles de ruta, horario y precio.

• Facilitar la búsqueda y filtrado de viajes disponibles.

• Gestionar reservas de asientos y confirmaciones en tiempo real.

• Notificar a usuarios sobre cambios de estado en viajes y reservas.

• Garantizar la usabilidad y accesibilidad mediante una interfaz intuitiva.

---

## 2. Riesgos

• **Dependencia de conexión a Internet** para funcionalidades en tiempo real.

• **Posible resistencia al cambio** por parte de usuarios no tecnológicos.

• **Riesgos de seguridad y privacidad** de datos personales y de ubicación.

• **Limitaciones de compatibilidad** con dispositivos móviles antiguos.

• **Posibles conflictos legales** relacionados con transporte informal.

---

## 3. Análisis de la Situación actual

### 3.1 Planteamiento del problema

La comunidad universitaria de la UPT enfrenta dificultades de movilidad, incluyendo altos costos de transporte, falta de opciones eficientes y horarios limitados. No existe una plataforma centralizada que permita organizar viajes compartidos de manera segura y confiable dentro del ámbito universitario.

### 3.2 Consideraciones de hardware y software

El proyecto requiere infraestructura tecnológica tanto para desarrollo como para producción. A continuación se detallan los recursos necesarios:

#### Hardware Requerido para Desarrollo

- **Computadoras de desarrollo** (2 unidades): Procesador mínimo Intel Core i5 o equivalente, 8GB RAM, 256GB almacenamiento SSD
- **Dispositivos móviles de prueba**: Al menos 1 dispositivo Android y 1 iOS para testing
- **Servidor de desarrollo local**: Opcional, puede utilizarse cloud

#### Software y Servicios Requeridos

- **Sistema Operativo**: Windows 10/11, macOS o Linux para desarrollo
- **Entorno de desarrollo Flutter**: SDK Flutter 3.7.2 o superior
- **Node.js**: Versión 18.x o superior para backend
- **MongoDB**: Base de datos NoSQL (versión cloud o local)
- **Firebase**: Servicios de autenticación, notificaciones push y hosting
- **Google Cloud Platform**: Para Maps API y almacenamiento
- **Editores de código**: Visual Studio Code o Android Studio
- **Control de versiones**: Git y GitHub
- **Herramientas de despliegue**: Docker, Nginx

#### Infraestructura Cloud Necesaria

- **MongoDB Atlas**: Base de datos en la nube (plan gratuito disponible, pero se recomienda plan básico)
- **Firebase Hosting**: Para hosting web de la aplicación Flutter Web
- **Firebase Authentication**: Autenticación con Google y correo institucional
- **Firebase Cloud Messaging**: Notificaciones push
- **Google Maps API**: Visualización de mapas y geocodificación
- **Servidor VPS o Cloud**: Para backend Node.js (puede ser DigitalOcean, AWS, Azure, o servidor propio)

#### Requisitos de Red

- **Internet estable** para desarrollo y producción
- **Ancho de banda**: Mínimo 10 Mbps para desarrollo
- **Dominio web**: Opcional pero recomendado (ej: rideupt.edu.pe)

---

## 4. Estudio de Factibilidad

El presente estudio de factibilidad tiene como objetivo evaluar la viabilidad técnica, económica, operativa, legal, social y ambiental del proyecto RideUPT. Se realizó una evaluación exhaustiva de los recursos disponibles, las tecnologías existentes, los costos asociados y los beneficios esperados. El estudio fue aprobado por el comité de dirección del proyecto.

Las actividades realizadas para la evaluación incluyen:
- Análisis del stack tecnológico actual y su aplicabilidad
- Evaluación de costos de desarrollo e infraestructura
- Revisión de marcos legales aplicables
- Estudio de impacto social y ambiental
- Análisis de capacidad operativa de la institución

### 4.1 Factibilidad Técnica

El estudio de viabilidad técnica se enfoca en obtener un entendimiento de los recursos tecnológicos disponibles actualmente y su aplicabilidad a las necesidades que se espera tenga el proyecto. En el caso de tecnología informática esto implica una evaluación del hardware y software y como este puede cubrir las necesidades del sistema propuesto.

#### Evaluación de Tecnología Actual

La tecnología seleccionada para el desarrollo de RideUPT está basada en herramientas modernas, ampliamente utilizadas y soportadas por la comunidad de desarrolladores. Todas las tecnologías son de código abierto o tienen planes gratuitos/tier disponibles, lo que reduce significativamente los costos de implementación.

#### Stack Tecnológico Propuesto

**Frontend - Flutter (Dart)**
- **Framework multiplataforma**: Permite desarrollar una sola aplicación para Android, iOS y Web
- **Rendimiento**: Compilación nativa que garantiza excelente rendimiento
- **Disponibilidad**: Gratuito y de código abierto
- **Soporte**: Amplia comunidad y documentación
- **Requisitos**: Flutter SDK 3.7.2+, compatible con Windows, macOS y Linux

**Backend - Node.js + Express.js**
- **Runtime JavaScript**: Node.js versión 18.x o superior
- **Framework web**: Express.js para API REST
- **Comunicación en tiempo real**: Socket.io para WebSockets
- **Disponibilidad**: Gratuito y de código abierto
- **Ventajas**: Misma base de código JavaScript en cliente y servidor, amplia ecosistema de paquetes

**Base de Datos - MongoDB**
- **Base de datos NoSQL**: Ideal para datos no estructurados y geolocalización
- **Servicio cloud**: MongoDB Atlas (plan gratuito M0 disponible)
- **ODM**: Mongoose para modelado de datos
- **Índices geoespaciales**: Soporte nativo para búsquedas por ubicación
- **Escalabilidad**: Facilita el crecimiento horizontal

**Autenticación y Servicios - Firebase**
- **Firebase Authentication**: Autenticación con Google y correo/contraseña
- **Firebase Cloud Messaging**: Notificaciones push multiplataforma
- **Firebase Hosting**: Hosting web gratuito para aplicación Flutter Web
- **Ventajas**: Infraestructura gestionada por Google, alta disponibilidad

**Mapas y Geocodificación - Google Maps API**
- **Google Maps SDK**: Integración en Flutter
- **Geocoding API**: Conversión de direcciones a coordenadas y viceversa
- **Costo**: Plan gratuito disponible con límites generosos
- **Disponibilidad**: Servicio global de Google

#### Infraestructura de Hardware

**Para Desarrollo:**
- Computadoras con especificaciones estándar (Intel i5 o superior, 8GB RAM)
- Dispositivos móviles Android e iOS para pruebas
- Conexión a internet estable (mínimo 10 Mbps)

**Para Producción:**
- **Servidor VPS o Cloud**: Opciones disponibles:
  - DigitalOcean Droplet (Desde $6/mes)
  - AWS EC2 t3.micro (Elegible para plan gratuito)
  - Azure App Service (Plan básico disponible)
  - Google Cloud Platform Compute Engine (Créditos gratuitos disponibles)
- **MongoDB Atlas**: Plan M0 (Gratis) o M10 ($57/mes) según tráfico
- **Firebase Hosting**: Gratis hasta 10GB almacenamiento y 360MB/día transferencia
- **CDN y SSL**: Incluido en servicios cloud modernos

#### Infraestructura de Software

**Sistemas Operativos Soportados:**
- Windows 10/11
- macOS 10.15 o superior
- Linux (Ubuntu 20.04 LTS o superior)

**Navegadores Web Soportados:**
- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+

**Dispositivos Móviles:**
- Android: API nivel 23+ (Android 6.0 Marshmallow o superior)
- iOS: iOS 12.0 o superior

**Infraestructura de Red:**
- Internet: Conexión estable con ancho de banda mínimo 10 Mbps para desarrollo
- Dominio: Opcional pero recomendado (ej: rideupt.upt.edu.pe)
- SSL/HTTPS: Certificados incluidos en servicios cloud (Let's Encrypt gratuito)

#### Evaluación de Capacidad Técnica

La implementación del sistema es técnicamente factible porque:

1. **Tecnologías maduras**: Todas las tecnologías propuestas son estables, documentadas y ampliamente utilizadas en la industria
2. **Recursos disponibles**: Las herramientas necesarias son gratuitas o de bajo costo
3. **Escalabilidad**: La arquitectura permite crecer según la demanda
4. **Mantenibilidad**: Código modular y bien estructurado facilita el mantenimiento
5. **Soporte comunitario**: Amplia comunidad y recursos de aprendizaje disponibles

**Conclusión de Factibilidad Técnica**: ✅ **VIABLE**

El proyecto es técnicamente factible. Todas las tecnologías necesarias están disponibles, son accesibles y cuentan con el soporte necesario. La infraestructura requerida puede implementarse con recursos mínimos iniciales, permitiendo escalar según la demanda.

---

### 4.2 Factibilidad Económica

El propósito del estudio de viabilidad económica es determinar los beneficios económicos del proyecto o sistema propuesto para la organización, en contraposición con los costos.

Como se mencionó anteriormente en el estudio de factibilidad técnica, la institución (departamento de TI) puede evaluar si cuenta con las herramientas necesarias para la implantación del sistema y evaluar si la propuesta requiere o no de una inversión inicial en infraestructura informática.

Se plantearán los costos del proyecto.

**Costeo del Proyecto**: Consiste en estimar los costos de los recursos (Humanos, materiales o consumibles y/o máquinas) directos para completar las actividades del proyecto.

#### 4.2.1 Costos Generales

Los costos generales son todos los gastos realizados en accesorios y material de oficina y de uso diario, necesarios para los procesos, tales como, papeles, plumas, cartuchos de impresora, marcadores, computadora, etc.

| Ítem | Descripción | Cantidad | Costo Unitario (S/.) | Costo Total (S/.) |
|------|-------------|----------|---------------------|-------------------|
| Papelería | Papel, cuadernos, marcadores | 1 lote | 50.00 | 50.00 |
| Cartuchos de impresora | Toner/inkjet para documentación | 2 unidades | 80.00 | 160.00 |
| Material de oficina | Plumas, lápices, resaltadores | 1 lote | 30.00 | 30.00 |
| **Subtotal Costos Generales** | | | | **240.00** |

#### 4.2.2 Costos Operativos durante el Desarrollo

Evaluar costos necesarios para la operatividad de las actividades durante el periodo en el que se realizará el proyecto. Los costos de operación pueden ser renta de oficina, agua, luz, teléfono, etc.

| Ítem | Descripción | Cantidad | Costo Unitario (S/.) | Costo Total (S/.) |
|------|-------------|----------|---------------------|-------------------|
| Internet | Conexión de alta velocidad (3 meses) | 3 meses | 80.00 | 240.00 |
| Energía eléctrica | Consumo adicional de computadoras (3 meses) | 3 meses | 60.00 | 180.00 |
| Servicios de comunicación | Telefonía/Comunicaciones | 3 meses | 30.00 | 90.00 |
| **Subtotal Costos Operativos** | | | | **510.00** |

#### 4.2.3 Costos del Ambiente

Evaluar si se cuenta con los requerimientos técnicos para la implantación del software como el dominio, infraestructura de red, acceso a internet, etc.

| Ítem | Descripción | Cantidad | Costo Unitario (S/.) | Costo Total (S/.) |
|------|-------------|----------|---------------------|-------------------|
| Dominio web | Dominio .edu.pe o .pe (anual) | 1 año | 50.00 | 50.00 |
| Servidor VPS/Cloud | Hosting backend Node.js (3 meses) | 3 meses | 25.00 | 75.00 |
| MongoDB Atlas | Base de datos cloud (Plan M0 gratis, M10 si crece) | 3 meses | 0.00* | 0.00 |
| Firebase Hosting | Hosting web (Plan gratuito) | 3 meses | 0.00* | 0.00 |
| Google Maps API | API de mapas (Créditos gratuitos disponibles) | 3 meses | 0.00* | 0.00 |
| Firebase Services | Auth, FCM (Plan gratuito) | 3 meses | 0.00* | 0.00 |
| Certificado SSL | SSL/TLS (Gratis con Let's Encrypt) | 1 año | 0.00* | 0.00 |
| **Subtotal Costos del Ambiente** | | | | **125.00** |

*Nota: Los servicios marcados con (*) ofrecen planes gratuitos generosos que cubren las necesidades iniciales del proyecto. Se estima que en los primeros 3 meses no se requerirá pagar por estos servicios.

#### 4.2.4 Costos de Personal

Aquí se incluyen los gastos generados por el recurso humano que se necesita para el desarrollo del sistema únicamente.

No se considerará personal para la operación y funcionamiento del sistema.

**Organización del Equipo:**

| Rol | Descripción | Cantidad | Horas Totales | Tarifa por Hora (S/.) | Costo Total (S/.) |
|-----|-------------|----------|---------------|----------------------|-------------------|
| Líder de Proyecto | Coordinación general, gestión de proyecto | 1 | 120 | 25.00 | 3,000.00 |
| Desarrollador Full Stack | Desarrollo frontend y backend | 2 | 480 | 20.00 | 19,200.00 |
| Diseñador UI/UX | Diseño de interfaces y experiencia de usuario | 1 | 160 | 18.00 | 2,880.00 |
| Tester QA | Pruebas y control de calidad | 1 | 120 | 15.00 | 1,800.00 |
| **Subtotal Costos de Personal** | | | | | **26,880.00** |

**Horario de Trabajo del Personal:**
- **Duración del proyecto**: 3 meses (12 semanas)
- **Horas semanales**: 40 horas por desarrollador
- **Total horas**: 880 horas totales del equipo
- **Distribución temporal**: Desarrollo intensivo con reuniones semanales de seguimiento

#### 4.2.5 Costos Totales del Desarrollo del Sistema

| Categoría | Costo (S/.) |
|-----------|-------------|
| Costos Generales | 240.00 |
| Costos Operativos durante el Desarrollo | 510.00 |
| Costos del Ambiente | 125.00 |
| Costos de Personal | 26,880.00 |
| **TOTAL DEL PROYECTO** | **27,755.00** |

**Forma de Pago:**
- **30% al inicio** (S/. 8,326.50) - Inicio del proyecto y definición de requisitos
- **40% a mitad del proyecto** (S/. 11,102.00) - Entrega de funcionalidades principales
- **30% al finalizar** (S/. 8,326.50) - Entrega final y documentación completa

**Conclusión de Factibilidad Económica**: ✅ **VIABLE**

El proyecto requiere una inversión inicial razonable de S/. 27,755.00, que incluye todos los costos necesarios para el desarrollo completo del sistema. Los costos pueden reducirse si se utilizan servicios gratuitos disponibles y si la institución cuenta con infraestructura existente (internet, espacio de oficina, computadoras).

---

### 4.3 Factibilidad Operativa

El sistema RideUPT está diseñado para ser operado y mantenido de manera eficiente por el departamento de TI de la Universidad Privada de Tacna.

#### Capacidad Operativa

**Recursos Humanos Necesarios para Operación:**

1. **Administrador del Sistema** (0.5 FTE - tiempo parcial)
   - Gestión de usuarios y permisos
   - Monitoreo del sistema
   - Resolución de problemas técnicos básicos
   - Tiempo estimado: 10 horas/semana

2. **Soporte Técnico** (0.25 FTE - tiempo parcial)
   - Atención a usuarios
   - Resolución de consultas
   - Reporte de incidencias
   - Tiempo estimado: 5 horas/semana

**Capacidades Requeridas:**
- Conocimiento básico de administración de servidores
- Familiaridad con MongoDB Atlas
- Capacidad para gestionar Firebase Console
- Habilidades de comunicación para soporte a usuarios

#### Beneficios del Producto

**Beneficios Tangibles:**
- **Reducción de costos de transporte** para estudiantes: Ahorro promedio estimado de 30-50% en costos de transporte
- **Optimización de recursos vehiculares**: Mejor aprovechamiento de vehículos existentes
- **Ahorro de tiempo**: Búsqueda rápida de viajes compartidos
- **Reducción de emisiones**: Menor número de vehículos en circulación

**Beneficios Intangibles:**
- **Mejora en la calidad de vida** de la comunidad universitaria
- **Fortalecimiento de la comunidad**: Conexión entre estudiantes, docentes y personal
- **Responsabilidad social y ambiental**: Contribución a la sostenibilidad
- **Imagen institucional**: Posicionamiento de la UPT como universidad innovadora y sostenible
- **Disponibilidad 24/7**: Acceso al sistema en cualquier momento

#### Impacto en los Usuarios

**Estudiantes:**
- Facilidad para encontrar y reservar viajes compartidos
- Ahorro económico significativo
- Mayor flexibilidad en horarios
- Seguridad mediante validación de usuarios institucionales

**Conductores:**
- Oportunidad de compartir costos de combustible
- Flexibilidad para publicar viajes cuando lo deseen
- Sistema de calificaciones para construir confianza

**Institución:**
- Reducción de congestión vehicular en el campus
- Contribución a objetivos de sostenibilidad
- Herramienta de apoyo a la comunidad universitaria

#### Lista de Interesados (Stakeholders)

1. **Estudiantes de la UPT** - Usuarios principales (pasajeros y conductores)
2. **Docentes de la UPT** - Usuarios del sistema
3. **Personal administrativo** - Usuarios del sistema
4. **Departamento de TI** - Operación y mantenimiento
5. **Dirección de la Universidad** - Patrocinadores del proyecto
6. **Autoridades de transporte local** - Regulación y cumplimiento

**Conclusión de Factibilidad Operativa**: ✅ **VIABLE**

El sistema puede ser operado eficientemente por el departamento de TI con recursos mínimos adicionales. Los beneficios superan ampliamente los costos operativos, y el impacto positivo en la comunidad universitaria justifica la implementación.

---

### 4.4 Factibilidad Legal

Determinar si existe conflicto del proyecto con restricciones legales como leyes y regulaciones del país o locales relacionadas con seguridad, protección de datos, conducta de negocio, empleo y adquisiciones.

#### Marco Legal Aplicable

**1. Protección de Datos Personales - Ley N° 29733 (Ley de Protección de Datos Personales del Perú)**
- ✅ **Cumplimiento**: El sistema implementará políticas de privacidad y protección de datos
- **Acciones requeridas**: 
  - Política de privacidad explícita
  - Consentimiento informado de usuarios
  - Medidas de seguridad técnicas y organizativas
  - Derecho de acceso, rectificación y supresión de datos

**2. Ley de Transporte Terrestre - Decreto Legislativo N° 651**
- ⚠️ **Consideración**: El sistema no constituye servicio de transporte público, sino una plataforma de coordinación entre particulares
- **Características que lo diferencian**:
  - No hay lucro comercial del sistema
  - Los conductores comparten costos, no generan ganancia
  - Uso exclusivo para comunidad universitaria
  - No constituye actividad comercial de transporte

**3. Código Civil - Obligaciones Contractuales**
- ✅ **Cumplimiento**: Términos y condiciones claros que establecen responsabilidades
- **Acciones requeridas**:
  - Términos de servicio claros
  - Exoneración de responsabilidad por incidentes de tránsito
  - Acuerdo de usuario explícito

**4. Seguridad de la Información**
- ✅ **Cumplimiento**: Implementación de medidas de seguridad
  - Autenticación robusta (JWT, Firebase Auth)
  - Encriptación de datos en tránsito (HTTPS)
  - Almacenamiento seguro de contraseñas (hashing con bcrypt)
  - Validación de usuarios mediante correo institucional

**5. Propiedad Intelectual**
- ✅ **Cumplimiento**: Uso de tecnologías de código abierto y licencias permitidas
  - Flutter: Licencia BSD
  - Node.js: Licencia MIT
  - MongoDB: Licencia Server Side Public License (SSPL)
  - Firebase: Términos de servicio de Google

#### Recomendaciones Legales

1. **Crear Política de Privacidad**: Documento que explique cómo se manejan los datos personales
2. **Términos y Condiciones**: Establecer claramente las responsabilidades de usuarios y la institución
3. **Exoneración de Responsabilidad**: Aclarar que la universidad no se responsabiliza por incidentes durante los viajes
4. **Consentimiento Explícito**: Implementar aceptación de términos al momento del registro
5. **Cumplimiento de Normativas de Transporte**: Asegurar que el sistema no constituya transporte comercial

#### Posibles Conflictos y Mitigación

**Conflicto Potencial**: Regulación de transporte informal
- **Mitigación**: El sistema no es un servicio de transporte comercial, sino una plataforma de coordinación. Los conductores comparten costos, no generan ganancia comercial.

**Conflicto Potencial**: Responsabilidad por accidentes
- **Mitigación**: Términos y condiciones claros que establecen que la responsabilidad recae en los conductores y sus seguros vehiculares, no en la universidad ni en la plataforma.

**Conclusión de Factibilidad Legal**: ✅ **VIABLE CON CONDICIONES**

El proyecto es legalmente viable siempre que se implementen las medidas de protección de datos personales requeridas y se establezcan términos y condiciones claros. No existe conflicto directo con leyes de transporte siempre que se mantenga como plataforma de coordinación sin ánimo comercial.

---

### 4.5 Factibilidad Social

Evaluar influencias y asuntos de índole social y cultural como el clima político, códigos de conducta y ética.

#### Impacto Social Positivo

**1. Fortalecimiento de la Comunidad Universitaria**
- Fomento de relaciones entre estudiantes, docentes y personal
- Creación de redes de apoyo dentro de la universidad
- Mejora del sentido de pertenencia institucional

**2. Accesibilidad y Equidad**
- Reducción de barreras económicas para acceder a la universidad
- Facilita el acceso a estudiantes de recursos limitados
- Promueve la inclusión social

**3. Seguridad y Confianza**
- Validación mediante correo institucional genera confianza
- Sistema de calificaciones promueve comportamiento responsable
- Comunidad cerrada reduce riesgos de seguridad

**4. Responsabilidad Social**
- Contribución a la movilidad sostenible
- Reducción de impacto ambiental
- Ejemplo de innovación social aplicada

#### Consideraciones Sociales

**1. Aceptación Social**
- **Ventaja**: Los estudiantes universitarios están familiarizados con aplicaciones móviles
- **Desafío**: Posible resistencia inicial de usuarios menos tecnológicos
- **Mitigación**: Interfaz intuitiva y capacitación básica

**2. Cambio Cultural**
- Promoción del transporte compartido como práctica común
- Cambio de mentalidad de "propiedad individual" a "compartir recursos"

**3. Código de Conducta**
- Establecimiento de normas de comportamiento dentro de la plataforma
- Sistema de reportes para comportamiento inapropiado
- Promoción de respeto y cortesía entre usuarios

**4. Ética y Valores**
- Transparencia en el funcionamiento del sistema
- Igualdad de oportunidades para todos los usuarios
- Protección de usuarios vulnerables

#### Clima Político y Social

- **Contexto favorable**: El gobierno y la sociedad promueven iniciativas de sostenibilidad
- **Alineación con políticas públicas**: Contribuye a objetivos de reducción de emisiones
- **Apoyo institucional**: La universidad puede posicionarse como líder en innovación social

**Conclusión de Factibilidad Social**: ✅ **ALTAMENTE VIABLE**

El proyecto tiene un impacto social altamente positivo, fortalece la comunidad universitaria, promueve valores de sostenibilidad y responsabilidad social, y contribuye a la equidad y accesibilidad. El impacto social justifica ampliamente la implementación del proyecto.

---

### 4.6 Factibilidad Ambiental

Evaluar influencias y asuntos de índole ambiental como el impacto y repercusión en el medio ambiente.

#### Impacto Ambiental Positivo

**1. Reducción de Emisiones de CO₂**
- **Estimación**: Si 100 estudiantes utilizan el sistema diariamente, compartiendo viajes en lugar de usar vehículos individuales, se podría reducir:
  - Aproximadamente 30-50 vehículos menos en circulación diaria
  - Reducción estimada de 500-800 kg CO₂ por semana (dependiendo de distancias)
  - Reducción anual estimada de 25-40 toneladas de CO₂

**2. Reducción de Consumo de Combustible**
- Menor consumo de combustible fósil
- Optimización del uso de recursos energéticos

**3. Reducción de Congestión Vehicular**
- Menos vehículos en las vías alrededor del campus
- Reducción de tiempos de viaje para todos los usuarios de la vía
- Menor contaminación sonora

**4. Sostenibilidad a Largo Plazo**
- Promoción de prácticas de movilidad sostenible
- Educación ambiental indirecta a la comunidad universitaria
- Contribución a objetivos de desarrollo sostenible (ODS) de la ONU

#### Consideraciones Ambientales del Sistema

**1. Impacto de la Infraestructura Digital**
- **Servidores cloud**: Utilizan energía renovable (Google Cloud, AWS, Azure tienen compromisos de energía limpia)
- **Dispositivos de usuarios**: No requiere hardware adicional, utiliza dispositivos existentes
- **Minimización**: Arquitectura eficiente reduce consumo de recursos computacionales

**2. Ciclo de Vida del Sistema**
- **Fase de desarrollo**: Impacto mínimo, principalmente consumo de energía en computadoras de desarrollo
- **Fase de operación**: Impacto positivo neto por reducción de emisiones vehiculares
- **Fase de mantenimiento**: Impacto mínimo

#### Contribución a Objetivos de Desarrollo Sostenible (ODS)

- **ODS 11 - Ciudades y Comunidades Sostenibles**: Movilidad urbana sostenible
- **ODS 13 - Acción por el Clima**: Reducción de emisiones de gases de efecto invernadero
- **ODS 17 - Alianzas para lograr los Objetivos**: Colaboración universidad-comunidad

**Conclusión de Factibilidad Ambiental**: ✅ **ALTAMENTE VIABLE Y BENEFICIOSA**

El proyecto tiene un impacto ambiental neto altamente positivo. La reducción de emisiones de CO₂ y el fomento de prácticas de movilidad sostenible contribuyen significativamente a la protección del medio ambiente. El impacto positivo del sistema supera ampliamente cualquier impacto negativo asociado a la infraestructura digital necesaria.

---

## 5. Análisis Financiero

El plan financiero se ocupa del análisis de ingresos y gastos asociados a cada proyecto, desde el punto de vista del instante temporal en que se producen. Su misión fundamental es detectar situaciones financieramente inadecuadas.

Se tiene que estimar financieramente el resultado del proyecto.

### 5.1 Justificación de la Inversión

#### 5.1.1 Beneficios del Proyecto

El beneficio se calcula como el margen económico menos los costes de oportunidad, que son los márgenes que hubieran podido obtenerse de haber dedicado el capital y el esfuerzo a otras actividades.

El beneficio, obtenido lícitamente, no es sólo una recompensa a la inversión, al esfuerzo y al riesgo asumidos por el empresario, sino que también es un factor esencial para que las empresas sigan en el mercado e incorporen nuevas inversiones al tejido industrial y social de las naciones.

**Beneficios Tangibles** (fácilmente cuantificables):

1. **Reducción de costos de transporte para estudiantes**
   - Ahorro promedio estimado: 40% del costo de transporte individual
   - Si 500 estudiantes ahorran S/. 2.00 diarios en promedio
   - Ahorro mensual de la comunidad: S/. 30,000.00
   - Ahorro anual estimado: S/. 360,000.00 (beneficio para usuarios)

2. **Reducción de costos operativos de la universidad**
   - Menor necesidad de estacionamientos
   - Menor mantenimiento de infraestructura vial
   - Ahorro estimado: S/. 5,000.00 anuales

3. **Optimización de recursos**
   - Mejor aprovechamiento del tiempo de estudiantes y personal
   - Reducción de tardanzas y ausentismo

**Beneficios Intangibles** (no fácilmente cuantificables):

1. **Mejoras en la eficiencia del área bajo estudio**
   - Sistema automatizado reduce tiempo de coordinación manual
   - Disponibilidad 24/7 vs coordinación manual limitada

2. **Disponibilidad del recurso humano**
   - Menor tiempo perdido en búsqueda de transporte
   - Mayor puntualidad

3. **Mejoras en planeación, control y uso de recursos**
   - Datos disponibles para análisis de patrones de movilidad
   - Información para toma de decisiones

4. **Toma acertada de decisiones**
   - Datos del sistema pueden informar políticas de transporte
   - Análisis de demanda y oferta de viajes compartidos

5. **Disponibilidad de información apropiada**
   - Información en tiempo real sobre viajes disponibles
   - Historial y estadísticas para usuarios

6. **Aumento en la confiabilidad de la información**
   - Validación de usuarios mediante correo institucional
   - Sistema de calificaciones

7. **Mejor servicio al cliente externo e interno**
   - Facilidad de uso
   - Acceso desde múltiples plataformas (Android, iOS, Web)
   - Soporte en tiempo real

8. **Logro de ventajas competitivas**
   - Posicionamiento de la UPT como universidad innovadora
   - Diferenciación frente a otras universidades

9. **Valor agregado a un producto de la compañía**
   - Herramienta que mejora la experiencia universitaria
   - Contribución a la sostenibilidad institucional

**Estimación Total de Beneficios Anuales**:
- Beneficios tangibles para usuarios: S/. 360,000.00 (ahorro en transporte)
- Beneficios tangibles para institución: S/. 5,000.00
- Beneficios intangibles: Significativos pero no cuantificables en términos monetarios directos
- **Total beneficios tangibles anuales**: S/. 365,000.00

#### 5.1.2 Criterios de Inversión

##### 5.1.2.1 Relación Beneficio/Costo (B/C)

En base a los costos y beneficios identificados se evalúa si es factible el desarrollo del proyecto.

**Cálculo de la Relación B/C:**

- **Costo Total del Proyecto (Inversión Inicial)**: S/. 27,755.00
- **Beneficios Anuales Tangibles**: S/. 365,000.00
- **Período de Análisis**: 3 años (vida útil estimada del sistema)

**Beneficios Totales (3 años)**:
- Año 1: S/. 365,000.00
- Año 2: S/. 365,000.00 (considerando mantenimiento y actualizaciones)
- Año 3: S/. 365,000.00
- **Total Beneficios**: S/. 1,095,000.00

**Costos Totales (3 años)**:
- Inversión Inicial: S/. 27,755.00
- Costos de Operación Anual (mantenimiento, hosting, soporte): S/. 2,400.00/año × 3 = S/. 7,200.00
- **Total Costos**: S/. 34,955.00

**Relación B/C = Beneficios Totales / Costos Totales**
**B/C = S/. 1,095,000.00 / S/. 34,955.00 = 31.33**

**Interpretación**: 
- ✅ **B/C = 31.33 > 1**: El proyecto es **ALTAMENTE ACEPTABLE**
- Por cada sol invertido, se generan beneficios equivalentes a 31.33 soles
- El proyecto es muy rentable desde el punto de vista económico

##### 5.1.2.2 Valor Actual Neto (VAN)

Valor actual de los beneficios netos que genera el proyecto. Si el VAN es mayor que cero, se acepta el proyecto; si el VAN es igual a cero es indiferente aceptar o rechazar el proyecto y si el VAN es menor que cero se rechaza el proyecto.

**Parámetros:**
- **Tasa de descuento (COK)**: 10% anual (costo de oportunidad del capital)
- **Inversión Inicial**: S/. 27,755.00
- **Beneficios Netos Anuales**: S/. 365,000.00 - S/. 2,400.00 = S/. 362,600.00
- **Período**: 3 años

**Cálculo del VAN:**

```
VAN = -Inversión Inicial + Σ (Beneficio Neto / (1 + COK)^n)

VAN = -27,755 + [362,600 / (1.10)^1] + [362,600 / (1.10)^2] + [362,600 / (1.10)^3]

VAN = -27,755 + 329,636.36 + 299,669.42 + 272,426.75

VAN = -27,755 + 901,732.53

VAN = S/. 873,977.53
```

**Interpretación**:
- ✅ **VAN = S/. 873,977.53 > 0**: El proyecto es **ALTAMENTE ACEPTABLE**
- El proyecto genera un valor actual neto positivo muy significativo
- La inversión es altamente rentable

##### 5.1.2.3 Tasa Interna de Retorno (TIR)

Es la tasa porcentual que indica la rentabilidad promedio anual que genera el capital invertido en el proyecto. Si la TIR es mayor que el costo de oportunidad se acepta el proyecto, si la TIR es igual al costo de oportunidad es indiferente aceptar o rechazar el proyecto, si la TIR es menor que el costo de oportunidad se rechaza el proyecto.

**Costo de oportunidad de capital (COK)**: 10% anual (tasa de interés que podría obtenerse con el dinero invertido en el proyecto)

**Cálculo de la TIR:**

La TIR es la tasa de descuento que hace el VAN = 0

Mediante iteración o herramientas financieras:

```
0 = -27,755 + [362,600 / (1 + TIR)^1] + [362,600 / (1 + TIR)^2] + [362,600 / (1 + TIR)^3]
```

**TIR ≈ 1,305% anual** (aproximadamente)

**Interpretación**:
- ✅ **TIR = 1,305% >> COK = 10%**: El proyecto es **EXTREMADAMENTE ACEPTABLE**
- La rentabilidad del proyecto supera ampliamente el costo de oportunidad
- El proyecto es altamente atractivo desde el punto de vista de retorno de inversión

**Conclusión del Análisis Financiero**: ✅ **ALTAMENTE VIABLE**

Todos los indicadores financieros (B/C, VAN, TIR) demuestran que el proyecto es extremadamente viable desde el punto de vista financiero. La inversión inicial se recupera rápidamente y genera beneficios muy significativos tanto para los usuarios como para la institución.

---

## 6. Conclusiones

El análisis de factibilidad realizado para el proyecto RideUPT arroja resultados altamente positivos en todas las dimensiones evaluadas:

### Resumen de Factibilidades

1. **Factibilidad Técnica**: ✅ **VIABLE**
   - Todas las tecnologías necesarias están disponibles y son accesibles
   - La infraestructura requerida puede implementarse con recursos razonables
   - El stack tecnológico propuesto es moderno, escalable y mantenible

2. **Factibilidad Económica**: ✅ **VIABLE**
   - Inversión inicial razonable: S/. 27,755.00
   - Beneficios significativos superan ampliamente los costos
   - Relación Beneficio/Costo de 31.33 indica alta rentabilidad

3. **Factibilidad Operativa**: ✅ **VIABLE**
   - El sistema puede ser operado eficientemente con recursos mínimos adicionales
   - Impacto positivo significativo en la comunidad universitaria
   - Beneficios tangibles e intangibles justifican la operación

4. **Factibilidad Legal**: ✅ **VIABLE CON CONDICIONES**
   - No existen impedimentos legales fundamentales
   - Se requieren medidas estándar de protección de datos personales
   - Términos y condiciones claros evitarán conflictos

5. **Factibilidad Social**: ✅ **ALTAMENTE VIABLE**
   - Impacto social altamente positivo
   - Fortalecimiento de la comunidad universitaria
   - Promoción de valores de sostenibilidad y responsabilidad social

6. **Factibilidad Ambiental**: ✅ **ALTAMENTE VIABLE Y BENEFICIOSA**
   - Impacto ambiental neto altamente positivo
   - Reducción significativa de emisiones de CO₂
   - Contribución a objetivos de sostenibilidad

### Indicadores Financieros

- **Relación Beneficio/Costo (B/C)**: 31.33 (Altamente favorable)
- **Valor Actual Neto (VAN)**: S/. 873,977.53 (Muy positivo)
- **Tasa Interna de Retorno (TIR)**: ~1,305% (Extremadamente favorable)
- **Período de Recuperación**: Menos de 1 mes (muy rápido)

### Recomendación Final

**El proyecto RideUPT es ALTAMENTE VIABLE y se recomienda su implementación inmediata.**

El análisis exhaustivo en todas las dimensiones (técnica, económica, operativa, legal, social y ambiental) demuestra que:

1. El proyecto es técnicamente factible con tecnologías modernas y accesibles
2. La inversión es razonable y genera retornos excepcionales
3. El sistema puede operarse eficientemente
4. No existen impedimentos legales significativos
5. El impacto social es muy positivo
6. El impacto ambiental es altamente beneficioso

El proyecto no solo es viable, sino que representa una oportunidad excepcional para la Universidad Privada de Tacna de posicionarse como líder en innovación social, sostenibilidad y apoyo a su comunidad universitaria.

### Próximos Pasos Recomendados

1. **Aprobación formal del proyecto** por parte de la dirección universitaria
2. **Asignación de recursos** (presupuesto y personal)
3. **Formación del equipo de desarrollo** según la estructura propuesta
4. **Inicio de fase de desarrollo** siguiendo la metodología planificada
5. **Establecimiento de políticas y términos** legales necesarios
6. **Comunicación y sensibilización** a la comunidad universitaria

---

**Versión del Documento**: 1.0  
**Fecha**: 2025  
**Elaborado por**: Equipo de Desarrollo RideUPT  
**Revisado por**: Departamento de TI - UPT  
**Aprobado por**: Dirección de la Universidad Privada de Tacna

