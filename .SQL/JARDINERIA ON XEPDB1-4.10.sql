--1.Un listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado.
    SELECT NOMBRECLIENTE, CODIGOCLIENTE, COUNT(*) AS NUMERO_PEDIDOS
    FROM PEDIDOS NATURAL JOIN CLIENTES
    GROUP BY NOMBRECLIENTE, CODIGOCLIENTE;
--2.Un listado con los nombres de los clientes y el total pagado por cada uno de ellos.
    SELECT NOMBRECLIENTE, SUM(CANTIDAD)
    FROM PAGOS NATURAL JOIN CLIENTES
    GROUP BY NOMBRECLIENTE;
    
    SELECT NOMBRECLIENTE, CLIENTES.CODIGOCLIENTE, SUM(CANTIDAD)
    FROM PAGOS RIGHT JOIN CLIENTES
    ON CLIENTES.CODIGOCLIENTE=PAGOS.CODIGOCLIENTE
    GROUP BY NOMBRECLIENTE, CLIENTES.CODIGOCLIENTE;
--3.El nombre de los clientes que hayan hecho pedidos en 2008.
    SELECT DISTINCT NOMBRECLIENTE
    FROM CLIENTES NATURAL JOIN PEDIDOS
    WHERE TO_CHAR (FECHAPEDIDO, 'YYYY')=2008;
--4.El nombre del cliente y el nombre y apellido de sus representantes de aquellos clientes que no hayan realizado pagos.
    SELECT DISTINCT NOMBRECLIENTE, NOMBRE||' '||APELLIDO1 AS REPRESENTANTE
    FROM CLIENTES INNER JOIN EMPLEADOS
    ON CLIENTES.CODIGOEMPLEADOREPVENTAS=EMPLEADOS.CODIGOEMPLEADO
    AND CODIGOCLIENTE NOT IN (SELECT DISTINCT CODIGOCLIENTE FROM PAGOS);
--5.Un listado de clientes donde apareza el nombre de su comercial y la ciudad donde está su oficina.
    SELECT NOMBRECLIENTE, NOMBRE AS COMERCIAL, OFICINAS.CIUDAD
    FROM EMPLEADOS INNER JOIN CLIENTES
    ON EMPLEADOS.CODIGOEMPLEADO=CLIENTES.CODIGOEMPLEADOREPVENTAS
    INNER JOIN OFICINAS
    ON EMPLEADOS.CODIGOOFICINA=OFICINAS.CODIGOOFICINA;
--6.El nombre, apellidos, oficina y cargo de aquellos que no sean representantes de ventas
    SELECT NOMBRE, APELLIDO1||' '||APELLIDO2 AS APELLIDOS, PUESTO, CODIGOOFICINA
    FROM EMPLEADOS NATURAL JOIN OFICINAS
    --ON EMPLEADOS.CODIGOOFICINA=OFICINAS.CODIGOOFICINA
    WHERE UPPER(PUESTO) <>'REPRESENTANTE VENTAS';
--7.Cuántos empleados tiene cada oficina, mostrando el nombre de la ciudad donde está la oficina.
    SELECT CIUDAD, COUNT(CODIGOEMPLEADO) AS NUMERO_EMPLEADOS
    FROM OFICINAS NATURAL JOIN EMPLEADOS
    GROUP BY CIUDAD;
--8.Un listado con el nombre de los empleados y el nombre de sus respectivos jefes.
    SELECT E.NOMBRE EMPLEADO, J.NOMBRE JEFE
    FROM EMPLEADOS E INNER JOIN EMPLEADOS J
    ON E.CODIGOJEFE=J.CODIGOEMPLEADO;
--9.El nombre, apellido, oficina (ciudad) y cargo del empleado que no represente a ningún cliente.
    SELECT EMPLEADOS.NOMBRE, 
    EMPLEADOS.APELLIDO1||' '||EMPLEADOS.APELLIDO2 APELLIDOS,
    EMPLEADOS.PUESTO, OFICINAS.CIUDAD
    FROM EMPLEADOS NATURAL JOIN OFICINAS
    WHERE EMPLEADOS.CODIGOEMPLEADO NOT IN
    (SELECT DISTINCT CLIENTES.CODIGOEMPLEADOREPVENTAS
    FROM CLIENTES);
--10.La media de unidades en stock, de los productos agrupados por gama.
    SELECT ROUND(AVG(CANTIDADENSTOCK),2), GAMA
    FROM PRODUCTOS
    GROUP BY GAMA;
--11.Los clientes que residan en la misma ciudad donde hay oficina, indicando dónde está la oficina.
    SELECT NOMBRECLIENTE, CIUDAD
    FROM CLIENTES
    WHERE CIUDAD IN(SELECT DISTINCT CIUDAD FROM OFICINAS);
--12.Los clientes que residan en la misma ciudad donde no hay oficinas, ordenado por la ciudad donde residan.
    SELECT NOMBRECLIENTE, CIUDAD
    FROM CLIENTES
    WHERE CIUDAD NOT IN(SELECT DISTINCT CIUDAD FROM OFICINAS)
    ORDER BY CIUDAD;
--13.El número de clientes que tiene asignado cada representante de ventas.
    SELECT COUNT(*), CODIGOEMPLEADOREPVENTAS
    FROM CLIENTES
    GROUP BY CODIGOEMPLEADOREPVENTAS
    ORDER BY CODIGOEMPLEADOREPVENTAS;
--14.Cuál fue el cliente que hizo el pago con mayor cuantía y el que hizo el pago con menor cuantía.
    SELECT NOMBRECLIENTE, CANTIDAD
    FROM CLIENTES NATURAL JOIN PAGOS
    WHERE CANTIDAD=
    (SELECT MAX(CANTIDAD) FROM PAGOS)
    OR CANTIDAD=
    (SELECT MIN(CANTIDAD) FROM PAGOS);
--15.Un listado con el precio total de cada pedido.
    SELECT SUM(CANTIDAD*PRECIOUNIDAD) AS TOTAL, CODIGOPEDIDO
    FROM DETALLEPEDIDOS
    GROUP BY CODIGOPEDIDO;
--16.Los clientes que hayan hecho pedidos en 2008 por una cuantía superior a 2000 €.
    SELECT SUM(CANTIDAD*PRECIOUNIDAD) AS CUANTIA, CODIGOPEDIDO, NOMBRECLIENTE, FECHAPEDIDO
    FROM DETALLEPEDIDOS NATURAL JOIN PEDIDOS NATURAL JOIN CLIENTES
    WHERE TO_CHAR(FECHAPEDIDO,'YYYY')=2008
    GROUP BY CODIGOPEDIDO, NOMBRECLIENTE, FECHAPEDIDO
    HAVING SUM(CANTIDAD*PRECIOUNIDAD)>2000;
--17.¿Cuántos pedidos tiene cada cliente en cada estado?
    select count(codigopedido), estado, codigocliente, nombrecliente
    from pedidos natural join clientes
    group by codigocliente, estado, nombrecliente;
--18.Los clientes que han pedido más de 200 unidades de cualquier producto.
    