class InquilinosModel {
  String? id;
  String nombre;
  String descripcion;
  String fecha;

  bool estado;

  InquilinosModel({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.fecha,
    required this.estado,
  });

  factory InquilinosModel.fromJson(Map<String, dynamic> json) =>
      InquilinosModel(
        id: json["id"] ?? "", //si es null manda vacio
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        fecha: json["fecha"],

        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "descripcion": descripcion,
        "fecha": fecha,
        "estado": estado,
      };
}
