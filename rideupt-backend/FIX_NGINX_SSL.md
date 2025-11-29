# 🔧 Solución: Error de Certificado SSL en Nginx

## Problema

```
nginx: [emerg] cannot load certificate "/etc/letsencrypt/live/rideupt.sytes.net/fullchain.pem": 
BIO_new_file() failed (SSL: error:02001002:system library:fopen:No such file or directory
```

**Causa**: El certificado SSL aún no existe, pero la configuración de Nginx intenta cargarlo.

## ✅ Solución Rápida

### Opción 1: Configurar sin SSL primero (Recomendado)

```bash
# 1. Copiar configuración temporal (sin SSL)
sudo cp nginx-rideupt-sytes-temp.conf /etc/nginx/sites-available/rideupt-backend

# 2. Verificar configuración
sudo nginx -t

# 3. Iniciar/Recargar Nginx
sudo systemctl start nginx
# O si ya está corriendo:
sudo systemctl reload nginx

# 4. Verificar que funciona
curl http://rideupt.sytes.net/health

# 5. Ahora obtener el certificado SSL
sudo certbot --nginx -d rideupt.sytes.net

# Certbot modificará automáticamente la configuración para incluir SSL
```

### Opción 2: Obtener certificado primero (Standalone)

```bash
# 1. Detener Nginx temporalmente
sudo systemctl stop nginx

# 2. Obtener certificado en modo standalone
sudo certbot certonly --standalone -d rideupt.sytes.net

# Te pedirá:
# - Email: tu email
# - Términos: A (Aceptar)
# - Compartir email: N (No)

# 3. Iniciar Nginx
sudo systemctl start nginx

# 4. Ahora copiar la configuración con SSL
sudo cp nginx-rideupt-sytes.conf /etc/nginx/sites-available/rideupt-backend

# 5. Verificar y recargar
sudo nginx -t
sudo systemctl reload nginx
```

## 🔍 Verificar que Funciona

```bash
# Verificar HTTP (debe redirigir a HTTPS)
curl -I http://rideupt.sytes.net/health

# Verificar HTTPS
curl https://rideupt.sytes.net/health

# Ver logs si hay problemas
sudo tail -f /var/log/nginx/error.log
```

## 📝 Comandos Útiles

```bash
# Ver estado de Nginx
sudo systemctl status nginx

# Ver configuración actual
sudo cat /etc/nginx/sites-available/rideupt-backend

# Verificar certificados existentes
sudo certbot certificates

# Ver logs de Certbot
sudo tail -f /var/log/letsencrypt/letsencrypt.log
```

## ⚠️ Notas Importantes

1. **El dominio debe apuntar a la IP** antes de obtener el certificado:
   ```bash
   nslookup rideupt.sytes.net
   # Debe mostrar: 161.132.50.113
   ```

2. **Puerto 80 debe estar abierto** para la verificación de Certbot:
   ```bash
   sudo ufw allow 80/tcp
   ```

3. **El backend debe estar corriendo** en `localhost:3000`:
   ```bash
   curl http://localhost:3000/health
   ```

## 🐛 Si Certbot Falla

### Error: "Domain does not point to this server"

**Solución**:
1. Verifica DNS: `nslookup rideupt.sytes.net`
2. Espera a que se propague (puede tardar unos minutos)
3. Verifica en No-IP que el registro A esté configurado

### Error: "Port 80 already in use"

**Solución**:
```bash
# Ver qué está usando el puerto 80
sudo lsof -i :80

# Detener Apache si está instalado
sudo systemctl stop apache2
```

### Error: "Connection refused"

**Solución**:
```bash
# Verificar que Nginx esté corriendo
sudo systemctl status nginx

# Iniciar si no está corriendo
sudo systemctl start nginx

# Verificar logs
sudo journalctl -u nginx -f
```




