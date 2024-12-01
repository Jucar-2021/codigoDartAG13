import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'student.dart';

class BDConnections {
  static const SERVER =
      "http://192.168.0.24/ComandosConnections/ComandosSQL.php";
  static const _CREATE_TABLE_COMMAND = "CREATE_TABLE";
  static const _SELECT_TABLE_COMMAND = "SELECT_TABLE";
  static const _INSERT_TABLE_COMMAND = "INSERT_DATA";
  static const _DELETE_TABLE_COMMAND = "DELETE_DATA";
  static const _UPDATE_NOMBRE = "UPDATE_NOMBRE";
  static const _UPDATE_PATERNO = "UPDATE_PATERNO";
  static const _UPDATE_MATERNO = "UPDATE_MATERNO";
  static const _UPDATE_TELEFONO = "UPDATE_TELEFONO";
  static const _UPDATE_CORREO = "UPDATE_CORREO";
  static const _BUSCAR_LIKE = "BUSCAR_LIKE";
  static final Uri serverUri = Uri.parse(SERVER);

//Crear tabla
  static Future<String?> createTable() async {
    try {
      var map = {
        'actions': _CREATE_TABLE_COMMAND,
      };

      final response = await http.post(
        serverUri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(map),
      );
      print('Table response: ${response.body}');

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'Error';
      }
    } catch (e) {
      print("Error creando tabla o la tabla ya existe");
      print(e.toString());
      return 'Error';
    }
  }

//Seleccionar tabla
  static Future<List<Student>> selectData() async {
    try {
      var map = {
        'actions': _SELECT_TABLE_COMMAND,
      };

      final response = await http.post(
        serverUri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(map),
      );
      print('Select response: ${response.body}');

      if (response.statusCode == 200) {
        List<Student> list = parseResponse(response.body);
        return list;
      } else {
        return <Student>[];
      }
    } catch (e) {
      print("Error obteniendo datos");
      print(e.toString());
      return <Student>[];
    }
  }

  static List<Student> parseResponse(String responseBody) {
    final parsedData = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsedData.map<Student>((json) => Student.fromJson(json)).toList();
  }

//Insetar datos
  static Future<String?> insertData(String nombre, String paterno,
      String materno, String telefono, String correo) async {
    try {
      var map = {
        'actions': _INSERT_TABLE_COMMAND,
        'nombre': nombre,
        'paterno': paterno,
        'materno': materno,
        'telefono': telefono,
        'correo': correo,
      };

      final response = await http.post(
        serverUri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(map),
      );
      print('Insert response: ${response.body}');

      if (response.statusCode == 200) {
        print('Insert Correcto');
        return response.body;
      } else {
        return 'Error';
      }
    } catch (e) {
      print("Error al insertar datos");
      print(e.toString());
      return 'Error';
    }
  }

//Eliminar
  static Future<String?> deleteData(int id) async {
    try {
      var map = {
        'actions': _DELETE_TABLE_COMMAND,
        'id': id,
      };

      final response = await http.post(
        serverUri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(map),
      );
      print('Delete response: ${response.body}');

      if (response.statusCode == 200) {
        print('Delete Correcto');
        return response.body;
      } else {
        return 'Error';
      }
    } catch (e) {
      print("Error al eliminar datos");
      print(e.toString());
      return 'Error';
    }
  }

//Actualizar nombre
  static Future<String?> updateName(String id, String nombre) async {
    try {
      var map = {
        'actions': _UPDATE_NOMBRE,
        'id': id,
        'nombre': nombre,
      };

      final response = await http.post(
        serverUri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(map),
      );
      print('Update response: ${response.body}');

      if (response.statusCode == 200) {
        print('Update Correcto');
        return response.body;
      } else {
        return 'Error';
      }
    } catch (e) {
      print("Error al actualizar datos");
      print(e.toString());
      return 'Error';
    }
  }

