show databases;

create database VETERINARIA;

USE VETERINARIA;

CREATE TABLE MASCOTAS(
    CODIGO INT(11) PRIMARY KEY,
    NOMBRE VARCHAR(50),
    RAZA VARCHAR(50) DEFAULT 'Gato comun',
    CLIENTE VARCHAR(9)
);

INSERT INTO MASCOTAS
(CODIGO,NOMBRE,RAZA,CLIENTE)
VALUES
(2,'Garfield',DEFAULT,'12345678C');

INSERT INTO MASCOTAS
(CODIGO,NOMBRE,RAZA,CLIENTE)
VALUES
(2,'Cora',DEFAULT,'12542176H');

SELECT * FROM MASCOTAS;




