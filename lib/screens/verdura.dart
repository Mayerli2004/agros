import 'package:agros/models/agros.dart';
import 'package:agros/models/database_helper.dart';
import 'package:agros/screens/fruta.dart';
import 'package:flutter/material.dart';

class VerdurasScreen extends StatefulWidget {
  @override
  _VerdurasScreenState createState() => _VerdurasScreenState();
}

class _VerdurasScreenState extends State<VerdurasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verduras'),
      ),
      body: FutureBuilder<List<Agros>>(
        future: DatabaseProvider.instance.getAllAgrosByType('Verdura'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No hay verduras registradas'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final agro = snapshot.data![index];
                return AgrosCard(
                  agro: agro,
                );
              },
            );
          }
        },
      ),
    );
  }
}
