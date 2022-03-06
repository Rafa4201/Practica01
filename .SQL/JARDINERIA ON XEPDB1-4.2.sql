--1.El código de oficina y la ciudad donde hay oficinas.
    SELECT CODIGOOFICINA, CIUDAD FROM OFICINAS;
    SELECT CODIGOOFICINA, CIUDAD FROM OFICINAS WHERE CIUDAD IS NOT NULL;
--2.Cuántos empleados hay en la compañia.
    SELECT COUNT(*) AS NUMERO_EMPLEADOS FROM EMPLEADOS;
    SELECT COUNT(CODIGOEMPLEADO) AS NUMERO_EMPLEADOS FROM EMPLEADOS;
--3.Cuántos clientes tiene cada país.
    SELECT COUNT(CODIGOCLIENTE), PAIS FROM CLIENTES GROUP BY PAIS;
--4.Cuál fue el pago medio de 2009 (pista: Usar la función YEAR de mysql o la función to_char(fecha,'yyyy') de Oracle).
    SELECT TO_CHAR(ROUND(AVG(CANTIDAD),2),'FM999G999D99L') FROM PAGOS WHERE TO_CHAR(FECHAPAGO,'YYYY')='2009';
--5.Cuántos pedidos están en cada estado, ordenado descendente por el número de pedidos.
    SELECT COUNT(CODIGOPEDIDO), ESTADO FROM PEDIDOS GROUP BY ESTADO ORDER BY ESTADO DESC;
--6.El precio del producto más caro y más barato
    SELECT TO_CHAR(MAX(PRECIOVENTA),'FM999G999L'), TO_CHAR(MIN(PRECIOVENTA),'FM999G999L')
    FROM PRODUCTOS;