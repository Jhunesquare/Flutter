import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firebase_service.dart';
import '../models/universidad.dart';

class UniversidadesListScreen extends StatelessWidget {
  const UniversidadesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseService = Provider.of<FirebaseService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Universidades'),
        elevation: 2,
      ),
      body: StreamBuilder<List<Universidad>>(
        stream: firebaseService.getUniversidadesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No hay universidades registradas',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          final universidades = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: universidades.length,
            itemBuilder: (context, index) {
              final universidad = universidades[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.school),
                  ),
                  title: Text(
                    universidad.nombre,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('NIT: ${universidad.nit}'),
                      Text('Tel: ${universidad.telefono}'),
                      Text('Dir: ${universidad.direccion}'),
                      Text(
                        universidad.paginaWeb,
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirmar eliminación'),
                          content: Text(
                            '¿Está seguro de eliminar ${universidad.nombre}?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Eliminar'),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true && universidad.id != null) {
                        await firebaseService.eliminarUniversidad(universidad.id!);
                      }
                    },
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/form');
        },
        icon: const Icon(Icons.add),
        label: const Text('Nueva Universidad'),
      ),
    );
  }
}
