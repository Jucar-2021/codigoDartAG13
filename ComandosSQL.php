<?php

$servername = "localhost";
$username = "root";
$password = "UNIDEH.ag13";
$dbname = "actividad_ag13";
$table = "actividad_final";

// Leer el cuerpo JSON
$input = json_decode(file_get_contents('php://input'), true);

if (isset($input['actions'])) {
    $action = $input['actions'];

    $conn = new mysqli($servername, $username, $password, $dbname);
    if ($conn->connect_error) {
        die("Connection Failed: " . $conn->connect_error);
    }

    if ("CREATE_TABLE" == $action) {
        $sql = "CREATE TABLE IF NOT EXISTS $table (
            id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            nombre VARCHAR(50) NOT NULL,
            paterno VARCHAR(50) NOT NULL,
            materno VARCHAR(50) NOT NULL,
            telefono VARCHAR(10) NOT NULL,
            correo VARCHAR(50) NOT NULL
        )";

        echo $conn->query($sql) === TRUE ? "success" : "error";

    } elseif ("INSERT_DATA" == $action) {
        $nombre = $input['nombre'];
        $paterno = $input['paterno'];
        $materno = $input['materno'];
        $telefono = $input['telefono'];
        $correo = $input['correo'];
        $sql = $conn->prepare("INSERT INTO $table (nombre, paterno, materno, telefono, correo) VALUES (?,?,?,?,?)");
        $sql->bind_param("sssss", $nombre, $paterno, $materno, $telefono, $correo);
        echo $sql->execute() ? "success" : "error";

    } elseif ("SELECT_TABLE" == $action) {
        $result = $conn->query("SELECT id, nombre, paterno, materno, telefono, correo FROM $table ORDER BY id DESC");
        $data = $result->fetch_all(MYSQLI_ASSOC);
        echo json_encode($data);

    } elseif ("DELETE_DATA" == $action) {
        $id = $input['id'];
        $sql = $conn->prepare("DELETE FROM $table WHERE id = ?");
        $sql->bind_param("i", $id);
        echo $sql->execute() ? "success" : "error";

    } elseif ("UPDATE_NOMBRE" == $action) {
        $id = $input['id'];
        $nombre = $input['nombre'];
        $sql = $conn->prepare("UPDATE $table SET nombre = ? WHERE id = ?");
        $sql->bind_param("si", $nombre, $id);

        echo $sql->execute() ? "success" : "error";

    }elseif ("UPDATE_PATERNO" == $action) {
        $id = $input['id'];
        $paterno = $input['paterno'];
        $sql = $conn->prepare("UPDATE $table SET paterno = ? WHERE id = ?");
        $sql->bind_param("si", $paterno, $id);

        echo $sql->execute() ? "success" : "error";

    }elseif ("UPDATE_MATERNO" == $action) {
        $id = $input['id'];
        $materno = $input['materno'];
        $sql = $conn->prepare("UPDATE $table SET materno = ? WHERE id = ?");
        $sql->bind_param("si", $materno, $id);

        echo $sql->execute() ? "success" : "error";

    }elseif ("UPDATE_TELEFONO" == $action) {
        $id = $input['id'];
        $telefono = $input['telefono'];
        $sql = $conn->prepare("UPDATE $table SET telefono = ? WHERE id = ?");
        $sql->bind_param("si", $telefono, $id);

        echo $sql->execute() ? "success" : "error";

    }elseif ("UPDATE_CORREO" == $action) {
        $id = $input['id'];
        $correo = $input['correo'];
        $sql = $conn->prepare("UPDATE $table SET correo = ? WHERE id = ?");
        $sql->bind_param("si", $correo, $id);

        echo $sql->execute() ? "success" : "error";

    }elseif ("BUSCAR_LIKE" == $action) {
        $term = isset($input['term']) ? trim($input['term']) : '';
        if (empty($term)) {
            echo json_encode(['error' => 'El término de búsqueda no puede estar vacío']);
            exit;
        }
    
        if (is_numeric($term)) {
            // Si es un número, busca por ID o teléfono
            $sql = $conn->prepare("SELECT * FROM $table WHERE id = ? OR telefono = ?");
            $sql->bind_param("ii", $term, $term);
        } else {
            // Si no es un número, usa LIKE en los campos de texto
            $term = "%" . $term . "%";
            $sql = $conn->prepare("SELECT * FROM $table 
                WHERE nombre LIKE ? OR paterno LIKE ? OR materno LIKE ? OR correo LIKE ?
            ");
            $sql->bind_param("ssss", $term, $term, $term, $term);
        }
    
        $sql->execute();
        $result = $sql->get_result();
        $data = $result->fetch_all(MYSQLI_ASSOC);
    
        echo json_encode($data);
    }else {
        echo "Acción no reconocida: $action";
    }
    $conn->close();
} else {
    echo "No se proporcionó ninguna acción.";
}

?>