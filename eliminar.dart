import 'package:flutter/material.dart';
import 'student.dart';
import 'db_connection.dart';

class Eliminar extends StatefulWidget {
  const Eliminar({super.key});

  @override
  State<Eliminar> createState() => _EliminarState();
}

class _EliminarState extends State<Eliminar> {
  late List<Student> _Students;
  String? selecRadio;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectData();
    _Students = [];
  }

  //Actualizacion de tabla
  _selectData() {
    BDConnections.selectData().then((students) {
      setState(() {
        _Students = students;
      });
    });
  }

  _ordenar() {
    BDConnections.selectData().then((students) {
      students.sort((a, b) => a.nombre.compareTo(b.nombre));
      setState(() {
        _Students = students;
      });
    });
  }

  //Delete Data
  _deleteData(String id) {
    int idNumerico = int.parse(id);
    BDConnections.deleteData(idNumerico);
    _selectData();
  }

  SingleChildScrollView _body() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Selec')),
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Nombre')),
            DataColumn(label: Text('A Paterno')),
            DataColumn(label: Text('A Materno')),
            DataColumn(label: Text('Telefono')),
            DataColumn(label: Text('Correo')),
          ],
          rows: _Students.map(
            (student) => DataRow(
              cells: [
                DataCell(
                  Radio<String>(
                    value: student.id,
                    groupValue: selecRadio,
                    onChanged: (String? value) {
                      setState(() {
                        selecRadio = value;
                        print('Seleccionado: $selecRadio');
                        // Deselecciona después de una operación
                      });
                    },
                  ),
                ),
                DataCell(Text(student.id)),
                DataCell(Text(student.nombre)),
                DataCell(Text(student.paterno)),
                DataCell(Text(student.materno)),
                DataCell(Text(student.telefono)),
                DataCell(Text(student.correo)),
              ],
            ),
          ).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          'Eliminar',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _selectData();
            },
            icon: const Icon(
              Icons.update,
              size: 40,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: IconButton.filled(
                  onPressed: () {
                    _ordenar();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Aviso'),
                          content: const Text(
                              'Los datos se ordenaron albabeticamente por nombre.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Cerrar el diálogo
                              },
                              child: const Text('Aceptar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.swap_vert_circle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: IconButton.filled(
                  onPressed: () {
                    try {
                      _deleteData(selecRadio!);
                      selecRadio = null;
                      _selectData();
                      _selectData();
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Advertencia'),
                            content: const Text(
                                'Por favor, selecciona un elemento antes de eliminarlo.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Cerrar el diálogo
                                },
                                child: const Text('Aceptar'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  icon: const Icon(Icons.delete),
                ),
              ),
            ],
          ),
          Expanded(
            child: _body(),
          )
        ],
      ),
    );
  }
}
