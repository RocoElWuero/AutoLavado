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

