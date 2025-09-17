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
#   
# Taller Flutter - go_router + Ciclo de Vida StatefulWidget

## 📌 Descripción
Este proyecto demuestra:
- Navegación con `go_router`.
- Paso de parámetros entre pantallas.
- Diferencia entre `go`, `push` y `replace`.
- Uso de widgets intermedios (`GridView`, `TabBar`, y un widget adicional).
- Evidencia del ciclo de vida de un `StatefulWidget` (`initState`, `didChangeDependencies`, `build`, `setState`, `dispose`).

---

## 🚀 Arquitectura / Navegación
Rutas configuradas en `router.dart`:
- `/` → HomeScreen
- `/detail/:msg` → DetailScreen (recibe un parámetro `msg`).
- `/tabs` → TabsScreen (contiene `TabBar` y `GridView`).

### Paso de parámetros
- Ejemplo: `context.push('/detail/Hola desde PUSH')`
- El parámetro `msg` se recibe en `DetailScreen` y se muestra en pantalla.

---

## 🧩 Widgets usados
- **GridView:** mostrar una lista de 6 elementos en forma de cuadrícula.
- **TabBar + TabBarView:** organizar secciones de navegación en una pantalla.
- **Icon (extra widget):** mostrar el ícono de Flutter como adorno visual.

---

## 🔄 Ciclo de vida del StatefulWidget
En `DetailScreen` se imprimen en consola los métodos:
- `initState()` → cuando el widget se crea por primera vez.
- `didChangeDependencies()` → cuando cambia el contexto o las dependencias.
- `build()` → cada vez que se construye la interfaz.
- `setState()` → cuando se actualiza el estado y se fuerza un nuevo `build`.
- `dispose()` → cuando el widget se elimina de memoria.

---

## ▶️ Ejecución
1. Instalar dependencias:
   ```bash
   flutter pub get
