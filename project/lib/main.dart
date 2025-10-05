import 'package:flutter/material.dart';
import 'screens/future_screen.dart';
import 'screens/timer_screen.dart';
import 'screens/isolate_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicios Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ejercicios Flutter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("1) Future / async / await"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const FutureScreen()));
              },
            ),
            ElevatedButton(
              child: const Text("2) Timer - Cronómetro"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const TimerScreen()));
              },
            ),
            ElevatedButton(
              child: const Text("3) Isolate"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const IsolateScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
