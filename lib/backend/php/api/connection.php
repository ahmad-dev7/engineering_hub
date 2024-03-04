<?php
class dbObj{

    var $serverName = "localhost";
    var $userName = "ahmali7671_engineeringhub";
    var $password = "ahabiya22J*";
    var $dbname = "ahmali7671_engineeringhub";
    var $conn;

    function getConnString() {
        $con = mysqli_connect($this -> serverName, $this -> userName, $this -> password, $this -> dbname) or die("failed to connect with sever: ".mysqli_connect_error());
        // Check connection
        if (mysqli_connect_errno()) {
            echo "Connect failed: %s\n", mysqli_connect_errno();
            exit();
        }
        else {
            $this -> conn = $con;
        }
        return $this -> conn;
    }
}