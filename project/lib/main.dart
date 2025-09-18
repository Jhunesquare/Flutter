import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  String _title = "Hola, Flutter";

  void _changeTitle() {
    setState(() {
      _title = _title == "Hola, Flutter"
          ? "¡Título cambiado!"
          : "Hola, Flutter";
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Título actualizado")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget> [
            // Nombre completo
            const Text(
              "Victor Hugo Soto Restrepo",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Imágenes en Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                  "https://i.pinimg.com/originals/b2/60/94/b26094970505bcd59c2e5fe8b6f41cf0.jpg?nii=t",
                  width: 100,
                ),
                Image.asset('lib/assets/tecito.png', width: 100),
              ],
            ),
            const SizedBox(height: 20),

            // ListView dentro de un contenedor fijo
            SizedBox(
              height: 120,
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.star),
                    title: Text("Elemento 1"),
                  ),
                  ListTile(
                    leading: Icon(Icons.star),
                    title: Text("Elemento 2"),
                  ),
                  ListTile(
                    leading: Icon(Icons.star),
                    title: Text("Elemento 3"),
                  ),
                  ListTile(
                    leading: Icon(Icons.star),
                    title: Text("Elemento 4"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Botón que usa setState()
            ElevatedButton(
              onPressed: _changeTitle,
              child: const Text("Cambiar título"),
            ),

            const SizedBox(height: 10),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _counter--;
        },
        tooltip: 'Decrement',
        child: const Icon(Icons.remove),
      ),
    );
  }
}
