import 'package:agros/models/agros.dart';
import 'package:agros/models/database_helper.dart';
import 'package:flutter/material.dart';

class AgrosScreen extends StatefulWidget {
  @override
  _AgrosScreenState createState() => _AgrosScreenState();
}

class _AgrosScreenState extends State<AgrosScreen> {
  List<Agros> agros = []; 

  @override
  void initState() {
    super.initState();
    _cargarAgros();
  }

  Future<void> _cargarAgros() async {
    final database = DatabaseProvider.instance.database;
    final todosAgros = await database.then((db) => db.query('agros'));
    setState(() {
      agros = todosAgros.map((map) => Agros.fromMap(map)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos los Agros'),
      ),
      body: agros.isEmpty
          ? Center(
              child: Text('No hay agros registrados.'),
            )
          : ListView.builder(
              itemCount: agros.length,
              itemBuilder: (context, index) {
                final agro = agros[index];
                return AgroCard(agro: agro);
              },
            ),
    );
  }
}

class AgroCard extends StatelessWidget {
  final Agros agro;

  const AgroCard({required this.agro});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            agro.imagenPath,
            height: 150.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre: ${agro.nombre}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Tipo: ${agro.tipo}'),
                Text('Precio: \$${agro.precio.toStringAsFixed(2)}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
