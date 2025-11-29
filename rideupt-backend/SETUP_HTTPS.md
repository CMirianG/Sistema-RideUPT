# Configuración HTTPS para RideUPT Backend

Esta guía te ayudará a configurar HTTPS en tu servidor backend usando Nginx y Let's Encrypt.

## Requisitos Previos

- Servidor con IP: `161.132.50.113`
- Acceso root o sudo al servidor
- Dominio apuntando a la IP (opcional, pero recomendado)
- Puerto 80 y 443 abiertos en el firewall

## Opción 1: Con Dominio (Recomendado)

### Paso 1: Instalar Nginx y Certbot

```bash
# Conectarse al servidor
ssh root@161.132.50.113

# Actualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar Nginx
sudo apt install nginx -y

# Instalar Certbot (Let's Encrypt)
sudo apt install certbot python3-certbot-nginx -y
```

### Paso 2: Configurar Dominio DNS

Si tienes un dominio (ej: `api.rideupt.com`):
1. Crea un registro A en tu DNS apuntando a `161.132.50.113`
2. Espera a que se propague (puede tardar unos minutos)

Si NO tienes dominio, puedes usar la IP directamente (ver Opción 2).

### Paso 3: Crear Configuración de Nginx

```bash
# Crear archivo de configuración
sudo nano /etc/nginx/sites-available/rideupt-backend
```

Pega esta configuración (reemplaza `api.rideupt.com` con tu dominio o IP):

```nginx
server {
    listen 80;
    server_name api.rideupt.com 161.132.50.113;
    
    # Redirigir HTTP a HTTPS
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name api.rideupt.com 161.132.50.113;
    
    # Certificados SSL (se generan en el siguiente paso)
    ssl_certificate /etc/letsencrypt/live/api.rideupt.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/api.rideupt.com/privkey.pem;
    
    # Configuración SSL
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;
    
    # Headers de seguridad
    add_header Strict-Transport-Security "max-age=31536000" always;
    
    # Tamaño máximo de archivos
    client_max_body_size 10M;
    
    # Proxy para API REST
    location /api {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }
    
    # Proxy para Socket.IO
    location /socket.io {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
    
    # Health check
    location /health {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
    }
    
    # Archivos estáticos
    location /storage {
        alias /var/rideupt/storage;
        expires 30d;
    }
}
```

### Paso 4: Habilitar el Sitio

```bash
# Crear enlace simbólico
sudo ln -s /etc/nginx/sites-available/rideupt-backend /etc/nginx/sites-enabled/

# Eliminar configuración por defecto (opcional)
sudo rm /etc/nginx/sites-enabled/default

# Verificar configuración
sudo nginx -t

# Si todo está bien, recargar Nginx
sudo systemctl reload nginx
```

### Paso 5: Obtener Certificado SSL

```bash
# Si tienes dominio
sudo certbot --nginx -d api.rideupt.com

# Si solo tienes IP, usar:
sudo certbot --nginx -d 161.132.50.113

# O usar modo standalone (si Nginx no puede verificar)
sudo certbot certonly --standalone -d api.rideupt.com
```

Certbot modificará automáticamente tu configuración de Nginx para incluir los certificados.

### Paso 6: Verificar Renovación Automática

```bash
# Probar renovación
sudo certbot renew --dry-run

# Verificar que el timer esté activo
sudo systemctl status certbot.timer
```

## Opción 2: Sin Dominio (Solo IP)

Si no tienes dominio, puedes usar un certificado autofirmado (menos seguro pero funcional):

```bash
# Generar certificado autofirmado
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/rideupt-key.pem \
  -out /etc/nginx/ssl/rideupt-cert.pem \
  -subj "/C=PE/ST=Tacna/L=Tacna/O=RideUPT/CN=161.132.50.113"

# Crear directorio si no existe
sudo mkdir -p /etc/nginx/ssl
```

Luego en la configuración de Nginx, usa:
```nginx
ssl_certificate /etc/nginx/ssl/rideupt-cert.pem;
ssl_certificate_key /etc/nginx/ssl/rideupt-key.pem;
```

**Nota**: Los navegadores mostrarán una advertencia de seguridad con certificados autofirmados.

## Paso 7: Actualizar Firewall

```bash
# Permitir HTTP y HTTPS
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Verificar estado
sudo ufw status
```

## Paso 8: Actualizar Configuración de la App

Una vez que tengas HTTPS funcionando, actualiza `AppConfig` en Flutter:

```dart
// En rideupt_app/lib/utils/app_config.dart
static const String _serverIp = "api.rideupt.com";  // O tu dominio
// O mantener IP pero usar https://
```

Y cambiar:
```dart
static String get baseUrl {
  final host = _useServer ? _serverIp : _localHost;
  final port = _useServer ? _serverPort : _localPort;
  final protocol = _useServer ? 'https' : 'http';  // HTTPS en producción
  return '$protocol://$host:$port/api';
}
```

## Verificación

1. **Probar HTTPS directamente:**
   ```bash
   curl https://api.rideupt.com/health
   # O
   curl https://161.132.50.113/health
   ```

2. **Verificar desde el navegador:**
   - Abre: `https://api.rideupt.com/health`
   - Debe mostrar el JSON de health check

3. **Verificar logs de Nginx:**
   ```bash
   sudo tail -f /var/log/nginx/access.log
   sudo tail -f /var/log/nginx/error.log
   ```

## Solución de Problemas

### Error: "Port 80 already in use"
```bash
# Verificar qué está usando el puerto 80
sudo lsof -i :80
# Detener servicio si es necesario
sudo systemctl stop apache2  # Si está instalado
```

### Error: "Could not bind to address"
```bash
# Verificar que Nginx no esté corriendo
sudo systemctl stop nginx
# Luego intentar certbot en modo standalone
sudo certbot certonly --standalone -d api.rideupt.com
```

### El backend no responde
```bash
# Verificar que el backend esté corriendo
sudo docker ps  # O
sudo systemctl status rideupt-api

# Verificar logs
sudo docker logs rideupt-api-prod
```

## Notas Importantes

1. **Renovación Automática**: Let's Encrypt renueva automáticamente cada 90 días
2. **Backend debe seguir escuchando en localhost:3000**: Nginx hace el proxy
3. **CORS**: Asegúrate de que el backend permita `https://rideupt.firebaseapp.com`
4. **Firewall**: Asegúrate de que los puertos 80 y 443 estén abiertos




