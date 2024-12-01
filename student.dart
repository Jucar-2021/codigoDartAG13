class Student {
  String id;
  String nombre;
  String paterno;
  String materno;
  String telefono;
  String correo;

  Student(
      {required this.id,
      required this.nombre,
      required this.paterno,
      required this.materno,
      required this.telefono,
      required this.correo});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      paterno: json['paterno'] as String,
      materno: json['materno'] as String,
      telefono: json['telefono'] as String,
      correo: json['correo'] as String,
    );
  }
  @override
  String toString() {
    return 'Student(id: $id, nombre: $nombre, paterno: $paterno, materno: $materno, telefono: $telefono, correo: $correo)';
  }
}
