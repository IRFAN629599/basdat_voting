const BASE_URL = "http://localhost/BASDAT_VOTING/index.php";

document.getElementById("registerForm").addEventListener("submit", async function (e) {
    e.preventDefault();

    const nipd = document.getElementById("nipd").value.trim();
    const password = document.getElementById("password").value.trim();
    const role = document.getElementById("role").value;

    const msg = document.getElementById("msg");

    msg.style.color = "red";
    msg.innerText = "";

    if (!nipd || !password || !role) {
        msg.innerText = "Semua field wajib diisi!";
        return;
    }

    let payload = {
        username: nipd,
        password: password,
        role: role,
        nip: null,
        nipd: null
    };

    // kalau siswa
    if (role === "siswa") {
        payload.nipd = nipd;
    }

    // kalau guru
    if (role === "guru") {
        payload.nip = nipd;
    }

    try {

        const res = await fetch(`${BASE_URL}?action=tambah_user`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(payload)
        });

        const data = await res.json();

        if (data.status) {

            msg.style.color = "lime";
            msg.innerText = "Register berhasil!";

            setTimeout(() => {
                window.location.href = "login.html";
            }, 1500);

        } else {
            msg.innerText = data.message || "Register gagal!";
        }

    } catch (err) {
        console.log(err);
        msg.innerText = "Server error!";
    }
});