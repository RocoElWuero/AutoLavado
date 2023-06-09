DROP DATABASE IF EXISTS autolavado;
CREATE DATABASE autolavado;
USE autolavado;
--Primarias
CREATE TABLE empleado(
	idEmpleado NUMERIC(2,0) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	paterno VARCHAR(45) NOT NULL,
	materno VARCHAR(45) NOT NULL,
	telefono VARCHAR(10) NOT NULL,
	CONSTRAINT pkEmpleado PRIMARY KEY (idEmpleado)
);
CREATE TABLE inventario(
	idInventario NUMERIC(2,0) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	cantidad NUMERIC(3,0) NOT NULL,
	CONSTRAINT pkInventario PRIMARY KEY (idInventario)
);
CREATE TABLE tipoCarro(
	idTipoCarro NUMERIC(2,0) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	CONSTRAINT pkTipoCarro PRIMARY KEY (idTipoCarro)
);
CREATE TABLE paquete(
	idPaquete NUMERIC(2,0) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	precio NUMERIC(5,0) NOT NULL,
	CONSTRAINT pkPaquete PRIMARY KEY (idPaquete)
);
CREATE TABLE servicio(
	idServicio NUMERIC(2,0) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	precio NUMERIC(5,0) NOT NULL,
	CONSTRAINT pkServicio PRIMARY KEY (idServicio)
);
--Secundarias
CREATE TABLE auto(
	idAuto NUMERIC(2,0) NOT NULL,
	placas CHAR(6) NOT NULL,
	fkTipoCarro NUMERIC(2,0) NOT NULL,
	CONSTRAINT pkAuto PRIMARY KEY (idAuto),
	CONSTRAINT fkAutoTipoCarro
		FOREIGN KEY (fkTipoCarro)
		REFERENCES tipoCarro (idTipoCarro)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);
CREATE TABLE cliente(
	idCliente NUMERIC(2,0) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	paterno VARCHAR(45) NOT NULL,
	materno VARCHAR(45) NOT NULL,
	telefono CHAR(10) NOT NULL,
	correo VARCHAR(100) NOT NULL,
	fkAuto NUMERIC(2,0) NOT NULL,
	CONSTRAINT pkCliente PRIMARY KEY (idCliente),
	CONSTRAINT fkClienteAuto
		FOREIGN KEY (fkAuto)
		REFERENCES auto (idAuto)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);
CREATE TABLE venta(
	idVenta NUMERIC(2,0) NOT NULL,
	fecha DATE NOT NULL,
	fkCliente NUMERIC(2,0) NOT NULL,
	CONSTRAINT pkVenta PRIMARY KEY (idVenta),
	CONSTRAINT fkVentaCliente
		FOREIGN KEY (fkCliente)
		REFERENCES cliente (idCliente)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);
--Terciarias
CREATE TABLE detalleVenta(
	idDetalleVenta NUMERIC(2,0) NOT NULL,
	fecha DATE NOT NULL,
	fkVenta NUMERIC(2,0) NOT NULL,
	fkPaquete NUMERIC(2,0) NOT NULL,
	fkServicio NUMERIC(2,0) NOT NULL,
	CONSTRAINT pkDetalleVenta PRIMARY KEY (idDetalleVenta),
	CONSTRAINT fkDetalleVentaVenta
		FOREIGN KEY (fkVenta)
		REFERENCES venta (idVenta)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	CONSTRAINT fkDetalleVentaPaquete
		FOREIGN KEY (fkPaquete)
		REFERENCES paquete (idPaquete)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	CONSTRAINT fkDetalleVentaServicio
		FOREIGN KEY (fkServicio)
		REFERENCES servicio (idServicio)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);
CREATE TABLE servicioEmpleado(
	idServicioEmpleado NUMERIC(2,0) NOT NULL,
	fkServicio NUMERIC(2,0) NOT NULL,
	fkEmpleado NUMERIC(2,0) NOT NULL,
	CONSTRAINT pkServicioEmpleado PRIMARY KEY (idServicioEmpleado),
	CONSTRAINT fkServicioEmpleadoServicio
		FOREIGN KEY (fkServicio)
		REFERENCES servicio (idServicio)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	CONSTRAINT fkServicioEmpleadoEmpleado
		FOREIGN KEY (fkEmpleado)
		REFERENCES empleado (idEmpleado)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);
CREATE TABLE paqueteServicio(
	idPaqueteServicio NUMERIC(2,0) NOT NULL,
	fkServicio NUMERIC(2,0) NOT NULL,
	fkPaquete NUMERIC(2,0) NOT NULL,
	CONSTRAINT pkPaqueteServicio PRIMARY KEY (idPaqueteServicio),
	CONSTRAINT fkPaqueteServicioServicio
		FOREIGN KEY (fkServicio)
		REFERENCES servicio (idServicio)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	CONSTRAINT fkPaqueteServicioPaquete
		FOREIGN KEY (fkPaquete)
		REFERENCES paquete (idPaquete)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);
CREATE TABLE servicioInventario(
	idServicioInventario NUMERIC(2,0) NOT NULL,
	fkServicio NUMERIC(2,0) NOT NULL,
	fkInventario NUMERIC(2,0) NOT NULL,
	CONSTRAINT pkServicioInventario PRIMARY KEY (idServicioInventario),
	CONSTRAINT fkServicioInventarioServicio
		FOREIGN KEY (fkServicio)
		REFERENCES servicio (idServicio)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	CONSTRAINT fkServicioInventarioInventario
		FOREIGN KEY (fkInventario)
		REFERENCES inventario (idInventario)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);
