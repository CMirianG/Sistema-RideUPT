// config/storage.js
// Configuración de almacenamiento de archivos fuera de Docker

const path = require('path');
const fs = require('fs');

// Directorio base para almacenamiento (fuera de Docker)
// Este directorio debe estar montado como volumen en Docker
// IMPORTANTE: Este directorio DEBE existir en el servidor host antes de iniciar Docker
const STORAGE_BASE_DIR = process.env.STORAGE_BASE_DIR || '/var/rideupt/storage';

// Directorios específicos
const DOCUMENTS_DIR = path.join(STORAGE_BASE_DIR, 'documents');
const PROFILES_DIR = path.join(STORAGE_BASE_DIR, 'profiles');

/**
 * Inicializa los directorios de almacenamiento
 */
function initializeStorage() {
  const timestamp = new Date().toISOString();
  console.log(`📁 [${timestamp}] Inicializando almacenamiento...`);
  console.log(`   📂 Directorio base: ${STORAGE_BASE_DIR}`);
  
  // Verificar si el directorio base existe (debe estar montado desde el host)
  if (!fs.existsSync(STORAGE_BASE_DIR)) {
    console.error(`   ❌ ERROR: El directorio ${STORAGE_BASE_DIR} no existe en el host`);
    console.error(`   💡 SOLUCIÓN: Crea el directorio en el servidor antes de iniciar Docker:`);
    console.error(`      sudo mkdir -p ${STORAGE_BASE_DIR}/documents`);
    console.error(`      sudo mkdir -p ${STORAGE_BASE_DIR}/profiles`);
    console.error(`      sudo chown -R 1001:1001 ${STORAGE_BASE_DIR}  # UID del usuario nodejs en el contenedor`);
    console.error(`      sudo chmod -R 755 ${STORAGE_BASE_DIR}`);
    console.error(`   🔄 Usando directorio local como fallback temporal...`);
    
    // Usar directorio local como fallback
    const fallbackDir = path.join(__dirname, '../uploads/documents');
    if (!fs.existsSync(fallbackDir)) {
      try {
        fs.mkdirSync(fallbackDir, { recursive: true });
        console.log(`   ⚠️  Fallback creado: ${fallbackDir}`);
      } catch (fallbackError) {
        console.error(`   ❌ Error crítico: No se pudo crear ningún directorio de almacenamiento`);
        console.error(`   📝 Error: ${fallbackError.message}`);
        return false;
      }
    }
    return false;
  }
  
  // Crear subdirectorios si no existen
  const subdirectories = [DOCUMENTS_DIR, PROFILES_DIR];
  let allCreated = true;
  
  subdirectories.forEach(dir => {
    if (!fs.existsSync(dir)) {
      try {
        fs.mkdirSync(dir, { recursive: true });
        console.log(`   ✅ Directorio creado: ${dir}`);
      } catch (error) {
        console.error(`   ❌ Error al crear directorio ${dir}: ${error.message}`);
        allCreated = false;
      }
    } else {
      console.log(`   ✓ Directorio existe: ${dir}`);
    }
  });
  
  // Verificar permisos de escritura
  let writable = false;
  try {
    const testFile = path.join(DOCUMENTS_DIR, '.test');
    fs.writeFileSync(testFile, 'test');
    fs.unlinkSync(testFile);
    console.log(`   ✅ Permisos de escritura verificados`);
    writable = true;
  } catch (error) {
    console.error(`   ❌ Error de permisos en ${DOCUMENTS_DIR}: ${error.message}`);
    console.error(`   💡 Verifica los permisos del directorio en el servidor host`);
    writable = false;
  }
  
  if (allCreated && writable) {
    console.log(`📁 [${timestamp}] ✅ Almacenamiento inicializado correctamente`);
    return true;
  } else {
    console.log(`📁 [${timestamp}] ⚠️  Almacenamiento inicializado con advertencias`);
    return false;
  }
}

/**
 * Obtiene la ruta completa para guardar un documento
 */
function getDocumentPath(filename) {
  return path.join(DOCUMENTS_DIR, filename);
}

/**
 * Obtiene la URL pública para acceder a un documento
 */
function getDocumentUrl(filename) {
  return `/uploads/documents/${filename}`;
}

/**
 * Verifica si un archivo existe
 */
function fileExists(filepath) {
  return fs.existsSync(filepath);
}

/**
 * Elimina un archivo de forma segura
 */
function deleteFile(filepath) {
  try {
    if (fs.existsSync(filepath)) {
      fs.unlinkSync(filepath);
      return true;
    }
    return false;
  } catch (error) {
    console.error(`Error al eliminar archivo ${filepath}: ${error.message}`);
    return false;
  }
}

/**
 * Obtiene información del almacenamiento
 */
function getStorageInfo() {
  try {
    const stats = fs.statSync(STORAGE_BASE_DIR);
    return {
      baseDir: STORAGE_BASE_DIR,
      documentsDir: DOCUMENTS_DIR,
      profilesDir: PROFILES_DIR,
      exists: true,
      writable: fs.accessSync(STORAGE_BASE_DIR, fs.constants.W_OK) === undefined
    };
  } catch (error) {
    return {
      baseDir: STORAGE_BASE_DIR,
      documentsDir: DOCUMENTS_DIR,
      profilesDir: PROFILES_DIR,
      exists: false,
      writable: false,
      error: error.message
    };
  }
}

module.exports = {
  STORAGE_BASE_DIR,
  DOCUMENTS_DIR,
  PROFILES_DIR,
  initializeStorage,
  getDocumentPath,
  getDocumentUrl,
  fileExists,
  deleteFile,
  getStorageInfo
};

