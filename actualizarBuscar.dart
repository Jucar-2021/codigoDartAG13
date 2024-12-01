import 'package:ag13_v2/buscarActualizar.dart';
import 'package:ag13_v2/student.dart';
import 'package:flutter/material.dart';
import 'db_connection.dart';

class Actualizar extends StatefulWidget {
  final String argumento;
  const Actualizar({super.key, required this.argumento});

  @override
  State<Actualizar> createState() => _ActualizarState();
}

class _ActualizarState extends State<Actualizar> {
  late List<Student> _Student;
  late TextEditingController _nombreController;
  late TextEditingController _paternoController;
  late TextEditingController _maternoController;
  late TextEditingController _telefonoController;
  late TextEditingController _correoController;
  final RegExp nameExp = RegExp(r'^[a-zA-Z]+$');
  final RegExp phoneExp = RegExp(r'^\d{10}$');
  final RegExp emailExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Student = [];
    _nombreController = TextEditingController();
    _paternoController = TextEditingController();
    _maternoController = TextEditingController();
    _telefonoController = TextEditingController();
    _correoController = TextEditingController();
    _realizarBusqueda(widget.argumento);

    //_selectData();
  }

  _realizarBusqueda(String termino) async {
    print("Término de búsqueda enviado: $termino");

    try {
      // Llama al método de búsqueda y actualiza el estado
      List<Student> resultados = await BDConnections.buscarData(termino);

      print('^^^^^^^^^^^^$resultados^^^^^^^^^^^^^^');
      setState(() {
        _Student = resultados;
        print('<<<<<<<<<<<<<<<<<<<<<<<$_Student>>>>>>>>>>>>>>>>>>');
      });
      print('Datos recuperados: ${resultados.length}<<<<<<<<<<<<<<<<<<<<<<<');
    } catch (e) {
      print('Error de búsqueda: $e');
    }
  }

  _selectData() {
    BDConnections.selectData().then((students) {
      setState(() {
        _Student = students;
      });
    });
  }

  _updateNombre(String id, String nombre) {
    if (_nombreController.text.isEmpty ||
        !nameExp.hasMatch(_nombreController.text)) {
      return;
    }
    BDConnections.updateName(id, _nombreController.text.toUpperCase());

    _nombreController.clear();
  }

  _updatePaterno(String id, String paterno) {
    if (_paternoController.text.isEmpty ||
        !nameExp.hasMatch(_paternoController.text)) {
      return;
    }
    BDConnections.updatePaterno(id, _paternoController.text.toUpperCase());

    _paternoController.clear();
  }

  _updateMaterno(String id, String materno) {
    if (_maternoController.text.isEmpty ||
        !nameExp.hasMatch(_maternoController.text)) {
      return;
    }
    BDConnections.updateMaterno(id, _maternoController.text.toUpperCase());

    _maternoController.clear();
  }

  _updateTelefono(String id, String telefono) {
    // Validación para teléfono
    if (_telefonoController.text.isEmpty ||
        !phoneExp.hasMatch(_telefonoController.text)) {
      return;
    }
    BDConnections.updateTelefono(id, _telefonoController.text);

    _telefonoController.clear();
  }

  _updateCorreo(String id, String correo) {
    // Validación para correo
    if (_correoController.text.isEmpty ||
        !emailExp.hasMatch(_correoController.text)) {
      return;
    }
    BDConnections.updateCorreo(id, _correoController.text);

    _correoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          'Actualizacion ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Text(
                'El registro seleccionado tiene el ID ${widget.argumento}',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 19, 3, 158)),
              ),
              DataTable(
                columns: const [
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('A.Paterno')),
                  DataColumn(label: Text('A.Materno')),
                  DataColumn(label: Text('Tel')),
                  DataColumn(label: Text('Mail')),
                ],
                rows: _Student.map(
                  (student) => DataRow(
                    cells: [
                      DataCell(Text(student.nombre)),
                      DataCell(Text(student.paterno)),
                      DataCell(Text(student.materno)),
                      DataCell(Text(student.telefono)),
                      DataCell(Text(student.correo)),
                    ],
                  ),
                ).toList(),
              ),
              DataTable(
                columns: const [
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.all(1),
                          child: TextField(
                            controller: _nombreController,
                            decoration: InputDecoration(
                              hintText: 'Nombre',
                              hintStyle: const TextStyle(
                                  color: Colors.red, fontSize: 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.yellow[100],
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.all(1),
                          child: TextField(
                            controller: _paternoController,
                            decoration: InputDecoration(
                              hintText: 'A.Paterno',
                              hintStyle: const TextStyle(
                                  color: Colors.red, fontSize: 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.yellow[100],
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.all(1),
                          child: TextField(
                            controller: _maternoController,
                            decoration: InputDecoration(
                              hintText: 'A.Materno',
                              hintStyle: const TextStyle(
                                  color: Colors.red, fontSize: 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.yellow[100],
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.all(1),
                          child: TextField(
                            controller: _telefonoController,
                            decoration: InputDecoration(
                              hintText: 'Tel',
                              hintStyle: const TextStyle(
                                  color: Colors.red, fontSize: 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.yellow[100],
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.all(1),
                          child: TextField(
                            controller: _correoController,
                            decoration: InputDecoration(
                              hintText: 'Mail',
                              hintStyle: const TextStyle(
                                  color: Colors.red, fontSize: 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.yellow[100],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_nombreController.text.isNotEmpty) {
            _updateNombre(widget.argumento, _nombreController.text);
          }
          if (_paternoController.text.isNotEmpty) {
            _updatePaterno(widget.argumento, _paternoController.text);
          }
          if (_maternoController.text.isNotEmpty) {
            _updateMaterno(widget.argumento, _maternoController.text);
          }
          if (_telefonoController.text.isNotEmpty) {
            _updateTelefono(widget.argumento, _telefonoController.text);
          }
          if (_correoController.text.isNotEmpty) {
            _updateCorreo(widget.argumento, _correoController.text);
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Buscar(),
            ),
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  'Confirmacion',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: const Text('Se actualizaron los datos con exito'),
                icon: const Icon(
                  Icons.check_circle,
                  size: 60,
                  color: Color.fromARGB(255, 15, 173, 23),
                ),
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
        },
        child: const Icon(
          Icons.update,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
