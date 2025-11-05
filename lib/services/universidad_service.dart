import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth/models/universidad_fb.dart';

class UniversidadService {
  static final _ref = FirebaseFirestore.instance.collection('universidades');

  static Stream<UniversidadFb?> watchUniversidadById(String id) {
    return _ref.doc(id).snapshots().map((doc) {
      if (doc.exists) {
        return UniversidadFb.fromMap(doc.id, doc.data()!);
      }
      return null;
    });
  }

  /// Obtiene todas las universidades
  static Future<List<UniversidadFb>> getUniversidades() async {
    final snapshot = await _ref.get();
    return snapshot.docs
        .map((doc) => UniversidadFb.fromMap(doc.id, doc.data()))
        .toList();
  }

  /// Agrega una nueva universidad
  static Future<void> addUniversidad(UniversidadFb categoria) async {
    await _ref.add(categoria.toMap());
  }

  /// Actualiza una universidad existente
  static Future<void> updateUniversidad(UniversidadFb categoria) async {
    await _ref.doc(categoria.id).update(categoria.toMap());
  }

  /// Obtiene una universidad por su ID
  static Future<UniversidadFb?> getUniversidadById(String id) async {
    final doc = await _ref.doc(id).get();
    if (doc.exists) {
      return UniversidadFb.fromMap(doc.id, doc.data()!);
    }
    return null;
  }

  /// Elimina una universidad
  static Future<void> deleteUniversidad(String id) async {
    await _ref.doc(id).delete();
  }

  /// Devuelve una lista de universidades actualizada
  static Stream<List<UniversidadFb>> watchUniversidades() {
    return _ref.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => UniversidadFb.fromMap(doc.id, doc.data()))
          .toList();
    });
  }
}
