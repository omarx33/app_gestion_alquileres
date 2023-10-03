import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegistroPage extends StatefulWidget {
  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  bool textoOculto = true;
  final TextEditingController _nombresController = TextEditingController();

  _login() async {
    print(_nombresController.text);
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
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      style: TextStyle(
                        color: Color.fromARGB(255, 252, 232, 231),
                        fontSize: 18,
                      ),
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
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      style: TextStyle(
                        color: Color.fromARGB(255, 252, 232, 231),
                        fontSize: 18,
                      ),
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
                    ),
                    SizedBox(height: 35),
                    SizedBox(
                      height: 45,
                      width: 230,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _login();
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
          ],
        ),
      ),
    );
  }
}
