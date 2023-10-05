import 'package:flutter/material.dart';
import 'package:gestion_alquileres/pages/home_page.dart';
import 'package:gestion_alquileres/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  //habilita codigo nativo para que firebase funciones bien
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "APP GESTIÓN ALQUILER",
      debugShowCheckedModeBanner: false,
      // home: HomePage(),
      home: LoginPage(),
    );
  }
}
