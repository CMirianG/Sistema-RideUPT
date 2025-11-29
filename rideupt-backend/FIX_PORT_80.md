# 🔧 Solución: Puerto 80 ya está en uso

## Problema
```
nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)
```

**Causa**: Otro servicio (probablemente Apache) está usando el puerto 80.

## ✅ Solución Rápida

### Paso 1: Identificar qué está usando el puerto 80

```bash
# Ver qué proceso está usando el puerto 80
sudo lsof -i :80

# O usar netstat
sudo netstat -tlnp | grep :80

# O usar ss
sudo ss -tlnp | grep :80
```

### Paso 2: Detener el servicio que está usando el puerto 80

**Si es Apache:**
```bash
# Detener Apache
sudo systemctl stop apache2

# Deshabilitar Apache para que no se inicie automáticamente
sudo systemctl disable apache2

# Verificar que se detuvo
sudo systemctl status apache2
```

**Si es otro servicio de Nginx:**
```bash
# Ver procesos de Nginx
ps aux | grep nginx

# Matar procesos de Nginx si hay alguno colgado
sudo pkill -9 nginx
```

**Si es otro servicio:**
```bash
# Ver el PID del proceso
sudo lsof -i :80

# Matar el proceso (reemplaza PID con el número que aparezca)
sudo kill -9 PID
```

### Paso 3: Verificar que el puerto 80 esté libre

```bash
# Verificar que el puerto 80 esté libre
sudo lsof -i :80

# No debe mostrar nada (o solo mostrar LISTEN sin proceso)
```

### Paso 4: Iniciar Nginx

```bash
# Iniciar Nginx
sudo systemctl start nginx

# Verificar estado
sudo systemctl status nginx

# Verificar que funciona
curl http://localhost/health
```

## 🔍 Verificación Completa

```bash
# 1. Verificar que el puerto 80 esté libre
sudo lsof -i :80

# 2. Verificar configuración de Nginx
sudo nginx -t

# 3. Iniciar Nginx
sudo systemctl start nginx

# 4. Verificar estado
sudo systemctl status nginx

# 5. Probar que funciona
curl http://rideupt.sytes.net/health
```

## 📝 Comandos Útiles

```bash
# Ver todos los servicios web corriendo
sudo systemctl list-units | grep -E 'nginx|apache'

# Ver puertos en uso
sudo netstat -tlnp

# Ver logs de Nginx
sudo tail -f /var/log/nginx/error.log
```




