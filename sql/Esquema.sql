DROP DATABASE IF EXISTS autolavado;
CREATE DATABASE autolavado;
USE autolavado;
--Primarias
CREATE TABLE empleado(
	idEmpleado NUMERIC(2,0) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	paterno VARCHAR(45) NOT NULL,
	materno VARCHAR(45) NOT NULL,
	telefono CHAR(10) NOT NULL,
	correo VARCHAR(100) NOT NULL,
	password VARCHAR(100) NOT NULL,
	CONSTRAINT pkEmpleado PRIMARY KEY (idEmpleado),
	CONSTRAINT uqEmpleadoId UNIQUE (idEmpleado),
	CONSTRAINT uqEmpleadoTelefono UNIQUE (telefono),
	CONSTRAINT uqEmpleadoCorreo UNIQUE (correo)
);
CREATE TABLE inventario(
	idInventario NUMERIC(2,0) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	cantidad NUMERIC(3,0) NOT NULL,
	CONSTRAINT pkInventario PRIMARY KEY (idInventario),
	CONSTRAINT uqInventarioId UNIQUE (idInventario)
);
CREATE TABLE tipoCarro(
	idTipoCarro NUMERIC(2,0) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	CONSTRAINT pkTipoCarro PRIMARY KEY (idTipoCarro),
	CONSTRAINT uqTipoCarroId UNIQUE (idTipoCarro)
);
CREATE TABLE paquete(
	idPaquete NUMERIC(2,0) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	precio NUMERIC(5,0) NOT NULL,
	CONSTRAINT pkPaquete PRIMARY KEY (idPaquete),
	CONSTRAINT uqPaqueteId UNIQUE (idPaquete)
);
CREATE TABLE servicio(
	idServicio NUMERIC(2,0) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	precio NUMERIC(5,0) NOT NULL,
	CONSTRAINT pkServicio PRIMARY KEY (idServicio),
	CONSTRAINT uqServicioId UNIQUE (idServicio)
);
--Secundarias
CREATE TABLE auto(
	idAuto NUMERIC(2,0) NOT NULL,
	placas CHAR(6) NOT NULL,
	fkTipoCarro NUMERIC(2,0) NOT NULL,
	CONSTRAINT pkAuto PRIMARY KEY (idAuto),
	CONSTRAINT uqAutoId UNIQUE (idAuto),
	CONSTRAINT fkAutoTipoCarro
		FOREIGN KEY (fkTipoCarro)
		REFERENCES tipoCarro (idTipoCarro)
		ON DELETE CASCADE
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
	CONSTRAINT uqClienteId UNIQUE (idCliente),
	CONSTRAINT fkClienteAuto
		FOREIGN KEY (fkAuto)
		REFERENCES auto (idAuto)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
CREATE TABLE venta(
	idVenta NUMERIC(2,0) NOT NULL,
	fecha DATE NOT NULL,
	fkCliente NUMERIC(2,0) NOT NULL,
	CONSTRAINT pkVenta PRIMARY KEY (idVenta),
	CONSTRAINT uqVentaId UNIQUE (idVenta),
	CONSTRAINT fkVentaCliente
		FOREIGN KEY (fkCliente)
		REFERENCES cliente (idCliente)
		ON DELETE CASCADE
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
	CONSTRAINT uqDetalleVentaId UNIQUE (idDetalleVenta),
	CONSTRAINT fkDetalleVentaVenta
		FOREIGN KEY (fkVenta)
		REFERENCES venta (idVenta)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fkDetalleVentaPaquete
		FOREIGN KEY (fkPaquete)
		REFERENCES paquete (idPaquete)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fkDetalleVentaServicio
		FOREIGN KEY (fkServicio)
		REFERENCES servicio (idServicio)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
CREATE TABLE servicioEmpleado(
	idServicioEmpleado NUMERIC(2,0) NOT NULL,
	fkServicio NUMERIC(2,0) NOT NULL,
	fkEmpleado NUMERIC(2,0) NOT NULL,
	CONSTRAINT pkServicioEmpleado PRIMARY KEY (idServicioEmpleado),
	CONSTRAINT uqServicioEmpleadoId UNIQUE (idServicioEmpleado),
	CONSTRAINT fkServicioEmpleadoServicio
		FOREIGN KEY (fkServicio)
		REFERENCES servicio (idServicio)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fkServicioEmpleadoEmpleado
		FOREIGN KEY (fkEmpleado)
		REFERENCES empleado (idEmpleado)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
CREATE TABLE paqueteServicio(
	idPaqueteServicio NUMERIC(2,0) NOT NULL,
	fkServicio NUMERIC(2,0) NOT NULL,
	fkPaquete NUMERIC(2,0) NOT NULL,
	CONSTRAINT pkPaqueteServicio PRIMARY KEY (idPaqueteServicio),
	CONSTRAINT uqPaqueteServicioId UNIQUE (idPaqueteServicio),
	CONSTRAINT fkPaqueteServicioServicio
		FOREIGN KEY (fkServicio)
		REFERENCES servicio (idServicio)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fkPaqueteServicioPaquete
		FOREIGN KEY (fkPaquete)
		REFERENCES paquete (idPaquete)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
CREATE TABLE servicioInventario(
	idServicioInventario NUMERIC(2,0) NOT NULL,
	fkServicio NUMERIC(2,0) NOT NULL,
	fkInventario NUMERIC(2,0) NOT NULL,
	CONSTRAINT pkServicioInventario PRIMARY KEY (idServicioInventario),
	CONSTRAINT uqServicioInventarioId UNIQUE (idServicioInventario),
	CONSTRAINT fkServicioInventarioServicio
		FOREIGN KEY (fkServicio)
		REFERENCES servicio (idServicio)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fkServicioInventarioInventario
		FOREIGN KEY (fkInventario)
		REFERENCES inventario (idInventario)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
