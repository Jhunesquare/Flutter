import 'package:flutter/material.dart';
import '../models/joke.dart';
import 'package:go_router/go_router.dart';

class JokeDetailView extends StatelessWidget {
  final String id;
  final Joke? jokeFromExtra;

  const JokeDetailView({
    Key? key,
    required this.id,
    this.jokeFromExtra,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Si el objeto fue pasado por extra ya lo usamos; si no, lo podríamos recargar por id (opcional).
    final joke = jokeFromExtra;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle - ${id.substring(0, id.length >= 6 ? 6 : id.length)}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: joke != null
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (joke.iconUrl != null)
                      Image.network(
                        joke.iconUrl!,
                        height: 120,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 120),
                      ),
                    const SizedBox(height: 12),
                    Text(
                      joke.value,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    Text('ID: ${joke.id}'),
                    if (joke.url != null) ...[
                      const SizedBox(height: 8),
                      Text('URL: ${joke.url}'),
                    ],
                  ],
                ),
              )
            : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('No se recibió el chiste en la navegación.'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        // Volver atrás demostrando comportamiento del botón atrás
                        context.pop();
                      },
                      child: const Text('Volver'),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
