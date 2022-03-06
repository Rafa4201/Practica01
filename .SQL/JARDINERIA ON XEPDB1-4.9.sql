--1.El nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
    SELECT C.CODIGOCLIENTE,C.NOMBRECLIENTE AS CLIENTE,
    E.NOMBRE||' '||E.APELLIDO1 AS REPRESENTANTE,
    O.CIUDAD
    FROM CLIENTES C INNER JOIN
    EMPLEADOS E
    ON C.CODIGOEMPLEADOREPVENTAS=E.CODIGOEMPLEADO
    INNER JOIN OFICINAS O
    ON O.CODIGOOFICINA=E.CODIGOOFICINA;
--2.La misma informaci�n que en la pregunta anterior pero solo los clientes que no hayan hecho pagos.
    SELECT C.CODIGOCLIENTE,C.NOMBRECLIENTE AS CLIENTE,
    E.NOMBRE||' '||E.APELLIDO1 AS REPRESENTANTE,
    O.CIUDAD
    FROM CLIENTES C INNER JOIN
    EMPLEADOS E
    ON C.CODIGOEMPLEADOREPVENTAS=E.CODIGOEMPLEADO
    INNER JOIN OFICINAS O
    ON O.CODIGOOFICINA=E.CODIGOOFICINA
    AND C.CODIGOCLIENTE NOT IN (SELECT DISTINCT CODIGOCLIENTE FROM PAGOS);
--3.Un listado con el nombre de los empleados junto con el nombre de sus jefes.
    SELECT E.NOMBRE||' '||E.APELLIDO1 AS EMPLEADO, J.NOMBRE||' '||J.APELLIDO1 AS JEFE
    FROM EMPLEADOS E INNER JOIN EMPLEADOS J
    ON E.CODIGOJEFE=J.CODIGOEMPLEADO;
--4.El nombre de los clientes a los que no se les ha entregado a tiempo un pedido (FechaEntrega>Fecha esperada)
    SELECT DISTINCT CLIENTES.NOMBRECLIENTE
    FROM CLIENTES NATURAL JOIN PEDIDOS
    WHERE PEDIDOS.FECHAENTREGA>PEDIDOS.FECHAESPERADA;