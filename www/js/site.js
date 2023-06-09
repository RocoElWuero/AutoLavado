function showThePassword() {
	var x = document.getElementById("password");
	var y = document.getElementById("showThePassword");
	if (x.type === "password") {
		x.type = "text";
		y.className = "bi bi-eye";
	} else {
		x.type = "password";
		y.className = "bi bi-eye-fill";
	}
}
