<?php
include("connection.php");
$db = new dbObj();
$connection = $db -> getConnString();

$request_method = $_SERVER['REQUEST_METHOD'];

switch ($request_method) {
    case 'GET':
        $collegeName = mysqli_real_escape_string($connection, $_GET["collegeName"]);
        $branchName = mysqli_real_escape_string($connection, $_GET["branchName"]);  
        $semester = intval($_GET['semester']);
        readMessage($collegeName,$branchName,$semester);
        break;

    case 'POST':
        $senderID = $_POST['senderId'];
        $message = $_POST['message'];
        $timeStamp = $_POST['timeStamp'];
        createMessage($senderID, $message, $timeStamp);
        break;

    case 'PUT':
        $data = json_decode(file_get_contents('php://input'), true);
        $messageId = $data['messageId'];
        $newMessage = $data['newMessage'];
        updateMessage($messageId, $newMessage);
        break;

    case 'DELETE':
        $messageId = intval($_GET['messageId']);
        deleteMessage($messageId);

    default:
        echo "Default Response encountered";
        break;
}

//* Create Message method
function createMessage($senderId, $message, $timeStamp){
    global $connection;

    $sqlQuery = "INSERT INTO messages(senderId, message, timeStamp) VALUES ('".$senderId."', '".$message."', '".$timeStamp."')";

    $response = array();

    if ($connection -> query($sqlQuery)) {
        //* Success
        header('HTTP/1.0 201');
        $response = array(
            'status_code' => 201,
            'status_message' => "Message added successfully"
        );
    } else {
        //* Failed   
        header('HTTP/1.0 400');
        $response  = array(
            'status_code'=> 400,
            'status_message'=> "Failed to add message"
        );
    }
    
    header('Content-Type: Application/json');
    echo json_encode($response);
}

//* Read Message method
function readMessage($collegeName, $branchName, $semester){
    global $connection;

    $sqlQuery = "SELECT messageId, senderId, message, timeStamp FROM messages ";

    $queryResponse = $connection->query($sqlQuery);

    $response = array();
    if ($queryResponse->num_rows > 0) {
        while ($row = $queryResponse->fetch_assoc()) {
            // Getting sender id from the message row
            $senderId = $row["senderId"];
            // Query for students table to fetch data of message sender
            $senderDataQuery = "SELECT college_name, branch, semester, name, email, phone_no FROM student WHERE id='$senderId' AND college_name='$collegeName' AND branch='$branchName' AND semester='$semester' ";
            // Running above query
            $senderDataResponse = $connection->query($senderDataQuery);
            // Checking if the following query got a response
            if ($senderDataResponse->num_rows >0) {
                // Reading retrieved student data
                $senderData = $senderDataResponse->fetch_assoc();
                // Combining student data with message
                $messageWithSenderData = array_merge($row, $senderData);
                // Pushing combined data in array
                array_push($response, $messageWithSenderData);
            }
           
        }
    } else {
        header('HTTP/1.0 401');
        $response = array(
            'status_code' => 401,
            'status_message' => 'No messages found here'
        );
    }

    header('Content-Type: Application/json');
    echo json_encode($response);
}

//* Update Message method
function updateMessage($messageId, $newMessage){
    global $connection;

    $sqlQuery = "UPDATE messages SET message= '".$newMessage."' WHERE messageId='".$messageId."' ";
    $response = array();
    if ($connection -> query($sqlQuery)) {
        //* Success
        $response = array(
            "status_code"=> 1,
            "status_message"=> "Successfully message updated"
        );
    }
    else {
        //* Failed
        $response = array(
            "status_code"=> 0,
            "status_message"=> "Failed to update message"
        );
    }

    header('Content-Type: Application/json');
    echo json_encode($response);
}

//* Delete Message method
function deleteMessage($messageId){
    global $connection;

    $sqlQuery = "DELETE FROM messages WHERE messageId = '".$messageId."'";
    $response = array();
    if ($connection -> query($sqlQuery)) {
        echo "No content";
    }
    else {
        header('HTTP:1.0 400');
        $response = array(
            'status_code'=> 400,
            'status_message'=> 'Failed to Delete message'
        );
    }
    echo  json_encode($response);
}