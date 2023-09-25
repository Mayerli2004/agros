import 'package:agros/models/agros.dart';
import 'package:agros/models/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NuevoAgroScreen extends StatefulWidget {
  @override
  _NuevoAgroScreenState createState() => _NuevoAgroScreenState();
}

class _NuevoAgroScreenState extends State<NuevoAgroScreen> {
  File? _selectedImage;
  String? _agroType;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  void _showSuccessAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Guardado exitoso'),
          content: Text('El agro se ha guardado correctamente.'),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorAlert(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error al guardar'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Nuevo Agro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre del agro',
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Precio',
                ),
              ),
              SizedBox(height: 20.0),
              DropdownButtonFormField(
                value: _agroType,
                onChanged: (newValue) {
                  setState(() {
                    _agroType = newValue.toString();
                  });
                },
                items: ['Fruta', 'Verdura', 'Citrico']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                decoration: InputDecoration(
                  labelText: 'Tipo de agro',
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: _pickImage,
                child: _selectedImage != null
                    ? Image.file(
                        _selectedImage!,
                        height: 150.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.add_a_photo,
                        size: 150.0,
                      ),
              ),
              SizedBox(height: 10.0),
              Text('Selecciona una imagen'),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  if (_selectedImage != null) {
                    final agro = Agros(
                      nombre: _nameController.text,
                      precio: double.parse(_priceController.text),
                      tipo: _agroType ?? '',
                      imagenPath: _selectedImage!.path,
                    );

                    final database = DatabaseProvider.instance;
                    try {
                      await database.insertAnimal(agro);
                      _showSuccessAlert();
                    } catch (error) {
                      _showErrorAlert('Error al guardar: $error');
                    }
                  }
                },
                child: Text('Guardar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
