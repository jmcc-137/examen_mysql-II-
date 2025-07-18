CREATE TABLE IF NOT EXISTS ()ENGINE = INNODB;

CREATE DATABASE EXAMEN_MYSQL_II;

USE EXAMEN_MYSQL_II;


CREATE TABLE IF NOT EXISTS pago(
id_pago INT AUTO_INCREMENT PRIMARY KEY,
id_cliente INT,
id_empleado INT, 
id_alquiler INT,
total DECIMAL(5,2),
fecha_pago DATETIME,
ultima_actualizacion TIMESTAMP
)ENGINE = INNODB;


CREATE TABLE IF NOT EXISTS alquiler(
id_alquiler INT AUTO_INCREMENT PRIMARY KEY,
id_inventario INT,
id_cliente INT,
fecha_devolucion DATETIME,
id_empleado INT,
ultima_actualizacion TIMESTAMP 
)ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS cliente(
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    id_almacen INT,
    nombre VARCHAR(45),
    apellidos VARCHAR(45),
    email VARCHAR(50),
    id_direccion INT,
    activo INT,
    fecha_creacion DATETIME,
    ultima_actualizacion TIMESTAMP
)ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS pelicula(
    id_pelicula INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255),
    descripcion TEXT,
    anyo_lanzamiento YEAR,
    id_idioma INT,
    id_idioma_original INT,
    duracion_alquiler INT,
    renta_rate DECIMAL(4,2),
    duracion INT,
    repaplacement_cost DECIMAL(5,2),
    clasificacion VARCHAR(10),
    caracteristicas_especiales SET('Trailers','Comentaries','Deleted Scenes','Behind the Scenes'),
    ultima_actualizacion TIMESTAMP
)ENGINE = INNODB;


CREATE TABLE IF NOT EXISTS empleado(
    id_empleado INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(45),
    apellidos VARCHAR(45),
    id_direccion INT,
    imagen INT,
    email VARCHAR(50),
    id_almacen INT,
    activo INT,
    username VARCHAR(16),
    password VARCHAR(40),
    ultima_actualizacion TIMESTAMP
)ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS direccion(
    id_direccion INT PRIMARY KEY,
    direccion VARCHAR(50),
    direccion2 VARCHAR(50),
    distrito VARCHAR(20),
    id_ciudad INT,
    codigo_postal VARCHAR(10),
    telefono VARCHAR(20),
    ultima_actualizacion TIMESTAMP
)ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS ciudad(
    id_ciudad INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    id_pais INT,
    ultima_actualizacion TIMESTAMP
)ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS pais(
    id_pais INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    ultima_actualizacion TIMESTAMP
)ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS idioma(
    id_idioma INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20),
    ultima_actualizacion TIMESTAMP
)ENGINE = INNODB;


CREATE TABLE IF NOT EXISTS actor(
    id_actor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(45),
    apellidos VARCHAR(45),
    ultima_actualizacion TIMESTAMP
)ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS pelicula_actor(
    id_actor INT,
    id_pelicula INT,
    ultima_actualizacion TIMESTAMP,
    PRIMARY KEY(id_actor,id_pelicula)
)ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS pelicula_categoria(
    id_pelicula INT,
    id_categoria INT,
    ultima_actualizacion TIMESTAMP,
    PRIMARY KEY (id_pelicula,id_categoria)
)ENGINE = INNODB;



CREATE TABLE IF NOT EXISTS categoria(
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255),
    ultima_actualizacion TIMESTAMP
)ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS inventario(
    id_inventario INT PRIMARY KEY AUTO_INCREMENT,
    id_pelicula INT,
    id_almacen INT,
    ultima_actualizacion TIMESTAMP
)ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS almacen(
    id_almacen INT PRIMARY KEY AUTO_INCREMENT,
    id_empleado_jefe INT,
    id_direccion INT,
    ultima_actualizacion TIMESTAMP
)ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS film_text(
 film_id INT PRIMARY KEY AUTO_INCREMENT,
 title VARCHAR(255),
 descripcion TEXT
)ENGINE = INNODB;



ALTER TABLE pago
ADD CONSTRAINT fk_pago_alquiler FOREIGN KEY(id_alquiler) REFERENCES alquiler(id_alquiler),
ADD CONSTRAINT fk_pago_empleado FOREIGN KEY(id_empleado) REFERENCES empleado(id_empleado),
ADD CONSTRAINT fk_pago_cliente FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente);


ALTER TABLE alquiler
ADD CONSTRAINT  fk_alquiler_inventario  FOREIGN KEY (id_inventario) REFERENCES inventario(id_inventario),
ADD CONSTRAINT fk_alquiler_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
ADD CONSTRAINT fk_alquiler_empleado FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado);


ALTER TABLE cliente
ADD CONSTRAINT  fk_cliente_almacen FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen),
ADD CONSTRAINT fk_cliente_direccion FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion);

ALTER TABLE cliente
ADD CONSTRAINT  fk_cliente_almacen FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen),
ADD CONSTRAINT fk_cliente_direccion FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion);


ALTER TABLE almacen
ADD CONSTRAINT  fk_almacen_empleado_jefe FOREIGN KEY (id_empleado_jefe) REFERENCES empleado(id_empleado),
ADD CONSTRAINT fk_almacen_direccion FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion);



ALTER TABLE inventario
ADD CONSTRAINT  fk_inventario_pelicula FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula),
ADD CONSTRAINT fk_inventario_almacen FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen);


ALTER TABLE pelicula_actor
ADD CONSTRAINT  fk_pa_pelicula FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula),
ADD CONSTRAINT fk_pa_actor FOREIGN KEY (id_actor) REFERENCES actor(id_actor);


ALTER TABLE pelicula_categoria
ADD CONSTRAINT  fk_pc_pelicula FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula),
ADD CONSTRAINT fk_pc_categoria FOREIGN KEY (id_actor) REFERENCES actor(id_actor);