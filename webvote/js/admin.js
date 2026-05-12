const API = "http://localhost/BASDAT_VOTING/index.php?action=";
const user = JSON.parse(localStorage.getItem("user"));

if (!user || user.role.toLowerCase() !== "admin") {
    window.location.href = "login.html";
}

// ================= GLOBAL =================
let editId = null;
let editGuruId = null;
let editKandidatId = null;

const successSound = new Audio("assets/sound/faah.mp3");

function playSuccessSound() {
    successSound.play().catch(err => console.log(err));
}

function showSuccess(message, callback = null) {
    Swal.fire({
        title: "Berhasil!",
        text: message,
        imageUrl: "assets/gif/yatta.gif",
        imageWidth: 200
    }).then(() => {
        playSuccessSound();
        if (callback) callback();
    });
}

function showConfirm(text, callback) {
    Swal.fire({
        title: "Yakin?",
        text: text,
        showCancelButton: true,
        confirmButtonText: "Ya"
    }).then(result => {
        if (result.isConfirmed) callback();
    });
}

// ================= NAVIGATION =================
function showPage(id, el = null) {
    document.querySelectorAll(".page").forEach(p => p.classList.add("hidden"));
    document.getElementById(id).classList.remove("hidden");

    const titles = {
        dashboard: "Dashboard",
        siswa: "Siswa",
        guru: "Guru",
        kandidat: "Kandidat",
        periode: "Periode"
    };

    document.getElementById("titlePage").innerText = titles[id];

    document.querySelectorAll(".sidebar a").forEach(a => {
        a.classList.remove("active");
    });

    if (el) el.classList.add("active");

    switch (id) {
        case "dashboard":
            loadDashboard();
            break;
        case "siswa":
            loadSiswa();
            break;
        case "guru":
            loadGuru();
            break;
        case "kandidat":
            loadKandidat();
            loadSiswaDropdown();
            loadPeriodeDropdown();
            break;
        case "periode":
            loadPeriode();
            break;
    }
}

