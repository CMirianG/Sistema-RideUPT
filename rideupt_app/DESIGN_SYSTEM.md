# 🎨 RideUpt Design System

## Sistema de Diseño Visual Profesional

Sistema de diseño completo inspirado en **inDrive**, **Uber** y **Bolt**, diseñado para transmitir **seguridad, eficiencia, confianza y modernidad**.

---

## 🎯 Filosofía de Diseño

### Percepción Objetivo
- **Seguridad**: Colores confiables y profesionales
- **Eficiencia**: Interfaz limpia y funcional
- **Confianza**: Paleta consistente y predecible
- **Modernidad**: Estética tecnológica y actual

### Principios
1. **Consistencia**: Mismo lenguaje visual en toda la app
2. **Legibilidad**: Contraste óptimo en ambos temas
3. **Accesibilidad**: Cumplimiento de WCAG 2.1
4. **Eficiencia**: Diseño que facilita la acción rápida

---

## 🎨 Paleta de Colores

### Tema Claro (Light Theme)

#### Colores Principales
```dart
// Primario - Azul Petróleo
Primary: #1E88E5        // Botones principales, AppBar, acentos
OnPrimary: #FFFFFF      // Texto sobre primario
PrimaryContainer: #E3F2FD  // Fondos suaves primarios
OnPrimaryContainer: #0D47A1  // Texto sobre container primario

// Secundario - Azul Profundo
Secondary: #1565C0      // Elementos secundarios
OnSecondary: #FFFFFF
SecondaryContainer: #E1F5FE
OnSecondaryContainer: #01579B

// Terciario - Verde Azulado (Cyan)
Tertiary: #00ACC1       // Acentos, estados especiales
OnTertiary: #FFFFFF
TertiaryContainer: #E0F7FA
OnTertiaryContainer: #006064
```

#### Fondos y Superficies
```dart
Surface: #FFFFFF              // Fondo principal
OnSurface: #1A1A1A           // Texto principal
SurfaceContainerHighest: #F5F5F5  // Superficies elevadas
OnSurfaceVariant: #616161    // Texto secundario
SurfaceVariant: #FAFAFA      // Superficies alternativas
```

#### Bordes y Divisores
```dart
Outline: #E0E0E0        // Bordes estándar
OutlineVariant: #F5F5F5  // Bordes sutiles
```

#### Estados Semánticos
```dart
Error: #E53935          // Errores
OnError: #FFFFFF
ErrorContainer: #FFEBEE
OnErrorContainer: #B71C1C
```

**Percepción del Tema Claro:**
- ✨ Limpio y profesional
- 🌞 Ideal para uso diurno
- 📱 Moderno y tecnológico
- 🎯 Alto contraste y legibilidad

---

### Tema Oscuro (Dark Theme)

#### Colores Principales
```dart
// Primario - Azul más claro para contraste
Primary: #64B5F6        // Más claro para mejor visibilidad
OnPrimary: #0D47A1
PrimaryContainer: #1565C0
OnPrimaryContainer: #E3F2FD

// Secundario - Cyan claro
Secondary: #81D4FA
OnSecondary: #01579B
SecondaryContainer: #0277BD
OnSecondaryContainer: #E1F5FE

// Terciario - Cyan vibrante
Tertiary: #4DD0E1
OnTertiary: #006064
TertiaryContainer: #00838F
OnTertiaryContainer: #E0F7FA
```

#### Fondos y Superficies
```dart
Surface: #121212              // Casi negro (Material Dark)
OnSurface: #E0E0E0           // Gris claro
SurfaceContainerHighest: #1E1E1E  // Superficies elevadas
OnSurfaceVariant: #B0B0B0    // Texto secundario
SurfaceVariant: #1C1C1C      // Superficies alternativas
```

#### Bordes y Divisores
```dart
Outline: #424242        // Gris medio oscuro
OutlineVariant: #2C2C2C  // Gris oscuro
```

#### Estados Semánticos
```dart
Error: #EF5350          // Rojo más claro para contraste
OnError: #B71C1C
ErrorContainer: #C62828
OnErrorContainer: #FFCDD2
```

