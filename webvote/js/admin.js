const API = "http://localhost/Basdat/kelompok_api/index.php?action=";

const user = JSON.parse(localStorage.getItem("user"));

if (!user || user.role.toLowerCase() !== "admin") {
    window.location.href = "login.html";
}

let editId = null;
let editGuruId = null;

const successSound = new Audio("assets/sound/faah.mp3");

function playSuccessSound() {
    successSound.play().catch(e => console.log(e));
}

/* ================= PAGE ================= */

function showPage(id, el) {

    document.querySelectorAll(".page")
        .forEach(p => p.classList.add("hidden"));

    document.getElementById(id)
        .classList.remove("hidden");

    document.getElementById("titlePage")
        .innerText = id;

    document.querySelectorAll(".sidebar a")
        .forEach(a => a.classList.remove("active"));

    if (el) el.classList.add("active");

    if (id === "dashboard") loadDashboard();
    if (id === "siswa") loadSiswa();
    if (id === "guru") loadGuru();
    if (id === "kandidat") loadKandidat();
    if (id === "periode") loadPeriode();
}

/* ================= DASHBOARD ================= */

function loadDashboard() {

    fetch(API + "siswa")
        .then(r => r.json())
        .then(d => {
            document.getElementById("totalSiswa").innerText = d.data.length;
        });

    fetch(API + "guru")
        .then(r => r.json())
        .then(d => {
            document.getElementById("totalGuru").innerText = d.data.length;
        });

    fetch(API + "kandidat")
        .then(r => r.json())
        .then(d => {
            document.getElementById("totalKandidat").innerText = d.data.length;
        });

    fetch(API + "periode")
        .then(r => r.json())
        .then(d => {

            let aktif = d.data.find(p => p.is_active === "Y");

            document.getElementById("periodeAktif").innerText =
                aktif ? aktif.nama_periode : "-";
        });

    fetch(API + "progres_voting")
        .then(r => r.json())
        .then(d => {

            let html = "";

            d.data.forEach((p, i) => {

                html += `
                    <tr>
                        <td>${i + 1}</td>
                        <td>${p.ketua}</td>
                        <td>${p.jenis}</td>
                        <td>${p.total_vote}</td>
                        <td>${p.persen ?? 0}%</td>
                    </tr>
                `;
            });

            document.getElementById("tblProgres").innerHTML = html;
        });
}

/* ================= SISWA ================= */

function showFormSiswa() {
    document.getElementById("formSiswa")
        .classList.toggle("hidden");
}

function resetForm() {

    editId = null;

    f_nipd.value = "";
    f_nama.value = "";
    f_jk.value = "L";
    f_status.value = "Y";

    document.getElementById("formSiswa")
        .classList.add("hidden");
}

function loadSiswa() {

    fetch(API + "siswa")
        .then(r => r.json())
        .then(d => {

            let html = "";

            d.data.forEach((s, i) => {

                html += `
                    <tr>
                        <td>${i + 1}</td>
                        <td>${s.nipd}</td>
                        <td>${s.nama_siswa}</td>
                        <td>${s.jenis_kelamin}</td>
                        <td>${s.is_active}</td>
                        <td>

                            <button onclick="editSiswa(
                                '${s.id_siswa}',
                                '${s.nipd}',
                                '${s.nama_siswa}',
                                '${s.jenis_kelamin}',
                                '${s.is_active}'
                            )">
                                Edit
                            </button>

                            <button onclick="deleteSiswa('${s.id_siswa}')">
                                Hapus
                            </button>

                        </td>
                    </tr>
                `;
            });

            tblSiswa.innerHTML = html;
        });
}

function editSiswa(id, nipd, nama, jk, status) {

    editId = id;

    showFormSiswa();

    f_nipd.value = nipd;
    f_nama.value = nama;
    f_jk.value = jk;
    f_status.value = status;
}

function saveSiswa() {

    const data = {
        id: editId,
        nipd: f_nipd.value,
        nama: f_nama.value,
        jk: f_jk.value,
        is_active: f_status.value
    };

    const url = editId
        ? "update_siswa"
        : "tambah_siswa";

    fetch(API + url, {

        method: "POST",

        headers: {
            "Content-Type": "application/json"
        },

        body: JSON.stringify(data)

    })
        .then(r => r.json())
        .then(res => {

            Swal.fire({
                title: "Berhasil!",
                text: res.message,
                imageUrl: "assets/gif/yatta.gif",
                imageWidth: 200
            }).then(() => playSuccessSound());

            resetForm();

            loadSiswa();
        });
}

function deleteSiswa(id) {

    Swal.fire({
        title: "Yakin?",
        text: "Data akan dihapus",
        showCancelButton: true,
        confirmButtonText: "Ya"
    })
        .then(result => {

            if (result.isConfirmed) {

                fetch(API + "hapus_siswa", {

                    method: "POST",

                    headers: {
                        "Content-Type": "application/json"
                    },

                    body: JSON.stringify({ id })

                })
                    .then(r => r.json())
                    .then(res => {

                        Swal.fire({
                            title: "Berhasil!",
                            text: res.message,
                            imageUrl: "assets/gif/yatta.gif",
                            imageWidth: 200
                        }).then(() => playSuccessSound());

                        loadSiswa();
                    });
            }
        });
}

