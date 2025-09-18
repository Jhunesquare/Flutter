import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailScreen extends StatefulWidget {
  final String message;
  const DetailScreen({super.key, required this.message});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String _dynamicMessage = "";

  // Se llama una sola vez cuando el widget se crea
  @override
  void initState() {
    super.initState();
    print("initState ejecutado");
    _dynamicMessage = widget.message;
  }

  // Se llama cuando el contexto o dependencias cambian
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies ejecutado");
  }

  void _turnBack(BuildContext context) {
    if (widget.message == '/detail/Hola desde GO' ||
        widget.message == '/detail/Hola desde REPLACE') {
      context.pop();
    } else {
      context.go('/');
    }
  }

  // Se ejecuta cada vez que se reconstruye la interfaz
  @override
  Widget build(BuildContext context) {
    print("build ejecutado");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle"),
        leading: IconButton(
          onPressed: () => _turnBack(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Mensaje recibido: ${widget.message}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _dynamicMessage = "Mensaje actualizado";
                  print("setState ejecutado");
                });
              },
              child: const Text("Actualizar mensaje"),
            ),
            const SizedBox(height: 20),
            Text("Mensaje dinámico: $_dynamicMessage"),
          ],
        ),
      ),
    );
  }

  // Se ejecuta cuando el widget se elimina
  @override
  void dispose() {
    print("dispose ejecutado");
    super.dispose();
  }
}
