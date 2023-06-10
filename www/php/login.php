<?php
	session_start();
	$status = 0;
	if (!empty($_POST)) {
		$correo = $_POST["email"];
		$password = $_POST["password"];

		include "conectarBd.php";

		$sql = "SELECT idEmpleado,correo,password FROM empleado WHERE correo = '".$correo."' AND password = '".$password."';";
		$result = mysqli_query($conexion,$sql);
		if (mysqli_num_rows($result) > 0) {
			while($row = mysqli_fetch_assoc($result)) {
				$_SESSION["idEmpleado"] = $row["idEmpleado"];
				$_SESSION["correo"] = $row["correo"];
			}
		} else {
			include "php/logout.php";
			$status = 1;
		}
		unset($correo,$password);
		mysqli_close($conexion);
	}
	header("Location: ../index.php?status=".$status);
	exit;
?>
