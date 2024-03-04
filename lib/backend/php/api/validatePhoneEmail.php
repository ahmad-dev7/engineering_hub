<?php
include('connection.php');
$db = new dbObj();
$connection = $db -> getConnString();

$email = $_GET['email'];

$sqlQuery = "SELECT * FROM student WHERE email='".$email."' ";
$queryResponse = $connection -> query($sqlQuery);

$response = array();
if ($queryResponse -> num_rows > 0) {
    header('HTTP/1.0 201');
    $response = array(
        "status_code"=>"201",
        "status_message"=>"Email is already in use",
    );
} else {
    header('HTTP/1.0 401');
    $response = array(
        "status_code"=>"401",
        "status_message"=>"Email is not in use"
    );
}

header('Content-Type: Application/json');
echo json_encode($response);