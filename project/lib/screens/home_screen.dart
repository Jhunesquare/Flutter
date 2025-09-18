import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pantalla Principal")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              // go → reemplaza la ruta actual
              onPressed: () {
                context.go('/detail/Hola desde GO');
              },
              child: const Text("Ir con go()"),
            ),
            ElevatedButton(
              // push → apila la nueva ruta
              onPressed: () {
                context.push('/detail/Hola desde PUSH');
              },
              child: const Text("Ir con push()"),
            ),
            ElevatedButton(
              // replace → reemplaza la ruta sin opción de volver
              onPressed: () {
                context.replace('/detail/Hola desde REPLACE');
              },
              child: const Text("Ir con replace()"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.push('/tabs');
              },
              child: const Text("Abrir pantalla con Tabs y Grid"),
            ),
          ],
        ),
      ),
    );
  }
}
