--------------------------------------------------------------------------
--------------------  CREACION DE LA BASE DE DATOS  ----------------------
--------------------------------------------------------------------------
CREATE DATABASE MIAP1;

----------------------  USO DE LA BASE CREADA  ---------------------------
USE MIAP1;

--------------------------------------------------------------------------
-----------------  TABLA TEMPORAL PARA LA CARGA DE DATOS -----------------
--------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS temporal(
	nombre_compania VARCHAR(50),
    contacto_compania VARCHAR(50),
    correo_compania VARCHAR(255),
    telefono_compania  VARCHAR(12),
    tipo char(1),
    nombre VARCHAR(50),
    correo VARCHAR(255),
    telefono VARCHAR(12),
    fecha_registro date,
    direccion VARCHAR(50),
    ciudad VARCHAR(50),
    codigo_postal int,
    region VARCHAR(50),
    producto VARCHAR(50),
    categoria_producto VARCHAR(50),
    cantidad  int,
    precio_unitario decimal(6,2)    
)ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--------------------------------------------------------------------------
--------------------------  TABLA COMPAÑIA -------------------------------
--------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS compania(
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    contacto VARCHAR(50) NOT NULL,
    correo VARCHAR(255) NOT NULL,
    telefono VARCHAR(12) NOT NULL, 
    PRIMARY KEY (id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--------------------------------------------------------------------------
-----------------------  TABLA TIPO DE USUARIOS --------------------------
--------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS tipo_usuario(
	id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--------------------------------------------------------------------------
---------------------------  TABLA REGION --------------------------------
--------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS region(
	id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--------------------------------------------------------------------------
---------------------------  TABLA CIUDAD  -------------------------------
--------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ciudad(
	codigoPostal INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    region INT NOT NULL,
    PRIMARY KEY (codigoPostal),
    FOREIGN KEY (region) REFERENCES region(id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--------------------------------------------------------------------------
--------------------------  TABLA UBICACION  -----------------------------
--------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ubicacion(
	id INT NOT NULL AUTO_INCREMENT,
    description VARCHAR(255) NOT NULL,
    ciudad INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (ciudad) REFERENCES ciudad(codigoPostal)
)ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--------------------------------------------------------------------------
--------------------------  TABLA DE USUARIOS ----------------------------
--------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS usuario(
	id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    correo VARCHAR(255) NOT NULL,
    telefono VARCHAR(12) NOT NULL, 
    createdAt date,
    tipo INT NOT NULL,
    ubicacion INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tipo) REFERENCES tipo_usuario(id),
    FOREIGN KEY (ubicacion) REFERENCES ubicacion(id)
)DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--------------------------------------------------------------------------
--------------------  TABLA CATEGORIA DE PRODUCTOS -----------------------
--------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS categoria_producto(
	id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--------------------------------------------------------------------------
-------------------------  TABLA DE PRODUCTOS ----------------------------
--------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS producto(
	id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    precio DECIMAL(6,2) NOT NULL,
    categoria INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (categoria) REFERENCES categoria_producto(id)
)DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--------------------------------------------------------------------------
-------------------------  TABLA DE PRODUCTOS ----------------------------
--------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS producto(
	id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    precio DECIMAL(6,2) NOT NULL,
    categoria INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (categoria) REFERENCES categoria_producto(id)
)DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--------------------------------------------------------------------------
----------------------  TABLA DE TRANSACCIONES  --------------------------
--------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS transaccion(
	id INT NOT NULL AUTO_INCREMENT,
    usuario INT NOT NULL,
    compania INT NOT NULL,
    total decimal(14,2)  NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (usuario) REFERENCES usuario(id),
    FOREIGN KEY (compania) REFERENCES compania(id)
)DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--------------------------------------------------------------------------
-------------------  TABLA DETALLE DE TRANSACCION ------------------------
--------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS detalle_transaccion(
	id INT NOT NULL AUTO_INCREMENT,
    producto INT NOT NULL,
	cantidad INT NOT NULL,
    transaccion INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (producto) REFERENCES producto(id),
    FOREIGN KEY (transaccion) REFERENCES transaccion(id)
)DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;