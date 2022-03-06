--1.La ciudad y el teléfono de las oficinas de Estados Unidos.
    SELECT CIUDAD,TELEFONO,PAIS FROM OFICINAS WHERE PAIS='EEUU';
--2.El nombre, los apellidos y el email de los empleados a cargo de Alberto Soria,
    SELECT CODIGOEMPLEADO, NOMBRE||' '||APELLIDO1 FROM EMPLEADOS WHERE NOMBRE||' '||APELLIDO1 LIKE 'Alberto Soria';
    
    SELECT NOMBRE, APELLIDO1||' '||APELLIDO2 AS APELLIDOS, EMAIL
    FROM EMPLEADOS WHERE CODIGOJEFE=3;
    
    SELECT NOMBRE, APELLIDO1||' '||APELLIDO2 AS APELLIDOS, EMAIL
    FROM EMPLEADOS WHERE CODIGOJEFE=
    (SELECT CODIGOEMPLEADO FROM EMPLEADOS WHERE NOMBRE||' '||APELLIDO1 LIKE 'Aberto Soria');
--3.El cargo, nombre, apellidos y email del jefe de la empresa.
    SELECT PUESTO, NOMBRE, APELLIDO1||APELLIDO2, EMAIL FROM EMPLEADOS WHERE CODIGOJEFE IS NULL;
--4.El nombre, apellidos y cargo que aquellos que no sean representantes de ventas.
    SELECT NOMBRE, APELLIDO1||' '||APELLIDO2 AS APELLIDOS, PUESTO FROM EMPLEADOS WHERE PUESTO != 'Representante Ventas';
--5.El número de clientes que tiene la empresa.
    SELECT COUNT(CODIGOCLIENTE) AS NUMERO_CLIENTES FROM CLIENTES;
--6.El nombre de los clientes españoles.
    SELECT DISTINCT PAIS FROM CLIENTES;
    UPDATE CLIENTES SET PAIS='Spain';
    SELECT NOMBRECLIENTE, PAIS FROM CLIENTES WHERE PAIS='Spain';
--7.¿Cuántos clientes tiene cada país?
    SELECT COUNT(CODIGOCLIENTE), PAIS FROM CLIENTES GROUP BY PAIS;
--8.¿Cuánto clientes tiene la ciudad de Madrid?
    SELECT COUNT(CODIGOCLIENTE), CIUDAD FROM CLIENTES WHERE CIUDAD='Madrid' GROUP BY CIUDAD;
--9.¿Cuántos clientes tienen las ciudadades que empiezan por M?
    SELECT COUNT(CODIGOCLIENTE), CIUDAD FROM CLIENTES WHERE CIUDAD LIKE 'M%' GROUP BY CIUDAD;
--10.El código de empleado y el número de clientes al que atiende cada representante de ventas.
    SELECT CODIGOEMPLEADOREPVENTAS, COUNT(CODIGOCLIENTE) FROM CLIENTES GROUP BY CODIGOEMPLEADOREPVENTAS ORDER BY CODIGOEMPLEADOREPVENTAS;
--11.El número de clientes que no tiene asignado representante de ventas.
    SELECT COUNT(CODIGOCLIENTE) FROM CLIENTES WHERE codigoempleadorepventas IS NULL;
--12.¿Cuál fue el primer y último pago que hizo algún cliente?
    SELECT MAX(FECHAPAGO),MIN(FECHAPAGO) FROM PAGOS;
    SELECT CODIGOCLIENTE FROM PAGOS WHERE TO_CHAR(FECHAPAGO, 'DD/MM/YYYY') IN ('26/03/2009','18/01/2006');
--13.El código de cliente de aquellos que hicieron pagos en 2008.
--14.Los distintos estados por los que puede pasar un pedido.
--15.El número de pedido, código de cliente, fecha requerida y fecha de entrega de los pedidos que no han sido entregados a tiempo.
--16.¿Cuántos productos existen  en cada linea de pedido?
--17.Un listado de los 20 códigos de productos más pedidos ordenado por cantidad pedida. (pista: Usa el filtro LIMIT de MySQL o el filtro rownum de Oracle).
--18.El número de pedido, código de cliente, fecha requerida y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha requerida. (pista: Usar la función AddDate de My¡SQL o el operado + de Oracle).
    SELECT CODIGOPEDIDO, CODIGOCLIENTE, FECHAESPERADA, FECHAENTREGA FROM PEDIDOS WHERE fechaentrega < fechaesperada -2;
--19.La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. NOTA: La base imponible se calcula sumando el coste del producto por el número de unidades vendidas EL IVA, el el 21% de la base imponible, y el total, la suma de los campos anteriores.
    SELECT SUM(CANTIDAD*PRECIOUNIDAD) AS BASEIMPONIBLE, ((SUM(CANTIDAD*PRECIOUNIDAD)*21)/100) AS IVA,
    SUM(CANTIDAD*PRECIOUNIDAD)+((SUM(CANTIDAD*PRECIOUNIDAD)*21)/100) AS TOTAL FROM DETALLEPEDIDOS;
--20.La misma información que la pregunta anterior, pero agrupada por código de producto y filtrada por los código que empiecen por FR.
    SELECT CODIGOPRODUCTO TO_CHAR(SUM
    