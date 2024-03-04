<?php
include "connection.php";

$db = new dbObj();
$connection = $db -> getConnString();

$email = $_POST['email'];
$password = $_POST['password'];

$sqlQuery = "SELECT * FROM student WHERE email = '".$email."' AND password = '".$password."' ";
$queryResponse = $connection -> query($sqlQuery);

$response = array();
if($queryResponse -> num_rows > 0){
    while ($row = $queryResponse -> fetch_assoc()) {
        array_push($response, $row);
    }

    header('Content-Type: Application/json');
    echo json_encode($response);
}else {
    
    header('HTTP:1.0 404');
    echo json_encode(array(
        'status_code'=> '404',
        'status_message'=> 'No user found with this email & password'
    ));
}

header('Content-Type: Application/json');
echo json_encode($response);