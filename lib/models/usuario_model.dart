class UsuarioModel {
  String? id;
  String nombres;
  String correo;

  UsuarioModel({
    this.id,
    required this.nombres,
    required this.correo,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombres": nombres,
        "correo": correo,
      };
}
