# Guía para Publicar la Aplicación Web RideUPT

Esta guía te ayudará a compilar y publicar tu aplicación Flutter web.

## 📋 Requisitos Previos

1. Flutter SDK instalado (versión 3.7.2 o superior)
2. Chrome instalado (para pruebas)
3. Cuenta en un servicio de hosting (Firebase Hosting, Netlify, Vercel, etc.)

## 🔧 Paso 1: Configurar la URL del Backend para Producción

Antes de compilar, debes actualizar la URL del backend en `lib/utils/app_config.dart`:

```dart
// Cambiar a la URL de tu servidor en producción
static const String _serverIp = "tu-dominio.com"; // o tu IP pública
static const String _serverPort = "3000"; // o el puerto que uses
static const bool _useServer = true; // Asegúrate de que esté en true
```

**Importante:** Si usas HTTPS en producción, cambia `http://` por `https://` en los métodos `baseUrl` y `socketUrl`.

## 🏗️ Paso 2: Compilar la Aplicación Web

### Opción A: Compilación Estándar (Recomendada)

```bash
# Navegar a la carpeta del proyecto
cd rideupt_app

# Limpiar builds anteriores
flutter clean

# Obtener dependencias
flutter pub get

# Compilar para web
flutter build web --release
```

### Opción B: Compilación con Base Path (si publicas en subdirectorio)

```bash
flutter build web --release --base-href="/rideupt/"
```

### Opción C: Compilación con Renderizado HTML (mejor rendimiento)

```bash
flutter build web --release --web-renderer html
```

**Nota:** El resultado se generará en `rideupt_app/build/web/`

## 📦 Paso 3: Probar Localmente Antes de Publicar

```bash
# Servir la aplicación localmente
flutter run -d chrome --web-port=8080
```

O usando un servidor HTTP simple:

```bash
# Instalar http-server (si no lo tienes)
npm install -g http-server

# Navegar a la carpeta build/web
cd build/web

# Iniciar servidor
http-server -p 8080
```

Luego abre `http://localhost:8080` en tu navegador.

## 🚀 Paso 4: Publicar en un Servicio de Hosting

### Opción 1: Firebase Hosting (Recomendado - Gratis)

#### 4.1. Instalar Firebase CLI

```bash
npm install -g firebase-tools
```

#### 4.2. Iniciar sesión en Firebase

```bash
firebase login
```

#### 4.3. Inicializar Firebase en tu proyecto

```bash
cd rideupt_app
firebase init hosting
```

Selecciona:
- ¿Qué archivos usar? → `build/web`
- ¿Configurar como SPA? → `Yes`
- ¿Configurar GitHub Actions? → `No` (opcional)

#### 4.4. Configurar firebase.json

Crea o edita `firebase.json`:

```json
{
  "hosting": {
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ],
    "headers": [
      {
        "source": "**/*.@(jpg|jpeg|gif|png|svg|webp|js|css|eot|otf|ttf|ttc|woff|woff2|font.css)",
        "headers": [
          {
            "key": "Cache-Control",
            "value": "max-age=604800"
          }
        ]
      }
    ]
  }
}
```

#### 4.5. Desplegar

```bash
# Compilar
flutter build web --release

# Desplegar
firebase deploy --only hosting
```

Tu aplicación estará disponible en: `https://tu-proyecto.web.app`

### Opción 2: Netlify (Gratis y Fácil)

#### 4.1. Instalar Netlify CLI

```bash
npm install -g netlify-cli
```

#### 4.2. Compilar y Desplegar

```bash
# Compilar
flutter build web --release

# Desplegar
cd build/web
netlify deploy --prod --dir=.
```

O arrastra la carpeta `build/web` a [app.netlify.com/drop](https://app.netlify.com/drop)

### Opción 3: Vercel (Gratis)

#### 4.1. Instalar Vercel CLI

```bash
npm install -g vercel
```

#### 4.2. Desplegar

```bash
# Compilar
flutter build web --release

# Desplegar
cd build/web
vercel --prod
```

### Opción 4: GitHub Pages (Gratis)

#### 4.1. Crear script de despliegue

Crea `deploy.sh`:

```bash
#!/bin/bash
flutter build web --release --base-href="/rideupt-app/"
cd build/web
git init
git add .
git commit -m "Deploy to GitHub Pages"
git branch -M main
git remote add origin https://github.com/TU_USUARIO/TU_REPO.git
git push -f origin main:gh-pages
```

#### 4.2. Configurar GitHub Pages

1. Ve a Settings → Pages en tu repositorio
2. Selecciona la rama `gh-pages` como fuente
3. Tu app estará en: `https://TU_USUARIO.github.io/TU_REPO/`

### Opción 5: Servidor Propio (VPS/Cloud)

#### 4.1. Usar Nginx

Instala Nginx en tu servidor y configura:

```nginx
server {
    listen 80;
    server_name tu-dominio.com;
    
    root /var/www/rideupt_app/build/web;
    index index.html;
    
    location / {
        try_files $uri $uri/ /index.html;
    }
    
    # Cache para assets estáticos
    location ~* \.(jpg|jpeg|png|gif|ico|css|js|svg|woff|woff2)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
```

#### 4.2. Subir archivos

```bash
# Comprimir
cd rideupt_app/build
tar -czf web.tar.gz web/

# Subir al servidor (usando SCP)
scp web.tar.gz usuario@tu-servidor:/var/www/

# En el servidor, descomprimir
ssh usuario@tu-servidor
cd /var/www
tar -xzf web.tar.gz
```

## 🔒 Paso 5: Configurar HTTPS (Importante)

Para producción, es **obligatorio** usar HTTPS:

### Con Firebase/Netlify/Vercel
- Se configura automáticamente con certificado SSL gratuito

### Con servidor propio
- Usa Let's Encrypt con Certbot:
```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d tu-dominio.com
```

## ⚙️ Paso 6: Configurar CORS en el Backend

Asegúrate de que tu backend permita peticiones desde tu dominio web:

```javascript
// En server.js
app.use(cors({
  origin: [
    'https://tu-dominio.com',
    'https://tu-proyecto.web.app',
    // Agrega todos los dominios donde esté publicada tu app
  ],
  credentials: true
}));
```

## 📱 Paso 7: Configurar PWA (Progressive Web App)

Tu aplicación ya tiene `manifest.json`. Para habilitar PWA completa:

1. Edita `web/manifest.json` con la información de tu app
2. Agrega un service worker si quieres funcionalidad offline

## 🐛 Solución de Problemas

### Error: "Failed to load resource"
- Verifica que la URL del backend en `app_config.dart` sea correcta
- Asegúrate de que el backend esté accesible desde internet

### Error: "CORS policy"
- Configura CORS en el backend para permitir tu dominio

### La app no carga
- Verifica que todos los archivos estén en `build/web`
- Revisa la consola del navegador para errores

### Imágenes no se muestran
- Verifica las rutas de las imágenes
- Asegúrate de que los assets estén incluidos en `pubspec.yaml`

## 📝 Checklist Final

- [ ] URL del backend configurada para producción
- [ ] Aplicación compilada con `flutter build web --release`
- [ ] Probada localmente
- [ ] Desplegada en el servicio de hosting
- [ ] HTTPS configurado
- [ ] CORS configurado en el backend
- [ ] Dominio personalizado configurado (opcional)

## 🎉 ¡Listo!

Tu aplicación web debería estar disponible públicamente. Comparte el enlace con tus usuarios.








