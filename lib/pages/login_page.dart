import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gestion_alquileres/pages/registro_page.dart';
import 'package:gestion_alquileres/ui/general/colores.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool textoOculto = true;

  @override
  Widget build(BuildContext context) {
    double Alto = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        // padding: EdgeInsets.all(16),
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
                      "assets/img/casa.svg",
                      height: 120,
                    ),
                    SizedBox(height: 28),
                    TextFormField(
                      style: TextStyle(
                        color: blancoColor,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                        prefixIcon: Icon(
                          Icons.email,
                          color: blancoColor,
                        ),

                        labelText: 'Correo',
                        labelStyle: TextStyle(
                          color: blancoColor,
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
                        color: blancoColor,
                        fontSize: 18,
                      ),
                      obscureText: textoOculto,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: blancoColor,
                        ),
                        labelText: "Contraseña",
                        labelStyle: TextStyle(
                          color: blancoColor,
                        ),
                        //filled para activar el backgraund del input
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: blancoColor,
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
                            color: blancoColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                    SizedBox(
                      height: 45,
                      width: 230,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.check),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        label: Text(
                          "Ingresar",
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "O Ingresa con tus redes sociales",
                      style: TextStyle(
                        color: blancoColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      height: 45,
                      width: 230,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          "assets/icons/google.svg",
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        label: Text(
                          "Google",
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistroPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Registrate",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: blancoColor,
                            ),
                          ),
                        ),
                      ],
                    )
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
