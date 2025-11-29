# 🚀 Configuración HTTPS para rideupt.sytes.net

Guía específica para configurar HTTPS en tu backend usando el dominio `rideupt.sytes.net`.

## 📋 Requisitos Previos

- ✅ Dominio: `rideupt.sytes.net` (No-IP)
- ✅ IP del servidor: `161.132.50.113`
- ✅ Acceso root o sudo al servidor
- ✅ Puerto 80 y 443 abiertos en el firewall
- ✅ El dominio debe apuntar a la IP `161.132.50.113`

## 🔧 Paso 1: Verificar DNS

Antes de continuar, verifica que el dominio apunte a tu IP:

```bash
# Desde tu PC
nslookup rideupt.sytes.net

# Debe mostrar: 161.132.50.113
```

Si no apunta correctamente, configura el DNS en No-IP.

## 📦 Paso 2: Instalar Nginx y Certbot

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

## ⚙️ Paso 3: Configurar Nginx (Temporal - Sin SSL)

**IMPORTANTE**: Primero configuramos Nginx sin SSL para que funcione, luego obtenemos el certificado.

```bash
# Copiar la configuración TEMPORAL (sin SSL)
sudo cp nginx-rideupt-sytes-temp.conf /etc/nginx/sites-available/rideupt-backend

# O crear manualmente
sudo nano /etc/nginx/sites-available/rideupt-backend
```

## 🔗 Paso 4: Habilitar el Sitio

```bash
# Crear enlace simbólico
sudo ln -s /etc/nginx/sites-available/rideupt-backend /etc/nginx/sites-enabled/

# Eliminar configuración por defecto (opcional)
sudo rm -f /etc/nginx/sites-enabled/default

# Verificar configuración
sudo nginx -t

# Si todo está bien, iniciar/recargar Nginx
sudo systemctl start nginx  # Si no está corriendo
sudo systemctl reload nginx  # Si ya está corriendo

# Verificar que Nginx esté activo
sudo systemctl status nginx
```

## 🔐 Paso 5: Obtener Certificado SSL

```bash
# Obtener certificado SSL para rideupt.sytes.net
sudo certbot --nginx -d rideupt.sytes.net

# Certbot te pedirá:
# - Email: ingresa tu email
# - Términos: A (Aceptar)
# - Compartir email: N (No, a menos que quieras)
# - Redirigir HTTP a HTTPS: 2 (Redirigir)
```

Certbot modificará automáticamente tu configuración de Nginx para incluir los certificados SSL.

**Alternativa si Certbot falla con --nginx:**

```bash
# Obtener certificado en modo standalone (detiene Nginx temporalmente)
sudo systemctl stop nginx
sudo certbot certonly --standalone -d rideupt.sytes.net
sudo systemctl start nginx

# Luego actualizar manualmente la configuración con SSL
sudo cp nginx-rideupt-sytes.conf /etc/nginx/sites-available/rideupt-backend
sudo nginx -t
sudo systemctl reload nginx
```

## 🔥 Paso 6: Configurar Firewall

```bash
# Permitir HTTP y HTTPS
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Verificar estado
sudo ufw status
```

## ✅ Paso 7: Verificar Funcionamiento

```bash
# Probar HTTPS directamente
curl https://rideupt.sytes.net/health

# Debe mostrar el JSON de health check
```

Desde el navegador:
- Abre: `https://rideupt.sytes.net/health`
- Debe mostrar el JSON sin errores de certificado

## 📱 Paso 8: Actualizar App Flutter

Actualiza `app_config.dart`:

```dart
// En rideupt_app/lib/utils/app_config.dart

// Cambiar IP por dominio
static const String _serverIp = "rideupt.sytes.net";

// Puerto HTTPS
static const String _serverPort = "443";

// Activar HTTPS
static const bool _useHttps = true;
```

Luego recompila y despliega:
```bash
cd rideupt_app
flutter build web --release
firebase deploy
```

## 🔄 Paso 9: Verificar Renovación Automática

```bash
# Probar renovación
sudo certbot renew --dry-run

# Verificar que el timer esté activo
sudo systemctl status certbot.timer
sudo systemctl enable certbot.timer
```

## 🐛 Solución de Problemas

### Error: "Domain does not point to this server"

**Causa**: El dominio no apunta a la IP correcta.

**Solución**:
1. Verifica DNS: `nslookup rideupt.sytes.net`
2. Espera a que se propague (puede tardar unos minutos)
3. Verifica en No-IP que el registro A esté configurado

### Error: "Port 80 already in use"

**Causa**: Otro servicio está usando el puerto 80.

**Solución**:
```bash
# Verificar qué está usando el puerto 80
sudo lsof -i :80

# Detener Apache si está instalado
sudo systemctl stop apache2
```

### Error: "Could not bind to address"

**Causa**: Nginx no puede iniciar.

**Solución**:
```bash
# Verificar configuración
sudo nginx -t

# Ver logs de error
sudo tail -f /var/log/nginx/error.log
```

### El backend no responde

**Causa**: El backend no está corriendo o no es accesible.

**Solución**:
```bash
# Verificar que el backend esté corriendo
sudo docker ps
# O
sudo systemctl status rideupt-api

# Verificar que responda localmente
curl http://localhost:3000/health

# Ver logs
sudo docker logs rideupt-api-prod
```

## 📝 Comandos Útiles

```bash
# Ver logs de Nginx
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log

# Reiniciar Nginx
sudo systemctl restart nginx

# Ver estado de Nginx
sudo systemctl status nginx

# Verificar certificados SSL
sudo certbot certificates

# Renovar certificado manualmente
sudo certbot renew
```

## ✅ Checklist Final

- [ ] DNS configurado correctamente (`rideupt.sytes.net` → `161.132.50.113`)
- [ ] Nginx instalado y configurado
- [ ] Certificado SSL obtenido
- [ ] Firewall configurado (puertos 80 y 443)
- [ ] Backend accesible en `https://rideupt.sytes.net/health`
- [ ] App Flutter actualizada con el nuevo dominio
- [ ] Renovación automática de certificados configurada

## 🎉 ¡Listo!

Tu backend ahora está accesible en:
- **HTTPS**: `https://rideupt.sytes.net`
- **API**: `https://rideupt.sytes.net/api`
- **Health Check**: `https://rideupt.sytes.net/health`

