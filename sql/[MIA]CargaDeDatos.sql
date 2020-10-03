--------------------------------------------------------------------------
--------------  CARGA DE DATOS DEL CSV A LA TABLA TEMPORAL ---------------
--------------------------------------------------------------------------
LOAD DATA LOCAL INFILE '/home/yosoyfr/Descargas/DataCenterData.csv'
INTO TABLE temporal
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(nombre_compania,contacto_compania,correo_compania,telefono_compania,tipo,nombre,correo,telefono,@FECHA,direccion,ciudad,codigo_postal,region,producto,categoria_producto,cantidad,precio_unitario)
SET fecha_registro = STR_TO_DATE(@FECHA,'%d/%m/%Y');

--------------------------------------------------------------------------
------------------------  INSERCION DE COMPAÑIAS -------------------------
--------------------------------------------------------------------------
INSERT INTO compania(nombre, contacto, correo, telefono) 
SELECT DISTINCT nombre_compania,contacto_compania,correo_compania,telefono_compania FROM temporal;

--------------------------------------------------------------------------
-------------  INSERCION DE LAS CATEGORIAS DE PRODUCTOS ------------------
--------------------------------------------------------------------------
INSERT INTO categoria_producto(nombre) 
SELECT DISTINCT categoria_producto FROM temporal;

--------------------------------------------------------------------------
--------------------  INSERCION DE LOS PRODUCTOS -------------------------
--------------------------------------------------------------------------
INSERT INTO producto(nombre, precio, categoria) 
SELECT DISTINCT Temporal.producto, Temporal.precio_unitario, Categoria.id 
FROM temporal Temporal 
LEFT JOIN categoria_producto Categoria ON Temporal.categoria_producto = Categoria.nombre;

--------------------------------------------------------------------------
-----------------  INSERCION DE LOS TIPOS DE USUARIOS  -------------------
--------------------------------------------------------------------------
INSERT INTO tipo_usuario(nombre) 
SELECT DISTINCT tipo FROM temporal;

--------------------------------------------------------------------------
---------------------  INSERCION DE LOS USUARIOS  ------------------------
--------------------------------------------------------------------------
INSERT INTO usuario(nombre, correo, telefono, createdAt, tipo, ubicacion) 
SELECT DISTINCT Temporal.nombre, Temporal.correo, Temporal.telefono, Temporal.fecha_registro, Tipo.id, Ubicacion.id
FROM temporal Temporal 
INNER JOIN tipo_usuario Tipo ON Temporal.tipo = Tipo.nombre
INNER JOIN ubicacion Ubicacion ON Temporal.direccion = Ubicacion.description
INNER JOIN ciudad Ciudad ON Temporal.codigo_postal = Ciudad.codigoPostal
INNER JOIN region Region ON Temporal.region = Region.nombre;

--------------------------------------------------------------------------
---------------------  INSERCION DE LAS REGIONES  ------------------------
--------------------------------------------------------------------------
INSERT INTO region(nombre) 
SELECT DISTINCT Temporal.region 
FROM temporal Temporal;

--------------------------------------------------------------------------
---------------------  INSERCION DE LAS CIUDADES  ------------------------
--------------------------------------------------------------------------
INSERT INTO ciudad(codigoPostal, nombre, region) 
SELECT DISTINCT Temporal.codigo_postal, Temporal.ciudad, Region.id 
FROM temporal Temporal 
LEFT JOIN region Region ON Temporal.region = Region.nombre;

--------------------------------------------------------------------------
-------------------  INSERCION DE LAS UBICACIONES  -----------------------
--------------------------------------------------------------------------
INSERT INTO ubicacion(description, ciudad) 
SELECT DISTINCT Temporal.direccion, Ciudad.codigoPostal
FROM temporal Temporal 
LEFT JOIN ciudad Ciudad ON Temporal.codigo_postal = Ciudad.codigoPostal;

--------------------------------------------------------------------------
-----------------  INSERCION DE LAS TRANSACCI0NES  -----------------------
--------------------------------------------------------------------------
INSERT INTO transaccion(usuario, compania, total) 
SELECT DISTINCT Usuario.id, Compania.id, SUM(Temporal.cantidad*Temporal.precio_unitario)
FROM temporal Temporal 
INNER JOIN usuario Usuario ON Temporal.nombre = Usuario.nombre
INNER JOIN compania Compania ON Temporal.nombre_compania = Compania.nombre
GROUP BY Usuario.id, Compania.id;

--------------------------------------------------------------------------
----------  INSERCION DE LOS DETALLES DE LAS TRANSACCIONES  --------------
--------------------------------------------------------------------------
INSERT INTO detalle_transaccion(producto, cantidad, transaccion) 
SELECT Producto.id, Temporal.cantidad, Transaccion.id
FROM temporal Temporal 
INNER JOIN producto Producto ON Temporal.producto = Producto.nombre
INNER JOIN categoria_producto Categoria ON Temporal.categoria_producto = Categoria.nombre
INNER JOIN usuario Usuario ON Temporal.nombre = Usuario.nombre
INNER JOIN compania Compania ON Temporal.nombre_compania = Compania.nombre
INNER JOIN transaccion Transaccion ON Transaccion.usuario = Usuario.id AND Transaccion.compania = Compania.id;

