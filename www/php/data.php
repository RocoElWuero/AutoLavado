<?php
	$status = 0;
	if (!empty($_SESSION["idEmpleado"])) {

		include "conectarBd.php";

		$sql = "CALL mostrarRegistrosPorEmpleado(".$_SESSION["idEmpleado"].");";
		$result = mysqli_query($conexion,$sql);
		?>
			<table>
				<thead>
					<tr>
						<th>Empleado</th>
						<th>Servicio</th>
						<th>Precio del servicio</th>
						<th>Producto utilizado para el servicio</th>
						<th>Fecha de la venta</th>
						<th>Paquete</th>
						<th>Precio del paquete</th>
						<th>Cliente</th>
						<th>Correo del cliente</th>
						<th>Telefono del cliente</th>
						<th>Placas del carro</th>
						<th>Modelo del carro</th>
						<th>Editar</th>
						<th>Borrar</th>
					</tr>
				</thead>
				<tbody>
					<?php
						if (mysqli_num_rows($result) > 0) {
							while($row = mysqli_fetch_assoc($result)) {
								echo "<tr><th>".$row["empleado"]."</th>";
								echo "<th>".$row["servicio"]."</th>";
								echo "<th>".$row["precioDelServicio"]."</th>";
								echo "<th>".$row["productoUtilizadoParaElServicio"]."</th>";
								echo "<th>".$row["fechaDeLaVenta"]."</th>";
								echo "<th>".$row["paquete"]."</th>";
								echo "<th>".$row["precioDelPaquete"]."</th>";
								echo "<th>".$row["cliente"]."</th>";
								echo "<th>".$row["correoDelCliente"]."</th>";
								echo "<th>".$row["telefonoDelCliente"]."</th>";
								echo "<th>".$row["placasDelCarro"]."</th>";
								echo "<th>".$row["modeloDelCarro"]."</th>";
								echo "<th><a class=\"bi bi-file-earmark-plus-fill btn btn-primary mx-2\" onclick=\"updateRow('".$_SESSION["idEmpleado"]."')\"></a></th>";
								echo "<th><a class=\"bi bi-trash btn btn-danger\" onclick=\"deleteRow('".$_SESSION["idEmpleado"]."')\" /></a></tr>";
							}
						} else {
								echo "<tr><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th></tr>";
						}
					?>
				</tbody>
			</table>
		<?php
		unset($correo,$password);
		mysqli_close($conexion);
	}
?>
