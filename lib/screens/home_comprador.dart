import 'package:agros/screens/citricos.dart';
import 'package:agros/screens/fruta.dart';
import 'package:agros/screens/home_admin.dart';
import 'package:agros/screens/login.dart';
import 'package:agros/screens/verdura.dart';
import 'package:flutter/material.dart';

class HomeComprador extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeComprador> {
  void _logout() {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('AGROSCEFA'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CategoryCard(
                title: 'Frutas',
                imageAsset: 'assets/images/fruta.jpg',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FrutasScreen()),
                  );
                },
              ),
              CategoryCard(
                title: 'Verduras',
                imageAsset: 'assets/images/verdura.jpg',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VerdurasScreen()),
                  );
                },
              ),
              CategoryCard(
                title: 'Citricos',
                imageAsset: 'assets/images/citrico.jpg',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CitricosScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
