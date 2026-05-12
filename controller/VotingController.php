<?php

require_once "config/database.php";
require_once "model/VotingModel.php";
require_once "helper/response.php";

class VotingController
{
    private $model;

    public function __construct()
    {
        $db = new Database();
        $this->model = new VotingModel($db->connect());
    }

    private function getInput()
    {
        return json_decode(file_get_contents("php://input"), true);
    }

    /* ================= LOGIN ================= */

    public function login()
    {
        $data = $this->getInput();

        $user = $this->model->login($data);

        if ($user) {
            jsonResponse(true, "Login berhasil", $user);
        } else {
            jsonResponse(false, "Username / Password salah");
        }
    }

    /* ================= VOTING ================= */

    public function voting()
    {
        $data = $this->getInput();

        $result = $this->model->voting($data);

        if ($result === true) {

            jsonResponse(true, "Voting berhasil");
        } else {

            jsonResponse(false, $result);
        }
    }

    /* ================= VIEW ================= */

    public function view_siswa()
    {
        jsonResponse(true, "Data siswa", $this->model->get_siswa());
    }

    public function view_user()
    {
        jsonResponse(true, "Data user", $this->model->get_user());
    }

    public function view_guru()
    {
        jsonResponse(true, "Data guru", $this->model->get_guru());
    }

    public function view_kandidat()
    {
        jsonResponse(true, "Data kandidat", $this->model->get_kandidat());
    }

    public function view_periode()
    {
        jsonResponse(true, "Data periode", $this->model->get_periode());
    }

    public function view_progres_voting()
    {
        jsonResponse(true, "Progres voting", $this->model->get_progres_voting());
    }

    public function view_total_vote()
    {
        jsonResponse(true, "Total vote", $this->model->get_total_vote());
    }

    /* ================= SISWA ================= */

    public function tambah_siswa()
    {
        $data = $this->getInput();

        $result = $this->model->tambah_siswa($data);

        if ($result === true) {
            jsonResponse(true, "Berhasil tambah siswa");
        } else {
            jsonResponse(false, $result);
        }
    }

    public function update_siswa()
    {
        $data = $this->getInput();

        $result = $this->model->update_siswa($data);

        if ($result === true) {
            jsonResponse(true, "Berhasil update siswa");
        } else {
            jsonResponse(false, $result);
        }
    }

    public function hapus_siswa()
    {
        $data = $this->getInput();

        $result = $this->model->hapus_siswa($data['id']);

        if ($result === true) {
            jsonResponse(true, "Berhasil hapus siswa");
        } else {
            jsonResponse(false, $result);
        }
    }

    /* ================= USER ================= */

    public function tambah_user()
    {
        $data = $this->getInput();

        if (
            !$data ||
            !isset($data['username']) ||
            !isset($data['password']) ||
            !isset($data['role'])
        ) {
            jsonResponse(false, "Data tidak lengkap");
            return;
        }

        $result = $this->model->tambah_user($data);

        if ($result === true) {
            jsonResponse(true, "Berhasil tambah user");
        } else {
            jsonResponse(false, "Error: " . $result);
        }
    }

    public function update_user()
    {
        $data = $this->getInput();

        if (
            !$data ||
            !isset($data['id']) ||
            !isset($data['username']) ||
            !isset($data['password']) ||
            !isset($data['role']) ||
            !isset($data['is_active'])
        ) {
            jsonResponse(false, "Data tidak lengkap");
            return;
        }

        $result = $this->model->update_user($data);

        if ($result === true) {
            jsonResponse(true, "Berhasil update user");
        } else {
            jsonResponse(false, "Error: " . $result);
        }
    }

    public function hapus_user()
    {
        $data = $this->getInput();

        if (!$data || !isset($data['id'])) {
            jsonResponse(false, "ID tidak ditemukan");
            return;
        }

        $result = $this->model->hapus_user($data['id']);

        if ($result === true) {
            jsonResponse(true, "Berhasil hapus user");
        } else {
            jsonResponse(false, "Error: " . $result);
        }
    }

    /* ================= GURU ================= */

    public function tambah_guru()
    {
        $data = $this->getInput();

        $result = $this->model->tambah_guru($data);

        if ($result === true) {
            jsonResponse(true, "Berhasil tambah guru");
        } else {
            jsonResponse(false, $result);
        }
    }

    public function update_guru()
    {
        $data = $this->getInput();

        $result = $this->model->update_guru($data);

        if ($result === true) {
            jsonResponse(true, "Berhasil update guru");
        } else {
            jsonResponse(false, $result);
        }
    }

    public function hapus_guru()
    {
        $data = $this->getInput();

        $result = $this->model->hapus_guru($data['id']);

        if ($result === true) {
            jsonResponse(true, "Berhasil hapus guru");
        } else {
            jsonResponse(false, $result);
        }
    }

    /* ================= PERIODE ================= */

    public function set_periode()
    {
        $data = $this->getInput();

        $result = $this->model->set_periode($data['id']);

        if ($result === true) {
            jsonResponse(true, "Periode berhasil diaktifkan");
        } else {
            jsonResponse(false, $result);
        }
    }
}
