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
	var texto = ["Modelo del carro","Placas del carro","Nombre del Cliente","Paterno del Cliente","Materno del Cliente","Telefono del cliente","Correo del cliente","Fecha de la venta","Nombre del Paquete","Nombre del Servicio","Precio del paquete","Precio del servicio","Producto utilizado para el servicio","Cantidad del Producto utilizado para el servicio"];
	let jsonData = {};
	for (let i = 0; i < 14; i++) {
		let input = "";
		while (input === "" || input === null) {
			input = prompt(`Ingresa el ${texto[i]}:`);
		}
		if (i==0) {
			jsonData["modeloDelCarro"] = input;
		} else if (i==1) {
			jsonData["placasDelCarro"] = input;
		} else if (i==2) {
			jsonData["nombreCliente"] = input;
		} else if (i==3) {
			jsonData["paterno"] = input;
		} else if (i==4) {
			jsonData["materno"] = input;
		} else if (i==5) {
			jsonData["telefono"] = input;
		} else if (i==6) {
			jsonData["correo"] = input;
		} else if (i==7) {
			jsonData["fecha"] = input;
		} else if (i==8) {
			jsonData["nombrePaquete"] = input;
		} else if (i==9) {
			jsonData["nombreServicio"] = input;
		} else if (i==10) {
			jsonData["precioPaquete"] = parseInt(input);
		} else if (i==11) {
			jsonData["precioServicio"] = parseInt(input);
		} else if (i==12) {
			jsonData["nombreInventario"] = input;
		} else if (i==13) {
			jsonData["cantidad"] = parseInt(input);
		}
		console.log(`Texto ${i}: ${input}`);
	}
	console.log(jsonData);
	$.ajax({
		type: "POST",
		url: `${window.location.origin}/AutoLavado/www/php/addRow.php`,
		data: JSON.stringify(jsonData),
		contentType: "application/json",
		success: function(response) {
			console.log(response);
		}
	});
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
