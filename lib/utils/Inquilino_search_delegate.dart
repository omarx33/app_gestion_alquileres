import 'package:flutter/material.dart';
import 'package:gestion_alquileres/models/inquilinos_model.dart';
import 'package:gestion_alquileres/ui/widgets/listitle_inquilinos_widget.dart';

class InquilinoSearchDelegate extends SearchDelegate {
  List<InquilinosModel> inquilinos;
  InquilinoSearchDelegate({
    required this.inquilinos,
  });

  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => "Buscar Nombre..";

  @override
  // TODO: implement searchFieldStyle
  TextStyle? get searchFieldStyle => TextStyle(
        fontSize: 18,
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    // para borrar el simbolo x
    //query contiene el valor que se escribe en el imput
    return [
      IconButton(
        onPressed: () {
          // print(query);
          query = "";
        },
        icon: Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<InquilinosModel> resultados = inquilinos
        .where(
          (element) => element.nombre.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    return Padding(
      padding: EdgeInsets.all(14),
      child: ListView.builder(
        itemCount: resultados.length,
        itemBuilder: (context, index) {
          return ListitleInquilinos(
            inquilinosModel: resultados[index],
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<InquilinosModel> resultados = inquilinos
        .where(
          (element) => element.nombre.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    return Padding(
      padding: EdgeInsets.all(14),
      child: ListView.builder(
        itemCount: resultados.length,
        itemBuilder: (context, index) {
          return ListitleInquilinos(
            inquilinosModel: resultados[index],
          );
        },
      ),
    );
  }
}
