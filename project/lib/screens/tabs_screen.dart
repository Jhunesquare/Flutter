import 'package:flutter/material.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pantalla con Tabs"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Grid"),
              Tab(text: "List"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            GridExample(),
            ListExample(),
          ],
        ),
      ),
    );
  }
}

class GridExample extends StatelessWidget {
  const GridExample({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(6, (index) => "Item $index");

    return GridView.count(
      crossAxisCount: 2,
      children: items.map((e) {
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        e,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Este es un modal con información adicional "
                        "sobre el ítem seleccionado.",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                        label: const Text("Cerrar"),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Card(
            margin: const EdgeInsets.all(8),
            child: Center(
              child: Text(
                e,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class ExtraWidget extends StatelessWidget {
  const ExtraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.flutter_dash, size: 100, color: Colors.blue),
    );
  }
}

class ListExample extends StatelessWidget {
  const ListExample({super.key});

  @override
  Widget build(BuildContext context) {
    final users = [
      {"name": "Usuario 1", "icon": Icons.person},
      {"name": "Usuario 2", "icon": Icons.person_outline},
      {"name": "Usuario 3", "icon": Icons.account_circle},
      {"name": "Usuario 4", "icon": Icons.people},
    ];

    return ListView(
      children: users
          .map(
            (user) => ListTile(
              leading: Icon(user["icon"] as IconData, color: Colors.blue),
              title: Text(user["name"] as String),
              subtitle: const Text("Descripción breve"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // 👇 Muestra un modal al tocar cada usuario
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            user["name"] as String,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text("Lorem ipsum dolor sit amet consectetur adipiscing elit, netus malesuada laoreet aliquet senectus morbi non cubilia, odio himenaeos luctus elementum dui rutrum. Hac phasellus cras nostra arcu ultrices viverra mi accumsan consequat, vulputate in proin quis mauris justo tellus eu lobortis, primis malesuada netus sodales duis felis vitae gravida. Magnis iaculis proin fermentum inceptos suscipit aptent donec erat eleifend vitae tempor venenatis, lectus placerat luctus fusce vel malesuada non tincidunt ante fames."),
                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          )
          .toList(),
    );
  }
}
