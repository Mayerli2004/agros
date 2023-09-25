import 'package:agros/models/agros.dart';
import 'package:agros/models/database_helper.dart';
import 'package:agros/screens/fruta.dart';
import 'package:flutter/material.dart';

class CitricosScreen extends StatefulWidget {
  @override
  _CitricosScreenState createState() => _CitricosScreenState();
}

class _CitricosScreenState extends State<CitricosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Citricos'),
      ),
      body: FutureBuilder<List<Agros>>(
        future: DatabaseProvider.instance.getAllAgrosByType('Citrico'),
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
              child: Text('No hay citricos registrados'),
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
