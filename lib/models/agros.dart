class Agros {
  final int? id;
  final String nombre;
  final double precio;
  final String tipo;
  final String imagenPath;

  Agros({
    this.id,
    required this.nombre,
    required this.precio,
    required this.tipo,
    required this.imagenPath,
  });

  factory Agros.fromMap(Map<String, dynamic> map) {
    return Agros(
      id: map['id'],
      nombre: map['nombre'],
      precio: map['precio'],
      tipo: map['tipo'],
      imagenPath: map['imagenPath'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'precio': precio,
      'tipo': tipo,
      'imagenPath': imagenPath,
    };
  }
}
