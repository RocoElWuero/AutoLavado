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
function showAddRow() {
	//
}
function updateRow(_idInventario,_idServicioInventario,_idVenta,_idDetalleVenta,_idPaquete,_idPaqueteServicio,_idServicio,_idTipoCarro,_idAuto,_idCliente) {
	var jsonData = { 
		"idInventario": _idInventario,
		"idServicioInventario": _idServicioInventario,
		"idVenta": _idVenta,
		"idDetalleVenta": _idDetalleVenta,
		"idPaquete": _idPaquete,
		"idPaqueteServicio": _idPaqueteServicio,
		"idServicio": _idServicio,
		"idTipoCarro": _idTipoCarro,
		"idAuto": _idAuto,
		"idCliente": _idCliente
	};
	console.log(jsonData);
	$.ajax({
		type: "POST",
		url: `${window.location.origin}/AutoLavado/www/php/updateRow.php`,
		data: JSON.stringify(jsonData),
		contentType: "application/json",
		success: function(response) {
			console.log(response);
		}
	});
}
/*function deleteRow(idInventario,idServicioInventario,idVenta,idDetalleVenta,idPaquete,idPaqueteServicio,idServicio,idTipoCarro,idAuto,idCliente) {
	//
}*/
