import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../services/joke_service.dart';
import 'package:go_router/go_router.dart';

class JokeListView extends StatefulWidget {
  const JokeListView({Key? key}) : super(key: key);

  @override
  State<JokeListView> createState() => _JokeListViewState();
}

enum LoadState { loading, success, error }

class _JokeListViewState extends State<JokeListView> {
  LoadState _state = LoadState.loading;
  String _errorMessage = '';
  final List<Joke> _jokes = [];

  // Número de ítems demo para el listado
  final int _count = 10;

  @override
  void initState() {
    super.initState();
    _loadJokes();
  }

  Future<void> _loadJokes() async {
    setState(() {
      _state = LoadState.loading;
      _errorMessage = '';
    });

    try {
      // Hacer múltiples requests en paralelo (no bloquear la UI)
      final futures = List.generate(_count, (_) => JokeService.fetchRandomJoke());
      final results = await Future.wait(futures);
      if (!mounted) return;
      setState(() {
        _jokes.clear();
        _jokes.addAll(results);
        _state = LoadState.success;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _state = LoadState.error;
        _errorMessage = e.toString();
      });
      // Mostrar snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error cargando chistes: $_errorMessage')),
      );
    }
  }

  Future<void> _refresh() async {
    await _loadJokes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Jokes'),
        actions: [
          IconButton(
            tooltip: 'Refrescar',
            icon: const Icon(Icons.refresh),
            onPressed: _loadJokes,
          ),
        ],
      ),
      body: Builder(builder: (context) {
        if (_state == LoadState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (_state == LoadState.error) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 48),
                const SizedBox(height: 8),
                Text(
                  'Ocurrió un error:\n$_errorMessage',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _loadJokes,
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              itemCount: _jokes.length,
              itemBuilder: (context, index) {
                final joke = _jokes[index];
                return ListTile(
                  leading: joke.iconUrl != null
                      ? Image.network(
                          joke.iconUrl!,
                          width: 48,
                          height: 48,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported),
                        )
                      : const Icon(Icons.sentiment_very_satisfied),
                  title: Text(
                    // Mostrar parte del texto
                    joke.value.length > 80
                        ? '${joke.value.substring(0, 80)}...'
                        : joke.value,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text('ID: ${joke.id}'),
                  onTap: () {
                    // Navegar a detalle pasando parámetros: path param id y extra como objeto completo
                    context.pushNamed(
                      'detail',
                      pathParameters: {'id': joke.id},
                      extra: joke, // también envío el objeto completo
                    );
                  },
                );
              },
            ),
          );
        }
      }),
    );
  }
}
