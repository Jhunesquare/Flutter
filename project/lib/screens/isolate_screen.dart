import 'dart:isolate';
import 'package:flutter/material.dart';

class IsolateScreen extends StatefulWidget {
  const IsolateScreen({super.key});

  @override
  State<IsolateScreen> createState() => _IsolateScreenState();
}

class _IsolateScreenState extends State<IsolateScreen> {
  String _result = "Presiona para ejecutar tarea pesada";

  Future<void> _runHeavyTask() async {
    final receivePort = ReceivePort();

    await Isolate.spawn(_heavyComputation, receivePort.sendPort);

    receivePort.listen((message) {
      setState(() => _result = "Resultado: $message");
      receivePort.close();
    });
  }

  static void _heavyComputation(SendPort sendPort) {
    int sum = 0;
    for (int i = 0; i < 100000000; i++) {
      sum += i;
    }
    sendPort.send(sum);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Isolate - Tarea Pesada")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_result, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _runHeavyTask,
              child: const Text("Ejecutar"),
            ),
          ],
        ),
      ),
    );
  }
}
