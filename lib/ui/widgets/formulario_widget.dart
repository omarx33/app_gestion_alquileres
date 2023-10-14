import 'package:flutter/material.dart';
import 'package:gestion_alquileres/models/inquilinos_model.dart';
import 'package:gestion_alquileres/serices/firestore_servicio.dart';
import 'package:gestion_alquileres/ui/widgets/snack_widget.dart';

class FormularioWidget extends StatefulWidget {
  const FormularioWidget({super.key});

  @override
  State<FormularioWidget> createState() => _FormularioWidgetState();
}

class _FormularioWidgetState extends State<FormularioWidget> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _nombresControlador = TextEditingController();
  final TextEditingController _descripcionControlador = TextEditingController();
  final TextEditingController _fechaControlador = TextEditingController();
  FirestoreServicio miFirestoreServcio =
      FirestoreServicio(coleccion: "inquilinos");

  showDateInput() async {
    DateTime? datetime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (datetime != null) {
      _fechaControlador.text = datetime.toString().substring(0, 10);
      setState(() {});
    }
  }

  registrarInquilino() {
    if (formKey.currentState!.validate()) {
      InquilinosModel inquilinosModel = InquilinosModel(
        nombre: _nombresControlador.text,
        descripcion: _descripcionControlador.text,
        fecha: _fechaControlador.text,
        estado: true,
      );
      miFirestoreServcio.agregarInquilino(inquilinosModel).then(
        (value) {
          if (value.isNotEmpty) {
            Navigator.pop(context);
            miSnackBarSuccess(
                context, "Inquilino Registrado", Colors.greenAccent);
          }
        },
      ).catchError((error) {
        miSnackBarSuccess(context, "Error de registro", Colors.redAccent);
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Agregar ",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            TextFormField(
              style: TextStyle(
                color: Color(0xff2c3550),
                fontSize: 18,
              ),
              controller: _nombresControlador,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 14),
                prefixIcon: Icon(
                  Icons.person_add_alt_rounded,
                  color: Color(0xff2c3550),
                ),

                labelText: 'Nombres',
                labelStyle: TextStyle(
                  color: Color(0xff2c3550),
                ),
                //filled para activar el backgraund del input
              ),
              validator: (String? value) {
                if (value != null && value.isEmpty) {
                  //vacio o null
                  return "Campo Obligatorio";
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              style: TextStyle(
                color: Color(0xff2c3550),
                fontSize: 18,
              ),
              controller: _descripcionControlador,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 14),
                prefixIcon: Icon(
                  Icons.description,
                  color: Color(0xff2c3550),
                ),

                labelText: 'Descripción',
                labelStyle: TextStyle(
                  color: Color(0xff2c3550),
                ),
                //filled para activar el backgraund del input
              ),
              validator: (String? value) {
                if (value != null && value.isEmpty) {
                  //vacio o null
                  return "Campo Obligatorio";
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              onTap: () {
                showDateInput();
              },
              readOnly: true,
              style: TextStyle(
                color: Color(0xff2c3550),
                fontSize: 18,
              ),
              controller: _fechaControlador,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 14),
                prefixIcon: Icon(
                  Icons.date_range,
                  color: Color(0xff2c3550),
                ),

                labelText: 'Fecha',
                labelStyle: TextStyle(
                  color: Color(0xff2c3550),
                ),
                //filled para activar el backgraund del input
              ),
              validator: (String? value) {
                if (value != null && value.isEmpty) {
                  //vacio o null
                  return "Campo Obligatorio";
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    registrarInquilino();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff2c3550),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: Icon(Icons.check_outlined),
                  label: Text(
                    "Registrar",
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
