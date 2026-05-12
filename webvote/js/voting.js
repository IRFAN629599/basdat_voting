const BASE_URL = "http://localhost/Basdat/kelompok_api/index.php";
const user = JSON.parse(localStorage.getItem("user"));

if (!user) {
    window.location.href = "login.html";
}

async function loadKandidat(jenis) {
    const res = await fetch(`${BASE_URL}?action=kandidat`);
    const result = await res.json();

    const data = result.data;

    const container = document.getElementById("kandidat");
    const modalContainer = document.getElementById("modal-container");

    container.innerHTML = "";
    modalContainer.innerHTML = "";

    const filtered = data.filter(k => {
        if (!k.jenis) return false;
        return k.jenis.toLowerCase().includes(jenis.toLowerCase());
    });

    if (filtered.length === 0) {
        container.innerHTML = "<p>Tidak ada kandidat</p>";
        return;
    }

    filtered.forEach((k, index) => {
        const card = document.createElement("div");
        card.className = "card";

        card.innerHTML = `
            <div class="foto">
                <div class="person">
                    <img src="assets/img/iconperson-removebg-preview.png">
                    <span>Ketua</span>
                </div>
                <div class="person">
                    <img src="assets/img/iconperson-removebg-preview.png">
                    <span>Wakil</span>
                </div>
            </div>

            <h3>${k.ketua} & ${k.wakil}</h3>
            <p>Kandidat ke-${index + 1}</p>
        `;

        const visiBtn = document.createElement("a");
        visiBtn.href = `#modal${k.id_kandidat}`;
        visiBtn.className = "btn visi-btn";
        visiBtn.innerText = "Lihat visi & misi";

        const voteBtn = document.createElement("button");
        voteBtn.className = "btn pilih";
        voteBtn.innerText = "Pilih";
        voteBtn.onclick = () => vote(k.id_kandidat);

        card.appendChild(visiBtn);
        card.appendChild(voteBtn);

        container.appendChild(card);

        const modal = document.createElement("div");
        modal.id = `modal${k.id_kandidat}`;
        modal.className = "modal";

        modal.innerHTML = `
            <div class="modal-content">
                <h3>${k.ketua} & ${k.wakil}</h3>
                <p><b>Visi:</b> ${k.visi}</p>
                <p><b>Misi:</b> ${k.misi}</p>
                <a href="#" class="btn">Tutup</a>
            </div>
        `;

        modalContainer.appendChild(modal);
    });
}

async function vote(id_kandidat) {
    const confirmResult = await Swal.fire({
        title: "Yakin pilih kandidat ini?",
        text: "Tidak bisa diubah!",
        imageUrl: "assets/gif/lemiting.gif",
        imageWidth: 200,
        imageHeight: 200,
        showCancelButton: true,
        confirmButtonText: "Ya, pilih",
        cancelButtonText: "Batal"
    });

    if (!confirmResult.isConfirmed) {
        return;
    }

    try {
        const res = await fetch(`${BASE_URL}?action=voting`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                id_user: user.id_users,
                id_kandidat: id_kandidat
            })
        });

        const data = await res.json();
        console.log(data);

        if (
            data.status === true ||
            data.status === "true" ||
            data.status === "success"
        ) {
            await Swal.fire({
                title: "Berhasil!",
                text: data.message,
                imageUrl: "assets/gif/done.gif",
                imageWidth: 200,
                imageHeight: 200,
                confirmButtonText: "OK"
            });
        }
        else if (
            data.message &&
            data.message.includes("Sudah voting di kategori ini")
        ) {
            await Swal.fire({
                title: "Info",
                text: "Lu kan udah voting boss, ngapain voting lagi",
                imageUrl: "assets/gif/pukul.gif",
                imageWidth: 200,
                imageHeight: 200,
                confirmButtonText: "OK"
            });
        }
        else {
            await Swal.fire({
                title: "Error",
                text: "server nya lagi error bosskuh, mantap bujang",
                imageUrl: "assets/gif/error.gif",
                imageWidth: 200,
                imageHeight: 200,
                confirmButtonText: "OK"
            });
        }

        window.location.href = "pilih.html";

    } catch (error) {
        console.error(error);

        await Swal.fire({
            title: "Error",
            text: "server nya lagi error bosskuh, mantap bujang",
            imageUrl: "assets/gif/error.gif",
            imageWidth: 200,
            imageHeight: 200,
            confirmButtonText: "OK"
        });

        window.location.href = "pilih.html";
    }
}  