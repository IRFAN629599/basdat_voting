<?php

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once "controller/VotingController.php";

$controller = new VotingController();
$action = $_GET['action'] ?? '';

switch ($action) {

    case 'login':
        $controller->login();
        break;
    case 'voting':
        $controller->voting();
        break;
    case 'siswa':
        $controller->view_siswa();
        break;
    case 'guru':
        $controller->view_guru();
        break;
    case 'kandidat':
        $controller->view_kandidat();
        break;
    case 'periode':
        $controller->view_periode();
        break;
    case 'progres_voting':
        $controller->view_progres_voting();
        break;
    case 'total_vote':
        $controller->view_total_vote();
        break;
    case 'tambah_siswa':
        $controller->tambah_siswa();
        break;
    case 'tambah_guru':
        $controller->tambah_guru();
        break;
    case 'tambah_user':
        $controller->tambah_user();
        break;
    case 'user':
        $controller->view_user();
        break;
    case 'update_user':
        $controller->update_user();
        break;
    case 'hapus_user':
        $controller->hapus_user();
        break;
    case 'update_siswa':
        $controller->update_siswa();
        break;
    case 'hapus_siswa':
        $controller->hapus_siswa();
        break;
    case 'update_guru':
        $controller->update_guru();
        break;
    case 'hapus_guru':
        $controller->hapus_guru();
        break;
    case 'set_periode':
        $controller->set_periode();
        break;

    default:
        echo json_encode([
            "status" => false,
            "message" => "Endpoint tidak ditemukan"
        ]);
}
