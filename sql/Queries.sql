USE autolavado;
DELIMITER //
CREATE PROCEDURE mostrarRegistrosPorEmpleado (IN idEmpleado NUMERIC(2,0))
BEGIN
	SELECT
		e.nombre AS empleado,
		s.nombre AS servicio,
		s.precio AS precioDelServicio,
		i.nombre AS productoUtilizadoParaElServicio,
		dv.fecha AS fechaDeLaVenta,
		p.nombre AS paquete,
		p.precio AS precioDelPaquete,
		c.nombre AS cliente,
		c.correo AS correoDelCliente,
		c.telefono AS telefonoDelCliente,
		a.placas AS placasDelCarro,
		tc.nombre AS modeloDelCarro
	FROM empleado AS e INNER JOIN servicioEmpleado AS se
		ON (e.idEmpleado = se.fkEmpleado)
			INNER JOIN servicio AS s
				ON (s.idServicio = se.fkServicio)
					INNER JOIN servicioInventario AS si
						ON (s.idServicio = si.fkServicio)
							INNER JOIN inventario AS i
								ON (i.idInventario = si.fkInventario)
									INNER JOIN paqueteServicio AS ps
										ON (s.idServicio = ps.fkServicio)
											INNER JOIN paquete AS p
												ON (p.idPaquete = ps.fkPaquete)
													INNER JOIN detalleVenta AS dv
														ON (p.idPaquete = dv.fkPaquete)
															INNER JOIN venta AS v
																ON (v.idVenta = dv.fkVenta)
																	INNER JOIN cliente AS c
																		ON (c.idCliente = v.fkCliente)
																			INNER JOIN auto AS a
																				ON (a.idAuto = c.fkAuto)
																					INNER JOIN tipoCarro AS tc
																						ON (tc.idTipoCarro = a.fkTipoCarro)
	WHERE e.idEmpleado = idEmpleado;
END //
DELIMITER ;

CALL mostrarRegistrosPorEmpleado(1);

DELIMITER //
CREATE PROCEDURE agregarClienteYSuAuto (IN carro VARCHAR(45), IN placas CHAR(6), IN nombre VARCHAR(45), IN paterno VARCHAR(45), IN materno VARCHAR(45), IN telefono CHAR(10), IN correo VARCHAR(100))
BEGIN
	DECLARE _idTipoCarro NUMERIC(2,0);
	DECLARE _idAuto NUMERIC(2,0);
	DECLARE _idCliente NUMERIC(2,0);
	SET _idTipoCarro = (SELECT MAX(idTipoCarro) FROM tipoCarro) + 1;
	SET _idAuto = (SELECT MAX(idAuto) FROM auto) + 1;
	SET _idCliente = (SELECT MAX(idCliente) FROM cliente) + 1;
	INSERT INTO tipoCarro (idTipoCarro,nombre) VALUES (_idTipoCarro,carro);
	INSERT INTO auto (idAuto,placas,fkTipoCarro) VALUES (_idAuto,placas,_idTipoCarro);
	INSERT INTO cliente (idCliente,nombre,paterno,materno,telefono,correo,fkAuto) VALUES (_idCliente,nombre,paterno,materno,telefono,correo,_idAuto);
END //
DELIMITER ;

CALL agregarClienteYSuAuto('Vocho','123456','Daniel','Mejia','Ramirez','0987654321','daniel-mejia-ramirez@email.com');

DELIMITER //
CREATE PROCEDURE agregarVentaPaqueteYServicio (IN fecha DATE, IN nombrePaquete VARCHAR(45), IN nombreServicio VARCHAR(45), IN precioPaquete NUMERIC(5,0), IN precioServicio NUMERIC(5,0))
BEGIN
	DECLARE _idVenta NUMERIC(2,0);
	DECLARE _idDetalleVenta NUMERIC(2,0);
	DECLARE _idPaquete NUMERIC(2,0);
	DECLARE _idPaqueteServicio NUMERIC(2,0);
	DECLARE _idServicio NUMERIC(2,0);
	DECLARE _fkCliente NUMERIC(2,0);
	SET _idVenta = (SELECT MAX(idVenta) FROM venta) + 1;
	SET _idDetalleVenta = (SELECT MAX(idDetalleVenta) FROM detalleVenta) + 1;
	SET _idPaquete = (SELECT MAX(idPaquete) FROM paquete) + 1;
	SET _idPaqueteServicio = (SELECT MAX(idPaqueteServicio) FROM paqueteServicio) + 1;
	SET _idServicio = (SELECT MAX(idServicio) FROM servicio) + 1;
	SET _fkCliente = (SELECT MAX(idCliente) FROM cliente);
	INSERT INTO paquete (idPaquete,nombre,precio) VALUES (_idPaquete,nombrePaquete,precioPaquete);
	INSERT INTO servicio (idServicio,nombre,precio) VALUES (_idServicio,nombreServicio,precioServicio);
	INSERT INTO venta (idVenta,fecha,fkCliente) VALUES (_idVenta,fecha,_fkCliente);
	INSERT INTO detalleVenta (idDetalleVenta,fecha,fkVenta,fkPaquete,fkServicio) VALUES (_idDetalleVenta,fecha,_idVenta,_idPaquete,_idServicio);
	INSERT INTO paqueteServicio (idPaqueteServicio,fkServicio,fkPaquete) VALUES (_idPaqueteServicio,_idServicio,_idPaquete);