/* ================= GURU ================= */

function showFormGuru() {
    document.getElementById("formGuru")
        .classList.toggle("hidden");
}

function resetFormGuru() {

    editGuruId = null;

    g_nip.value = "";
    g_nama.value = "";
    g_jk.value = "L";

    document.getElementById("formGuru")
        .classList.add("hidden");
}

function loadGuru() {

    fetch(API + "guru")
        .then(r => r.json())
        .then(d => {

            let html = "";

            d.data.forEach((g, i) => {

                html += `
                    <tr>
                        <td>${i + 1}</td>
                        <td>${g.nip}</td>
                        <td>${g.nama_guru}</td>
                        <td>${g.jenis_kelamin}</td>
                        <td>

                            <button onclick="editGuru(
                                '${g.id_guru}',
                                '${g.nip}',
                                '${g.nama_guru}',
                                '${g.jenis_kelamin}'
                            )">
                                Edit
                            </button>

                            <button onclick="deleteGuru('${g.id_guru}')">
                                Hapus
                            </button>

                        </td>
                    </tr>
                `;
            });

            tblGuru.innerHTML = html;
        });
}

function editGuru(id, nip, nama, jk) {

    editGuruId = id;

    showFormGuru();

    g_nip.value = nip;
    g_nama.value = nama;
    g_jk.value = jk;
}

function saveGuru() {

    const data = {
        id: editGuruId,
        nip: g_nip.value,
        nama: g_nama.value,
        jk: g_jk.value
    };

    const url = editGuruId
        ? "update_guru"
        : "tambah_guru";

    fetch(API + url, {

        method: "POST",

        headers: {
            "Content-Type": "application/json"
        },

        body: JSON.stringify(data)

    })
        .then(r => r.json())
        .then(res => {

            Swal.fire({
                title: "Berhasil!",
                text: res.message,
                imageUrl: "assets/gif/yatta.gif",
                imageWidth: 200
            }).then(() => playSuccessSound());

            resetFormGuru();

            loadGuru();
        });
}

function deleteGuru(id) {

    Swal.fire({
        title: "Yakin?",
        text: "Data guru akan dihapus",
        showCancelButton: true,
        confirmButtonText: "Ya"
    })
        .then(result => {

            if (result.isConfirmed) {

                fetch(API + "hapus_guru", {

                    method: "POST",

                    headers: {
                        "Content-Type": "application/json"
                    },

                    body: JSON.stringify({ id })

                })
                    .then(r => r.json())
                    .then(res => {

                        Swal.fire({
                            title: "Berhasil!",
                            text: res.message,
                            imageUrl: "assets/gif/yatta.gif",
                            imageWidth: 200
                        }).then(() => playSuccessSound());

                        loadGuru();
                    });
            }
        });
}

/* ================= KANDIDAT ================= */

function loadKandidat() {

    fetch(API + "kandidat")
        .then(r => r.json())
        .then(d => {

            let html = "";

            d.data.forEach((k, i) => {

                html += `
                    <tr>
                        <td>${i + 1}</td>
                        <td>${k.ketua}</td>
                        <td>${k.wakil}</td>
                        <td>${k.jenis}</td>
                    </tr>
                `;
            });

            tblKandidat.innerHTML = html;
        });
}

/* ================= PERIODE ================= */

function loadPeriode() {

    fetch(API + "periode")
        .then(r => r.json())
        .then(d => {

            let html = "";

            d.data.forEach((p, i) => {

                let status = p.is_active === "Y"
                    ? "Aktif"
                    : "Nonaktif";

                html += `
                    <tr>
                        <td>${i + 1}</td>
                        <td>${p.nama_periode}</td>
                        <td>${status}</td>
                        <td>

                            <button onclick="setAktif(${p.id_periode})">
                                Aktifkan
                            </button>

                        </td>
                    </tr>
                `;
            });

            tblPeriode.innerHTML = html;
        });
}

function setAktif(id) {

    fetch(API + "set_periode", {

        method: "POST",

        headers: {
            "Content-Type": "application/json"
        },

        body: JSON.stringify({ id })

    })
        .then(r => r.json())
        .then(res => {

            Swal.fire({
                title: "Berhasil!",
                text: res.message,
                imageUrl: "assets/gif/yatta.gif",
                imageWidth: 200
            }).then(() => playSuccessSound());

            loadPeriode();

            loadDashboard();
        });
}

/* ================= LOGOUT ================= */

function logout() {

    localStorage.removeItem("user");

    window.location.href = "login.html";
}

/* ================= INIT ================= */

loadDashboard();