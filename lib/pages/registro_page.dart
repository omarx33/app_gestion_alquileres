import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestion_alquileres/models/usuario_model.dart';
import 'package:gestion_alquileres/pages/home_page.dart';
import 'package:gestion_alquileres/serices/firestore_servicio.dart';
import 'package:gestion_alquileres/ui/widgets/snack_widget.dart';

class RegistroPage extends StatefulWidget {
  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final keyForm = GlobalKey<FormState>();
  bool textoOculto = true;
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FirestoreServicio usuarioServicio = FirestoreServicio(coleccion: "usuarios");
  _registroUsuario() async {
    // print(_nombresController.text);

    try {
      if (keyForm.currentState!.validate()) {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _correoController.text,
          password: _passwordController.text,
        );
        // print(userCredential);
        if (userCredential != null) {
          UsuarioModel usuarioModel = UsuarioModel(
            nombres: _nombresController.text,
            correo: _correoController.text,
          );

          // print(usuarioModel.correo);
          usuarioServicio.agregarUsuario(usuarioModel).then(
            (value) {
              //si no esta vacio
              if (value.isNotEmpty) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                    (route) => false);
              }
            },
          );
        }
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "weak-password") {
        miSnackBarSuccess(context, "La contraseña es muy debil");
      } else if (error.code == "email-already-in-use") {
        miSnackBarSuccess(context, "El correo ya existe");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double Alto = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Alto,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color.fromARGB(255, 14, 82, 99),
                    Color.fromARGB(255, 35, 136, 161),
                    Color.fromARGB(255, 134, 156, 218),
                    Color.fromARGB(255, 138, 156, 216),
                  ],
                  tileMode: TileMode.mirror,
                ),
              ),
              child: Form(
                key: keyForm,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(height: Alto * 0.10),
                      SvgPicture.asset(
                        "assets/img/user.svg",
                        height: 120,
                      ),
                      SizedBox(height: 28),
                      TextFormField(
                        style: TextStyle(
                          color: Color.fromARGB(255, 252, 232, 231),
                          fontSize: 18,
                        ),
                        controller: _nombresController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                          prefixIcon: Icon(
                            Icons.person_add_alt_rounded,
                            color: const Color.fromARGB(255, 252, 232, 231),
                          ),

                          labelText: 'Nombres',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 252, 232, 231),
                          ),
                          //filled para activar el backgraund del input
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 252, 232,
                                    231)), // Borde inferior rojo por defecto
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 252, 232,
                                    231)), // Borde inferior rojo cuando tiene el foco
                          ),
                        ),
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            //vacio o null
                            return "Campo Obligatorio";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        style: TextStyle(
                          color: Color.fromARGB(255, 252, 232, 231),
                          fontSize: 18,
                        ),
                        controller: _correoController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                          prefixIcon: Icon(
                            Icons.email,
                            color: const Color.fromARGB(255, 252, 232, 231),
                          ),

                          labelText: 'Correo',
                          labelStyle: TextStyle(
                            color: const Color.fromARGB(255, 252, 232, 231),
                          ),
                          //filled para activar el backgraund del input
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 252, 232,
                                    231)), // Borde inferior rojo por defecto
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 252, 232,
                                    231)), // Borde inferior rojo cuando tiene el foco
                          ),
                        ),
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            //vacio o null
                            return "Campo Obligatorio";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        style: TextStyle(
                          color: Color.fromARGB(255, 252, 232, 231),
                          fontSize: 18,
                        ),
                        controller: _passwordController,
                        obscureText: textoOculto,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: const Color.fromARGB(255, 252, 232, 231),
                          ),
                          labelText: "Contraseña",
                          labelStyle: TextStyle(
                            color: const Color.fromARGB(255, 252, 232, 231),
                          ),
                          //filled para activar el backgraund del input
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 252, 232, 231),
                            ), // Borde inferior rojo por defecto
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 252, 232,
                                    231)), // Borde inferior rojo cuando tiene el foco
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              textoOculto = !textoOculto;
                              setState(() {});
                            },
                            icon: Icon(
                              textoOculto
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color.fromARGB(255, 252, 232, 231),
                            ),
                          ),
                        ),
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            //vacio o null
                            return "Campo Obligatorio";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 35),
                      SizedBox(
                        height: 45,
                        width: 230,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _registroUsuario();
                          },
                          icon: Icon(Icons.check),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          label: Text(
                            "Registrate",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
