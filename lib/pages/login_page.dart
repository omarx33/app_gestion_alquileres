import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gestion_alquileres/models/usuario_model.dart';
import 'package:gestion_alquileres/pages/home_page.dart';
import 'package:gestion_alquileres/pages/registro_page.dart';
import 'package:gestion_alquileres/serices/firestore_servicio.dart';
import 'package:gestion_alquileres/ui/general/colores.dart';
import 'package:gestion_alquileres/ui/widgets/snack_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final GoogleSignIn _googleGignIn = GoogleSignIn(scopes: ["email"]);
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FirestoreServicio miFirestoreServcio =
      FirestoreServicio(coleccion: "usuarios");
  bool textoOculto = true;

  _login() async {
    try {
      if (formKey.currentState!.validate()) {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _correoController.text,
          password: _passwordController.text,
        );

        // print(userCredential);
        if (userCredential.user != null) {
          //con esto si se loguea ira  a homepage y si retrocede las vistas de logis y registros no se visualizaran porque ya esta logueado
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
        }
      }
    } on FirebaseAuthException catch (error) {
      print(error.code);
      if (error.code == "INVALID_LOGIN_CREDENTIALS") {
        miSnackBarSuccess(
          context,
          "Error con sus datos de registro",
          Colors.redAccent,
        );
      }
    }
  }

  _loginGoogle() async {
    // _googleGignIn.signIn();
    GoogleSignInAccount? googleSignInAccount = await _googleGignIn.signIn();
    // print(googleSignInAccount);
    if (googleSignInAccount == null) {
      return;
    }

    //_googleSigInAuth contiene idToken y accessToken
    GoogleSignInAuthentication _googleSigInAuth =
        await googleSignInAccount.authentication;

    OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: _googleSigInAuth.idToken,
      accessToken: _googleSigInAuth.accessToken,
    );

    //registra las credenciales en firebase
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.user != null) {
      UsuarioModel usuarioModel = UsuarioModel(
        nombres: userCredential.user!.displayName!,
        correo: userCredential.user!.email!,
      );

      miFirestoreServcio.validaUsuario(userCredential.user!.email!).then(
        (value) {
          if (value == false) {
            //si no existe el usuario agrega a la bd la sesion y redirige
            miFirestoreServcio.agregarUser(usuarioModel).then(
              (value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false);
              },
            );
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (route) => false);
          }
        },
      );
    }
  }

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
              child: Form(
                key: formKey,
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
                        controller: _correoController,
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
                        controller: _passwordController,
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
                            // _login();
                            _googleGignIn.signOut();
                          },
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
                          onPressed: () {
                            _loginGoogle();
                          },
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
            ),
          ],
        ),
      ),
    );
  }
}