**Percepción del Tema Oscuro:**
- 🌙 Sofisticado y elegante
- 💤 Reduce fatiga visual
- 🔋 Ahorro de batería (OLED)
- 🎨 Moderno y tecnológico

---

## 📐 Sistema de Espaciado

### Grid System (8pt Base)
```dart
spacingXS = 4.0   // 0.5x - Espaciado mínimo
spacingSM = 8.0   // 1x   - Espaciado pequeño
spacingMD = 16.0  // 2x   - Espaciado medio (estándar)
spacingLG = 24.0  // 3x   - Espaciado grande
spacingXL = 32.0  // 4x   - Espaciado extra grande
spacingXXL = 48.0 // 6x   - Espaciado máximo
```

### Uso Recomendado
- **Padding interno de cards**: `spacingMD` (16px)
- **Espaciado entre elementos**: `spacingSM` a `spacingMD`
- **Márgenes de pantalla**: `spacingMD` (móvil), `spacingLG` (tablet)
- **Espaciado de secciones**: `spacingLG` a `spacingXL`

---

## 🔲 Radios de Borde

```dart
radiusSM = 8.0    // Elementos pequeños (chips, badges)
radiusMD = 12.0   // Cards, botones, inputs (estándar)
radiusLG = 16.0   // Contenedores grandes
radiusXL = 24.0   // Modales, diálogos
radiusRound = 999.0  // Botones circulares
```

### Uso Recomendado
- **Botones**: `radiusMD` (12px)
- **Cards**: `radiusMD` (12px)
- **Inputs**: `radiusMD` (12px)
- **Modales**: `radiusXL` (24px)
- **Avatares**: `radiusRound`

---

## 🔤 Tipografía

### Fuente
**Roboto** (similar a Inter) - Moderna, legible, optimizada para pantallas

### Escala Tipográfica

#### Display (Títulos muy grandes)
```dart
displayLarge:  57px, Bold, -0.5 letter-spacing
displayMedium: 45px, Bold, -0.3 letter-spacing
displaySmall:  36px, Bold, -0.2 letter-spacing
```

#### Headline (Títulos principales)
```dart
headlineLarge:  32px, Bold, 0 letter-spacing
headlineMedium: 28px, SemiBold (600), 0 letter-spacing
headlineSmall:  24px, SemiBold (600), 0 letter-spacing
```

#### Title (Títulos de sección)
```dart
titleLarge:  22px, SemiBold (600), 0.15 letter-spacing
titleMedium: 16px, SemiBold (600), 0.15 letter-spacing
titleSmall:  14px, Medium (500), 0.1 letter-spacing
```

#### Body (Texto principal)
```dart
bodyLarge:  16px, Regular (400), 0.5 letter-spacing
bodyMedium: 14px, Regular (400), 0.25 letter-spacing
bodySmall:  12px, Regular (400), 0.4 letter-spacing
```

#### Label (Etiquetas y botones)
```dart
labelLarge:  14px, SemiBold (600), 0.1 letter-spacing
labelMedium: 12px, Medium (500), 0.5 letter-spacing
labelSmall:  11px, Medium (500), 0.5 letter-spacing
```

### Uso Recomendado
- **Títulos de pantalla**: `headlineMedium` o `headlineSmall`
- **Títulos de sección**: `titleLarge` o `titleMedium`
- **Texto de cuerpo**: `bodyLarge` o `bodyMedium`
- **Etiquetas y captions**: `bodySmall` o `labelMedium`
- **Botones**: `labelLarge`

---

## 🎯 Componentes Principales

### Botones

#### Filled Button (Primario)
- **Color**: Primary
- **Texto**: OnPrimary (blanco)
- **Padding**: 24px horizontal, 16px vertical
- **Radio**: 12px
- **Altura mínima**: 48px

#### Outlined Button (Secundario)
- **Borde**: Primary, 1.5px
- **Texto**: Primary
- **Fondo**: Transparente
- **Radio**: 12px

