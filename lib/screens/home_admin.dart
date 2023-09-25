import 'package:agros/screens/agros.dart';
import 'package:agros/screens/citricos.dart';
import 'package:agros/screens/fruta.dart';
import 'package:agros/screens/login.dart';
import 'package:agros/screens/nuevo_agro.dart';
import 'package:agros/screens/user_list.dart';
import 'package:agros/screens/verdura.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeAdmin> {
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
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserListView()),
              );
            },
          ),
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
                title: 'Nuevos Agros',
                imageAsset: 'assets/images/nuevo.jpg',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NuevoAgroScreen()),
                  );
                },
              ),
              CategoryCard(
                title: 'Agros',
                imageAsset: 'assets/images/agros.jpg',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AgrosScreen()),
                  );
                },
              ),
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

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageAsset;
  final VoidCallback onTap;

  const CategoryCard({
    required this.title,
    required this.imageAsset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imageAsset,
              height: 150.0, // Ajusta la altura deseada
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
