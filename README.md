# Taller 1 - Flutter + Control de Versiones

## 📌 Descripción
Este proyecto corresponde al **Taller 1** del curso.  
El objetivo es construir una **pantalla básica en Flutter** utilizando `StatefulWidget` y evidenciar el uso de `setState()` para actualizar dinámicamente la interfaz.  

Adicionalmente, se aplican **buenas prácticas de control de versiones** con un flujo de ramas basado en:
- `main` → rama estable (producción).  
- `dev` → rama de desarrollo.  
- `feature/taller1` → rama específica del taller.  

Todos los cambios de este taller se desarrollaron en `feature/taller1`, luego se abrió un Pull Request hacia `dev`, y finalmente se integró `dev → main`.  

---

## 👨‍🎓 Datos del Estudiante
- **Nombre completo:** Victor Hugo Soto Restrepo  
- **Código estudiantil:** 230221040  

---

## 🚀 Requisitos Técnicos Implementados
- **Pantalla principal (HomePage):**
  - AppBar con título inicial `"Hola, Flutter"`.  
  - `setState()` para alternar el título con `"¡Título cambiado!"`.  
  - Muestra un `SnackBar` con el mensaje `"Título actualizado"`.  
- **Widgets implementados:**
  - `Text` centrado con el nombre del estudiante.  
  - `Row` con dos imágenes:
    - Una cargada desde Internet (`Image.network`).  
    - Una cargada desde assets (`Image.asset`).  
  - `ListView` con 3 elementos simples.  
  - `ElevatedButton` con `setState()`.  
  - `OutlinedButton` como acción adicional.  
- **Diseño visual:** uso de `Column`, `Padding`, `SizedBox` y alineaciones.  

---

## 🛠️ Pasos para ejecutar el proyecto
1. Clonar el repositorio:
   ```bash
   git clone https://github.com/Jhunesquare/Flutter.git
   cd Flutter
