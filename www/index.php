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
					include "php/data.php";
				}
			?>
		</div>
		<?php
			if ($status == 1) {
				echo "<div class=\"message\"><a>Correo y/o contraseña incorrectos.<a/></div>";
			}
		?>
	</div>
	<script type="text/javascript" src="js/site.js" />
</body>
</html>