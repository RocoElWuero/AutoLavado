<?php
	session_start();
	session_unset();
	try {
		session_destroy();
	} catch (Exception $e) {
		echo $e;
	}
	header("Location: ../index.php");
	exit;
?>