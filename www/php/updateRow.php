<?php
	session_start();
	$status = 0;
	$jsonData = json_decode(file_get_contents('php://input'), true);
	if (!empty($jsonData)) {
		$_idInventario = $jsonData["_idInventario"];
		$_idServicioInventario = $jsonData["_idServicioInventario"];
		$_idVenta = $jsonData["_idVenta"];
		$_idDetalleVenta = $jsonData["_idDetalleVenta"];
		$_idPaquete = $jsonData["_idPaquete"];
		$_idPaqueteServicio = $jsonData["_idPaqueteServicio"];
		$_idServicio = $jsonData["_idServicio"];
		$_idTipoCarro = $jsonData["_idTipoCarro"];
		$_idAuto = $jsonData["_idAuto"];
		$_idCliente = $jsonData["_idCliente"];

		include "conectarBd.php";
		$sql = "CALL agregarInventario (".$_idInventario.", ".$_idServicioInventario.");";
		mysqli_query($conexion,$sql);
		unset($correo,$password);
		mysqli_close($conexion);

		include "conectarBd.php";
		$sql = "CALL agregarVentaPaqueteYServicio (".$_idVenta", ".$_idDetalleVenta.", ".$_idPaquete.", ".$_idPaqueteServicio.", ".$_idServicio.");";
		mysqli_query($conexion,$sql);
		unset($correo,$password);
		mysqli_close($conexion);


		include "conectarBd.php";
		$sql = "CALL agregarClienteYSuAuto (".$_idTipoCarro.", ".$_idAuto.", ".$_idCliente.");";
		mysqli_query($conexion,$sql);
		unset($correo,$password);
		mysqli_close($conexion);
	}
	header("Location: ../index.php?status=".$status);
	exit;
?>
