import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestion_alquileres/models/usuario_model.dart';

class FirestoreServicio {
  String coleccion;

  FirestoreServicio({
    required this.coleccion,
  });

  late final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(coleccion);

  Future<String> agregarUsuario(UsuarioModel usuarioModel) async {
    DocumentReference documentReference =
        await _collectionReference.add(usuarioModel.toJson());
    return documentReference.id;
  }
}
