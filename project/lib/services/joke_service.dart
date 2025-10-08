import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/joke.dart';

class JokeService {
  static const String _baseUrl = 'https://api.chucknorris.io';
  static const String randomEndpoint = '/jokes/random';

  /// Obtiene una broma Aleatoria
  static Future<Joke> fetchRandomJoke() async {
    final uri = Uri.parse('$_baseUrl$randomEndpoint');

    final response = await http.get(uri);
    // Validar statusCode
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Joke.fromJson(data);
    } else {
      // Lanzar error con información
      throw HttpException(
        'Error al cargar la broma: ${response.statusCode}',
        uri: uri,
      );
    }
  }
}

/// Excepción simple para mejores mensajes
class HttpException implements Exception {
  final String message;
  final Uri? uri;
  HttpException(this.message, {this.uri});
  @override
  String toString() => message + (uri != null ? ' -> $uri' : '');
}
