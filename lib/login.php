<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

// Database connection
$servername = "localhost";
$username = "root"; // Default XAMPP username
$password = ""; // Default XAMPP password
$dbname = "weather_app";

$conn = new mysqli($servername, $username, $password, $dbname);

// Check database connection
if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => $conn->connect_error]));
}

// Read input data from POST request
$data = json_decode(file_get_contents("php://input"), true);

// Debugging: Log incoming data
error_log(print_r($data, true)); // Log the incoming data to PHP error log for debugging

// Validate input data
if (isset($data['username'], $data['email'], $data['contact'], $data['address'], $data['weather'], $data['password'])) {
    $username = $conn->real_escape_string($data['username']);
    $email = $conn->real_escape_string($data['email']);
    $contact = $conn->real_escape_string($data['contact']);
    $address = $conn->real_escape_string($data['address']);
    $weather = $conn->real_escape_string($data['weather']);
    $password = password_hash($data['password'], PASSWORD_BCRYPT); // Hash the password for security

    // Insert into database
    $sql = "INSERT INTO users (username, email, contact, address, weather_condition, password)
            VALUES ('$username', '$email', '$contact', '$address', '$weather', '$password')";

    if ($conn->query($sql) === TRUE) {
        echo json_encode(["status" => "success", "message" => "User data saved successfully"]);
    } else {
        // Return error if insert fails
        echo json_encode(["status" => "error", "message" => $conn->error]);
    }
} else {
    // Return error if any input field is missing
    echo json_encode(["status" => "error", "message" => "Invalid input, all fields are required"]);
}

$conn->close();
?>
