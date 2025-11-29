# 📝 Archivos Modificados para Actualizar en el Servidor

## ⚠️ IMPORTANTE: Archivos que debes actualizar en tu servidor

### 1. **routes/driverDocuments.js** ⚠️ CRÍTICO
   - **Problema corregido**: Conflicto de nombres con variable `storage`
   - **Cambio**: Renombrado a `storageConfig` y `multerStorage`
   - **Ubicación**: `rideupt-backend/routes/driverDocuments.js`

### 2. **controllers/driverDocumentController.js**
   - **Cambio**: Import actualizado para usar el módulo de storage
   - **Ubicación**: `rideupt-backend/controllers/driverDocumentController.js`

### 3. **config/storage.js** ⚠️ NUEVO ARCHIVO
   - **Acción**: Crear este archivo nuevo
   - **Ubicación**: `rideupt-backend/config/storage.js`

### 4. **server.js**
   - **Cambio**: Agregado servicio de archivos estáticos y inicialización de storage
   - **Ubicación**: `rideupt-backend/server.js`

### 5. **docker-compose.prod.yml**
   - **Cambio**: Agregado volumen de almacenamiento y variable de entorno
   - **Ubicación**: `rideupt-backend/docker-compose.prod.yml`

---

## 🚀 Pasos para Actualizar en el Servidor

### Opción 1: Actualizar archivos específicos (Recomendado)

```bash
# 1. Conectarte al servidor
ssh root@tu-servidor

# 2. Ir al directorio del backend
cd /opt/rideupt-backend

# 3. Hacer backup (por si acaso)
cp routes/driverDocuments.js routes/driverDocuments.js.backup
cp controllers/driverDocumentController.js controllers/driverDocumentController.js.backup
cp server.js server.js.backup
cp docker-compose.prod.yml docker-compose.prod.yml.backup

# 4. Actualizar los archivos (copia el contenido desde tu máquina local)
# Usa nano, vim, o edita desde tu IDE remoto
```

### Opción 2: Sincronizar desde tu máquina local

```bash
# Desde tu máquina local (Windows)
scp rideupt-backend/routes/driverDocuments.js root@tu-servidor:/opt/rideupt-backend/routes/
scp rideupt-backend/controllers/driverDocumentController.js root@tu-servidor:/opt/rideupt-backend/controllers/
scp rideupt-backend/config/storage.js root@tu-servidor:/opt/rideupt-backend/config/
scp rideupt-backend/server.js root@tu-servidor:/opt/rideupt-backend/
scp rideupt-backend/docker-compose.prod.yml root@tu-servidor:/opt/rideupt-backend/
```

### Opción 3: Usar Git (si tienes repositorio)

```bash
# En el servidor
cd /opt/rideupt-backend
git pull origin main
```

---

## ✅ Después de Actualizar

```bash
# 1. Reconstruir e iniciar
docker compose -f docker-compose.prod.yml down
docker compose -f docker-compose.prod.yml up -d --build

# 2. Verificar logs
docker compose -f docker-compose.prod.yml logs -f api
```

Deberías ver:
```
✅ Almacenamiento inicializado correctamente
✅ SERVIDOR CORRIENDO EXITOSAMENTE
```

---

## 📋 Resumen de Cambios por Archivo

### routes/driverDocuments.js
- Línea 16: `const storage = require(...)` → `const storageConfig = require(...)`
- Línea 19: `const storage = multer.diskStorage(...)` → `const multerStorage = multer.diskStorage(...)`
- Línea 49: `storage: storage` → `storage: multerStorage`

### controllers/driverDocumentController.js
- Líneas 5-9: Import actualizado para usar el módulo storage correctamente

### config/storage.js (NUEVO)
- Archivo completo nuevo - copiar todo el contenido

### server.js
- Línea ~8: Agregado `const { initializeStorage, DOCUMENTS_DIR } = require('./config/storage');`
- Línea ~27: Agregado `initializeStorage();`
- Línea ~57: Agregado servicio de archivos estáticos

### docker-compose.prod.yml
- Línea ~27: Agregado volumen `- /var/rideupt/storage:/var/rideupt/storage`
- Línea ~25: Agregado `- STORAGE_BASE_DIR=/var/rideupt/storage`





