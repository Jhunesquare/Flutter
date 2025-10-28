import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';

enum AuthState { initial, loading, success, error }

class AuthProvider extends ChangeNotifier {
  final AuthService authService;
  final StorageService storage;

  AuthState _state = AuthState.initial;
  String? _errorMessage;
  bool _isLoggedIn = false;

  AuthState get state => _state;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _isLoggedIn;

  AuthProvider({required this.authService, required this.storage}) {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final token = await storage.getToken();
    _isLoggedIn = token != null && token.isNotEmpty;
    notifyListeners();
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    _state = AuthState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await authService.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );

      _state = AuthState.success;
      notifyListeners();
      return true;
    } catch (e) {
      _state = AuthState.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _state = AuthState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await authService.login(email: email, password: password);

      // Guardar token (sensible)
      final token = response['access_token'] ?? response['token'];
      if (token != null) {
        await storage.saveToken(token);
      }

      // Guardar refresh token si existe
      if (response['refresh_token'] != null) {
        await storage.saveRefreshToken(response['refresh_token']);
      }

      // Guardar datos de usuario (NO sensible)
      final userData = response['user'];
      if (userData != null) {
        await storage.saveUserData(
          name: userData['name'] ?? '',
          email: userData['email'] ?? email,
        );
      } else {
        // Si la API no devuelve user, guardamos el email usado
        await storage.saveUserData(name: '', email: email);
      }

      _isLoggedIn = true;
      _state = AuthState.success;
      notifyListeners();
      return true;
    } catch (e) {
      _state = AuthState.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await storage.clearAll();
    _isLoggedIn = false;
    _state = AuthState.initial;
    notifyListeners();
  }
}
