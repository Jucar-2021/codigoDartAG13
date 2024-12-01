// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'student.dart';
import 'db_connection.dart';
import 'actualizarBuscar.dart';

class Buscar extends StatefulWidget {
  const Buscar({super.key});

  @override
  State<Buscar> createState() => _BuscarState();
}

class _BuscarState extends State<Buscar> {
  late List<Student> _Students;
  late TextEditingController _busquedaController;
  late String argumento;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectData();
    _Students = [];
    _busquedaController = TextEditingController();
  }

  _realizarBusqueda(String termino) async {
    print("Término de búsqueda enviado: $termino");

    try {
      // Obtener los resultados de la búsqueda
      List<Student> resultados = await BDConnections.buscarData(termino);

      setState(() {
        _Students = resultados; // Actualizar el estado con los resultados
      });

      if (resultados.isNotEmpty) {
        print("La búsqueda: $termino devolvió ${resultados.length} resultados");
      } else {
        print("No se encontraron resultados para: $termino");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Sin coincidencias',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: const Text('No se encontraton elemtos para la busqueda'),
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
    } catch (e) {
      print("Error realizando búsqueda");
      print(e.toString());
    }
  }

  //Actualizacion de tabla
  _selectData() {
    BDConnections.selectData().then((students) {
      setState(() {
        _Students = students;
      });
    });
  }

  SingleChildScrollView _body() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Edit')),
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
                  IconButton(
                    onPressed: () {
                      setState(() {
                        argumento = student.id;
                        print('se selecciono el ID: $argumento');
                        argumento as String;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => new Actualizar(
                              argumento: argumento,
                            ),
                          ),
                        );
                      });
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.redAccent,
                    ),
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
          'Busqueda',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  cursorHeight: 25,
                  controller: _busquedaController,
                  decoration: InputDecoration(
                    hintText: 'Busqueda',
                    labelText: 'Busqueda',
                    prefixIcon: IconButton(
                      onPressed: () {
                        _realizarBusqueda(_busquedaController.text);
                      },
                      icon: (const Icon(
                        Icons.search,
                        size: 45,
                      )),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    filled: true,
                    fillColor: Colors.cyan[50],
                  ),
                  cursorWidth: 5,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      _selectData();
                    },
                    child: Container(
                      height: 45,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Actualizar',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Expanded(child: _body())
        ],
      ),
    );
  }
}
