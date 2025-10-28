import 'api_service.dart';

class AuthService {
  final ApiService api;

  AuthService(this.api);

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    return await api.post('/api/register', {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    return await api.post('/api/login', {
      'email': email,
      'password': password,
    });
  }
}
