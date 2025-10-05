# Ejercicios Flutter - Asincronía, Timer e Isolates

## 1) Future / async / await
- Se utiliza para operaciones **asíncronas que no bloquean la UI** (ej. llamadas a API).
- Ejemplo: simulación de carga de datos con `Future.delayed`.
- Estados mostrados: Cargando, Éxito, Error.

## 2) Timer
- Ideal para ejecutar tareas en intervalos de tiempo (cronómetro, cuenta regresiva).
- Botones: Iniciar, Pausar, Reanudar, Reiniciar.
- Uso de `Timer.periodic` para actualizar cada 1 segundo.

## 3) Isolate
- Usado para **tareas pesadas de CPU** que bloquearían la UI si se ejecutaran en el hilo principal.
- Comunicación entre hilos con `SendPort` y `ReceivePort`.

## 4) Flujo de pantallas
- **HomeScreen** → Menú con botones.
- **FutureScreen** → Ejemplo de async/await.
- **TimerScreen** → Cronómetro con controles.
- **IsolateScreen** → Cálculo pesado en segundo hilo.