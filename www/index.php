<?php
	session_start();
	if (! empty($_GET["status"])) {
		$status = $_GET["status"];
	} else {
		$status = 0;
	}
	if (!empty($_POST)) {
		$_SESSION["idEmpleado"] = $_POST["idEmpleado"];
	}
	include "html/head.html";
?>
<body>
	<?php
		include "php/header.php";
	?>
	<div class="background-image ">
		<br />
		<h1>Administración de los paquetes/servicios de los automóviles</h1>
		<div class="container">
			<?php
				if (empty($_SESSION["idEmpleado"]) && empty($_SESSION["correo"])) {
					include "html/login.html";
				} else {
					echo "<a class=\"my-2 bi bi-plus-lg btn btn-primary f-right\" onclick=\"showAddRow()\" style=\"margin: 5px;\" /></a><br />";
					include "php/data.php";
				}
			?>
		</div>
		<?php
			if (empty($_SESSION["idEmpleado"]) && empty($_SESSION["correo"]) && $status == 1) {
				echo "<div class=\"message\"><a>Correo y/o contraseña incorrectos.<a/></div>";
			} else if ($status == 1) {
				echo "<div class=\"message\"><a>Error al actualizar/borrar el registro.<a/></div>";
			}
		?>
	</div>
	<script type="text/javascript" src="js/site.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>