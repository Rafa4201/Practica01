--1.El c�digo de oficina y la ciudad donde hay oficinas.
    SELECT CODIGOOFICINA, CIUDAD FROM OFICINAS;
    SELECT CODIGOOFICINA, CIUDAD FROM OFICINAS WHERE CIUDAD IS NOT NULL;
--2.Cu�ntos empleados hay en la compa�ia.
    SELECT COUNT(*) AS NUMERO_EMPLEADOS FROM EMPLEADOS;
    SELECT COUNT(CODIGOEMPLEADO) AS NUMERO_EMPLEADOS FROM EMPLEADOS;
--3.Cu�ntos clientes tiene cada pa�s.
    SELECT COUNT(CODIGOCLIENTE), PAIS FROM CLIENTES GROUP BY PAIS;
--4.Cu�l fue el pago medio de 2009 (pista: Usar la funci�n YEAR de mysql o la funci�n to_char(fecha,'yyyy') de Oracle).
    SELECT TO_CHAR(ROUND(AVG(CANTIDAD),2),'FM999G999D99L') FROM PAGOS WHERE TO_CHAR(FECHAPAGO,'YYYY')='2009';
--5.Cu�ntos pedidos est�n en cada estado, ordenado descendente por el n�mero de pedidos.
    SELECT COUNT(CODIGOPEDIDO), ESTADO FROM PEDIDOS GROUP BY ESTADO ORDER BY ESTADO DESC;
--6.El precio del producto m�s caro y m�s barato
    SELECT TO_CHAR(MAX(PRECIOVENTA),'FM999G999L'), TO_CHAR(MIN(PRECIOVENTA),'FM999G999L')
    FROM PRODUCTOS;