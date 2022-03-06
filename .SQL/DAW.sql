DROP TABLE LOCALIDAD CASCADE CONSTRAINTS PURGE;
DROP TABLE PUB CASCADE CONSTRAINTS PURGE;
DROP TABLE EMPLEADO CASCADE CONSTRAINTS PURGE;
DROP TABLE PUB_EMPLEADO CASCADE CONSTRAINTS PURGE;

CREATE TABLE LOCALIDAD (
    COD_LOCALIDAD NUMBER(3),
    NOMBRE VARCHAR2(25),
    CONSTRAINT LOC_PK PRIMARY KEY (COD_LOCALIDAD)
    );
CREATE TABLE PUB (
    COD_PUB NUMBER(2),
    NOMBRE VARCHAR2(25) NOT NULL,
    LICENCIA_FISCAL VARCHAR2(25) NOT NULL,
    DOMICILIO VARCHAR2(50),
    FECHA_DE_APERTURA DATE NOT NULL,
    HORARIO VARCHAR2(50) NOT NULL CHECK (HORARIO IN('HOR1','HOR2','HOR3')),
    COD_LOCALIDAD NUMBER(3),
    CONSTRAINT PUB_PK PRIMARY KEY (COD_PUB),
    CONSTRAINT PUB_FK FOREIGN KEY (COD_LOCALIDAD) REFERENCES LOCALIDAD (COD_LOCALIDAD)
    );
CREATE TABLE EMPLEADO (
    DNI VARCHAR2(9),
    NOMBRE VARCHAR2(50) NOT NULL,
    DOMICILIO VARCHAR2(50),
    CONSTRAINT EMP_PK PRIMARY KEY (DNI)
    );
CREATE TABLE PUB_EMPLEADO (
    COD_PUB NUMBER(2),
    DNI VARCHAR2(9),
    FUNCION VARCHAR2(20) CHECK (FUNCION IN ('CAMARERO','SEGURIDAD','LIMPIEZA')),
    CONSTRAINT PUB_EMP_PK PRIMARY KEY (COD_PUB, DNI, FUNCION),
    CONSTRAINT PUB_EMP_FK FOREIGN KEY (DNI) REFERENCES EMPLEADO(DNI),
    CONSTRAINT PUB_EMP_FK2 FOREIGN KEY (COD_PUB) REFERENCES PUB(COD_PUB)
    );
CREATE TABLE EXISTENCIAS (
    COD_ARTICULO NUMBER,
    NOMBRE VARCHAR2(25) NOT NULL CHECK (NOMBRE =UPPER(NOMBRE)),
    CANTIDAD NUMBER NOT NULL CHECK(CANTIDAD > 0),
    PRECIO NUMBER(6,2) NOT NULL CHECK (PRECIO BETWEEN 0 AND 1000),
    COD_PUB NUMBER(2) REFERENCES PUB(COD_PUB)
    );

    