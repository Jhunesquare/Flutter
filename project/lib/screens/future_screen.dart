import 'package:flutter/material.dart';
import '../services/fake_service.dart';

class FutureScreen extends StatefulWidget {
  const FutureScreen({super.key});

  @override
  State<FutureScreen> createState() => _FutureScreenState();
}

class _FutureScreenState extends State<FutureScreen> {
  String _status = "Presiona para cargar datos";
  final FakeService _service = FakeService();

  Future<void> _loadData() async {
    setState(() => _status = "⏳ Cargando...");
    try {
      final result = await _service.fetchData();
      setState(() => _status = "✅ $result");
    } catch (e) {
      setState(() => _status = "❌ Error: $e");
    }
    print("👉 Después de la consulta");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Future / async / await")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _loadData, child: const Text("Cargar datos")),
          ],
        ),
      ),
    );
  }
}
