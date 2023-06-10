<?php
	$dbhost = "localhost";
	$dbuser = "root";
	$dbpass = ""; //usbw
	$dbname = 'autolavado';
	$conexion = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname);
	if(! $conexion) {
		include "php/logout.php";
		die('No es posible conectarse: ' . mysqli_error());
	}
?>