import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/api_service.dart';
import 'services/auth_service.dart';
import 'services/storage_service.dart';
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/evidence_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // BASE_URL: cambia si tu API está en otra ruta.
    const baseUrl = 'https://parking.visiontic.com.co';
    final api = ApiService(baseUrl: baseUrl);
    final authService = AuthService(api);
    final storage = StorageService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(authService: authService, storage: storage)),
      ],
      child: MaterialApp(
        title: 'Auth Demo',
        routes: {
          '/login': (_) => const LoginScreen(),
          '/register': (_) => const RegisterScreen(),
          '/evidence': (_) => const EvidenceScreen(),
        },
        initialRoute: '/login',
      ),
    );
  }
}