#### Text Button (Terciario)
- **Texto**: Primary
- **Sin borde ni fondo**
- **Padding reducido**

### Cards
- **Fondo**: Surface
- **Borde**: Outline con 0.2 opacidad
- **Radio**: 12px
- **Elevación**: 0 (diseño plano)
- **Padding interno**: 16px

### Inputs
- **Fondo**: SurfaceContainerHighest
- **Borde**: Outline (0.5 opacidad)
- **Borde activo**: Primary, 2px
- **Radio**: 12px
- **Padding**: 16px

### Chips
- **Fondo**: SurfaceContainerHighest
- **Seleccionado**: PrimaryContainer
- **Radio**: 8px
- **Padding**: 16px horizontal, 8px vertical

---

## 📱 Responsive Design

### Breakpoints
```dart
Mobile:  < 600px
Tablet:  600px - 1200px
Desktop: > 1200px
```

### Espaciado Responsivo
- **Mobile**: 16px padding horizontal
- **Tablet**: 24px padding horizontal
- **Desktop**: 48px padding horizontal

### Grid Columns
- **Mobile**: 1 columna
- **Tablet**: 2 columnas
- **Desktop**: 3 columnas

---

## ✨ Animaciones y Transiciones

### Duración
- **Rápida**: 200ms (microinteracciones)
- **Estándar**: 300ms (transiciones)
- **Lenta**: 500ms (transiciones complejas)

### Curvas
- **Ease In Out**: Transiciones suaves
- **Ease Out**: Elementos que aparecen
- **Ease In**: Elementos que desaparecen

---

## 🎨 Tokens de Diseño (CSS Variables Style)

```dart
// Colores Primarios
--color-primary: #1E88E5
--color-primary-container: #E3F2FD
--color-on-primary: #FFFFFF
--color-on-primary-container: #0D47A1

// Colores Secundarios
--color-secondary: #1565C0
--color-secondary-container: #E1F5FE
--color-on-secondary: #FFFFFF
--color-on-secondary-container: #01579B

// Colores Terciarios
--color-tertiary: #00ACC1
--color-tertiary-container: #E0F7FA
--color-on-tertiary: #FFFFFF
--color-on-tertiary-container: #006064

// Fondos
--color-surface: #FFFFFF (light) / #121212 (dark)
--color-surface-container: #F5F5F5 (light) / #1E1E1E (dark)
--color-on-surface: #1A1A1A (light) / #E0E0E0 (dark)
--color-on-surface-variant: #616161 (light) / #B0B0B0 (dark)

// Bordes
--color-outline: #E0E0E0 (light) / #424242 (dark)
--color-outline-variant: #F5F5F5 (light) / #2C2C2C (dark)

// Estados
--color-error: #E53935 (light) / #EF5350 (dark)
--color-success: #4CAF50
--color-warning: #FF9800

// Espaciado
--spacing-xs: 4px
--spacing-sm: 8px
--spacing-md: 16px
--spacing-lg: 24px
--spacing-xl: 32px
--spacing-xxl: 48px

// Radios
--radius-sm: 8px
--radius-md: 12px
--radius-lg: 16px
--radius-xl: 24px
--radius-round: 999px
```

---

## 📋 Checklist de Implementación

- [x] Paleta de colores completa (claro y oscuro)
- [x] Sistema de espaciado (8pt grid)
- [x] Radios de borde definidos
- [x] Tipografía escalada
- [x] Componentes base estilizados
- [x] Tokens de diseño documentados
- [x] Responsive breakpoints
- [x] Contraste WCAG 2.1 AA

---

## 🚀 Próximos Pasos

1. **Iconografía**: Definir estilo de iconos (outline vs filled)
2. **Ilustraciones**: Estilo de ilustraciones y gráficos
3. **Microinteracciones**: Detalles de animaciones específicas
4. **Componentes avanzados**: Mapas, cards de viaje, etc.

---

**Versión**: 1.0.0  
**Última actualización**: 2024  
**Diseñado para**: RideUpt - App de Transporte Universitario


