import 'dart:math';
import 'dart:async';

class FakeService {
  Future<String> fetchData() async {
    print("👉 Antes de la consulta");
    await Future.delayed(const Duration(seconds: 3));
    print("⚡ Durante la consulta");
    if (Random().nextBool()) {
      print("✅ Éxito en la consulta");
      return "Datos cargados correctamente";
    } else {
      print("❌ Error en la consulta");
      throw Exception("No se pudieron obtener los datos");
    }
  }
}
