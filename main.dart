import 'package:ag13_v2/Agregar.dart';
import 'package:ag13_v2/Eliminar.dart';
import 'package:ag13_v2/buscarActualizar.dart';
import 'package:flutter/material.dart';
import 'db_connection.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PantallaInicial(),
      theme: ThemeData.light(),
    );
  }
}

class PantallaInicial extends StatefulWidget {
  const PantallaInicial({super.key});

  @override
  State<PantallaInicial> createState() => _PantallaInicialState();
}

class _PantallaInicialState extends State<PantallaInicial>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    BDConnections.createTable();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 219, 201, 136),
        title: const Text(
          'AG13 - MySQL',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(padding: const EdgeInsets.all(30), children: <Widget>[
          const Text(
            'Menu',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: const Icon(Icons.manage_search),
            title: const Text(
              'Buscar',
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Buscar()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            dense: false,
            title: const Text(
              'Agregar',
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Agregar()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_sweep),
            title: const Text(
              'Eliminar',
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Eliminar()));
            },
          )
        ]),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.black),
              child: Text(
                'Equipo - 1'.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Image.asset('assets/unideh.png'),
            Image.asset('assets/ing.jpg'),
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.cyan),
              child: Text(
                'Actividad final'.toUpperCase(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 350,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Si la tabla de no existe, \nse crea al inicial la palicacion.')
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            child: const Icon(
              Icons.menu,
              size: 30,
            ),
          );
        },
      ),
    );
  }
}
