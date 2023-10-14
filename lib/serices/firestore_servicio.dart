import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestion_alquileres/models/inquilinos_model.dart';
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

  Future<String> agregarInquilino(InquilinosModel inquilinosModel) async {
    DocumentReference documentReference =
        await _collectionReference.add(inquilinosModel.toJson());
    String id = documentReference.id;
    return id;
  }

  Future<String> agregarUser(UsuarioModel userModel) async {
    DocumentReference documentReference =
        await _collectionReference.add(userModel.toJson());
    return documentReference.id;
  }

  Future<bool> validaUsuario(String email) async {
    //veduelve la coleccion validando antes el correo de bd
    QuerySnapshot coleccion =
        await _collectionReference.where("correo", isEqualTo: email).get();
    if (coleccion.docs.isNotEmpty) {
      // si no es vacia
      return true;
    }
    return false;
  }
}
