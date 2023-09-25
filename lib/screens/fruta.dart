import 'dart:io';
import 'package:agros/models/agros.dart';
import 'package:agros/models/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FrutasScreen extends StatefulWidget {
  @override
  _FrutasScreenState createState() => _FrutasScreenState();
}

class _FrutasScreenState extends State<FrutasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frutas'),
      ),
      body: FutureBuilder<List<Agros>>(
        future: DatabaseProvider.instance.getAllAgrosByType('Fruta'),
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
              child: Text('No hay frutas registradas'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0, // Null check added here
              itemBuilder: (context, index) {
                final agro =
                    snapshot.data![index]; // Using '!' to assert not null
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

class AgrosCard extends StatelessWidget {
  final Agros agro;
  final TextEditingController quantityController = TextEditingController();

  AgrosCard({required this.agro});

  void _launchWhatsApp(BuildContext context) async {
    final number = '+57 313 3573388';
    final quantity = quantityController.text;
    final message =
        '¡Quiero comprar ${agro.nombre} por $quantity unidades por \$${agro.precio.toStringAsFixed(2)}!';

    final url = 'https://wa.me/$number/?text=${Uri.encodeFull(message)}';

    if (await launch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch WhatsApp.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          agro.imagenPath != null && agro.imagenPath!.isNotEmpty
              ? Image.file(
                  File(agro.imagenPath!),
                  height: 150.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : SizedBox(
                  height: 150.0,
                  width: double.infinity,
                  child: Center(
                    child: Text('No Image'),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  agro.nombre,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Precio: \$${agro.precio.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Cantidad a pedir'),
                          content: TextField(
                            controller: quantityController,
                            keyboardType: TextInputType.number,
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Confirmar'),
                              onPressed: () {
                                _launchWhatsApp(context);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Comprar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
