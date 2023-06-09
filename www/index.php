<?php
	session_start();
	if (!empty($_POST)) {
		$_SESSION['correo'] = $_POST['correo'];
		//$correo = $_POST['correo'];
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
				if (empty($_SESSION['correo'])) {
					?>
						<form action="php/signup.php"> <!-- ESTE PIENSO CAMBIARLO POR login.php, ya que realmente queda mas para ese -->
							<input type="text" name="email" id="email" placeholder="direction@domain.com" style="margin: 5px;" />
							<br />
							<input type="password" name="password" id="password" placeholder="Pa55w0rd+" />
						</form>
					<?php
				}
			?>
		</div>
	</div>
</body>
</html>