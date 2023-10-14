import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestion_alquileres/models/inquilinos_model.dart';
import 'package:gestion_alquileres/serices/firestore_servicio.dart';
import 'package:gestion_alquileres/ui/widgets/formulario_widget.dart';
import 'package:gestion_alquileres/ui/widgets/listitle_inquilinos_widget.dart';
import 'package:gestion_alquileres/utils/Inquilino_search_delegate.dart';
import 'package:google_fonts/google_fonts.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  List<InquilinosModel> inquilinosGeneral = [];
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("inquilinos");
  vistaForm(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context)
              .viewInsets, //esto mueve el form si aparece el teclado
          child: FormularioWidget(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          vistaForm(context);
        },
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.blue,
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            Text(
              "agregar",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ]),
        ),
      ),
      // appBar: AppBar(title: const Text('Usuarios')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff05172A),
                    Color(0xff0A494E),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 22),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width *
                          0.7, //saco el 70% de la pantalla
                    ),
                    child: Text(
                      "Lista de usuarios",
                      style: GoogleFonts.montserrat(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      onTap: () async {
                        await showSearch(
                          context: context,
                          delegate: InquilinoSearchDelegate(
                              inquilinos: inquilinosGeneral),
                        );
                        // print(inquilinosGeneral);
                      },
                      decoration: InputDecoration(
                        hintText: "Buscar",
                        hintStyle: GoogleFonts.montserrat(
                          color: Colors.black38,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black38,
                          size: 20,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //
            // StreamBuilder(
            //   stream: _collectionReference.snapshots(),
            //   builder: (BuildContext context, AsyncSnapshot snap) {
            //     if (snap.hasData) {
            //       QuerySnapshot coleccion = snap.data;
            //       List<QueryDocumentSnapshot> docs = coleccion.docs;
            //       List<Map<String, dynamic>> docsMap = docs
            //           .map((e) => e.data() as Map<String, dynamic>)
            //           .toList();
            //       // print(docsMap);
            //       return ListView.builder(
            //         shrinkWrap: true,
            //         physics: const ScrollPhysics(),
            //         itemCount: docsMap.length,
            //         itemBuilder: (BuildContext context, int index) {
            //           return Text(docsMap[index]["descripcion"]);
            //         },
            //       );
            //     }
            //     return Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   },
            // )

            StreamBuilder(
              stream: _collectionReference.snapshots(),
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.hasData) {
                  List<InquilinosModel> inquilinos = [];
                  QuerySnapshot coleccion = snap.data;
                  //  coleccion.docs.forEach((element) {
                  // Map<String, dynamic> miMapa =
                  //     element.data() as Map<String, dynamic>;

                  // inquilinos.add(InquilinosModel.fromJson(miMapa));
                  //});
                  inquilinos = coleccion.docs.map((e) {
                    //recorre
                    InquilinosModel inqulino = InquilinosModel.fromJson(
                        e.data() as Map<String, dynamic>);
                    inqulino.id = e.id;

                    return inqulino;
                  }).toList();
                  //limpia el array
                  inquilinosGeneral.clear();
                  // asigna valor
                  inquilinosGeneral = inquilinos;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: inquilinos.length,
                    itemBuilder: (context, index) {
                      return ListitleInquilinos(
                          inquilinosModel: inquilinos[index]);
                    },
                  );
                }
                return Center(
                  child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
