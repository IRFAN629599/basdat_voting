window.onload = function() {
  document.getElementById("popup").style.display = "flex";
}

function closePopup() {
  document.getElementById("popup").style.display = "none";
}

const BASE_URL = "http://localhost/BASDAT_VOTING/index.php";

document.getElementById("loginForm").addEventListener("submit", async function(e) {
    e.preventDefault();

    const username = document.getElementById("username").value.trim();
    const password = document.getElementById("password").value.trim();

    try {
        const res = await fetch(`${BASE_URL}?action=login`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ username, password })
        });

        const data = await res.json();

        if (data.status && data.data) {
            localStorage.setItem("user", JSON.stringify(data.data));
            const role = (data.data.role || "").toLowerCase();

            if (role === "admin") {
                window.location.href = "index_admin.html";
            } else {
                window.location.href = "pilih.html";
            }
        } else {
            document.getElementById("msg").innerText = data.message || "Login gagal!";
        }

    } catch (err) {
        document.getElementById("msg").innerText = "Server error!";
    }
});