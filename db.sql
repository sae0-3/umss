CREATE DATABASE muchocine;

USE muchocine;

CREATE TABLE INFORMACION (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL
);

CREATE TABLE AUDIO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    link_audio VARCHAR(255) NOT NULL
);

CREATE TABLE SUBTITULO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    link_subtitulo VARCHAR(255) NOT NULL
);

CREATE TABLE PREMIO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(100) NOT NULL
    -- PRIMARY KEY (id),
    -- FOREIGN KEY (id) REFERENCES INFORMACION(id)
);

CREATE TABLE DIRECCION (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ciudad VARCHAR(100),
    pais VARCHAR(100) NOT NULL
);

CREATE TABLE GENERO (
    id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES INFORMACION(id)
);

CREATE TABLE RESTRICCION (
    id INT NOT NULL,
    categoria ENUM('ATP', 'TP', 'MPAA', 'PG-15', 'R-Rated'),
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES INFORMACION(id)
);

CREATE TABLE PERSONA (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    primer_nombre VARCHAR(50) NOT NULL,
    segundo_nombre VARCHAR(50),
    apellido_paterno VARCHAR(50),
    apellido_materno VARCHAR(50),
    fecha_nacimiento DATE NOT NULL,
    id_residencia INT NOT NULL,
    sexo CHAR(1),
    FOREIGN KEY (id_residencia) REFERENCES DIRECCION(id)
);

CREATE TABLE VIDEO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    duracion DECIMAL(10, 2) NOT NULL,
    id_restriccion INT NOT NULL,
    FOREIGN KEY (id_restriccion) REFERENCES RESTRICCION(id)
    -- TODO: trailer, banner, etc...
);

CREATE TABLE ACTOR (
    id INT NOT NULL,
    id_origen INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES PERSONA(id),
    FOREIGN KEY (id_origen) REFERENCES DIRECCION(id)
);

CREATE TABLE SERIE (
    id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES VIDEO(id)
);

CREATE TABLE TEMPORADA (
    id INT NOT NULL,
    id_serie INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES INFORMACION(id),
    FOREIGN KEY (id_serie) REFERENCES SERIE(id)
);

CREATE TABLE CAPITULO (
    id INT NOT NULL,
    link_video VARCHAR(255) NOT NULL,
    duracion DECIMAL(10, 2),
    id_temporada INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES INFORMACION(id),
    FOREIGN KEY (id_temporada) REFERENCES TEMPORADA(id)
);

CREATE TABLE PELICULA (
    id INT NOT NULL,
    link_video VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES VIDEO(id)
);

CREATE TABLE CUENTA (
    id INT NOT NULL,
    correo VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES PERSONA(id)
);

CREATE TABLE SUSCRIPCION (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cuenta INT NOT NULL,
    FOREIGN KEY (id_cuenta) REFERENCES CUENTA(id)
    -- TODO: AGREGAR INFORMACION
);

CREATE TABLE OFERTA (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
    -- TODO: AGREGAR INFORMACION
);

CREATE TABLE PAQUETE (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
    -- TODO: AGREGAR INFORMACION
);

CREATE TABLE SUBCUENTA (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cuenta INT NOT NULL,
    FOREIGN KEY (id_cuenta) REFERENCES CUENTA(id)
);

CREATE TABLE REPRODUCCION (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_cuenta INT NOT NULL,
    id_video INT NOT NULL,
    FOREIGN KEY (id_cuenta) REFERENCES CUENTA(id),
    FOREIGN KEY (id_video) REFERENCES VIDEO(id)
);

CREATE TABLE ESTRENO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha DATETIME NOT NULL,
    tipo ENUM('pelicula', 'serie') NOT NULL,
    id_video INT NOT NULL,
    FOREIGN KEY (id_video) REFERENCES VIDEO(id)
);

CREATE TABLE EMPRESA (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);



CREATE TABLE ACTUACION (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_artistico VARCHAR(100) NOT NULL,
    rol ENUM('principal', 'secundario', 'reparto', 'extra', 'cameo') NOT NULL,
    id_actor INT NOT NULL,
    id_video INT NOT NULL,
    FOREIGN KEY (id_actor) REFERENCES ACTOR(id),
    FOREIGN KEY (id_video) REFERENCES VIDEO(id)
);

CREATE TABLE PREMIACION (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha YEAR NOT NULL,
    -- tipo ENUM('pelicula', 'serie') NOT NULL,
    id_video INT NOT NULL,
    id_premio INT NOT NULL,
    FOREIGN KEY (id_video) REFERENCES VIDEO(id),
    FOREIGN KEY (id_premio) REFERENCES PREMIO(id)
);

CREATE TABLE VIDEO_GENERO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_video INT NOT NULL,
    id_genero INT NOT NULL,
    FOREIGN KEY (id_video) REFERENCES VIDEO(id),
    FOREIGN KEY (id_genero) REFERENCES GENERO(id)
);

CREATE TABLE VIDEO_AUDIO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_audio INT NOT NULL,
    id_video INT NOT NULL,
    FOREIGN KEY (id_audio) REFERENCES AUDIO(id),
    FOREIGN KEY (id_video) REFERENCES VIDEO(id)
);

CREATE TABLE VIDEO_SUBTITULO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_subtitulo INT NOT NULL,
    id_video INT NOT NULL,
    FOREIGN KEY (id_subtitulo) REFERENCES SUBTITULO(id),
    FOREIGN KEY (id_video) REFERENCES VIDEO(id)
);

CREATE TABLE SUBCUENTA_GENERO (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_subcuenta INT NOT NULL,
    id_genero INT NOT NULL,
    FOREIGN KEY (id_subcuenta) REFERENCES SUBCUENTA(id),
    FOREIGN KEY (id_genero) REFERENCES GENERO(id)
);

CREATE TABLE PRODUCCION (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    costo DECIMAL(10, 2) NOT NULL,
    id_video INT NOT NULL,
    id_empresa INT NOT NULL,
    FOREIGN KEY (id_video) REFERENCES VIDEO(id),
    FOREIGN KEY (id_empresa) REFERENCES EMPRESA(id)
);
