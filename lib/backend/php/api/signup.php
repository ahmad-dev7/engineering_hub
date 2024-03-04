<?php
include 'connection.php';

$db = new dbObj();
$connection = $db -> getConnString();
$data = json_decode(file_get_contents('php://input'),true);
$college_name = $_POST['collegeName'];
$branch = $_POST['branch'];
$semester = $_POST['semester'];
$name = $_POST['name'];
$email = $_POST['email'];
$phone_no = $_POST['phoneNo'];
$password = $_POST['password'];

$sqlQuery = "INSERT INTO student(college_name, branch, semester, name, email, phone_no, password) VALUES ('".$college_name."', '".$branch."', '".$semester."', '".$name."', '".$email."', '".$phone_no."', '".$password."',)";


$response = array();
if ($connection -> query($sqlQuery)) {
    // Success
    header('HTTP/1.0 201');
    $response = array(
        'status_code' => '201',
        'status_message' => 'Student added successfully'
    );
} else {
    // Failed
    header('HTTP/1.0 401');
    $response = array(
        'status_code'=> '401',
        'status_message'=> 'Failed to add student'
    );
}

header('Content-Type: Application/json');
echo json_encode($response);