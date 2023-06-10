<?php
	session_start();
	$status = 0;
	$jsonData = json_decode(file_get_contents('php://input'), true);
	if (!empty($jsonData)) {
		$modeloDelCarro = $jsonData["modeloDelCarro"];
		$placasDelCarro = $jsonData["placasDelCarro"];
		$nombreCliente = $jsonData["nombreCliente"];
		$paterno = $jsonData["paterno"];
		$materno = $jsonData["materno"];
		$telefono = $jsonData["telefono"];
		$correo = $jsonData["correo"];
		$fecha = $jsonData["fecha"];
		$nombrePaquete = $jsonData["nombrePaquete"];
		$nombreServicio = $jsonData["nombreServicio"];
		$precioPaquete = $jsonData["precioPaquete"];
		$precioServicio = $jsonData["precioServicio"];
		$nombreInventario = $jsonData["nombreInventario"];
		$cantidad = $jsonData["cantidad"];

		include "conectarBd.php";
		$sql = "CALL agregarClienteYSuAuto ('".$modeloDelCarro."', '".$placasDelCarro."', '".$nombreCliente."', '".$paterno."', '".$materno."', '".$telefono."', '".$correo."');";
		mysqli_query($conexion,$sql);
		mysqli_close($conexion);

		include "conectarBd.php";
		$sql = "CALL agregarVentaPaqueteYServicio ('".$fecha."', '".$nombrePaquete."', '".$nombreServicio."', ".$precioPaquete.", ".$precioServicio.");";
		mysqli_query($conexion,$sql);
		mysqli_close($conexion);

		include "conectarBd.php";
		$sql = "CALL agregarInventario ('".$nombreInventario."', ".$cantidad.");";
		mysqli_query($conexion,$sql);
		mysqli_close($conexion);
	}
	header("Location: ../index.php?status=".$status);
	exit;
?>
