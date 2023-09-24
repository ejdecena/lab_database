/* CASO DE ESTUDIO FACTURACIÓN.
*/

-- DROP DATABASE IF EXISTS facturacion;
-- CREATE DATABASE facturacion;

DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS factura CASCADE;
DROP TABLE IF EXISTS producto CASCADE;
DROP TABLE IF EXISTS detalle_factura CASCADE;

CREATE TABLE cliente (
	cliente_id serial,
	tipo_doc char(1) NOT NULL,
	num_doc varchar(10) NOT NULL,
	nombre varchar(20) NOT NULL,
	fecha_creacion date NOT NULL DEFAULT CURRENT_DATE,
	CONSTRAINT pk_cliente PRIMARY KEY (cliente_id),
	CONSTRAINT un_cliente UNIQUE (tipo_doc, num_doc),
	CONSTRAINT ch_cliente_tipo_doc CHECK (tipo_doc IN ('V', 'E', 'J', 'G'))
);

CREATE TABLE factura (
	factura_id serial,
	cliente_id int NOT NULL,
	fecha_factura date NOT NULL DEFAULT CURRENT_DATE,
	impuesto numeric NOT NULL,
	tipo_pago varchar(7) NOT NULL DEFAULT 'Contado',
	CONSTRAINT pk_factura PRIMARY KEY (factura_id),
	CONSTRAINT fk_factura_cliente FOREIGN KEY (cliente_id)
		REFERENCES cliente(cliente_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT ch_factura_tipo_pago CHECK (tipo_pago IN ('Contado', 'Crédito')),
	CONSTRAINT ch_factura_impuesto CHECK (impuesto >=0 AND impuesto <= 1)
);

CREATE TABLE producto (
	producto_id serial,
	nom_producto varchar(20) NOT NULL,
	fecha_creado date NOT NULL DEFAULT CURRENT_DATE,
	precio numeric NOT NULL,
	existencias int NOT NULL DEFAULT 0,
	minimo int NOT NULL DEFAULT 0,
	CONSTRAINT pk_producto PRIMARY KEY (producto_id),
	CONSTRAINT ch_producto_existencias CHECK (existencias >= 0),
	CONSTRAINT ch_producto_minimo CHECK (minimo >= 0),
	CONSTRAINT ch_producto_precio CHECK (precio > 0)
);

CREATE TABLE detalle_factura (
	factura_id int NOT NULL,
	producto_id int NOT NULL,
	cantidad int NOT NULL,
	precio numeric NOT NULL,
	CONSTRAINT pk_detalle_fact PRIMARY KEY (factura_id, producto_id),
	CONSTRAINT fk_detalle_factura FOREIGN KEY (factura_id)
		REFERENCES factura(factura_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT fk_detalle_producto FOREIGN KEY (producto_id)
		REFERENCES producto(producto_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT ch_detalle_cantidad CHECK (cantidad > 0),
	CONSTRAINT ch_detalle_precio CHECK (precio > 0)
);

-- INSERTS INTO CLIENTE:
INSERT INTO cliente (tipo_doc, num_doc, nombre)
	VALUES	('V', '123', 'Pedro'),
			('V', '456', 'Maria'),
			('V', '789', 'Juan');

-- INSERTS INTO FACTURA:
INSERT INTO cuenta (cliente_id, tipo)
	VALUES	(1, 'Ahorros'),
			(2, 'Ahorros'),
			(2, 'Corriente'),
			(3, 'Ahorros');

-- INSERTS INTO PRODUCTO:
INSERT INTO cuenta (cliente_id, tipo)
	VALUES	(1, 'Ahorros'),
			(2, 'Ahorros'),
			(2, 'Corriente'),
			(3, 'Ahorros');

-- INSERTS INTO DETALLE DE FACTURA:
INSERT INTO transaccion (cuenta_id, descripcion, deposito) VALUES (1, 'Apertura.', 1000);
INSERT INTO transaccion (cuenta_id, descripcion, retiro) VALUES (1, 'Cajero automatico.', 200);
INSERT INTO transaccion (cuenta_id, descripcion, retiro) VALUES (1, 'Compra Supermercado.', 500);
INSERT INTO transaccion (cuenta_id, descripcion, deposito) VALUES (1, 'Pago Móvil.', 700);
INSERT INTO transaccion (cuenta_id, descripcion, deposito) VALUES (2, 'Apertura.', 1000);
INSERT INTO transaccion (cuenta_id, descripcion, retiro) VALUES (2, 'Cajero automatico.', 200);
INSERT INTO transaccion (cuenta_id, descripcion, deposito) VALUES (3, 'Apertura.', 1000);
INSERT INTO transaccion (cuenta_id, descripcion, deposito) VALUES (1, 'Pago Movil.', 200);

-- SELECT * FROM cliente;
-- SELECT * FROM cuenta;
-- SELECT * FROM transaccion;