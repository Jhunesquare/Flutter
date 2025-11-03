import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/universidad.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'universidades';

  // Obtener stream de universidades en tiempo real
  Stream<List<Universidad>> getUniversidadesStream() {
    return _firestore.collection(_collection).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => Universidad.fromFirestore(doc.id, doc.data()))
              .toList(),
        );
  }

  // Crear nueva universidad
  Future<void> crearUniversidad(Universidad universidad) async {
    await _firestore.collection(_collection).add(universidad.toMap());
  }

  // Actualizar universidad
  Future<void> actualizarUniversidad(Universidad universidad) async {
    if (universidad.id != null) {
      await _firestore
          .collection(_collection)
          .doc(universidad.id)
          .update(universidad.toMap());
    }
  }

  // Eliminar universidad
  Future<void> eliminarUniversidad(String id) async {
    await _firestore.collection(_collection).doc(id).delete();
  }

  // Obtener una universidad por ID
  Future<Universidad?> getUniversidadById(String id) async {
    final doc = await _firestore.collection(_collection).doc(id).get();
    if (doc.exists) {
      return Universidad.fromFirestore(doc.id, doc.data()!);
    }
    return null;
  }
}