END //
DELIMITER ;

CALL agregarVentaPaqueteYServicio('2023-06-09','Completo','Mantenimiento',750,750);

DELIMITER //
CREATE PROCEDURE agregarInventario (IN nombre VARCHAR(45), IN cantidad NUMERIC(3,0))
BEGIN
	DECLARE _idInventario NUMERIC(2,0);
	DECLARE _idServicioInventario NUMERIC(2,0);
	DECLARE _fkServicio NUMERIC(2,0);
	DECLARE _fkInventario NUMERIC(2,0);
	SET _idInventario = (SELECT MAX(idInventario) FROM inventario) + 1;
	SET _idServicioInventario = (SELECT MAX(idServicioInventario) FROM servicioInventario) + 1;
	SET _fkServicio = (SELECT MAX(idServicio) FROM servicio);
	SET _fkInventario = (SELECT MAX(idInventario) FROM inventario) + 1;
	INSERT INTO inventario (idInventario,nombre,cantidad) VALUES (_idInventario,nombre,cantidad);
	INSERT INTO servicioInventario(idServicioInventario,fkServicio,fkInventario) VALUES (_idServicioInventario,_fkServicio,_fkInventario);
END //
DELIMITER ;

CALL agregarInventario('Cera',15);

DELIMITER //
CREATE PROCEDURE eliminarInventario (IN _idInventario NUMERIC(2,0), IN _idServicioInventario NUMERIC(2,0))
BEGIN
	DELETE FROM inventario WHERE idInventario = _idInventario;
	DELETE FROM servicioInventario WHERE idServicioInventario = _idServicioInventario;
END //
DELIMITER ;

CALL eliminarInventario(5,5);

DELIMITER //
CREATE PROCEDURE eliminarVentaPaqueteYServicio (IN _idVenta NUMERIC(2,0), IN _idDetalleVenta NUMERIC(2,0), IN _idPaquete NUMERIC(2,0), IN _idPaqueteServicio NUMERIC(2,0), IN _idServicio NUMERIC(2,0))
BEGIN
	DELETE FROM paquete WHERE idPaquete = _idPaquete;
	DELETE FROM servicio WHERE idServicio = _idServicio;
	DELETE FROM venta WHERE idVenta = _idVenta;
	DELETE FROM detalleVenta WHERE idDetalleVenta = _idDetalleVenta;
	DELETE FROM paqueteServicio WHERE idPaqueteServicio = _idPaqueteServicio;
END //
DELIMITER ;

CALL eliminarVentaPaqueteYServicio(5,5,5,5,5);

DELIMITER //
CREATE PROCEDURE eliminarClienteYSuAuto (IN _idTipoCarro NUMERIC(2,0), IN _idAuto NUMERIC(2,0), IN _idCliente NUMERIC(2,0))
BEGIN
	DELETE FROM tipoCarro WHERE idTipoCarro = _idTipoCarro;
	DELETE FROM auto WHERE idAuto = _idAuto;
	DELETE FROM cliente WHERE idCliente = _idCliente;
END //
DELIMITER ;

CALL eliminarClienteYSuAuto(5,5,5);

/*
	1. Agregar mas registros para el inventario, incluso si se repiten los productos, para poder actualizar los registros y a la hr de actualizar/borrar en la pagina, solo se vea afectado ese registro en especifico
	Ya que el modelo de la BD, fue mal diseñado
		2. Crear los Procedures respectivos para el agregar/actualizar/borrar para cada una de las tablas correspondientes y que sean invocados desde sus PHP respectivos
	3. En los botones (que implementar bootstrap-icons), en el atributo onclick, apunte a un Jquery (pasandole un array con los IDs de las tablas MySql a tratar) y este apunte a un PHP, el cual ejecutara un Procedure respectivo para ello
*/
