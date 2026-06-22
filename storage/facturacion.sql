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

-- 1. Tabla: cliente
INSERT INTO cliente (tipo_doc, num_doc, nombre) VALUES ('V', '12345678', 'Juan Perez');
INSERT INTO cliente (tipo_doc, num_doc, nombre) VALUES ('E', '87654321', 'Maria Garcia');
INSERT INTO cliente (tipo_doc, num_doc, nombre) VALUES ('J', '10203040', 'Empresa Polar');
INSERT INTO cliente (tipo_doc, num_doc, nombre) VALUES ('V', '11223344', 'Carlos Lopez');
INSERT INTO cliente (tipo_doc, num_doc, nombre) VALUES ('G', '55667788', 'Alcaldia CCS');
INSERT INTO cliente (tipo_doc, num_doc, nombre) VALUES ('V', '99887766', 'Ana Rodriguez');
INSERT INTO cliente (tipo_doc, num_doc, nombre) VALUES ('E', '22334455', 'Luis Fernandez');
INSERT INTO cliente (tipo_doc, num_doc, nombre) VALUES ('J', '44556677', 'Inversiones ABC');
INSERT INTO cliente (tipo_doc, num_doc, nombre) VALUES ('V', '33445566', 'Rosa Diaz');
INSERT INTO cliente (tipo_doc, num_doc, nombre) VALUES ('V', '77889900', 'Pedro Gomez');

-- 2. Tabla: producto
INSERT INTO producto (nom_producto, precio, existencias, minimo) VALUES ('Harina Pan', 1.20, 100, 10);
INSERT INTO producto (nom_producto, precio, existencias, minimo) VALUES ('Arroz 1kg', 0.90, 80, 15);
INSERT INTO producto (nom_producto, precio, existencias, minimo) VALUES ('Pasta 500g', 1.10, 60, 10);
INSERT INTO producto (nom_producto, precio, existencias, minimo) VALUES ('Azucar 1kg', 1.50, 50, 20);
INSERT INTO producto (nom_producto, precio, existencias, minimo) VALUES ('Aceite 1L', 3.50, 40, 5);
INSERT INTO producto (nom_producto, precio, existencias, minimo) VALUES ('Cafe 250g', 2.80, 30, 8);
INSERT INTO producto (nom_producto, precio, existencias, minimo) VALUES ('Leche 1L', 1.80, 25, 10);
INSERT INTO producto (nom_producto, precio, existencias, minimo) VALUES ('Mantequilla', 2.00, 45, 12);
INSERT INTO producto (nom_producto, precio, existencias, minimo) VALUES ('Jabon Baño', 0.75, 120, 30);
INSERT INTO producto (nom_producto, precio, existencias, minimo) VALUES ('Detergente', 4.50, 15, 10);

-- 3. Tabla: factura
INSERT INTO factura (cliente_id, impuesto, tipo_pago) VALUES (1, 0.16, 'Contado');
INSERT INTO factura (cliente_id, impuesto, tipo_pago) VALUES (2, 0.16, 'Crédito');
INSERT INTO factura (cliente_id, impuesto, tipo_pago) VALUES (3, 0.16, 'Contado');
INSERT INTO factura (cliente_id, impuesto, tipo_pago) VALUES (4, 0.16, 'Contado');
INSERT INTO factura (cliente_id, impuesto, tipo_pago) VALUES (5, 0.00, 'Crédito');
INSERT INTO factura (cliente_id, impuesto, tipo_pago) VALUES (6, 0.16, 'Contado');
INSERT INTO factura (cliente_id, impuesto, tipo_pago) VALUES (7, 0.16, 'Contado');
INSERT INTO factura (cliente_id, impuesto, tipo_pago) VALUES (8, 0.16, 'Crédito');
INSERT INTO factura (cliente_id, impuesto, tipo_pago) VALUES (9, 0.16, 'Contado');
INSERT INTO factura (cliente_id, impuesto, tipo_pago) VALUES (10, 0.16, 'Contado');

-- 4. Tabla: detalle_factura
INSERT INTO detalle_factura (factura_id, producto_id, cantidad, precio) VALUES (1, 1, 2, 1.20);
INSERT INTO detalle_factura (factura_id, producto_id, cantidad, precio) VALUES (2, 2, 5, 0.90);
INSERT INTO detalle_factura (factura_id, producto_id, cantidad, precio) VALUES (3, 3, 1, 1.10);
INSERT INTO detalle_factura (factura_id, producto_id, cantidad, precio) VALUES (4, 4, 3, 1.50);
INSERT INTO detalle_factura (factura_id, producto_id, cantidad, precio) VALUES (5, 5, 2, 3.50);
INSERT INTO detalle_factura (factura_id, producto_id, cantidad, precio) VALUES (6, 6, 1, 2.80);
INSERT INTO detalle_factura (factura_id, producto_id, cantidad, precio) VALUES (7, 7, 4, 1.80);
INSERT INTO detalle_factura (factura_id, producto_id, cantidad, precio) VALUES (8, 8, 2, 2.00);
INSERT INTO detalle_factura (factura_id, producto_id, cantidad, precio) VALUES (9, 9, 10, 0.75);
INSERT INTO detalle_factura (factura_id, producto_id, cantidad, precio) VALUES (10, 10, 1, 4.50);