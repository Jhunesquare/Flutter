import 'dart:async';
import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _seconds = 0;
  Timer? _timer;

  void _start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _seconds++);
    });
  }

  void _pause() {
    _timer?.cancel();
  }

  void _resume() {
    _start();
  }

  void _reset() {
    _timer?.cancel();
    setState(() => _seconds = 0);
  }

  @override
  void dispose() {
    _timer?.cancel(); // Limpieza al salir
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String formatted = "${(_seconds ~/ 60).toString().padLeft(2, '0')}:${(_seconds % 60).toString().padLeft(2, '0')}";
    return Scaffold(
      appBar: AppBar(title: const Text("Cronómetro con Timer")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(formatted, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(onPressed: _start, child: const Text("Iniciar")),
                ElevatedButton(onPressed: _pause, child: const Text("Pausar")),
                ElevatedButton(onPressed: _resume, child: const Text("Reanudar")),
                ElevatedButton(onPressed: _reset, child: const Text("Reiniciar")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
