# 🚀 Guía Rápida: Configurar HTTPS en 5 Minutos

## Opción A: Script Automatizado (Recomendado)

### 1. Conectarse al servidor
```bash
ssh root@161.132.50.113
```

### 2. Ejecutar el script
```bash
cd /opt/rideupt-backend  # O donde esté tu backend
chmod +x setup-https.sh
sudo ./setup-https.sh
```

El script te preguntará:
- ¿Tienes dominio? (s/n)
- Si tienes dominio, ingresa el nombre (ej: `api.rideupt.com`)

### 3. ¡Listo! El script hace todo automáticamente

---

## Opción B: Manual (Si prefieres control total)

### Paso 1: Instalar Nginx y Certbot
```bash
sudo apt update
sudo apt install -y nginx certbot python3-certbot-nginx
```

### Paso 2: Crear configuración de Nginx
```bash
sudo nano /etc/nginx/sites-available/rideupt-backend
```

Copia el contenido de `nginx-config-example.conf` y ajusta:
- `server_name` con tu dominio o IP
- Rutas de certificados SSL

### Paso 3: Habilitar sitio
```bash
sudo ln -s /etc/nginx/sites-available/rideupt-backend /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl reload nginx
```

### Paso 4: Obtener certificado SSL

**Con dominio:**
```bash
sudo certbot --nginx -d api.rideupt.com
```

**Sin dominio (certificado autofirmado):**
```bash
sudo mkdir -p /etc/nginx/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/rideupt-key.pem \
  -out /etc/nginx/ssl/rideupt-cert.pem \
  -subj "/C=PE/ST=Tacna/L=Tacna/O=RideUPT/CN=161.132.50.113"
```

### Paso 5: Abrir puertos en firewall
```bash
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
```

---

## Actualizar la App Flutter

Una vez que HTTPS esté funcionando, actualiza `app_config.dart`:

```dart
// En rideupt_app/lib/utils/app_config.dart

// Cambiar puerto a 443
static const String _serverPort = "443";

// Activar HTTPS
static const bool _useHttps = true;

// Si tienes dominio, cambiar IP por dominio
static const String _serverIp = "api.rideupt.com";  // O mantener IP
```

Luego recompila y despliega:
```bash
cd rideupt_app
flutter build web --release
firebase deploy
```

---

## Verificación

### 1. Probar HTTPS directamente
```bash
curl https://161.132.50.113/health
# O con dominio
curl https://api.rideupt.com/health
```

### 2. Verificar desde navegador
Abre: `https://161.132.50.113/health` (o tu dominio)

Debe mostrar el JSON de health check sin errores de certificado.

### 3. Ver logs de Nginx
```bash
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log
```

---

## Solución de Problemas

### Error: "Port 80 already in use"
```bash
sudo lsof -i :80
sudo systemctl stop apache2  # Si está instalado
```

### Error: "Could not bind to address"
```bash
sudo systemctl stop nginx
sudo certbot certonly --standalone -d tu-dominio.com
sudo systemctl start nginx
```

### El backend no responde
```bash
# Verificar que el backend esté corriendo
sudo docker ps
curl http://localhost:3000/health
```

### Certificado no se renueva automáticamente
```bash
sudo certbot renew --dry-run
sudo systemctl enable certbot.timer
sudo systemctl status certbot.timer
```

---

## ¿Necesitas Ayuda?

1. Revisa los logs: `sudo journalctl -u nginx -f`
2. Verifica configuración: `sudo nginx -t`
3. Revisa firewall: `sudo ufw status`
4. Verifica DNS: `nslookup tu-dominio.com`

---

## Notas Importantes

✅ **El backend debe seguir escuchando en `localhost:3000`**  
✅ **Nginx hace el proxy de HTTPS → HTTP interno**  
✅ **Los certificados se renuevan automáticamente cada 90 días**  
✅ **Asegúrate de que CORS permita `https://rideupt.firebaseapp.com`**




