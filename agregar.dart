// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'db_connection.dart';
import 'student.dart';

class Agregar extends StatefulWidget {
  const Agregar({super.key});

  @override
  State<Agregar> createState() => _AgregarState();
}

class _AgregarState extends State<Agregar> {
  late TextEditingController _nombreController;
  late TextEditingController _paternoController;
  late TextEditingController _maternoController;
  late TextEditingController _telefonoController;
  late TextEditingController _correoController;
  final RegExp nameExp = RegExp(r'^[a-zA-Z]+$');
  final RegExp phoneExp = RegExp(r'^\d{10}$');
  final RegExp emailExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
  // ignore: unused_field, non_constant_identifier_names
  late List<Student> _Students;
  late int tam;
  late int aumento = tam;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Students = [];
    _nombreController = TextEditingController();
    _paternoController = TextEditingController();
    _maternoController = TextEditingController();
    _telefonoController = TextEditingController();
    _correoController = TextEditingController();

    tam = 0;
    _selectData();
    aumento = tam;
  }

  //Agregar datos
  _insertData(String nombre, String paterno, String materno, String tel,
      String correo) {
    // Validaciones para nombres y apellidos
    if (nombre.isEmpty || !nameExp.hasMatch(nombre)) {
      _mostrarAdvertencia('Advertencia', 'Nombre con caratteres invalidos');
      return;
    }

    if (paterno.isEmpty || !nameExp.hasMatch(paterno)) {
      _mostrarAdvertencia(
          'Error', 'Apellido paterno con caracteres no validos');
      return;
    }

    if (materno.isEmpty || !nameExp.hasMatch(materno)) {
      _mostrarAdvertencia(
          'Error', 'Apellido materno con caracteres no validos');
      return;
    }

    // Validación para teléfono
    if (tel.isEmpty || !phoneExp.hasMatch(tel)) {
      _mostrarAdvertencia('Error',
          'Numero telefonico no debe incluir letras y maximo 10 digitos');
      return;
    }

    // Validación para correo
    if (correo.isEmpty || !emailExp.hasMatch(correo)) {
      _mostrarAdvertencia(
          'Error', 'El correo no cuenta con la extruntura xxxxxx@xxxx.xxx');
      return;
    }
    BDConnections.insertData(
      nombre.toUpperCase(),
      paterno.toUpperCase(),
      materno.toUpperCase(),
      tel,
      correo.toLowerCase(),
    ).then((result) {
      if (result == 'success') {
        _limpiezaText();
        _mostrarAdvertencia('Éxito', 'Los datos se guardaron correctamente');
      } else {
        _mostrarAdvertencia('Error', 'No se pudieron guardar los datos');
      }
    }).catchError((error) {
      _mostrarAdvertencia('Error', 'Ocurrió un problema al guardar los datos');
      print('Error al guardar datos: $error');
    });
  }

  Future<void> _selectData() async {
    await BDConnections.selectData().then((students) {
      try {
        setState(() {
          _Students = students;
          tam = students.length; // Actualiza la longitud de la lista
        });
      } catch (e) {
        print('Error $e');
      }
    });
  }

  _limpiezaText() {
    _nombreController.clear();
    _paternoController.clear();
    _maternoController.clear();
    _telefonoController.clear();
    _correoController.clear();
  }

  void _mostrarAdvertencia(String titulo, String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          'Agregar',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _insertData(
                    _nombreController.text,
                    _paternoController.text,
                    _maternoController.text,
                    _telefonoController.text,
                    _correoController.text);
                setState(
                  () {
                    _selectData();
                  },
                );
              },
              icon: const Icon(
                Icons.save_rounded,
                size: 30,
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  //Tamaño del arego para confirmar el cambio
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Se cuentan con ${tam.toString()} registros.',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.green),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  controller: _nombreController,
                  decoration: InputDecoration(
                    hintText: 'Nombre(s)',
                    labelText: 'Nombre',
                    prefix: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  controller: _paternoController,
                  decoration: InputDecoration(
                    hintText: 'Apellido parerno',
                    labelText: 'Apellido Paterno',
                    prefix: const Icon(Icons.person_2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  controller: _maternoController,
                  decoration: InputDecoration(
                    hintText: 'Apellido materno',
                    labelText: 'Apellido Materno',
                    prefix: const Icon(Icons.person_3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  controller: _telefonoController,
                  decoration: InputDecoration(
                    hintText: 'Telefono',
                    labelText: 'Numero telefonico',
                    prefix: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  controller: _correoController,
                  decoration: InputDecoration(
                    hintText: 'Correo',
                    labelText: 'Mail',
                    prefix: const Icon(Icons.mail),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