//Actualizar apellido paterno
  static Future<String?> updatePaterno(String id, String paterno) async {
    try {
      var map = {
        'actions': _UPDATE_PATERNO,
        'id': id,
        'paterno': paterno,
      };

      final response = await http.post(
        serverUri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(map),
      );
      print('Update response: ${response.body}');

      if (response.statusCode == 200) {
        print('Update Correcto');
        return response.body;
      } else {
        return 'Error';
      }
    } catch (e) {
      print("Error al actualizar datos");
      print(e.toString());
      return 'Error';
    }
  }

//Actualizar apellido materno
  static Future<String?> updateMaterno(String id, String materno) async {
    try {
      var map = {
        'actions': _UPDATE_MATERNO,
        'id': id,
        'materno': materno,
      };

      final response = await http.post(
        serverUri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(map),
      );
      print('Update response: ${response.body}');

      if (response.statusCode == 200) {
        print('Update Correcto');
        return response.body;
      } else {
        return 'Error';
      }
    } catch (e) {
      print("Error al actualizar datos");
      print(e.toString());
      return 'Error';
    }
  }

//Actualizar telefono
  static Future<String?> updateTelefono(String id, String telefono) async {
    try {
      var map = {
        'actions': _UPDATE_TELEFONO,
        'id': id,
        'telefono': telefono,
      };

      final response = await http.post(
        serverUri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(map),
      );
      print('Update response: ${response.body}');

      if (response.statusCode == 200) {
        print('Update Correcto');
        return response.body;
      } else {
        return 'Error';
      }
    } catch (e) {
      print("Error al actualizar datos");
      print(e.toString());
      return 'Error';
    }
  }

//Actualizar correo
  static Future<String?> updateCorreo(String id, String correo) async {
    try {
      var map = {
        'actions': _UPDATE_CORREO,
        'id': id,
        'correo': correo,
      };

      final response = await http.post(
        serverUri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(map),
      );
      print('Update response: ${response.body}');

      if (response.statusCode == 200) {
        print('Update Correcto');
        return response.body;
      } else {
        return 'Error';
      }
    } catch (e) {
      print("Error al actualizar datos");
      print(e.toString());
      return 'Error';
    }
  }

  // Búsqueda LIKE
  static Future<List<Student>> buscarData(String term) async {
    try {
      var map = {
        'actions': _BUSCAR_LIKE,
        'term': term, // Enviar término de búsqueda
      };

      final response = await http.post(
        serverUri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(map),
      );

      if (response.body.isNotEmpty) {
        // Decodificar la respuesta JSON
        final List<dynamic> decodedJson = jsonDecode(response.body);

        // Mapear los datos a objetos Student
        List<Student> estudiantes = decodedJson.map((item) {
          return Student(
            id: item['id'].toString(),
            nombre: item['nombre'],
            paterno: item['paterno'],
            materno: item['materno'],
            telefono: item['telefono'],
            correo: item['correo'],
          );
        }).toList();

        print('Lista generada: $estudiantes');
        return estudiantes;
      } else {
        print("No se encontraron datos para la búsqueda.");
        return <Student>[];
      }
    } catch (e) {
      print("Error en buscarData: $e");
      return <Student>[]; // Retornar lista vacía en caso de error
    }
  }

  static List<Student> mapo(String datos) {
    // Decodificar el JSON
    final List<dynamic> decodedJson = jsonDecode(datos);

    // Lista para almacenar los objetos Student
    List<Student> listaEstudiantes = [];

    // Iterar sobre los elementos y extraer los datos requeridos
    for (var item in decodedJson) {
      listaEstudiantes.add(
        Student(
          id: item['id'].toString(), // Convertir ID a String si es numérico
          nombre: item['nombre'],
          paterno: item['paterno'],
          materno: item['materno'],
          telefono: item['telefono'],
          correo: item['correo'],
        ),
      );
    }

    // Imprimir la lista generada
    print('est lista contiene $listaEstudiantes');

    return listaEstudiantes;
  }
}
