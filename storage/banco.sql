/* CASO DE ESTUDIO BANCO.
*/

-- DROP DATABASE IF EXISTS banco;
-- CREATE DATABASE banco;

DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS cuenta CASCADE;
DROP TABLE IF EXISTS transaccion CASCADE;

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

CREATE TABLE cuenta (
	cuenta_id serial,
	cliente_id int NOT NULL,
	fecha_creacion date NOT NULL DEFAULT CURRENT_DATE,
	tipo varchar(9) NOT NULL DEFAULT 'Ahorros',
	CONSTRAINT pk_cuenta PRIMARY KEY (cuenta_id),
	CONSTRAINT fk_cuenta_cliente FOREIGN KEY (cliente_id)
		REFERENCES cliente(cliente_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT ch_cuenta_tipo CHECK (tipo IN ('Ahorros', 'Corriente'))
);

CREATE TABLE transaccion (
	transaccion_id serial,
	cuenta_id int NOT NULL,
	fecha_trans date NOT NULL DEFAULT CURRENT_DATE,
	descripcion varchar(20) NOT NULL,
	retiro numeric,
	deposito numeric,
	CONSTRAINT pk_transaccion PRIMARY KEY (transaccion_id),
	CONSTRAINT fk_transaccion_cuenta FOREIGN KEY (cuenta_id)
		REFERENCES cuenta(cuenta_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT ch_transaccion_monto CHECK ((retiro + deposito) > 0)
);

-- INSERTS INTO CLIENTE:
INSERT INTO cliente (tipo_doc, num_doc, nombre)
	VALUES	('V', '123', 'Pedro'),
			('V', '456', 'Maria'),
			('V', '789', 'Juan');

-- INSERTS INTO CUENTA:
INSERT INTO cuenta (cliente_id, tipo)
	VALUES	(1, 'Ahorros'),
			(2, 'Ahorros'),
			(2, 'Corriente'),
			(3, 'Ahorros');

-- INSERTS INTO TRANSACCION:
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
SELECT * FROM transaccion;