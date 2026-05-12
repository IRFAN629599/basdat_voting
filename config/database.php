<?php
class Database {
    private $host = "localhost";
    private $db = "vote_osismpk";
    private $user = "root";
    private $pass = "";

    public function connect() {
        return new PDO(
            "mysql:host=$this->host;dbname=$this->db",
            $this->user,
            $this->pass,
            [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
        );
    }
}