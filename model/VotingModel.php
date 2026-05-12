<?php

class VotingModel
{
    private $db;

    public function __construct($conn)
    {
        $this->db = $conn;
    }

    /* ================= LOGIN ================= */

    public function login($data)
    {
        try {

            $stmt = $this->db->prepare("
            CALL sp_login(:username, :password)
        ");

            $stmt->execute([
                ":username" => $data['username'],
                ":password" => $data['password']
            ]);

            $user = $stmt->fetch(PDO::FETCH_ASSOC);

            $stmt->closeCursor();

            return $user ?: false;
        } catch (PDOException $e) {

            return false;
        }
    }

    /* ================= VOTING ================= */

    public function voting($data)
    {
        try {

            $stmt = $this->db->prepare("CALL sp_voting(:user, :kandidat)");

            $stmt->execute([
                ":user" => $data['id_user'],
                ":kandidat" => $data['id_kandidat']
            ]);

            $stmt->closeCursor();

            return true;
        } catch (PDOException $e) {

            return $e->getMessage();
        }
    }

    /* ================= GET DATA ================= */

    public function get_siswa()
    {
        return $this->db->query("SELECT * FROM v_siswa")
            ->fetchAll(PDO::FETCH_ASSOC);
    }

    public function get_user()
    {
        return $this->db->query("SELECT * FROM v_user")->fetchAll(PDO::FETCH_ASSOC);
    }

    public function get_guru()
    {
        return $this->db->query("SELECT * FROM v_guru")
            ->fetchAll(PDO::FETCH_ASSOC);
    }

    public function get_kandidat()
    {
        return $this->db->query("SELECT * FROM v_kandidat")
            ->fetchAll(PDO::FETCH_ASSOC);
    }

    public function get_periode()
    {
        return $this->db->query("SELECT * FROM m_periode")
            ->fetchAll(PDO::FETCH_ASSOC);
    }

    public function get_progres_voting()
    {
        return $this->db->query("SELECT * FROM v_progres_voting")
            ->fetchAll(PDO::FETCH_ASSOC);
    }

    public function get_total_vote()
    {
        return $this->db->query("SELECT * FROM total_vote")
            ->fetchAll(PDO::FETCH_ASSOC);
    }

    /* ================= SISWA ================= */

    public function tambah_siswa($data)
    {
        try {

            $stmt = $this->db->prepare("
                CALL sp_tambah_siswa(:nipd,:nama,:jk)
            ");

            $stmt->execute([
                ":nipd" => $data['nipd'],
                ":nama" => $data['nama'],
                ":jk" => $data['jk']
            ]);

            $stmt->closeCursor();

            return true;
        } catch (PDOException $e) {

            return $e->getMessage();
        }
    }

    public function update_siswa($data)
    {
        try {

            $stmt = $this->db->prepare("
                CALL update_siswa(:id,:active)
            ");

            $stmt->execute([
                ":id" => $data['id'],
                ":active" => $data['is_active']
            ]);

            $stmt->closeCursor();

            return true;
        } catch (PDOException $e) {

            return $e->getMessage();
        }
    }

    public function hapus_siswa($id)
    {
        try {

            $stmt = $this->db->prepare("
                CALL sp_hapus_siswa(:id)
            ");

            $stmt->bindParam(":id", $id, PDO::PARAM_INT);

            $stmt->execute();

            $stmt->closeCursor();

            return true;
        } catch (PDOException $e) {

            return $e->getMessage();
        }
    }

    /* ================= CRUD USER ================= */

    public function tambah_user($data)
    {
        try {
            $stmt = $this->db->prepare("
                CALL sp_tambah_user(
                    :username,
                    :password,
                    :role,
                    :nip,
                    :nipd
                )
            ");

            $stmt->execute([
                ":username" => $data['username'],
                ":password" => $data['password'],
                ":role" => $data['role'],
                ":nip" => $data['nip'] ?? null,
                ":nipd" => $data['nipd'] ?? null
            ]);

            $stmt->closeCursor();

            return true;
        } catch (PDOException $e) {
            return $e->getMessage();
        }
    }

    public function update_user($data)
    {
        try {
            $stmt = $this->db->prepare("
                CALL update_user(
                    :id,
                    :username,
                    :password,
                    :role,
                    :active,
                    :nip,
                    :nipd
                )
            ");

            $stmt->execute([
                ":id" => $data['id'],
                ":username" => $data['username'],
                ":password" => $data['password'],
                ":role" => $data['role'],
                ":active" => $data['is_active'],
                ":nip" => $data['nip'] ?? null,
                ":nipd" => $data['nipd'] ?? null
            ]);

            $stmt->closeCursor();

            return true;
        } catch (PDOException $e) {
            return $e->getMessage();
        }
    }

    public function hapus_user($id)
    {
        try {
            $stmt = $this->db->prepare("CALL sp_hapus_user(:id)");

            $stmt->bindParam(":id", $id, PDO::PARAM_INT);

            $stmt->execute();
            $stmt->closeCursor();

            return true;
        } catch (PDOException $e) {
            return $e->getMessage();
        }
    }

    /* ================= KANDIDAT ================= */

    public function tambah_kandidat($data)
{
    try {
        $periode = $this->db->query("
            SELECT id_periode 
            FROM m_periode 
            WHERE is_active='Y'
            LIMIT 1
        ")->fetch(PDO::FETCH_ASSOC);

        $stmt = $this->db->prepare("
            CALL sp_tambah_kandidat(
                :ketua,
                :wakil,
                :periode,
                :jenis,
                :visi,
                :misi
            )
        ");

        $stmt->execute([
            ":ketua" => $data['ketua'],
            ":wakil" => $data['wakil'],
            ":periode" => $periode['id_periode'],
            ":jenis" => $data['jenis'],
            ":visi" => $data['visi'],
            ":misi" => $data['misi']
        ]);

        $stmt->closeCursor();
        return true;

    } catch(PDOException $e){
        return $e->getMessage();
    }
}

    public function update_kandidat($data)
    {
        try {
            $stmt = $this->db->prepare("
            CALL sp_update_kandidat(:id,:ketua,:wakil,:jenis)
        ");

            $stmt->execute([
                ":id" => $data['id'],
                ":ketua" => $data['ketua'],
                ":wakil" => $data['wakil'],
                ":jenis" => $data['jenis']
            ]);

            $stmt->closeCursor();
            return true;
        } catch (PDOException $e) {
            return $e->getMessage();
        }
    }

    public function hapus_kandidat($id)
    {
        try {
            $stmt = $this->db->prepare("CALL sp_hapus_kandidat(:id)");
            $stmt->bindParam(":id", $id, PDO::PARAM_INT);
            $stmt->execute();
            $stmt->closeCursor();
            return true;
        } catch (PDOException $e) {
            return $e->getMessage();
        }
    }

    public function tambah_periode($data)
    {
        try {
            $stmt = $this->db->prepare("
            INSERT INTO m_periode(nama_periode,is_active)
            VALUES(:nama,'N')
        ");

            $stmt->execute([
                ":nama" => $data['nama']
            ]);

            return true;
        } catch (PDOException $e) {
            return $e->getMessage();
        }
    }

    public function update_periode($data)
    {
        try {
            $stmt = $this->db->prepare("
            UPDATE m_periode
            SET nama_periode = :nama
            WHERE id_periode = :id
        ");

            $stmt->execute([
                ":id" => $data['id'],
                ":nama" => $data['nama']
            ]);

            return true;
        } catch (PDOException $e) {
            return $e->getMessage();
        }
    }

    public function hapus_periode($id)
    {
        try {
            $stmt = $this->db->prepare("
            DELETE FROM m_periode
            WHERE id_periode = :id
        ");

            $stmt->execute([
                ":id" => $id
            ]);

            return true;
        } catch (PDOException $e) {
            return $e->getMessage();
        }
    }

    /* ================= GURU ================= */

    public function tambah_guru($data)
    {
        try {

            $stmt = $this->db->prepare("
                CALL sp_tambah_guru(:nip,:nama,:jk)
            ");

            $stmt->execute([
                ":nip" => $data['nip'],
                ":nama" => $data['nama'],
                ":jk" => $data['jk']
            ]);

            $stmt->closeCursor();

            return true;
        } catch (PDOException $e) {

            return $e->getMessage();
        }
    }

    public function update_guru($data)
    {
        try {

            $stmt = $this->db->prepare("
                CALL update_guru(:nama,:nip,:jk,:id)
            ");

            $stmt->execute([
                ":nama" => $data['nama'],
                ":nip" => $data['nip'],
                ":jk" => $data['jk'],
                ":id" => $data['id']
            ]);

            $stmt->closeCursor();

            return true;
        } catch (PDOException $e) {

            return $e->getMessage();
        }
    }

    public function hapus_guru($id)
    {
        try {

            $stmt = $this->db->prepare("
                CALL sp_hapus_guru(:id)
            ");

            $stmt->bindParam(":id", $id, PDO::PARAM_INT);

            $stmt->execute();

            $stmt->closeCursor();

            return true;
        } catch (PDOException $e) {

            return $e->getMessage();
        }
    }

    /* ================= PERIODE ================= */

    public function set_periode($id)
    {
        try {

            $stmt = $this->db->prepare("
                UPDATE m_periode
                SET is_active = 'N'
            ");

            $stmt->execute();

            $stmt = $this->db->prepare("
                UPDATE m_periode
                SET is_active = 'Y'
                WHERE id_periode = :id
            ");

            $stmt->execute([
                ":id" => $id
            ]);

            return true;
        } catch (PDOException $e) {

            return $e->getMessage();
        }
    }
}
