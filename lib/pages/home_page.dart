import 'package:flutter/material.dart';
import 'package:gestion_alquileres/pages/usuarios_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _pages = [
    UsuariosPage(),
    Center(child: Text("Suscripción")),
    Center(child: Text("Biblioteca")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("test"),
      // ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 13,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 96, 197, 130),
        onTap: (int value) {
          _selectedIndex = value;
          print(_selectedIndex);
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Usuarios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Registros',
          ),
        ],
      ),
    );
  }
}