// ================= DASHBOARD =================
function loadDashboard() {
    fetch(API + "siswa")
        .then(r => r.json())
        .then(d => {
            totalSiswa.innerText = d.data.length;
        });

    fetch(API + "guru")
        .then(r => r.json())
        .then(d => {
            totalGuru.innerText = d.data.length;
        });

    fetch(API + "kandidat")
        .then(r => r.json())
        .then(d => {
            totalKandidat.innerText = d.data.length;
        });

    fetch(API + "periode")
        .then(r => r.json())
        .then(d => {
            const aktif = d.data.find(p => p.is_active === "Y");
            periodeAktif.innerText = aktif ? aktif.nama_periode : "-";
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
                        <td>${p.persen || 0}%</td>
                    </tr>
                `;
            });

            tblProgres.innerHTML = html;
        });
}

// ================= SISWA =================
function showFormSiswa() {
    formSiswa.classList.toggle("hidden");
}

function resetFormSiswa() {
    editId = null;
    f_nipd.value = "";
    f_nama.value = "";
    f_jk.value = "L";
    f_status.value = "Y";
    formSiswa.classList.add("hidden");
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
                            <button onclick="editSiswa('${s.id_siswa}','${s.nipd}','${s.nama_siswa}','${s.jenis_kelamin}','${s.is_active}')">Edit</button>
                            <button onclick="deleteSiswa('${s.id_siswa}')">Hapus</button>
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

    const url = editId ? "update_siswa" : "tambah_siswa";

    fetch(API + url, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(data)
    })
        .then(r => r.json())
        .then(res => {
            showSuccess(res.message, () => {
                resetFormSiswa();
                loadSiswa();
            });
        });
}

function deleteSiswa(id) {
    showConfirm("Data siswa akan dihapus", () => {
        fetch(API + "hapus_siswa", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ id })
        })
            .then(r => r.json())
            .then(res => {
                showSuccess(res.message, loadSiswa);
            });
    });
}

// ================= GURU =================
function showFormGuru() {
    formGuru.classList.toggle("hidden");
}

function resetFormGuru() {
    editGuruId = null;
    g_nip.value = "";
    g_nama.value = "";
    g_jk.value = "L";
    formGuru.classList.add("hidden");
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
                            <button onclick="editGuru('${g.id_guru}','${g.nip}','${g.nama_guru}','${g.jenis_kelamin}')">Edit</button>
                            <button onclick="deleteGuru('${g.id_guru}')">Hapus</button>
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

    const url = editGuruId ? "update_guru" : "tambah_guru";

    fetch(API + url, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(data)
    })
        .then(r => r.json())
        .then(res => {
            showSuccess(res.message, () => {
                resetFormGuru();
                loadGuru();
            });
        });
}

function deleteGuru(id) {
    showConfirm("Data guru akan dihapus", () => {
        fetch(API + "hapus_guru", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ id })
        })
            .then(r => r.json())
            .then(res => {
                showSuccess(res.message, loadGuru);
            });
    });
}

// ================= KANDIDAT =================
// ================= KANDIDAT =================
function showFormKandidat() {
    formKandidat.classList.toggle("hidden");
}

function resetFormKandidat() {
    editKandidatId = null;

    k_ketua.value = "";
    k_wakil.value = "";
    k_periode.value = "";
    k_jenis.value = "osis";

    formKandidat.classList.add("hidden");
}

// dropdown siswa
function loadSiswaDropdown() {
    fetch(API + "siswa")
        .then(r => r.json())
        .then(d => {
            let html = `<option value="">Pilih Siswa</option>`;

            d.data
                .filter(s => s.is_active === "Y")
                .forEach(s => {
                    html += `
                        <option value="${s.id_siswa}">
                            ${s.nama_siswa}
                        </option>
                    `;
                });

            k_ketua.innerHTML = html;
            k_wakil.innerHTML = html;
        });
}

// dropdown periode
function loadPeriodeDropdown() {
    fetch(API + "periode")
        .then(r => r.json())
        .then(d => {
            let html = `<option value="">Pilih Periode</option>`;

            d.data.forEach(p => {
                html += `
                    <option value="${p.id_periode}">
                        ${p.nama_periode}
                    </option>
                `;
            });

            k_periode.innerHTML = html;
        });
}

// load tabel kandidat
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
                        <td>${k.nama_periode}</td>
                        <td>${k.jenis.toUpperCase()}</td>
                    </tr>
                `;
            });

            tblKandidat.innerHTML = html;
        });
}

// ================= PERIODE =================
function showFormPeriode() {
    formPeriode.classList.toggle("hidden");
}

function resetFormPeriode() {
    p_nama.value = "";
    formPeriode.classList.add("hidden");
}

function loadPeriode() {
    fetch(API + "periode")
        .then(r => r.json())
        .then(d => {
            let html = "";

            d.data.forEach((p, i) => {
                html += `
                    <tr>
                        <td>${i + 1}</td>
                        <td>${p.nama_periode}</td>
                        <td>${p.is_active === "Y" ? "Aktif" : "Nonaktif"}</td>
                        <td>
                            <button onclick="setAktif('${p.id_periode}')">
                                Aktifkan
                            </button>
                            <button onclick="deletePeriode('${p.id_periode}')">
                                Hapus
                            </button>
                        </td>
                    </tr>
                `;
            });

            tblPeriode.innerHTML = html;
        });
}

function savePeriode() {
    const data = {
        nama: p_nama.value
    };

    fetch(API + "tambah_periode", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(data)
    })
        .then(r => r.json())
        .then(res => {
            showSuccess(res.message, () => {
                resetFormPeriode();
                loadPeriode();
                loadDashboard();
            });
        });
}

function deletePeriode(id) {
    showConfirm("Data periode akan dihapus", () => {
        fetch(API + "hapus_periode", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ id })
        })
            .then(r => r.json())
            .then(res => {
                showSuccess(res.message, () => {
                    loadPeriode();
                    loadDashboard();
                });
            });
    });
}

function setAktif(id) {
    fetch(API + "set_periode", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id })
    })
        .then(r => r.json())
        .then(res => {
            showSuccess(res.message, () => {
                loadPeriode();
                loadDashboard();
            });
        });
}

// ================= LOGOUT =================
function logout() {
    localStorage.removeItem("user");
    window.location.href = "login.html";
}

// ================= INIT =================
loadDashboard();    