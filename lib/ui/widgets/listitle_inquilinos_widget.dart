import 'package:flutter/material.dart';
import 'package:gestion_alquileres/models/inquilinos_model.dart';

class ListitleInquilinos extends StatelessWidget {
  InquilinosModel inquilinosModel;
  ListitleInquilinos({
    required this.inquilinosModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(4, 4),
            blurRadius: 18,
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(
          Icons.person,
          color: inquilinosModel.estado ? Colors.green : Colors.red,
        ),
        title: Text(inquilinosModel.nombre),
        subtitle: Text(inquilinosModel.descripcion),
      ),
    );
  }
}
