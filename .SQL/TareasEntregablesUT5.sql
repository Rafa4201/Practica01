





--ACTIVIDAD 5.1:
--1.Insertar una oficina con sede en Murcia y otra en Alicante.
    INSERT INTO OFICINAS
    (CODIGOOFICINA,CIUDAD,PAIS,REGION,CODIGOPOSTAL,TELEFONO,LINEADIRECCION1)
    VALUES
    ('MU-ES','MURCIA','ESPAÑA','MURCIA','30009','968222222','GRAN VIA, 1');
    
    INSERT INTO OFICINAS
    (CODIGOOFICINA,CIUDAD,PAIS,REGION,CODIGOPOSTAL,TELEFONO,LINEADIRECCION1)
    VALUES
    ('A-ES','ALICANTE','ESPAÑA','ALICANTE','03005','966222323','CARRER DE LAS FONTS, 24');
--2.Insertar un empleado para la oficina de Murcia que sea representante de ventas y otro para la oficina de Alicante.
    INSERT INTO EMPLEADOS (CODIGOEMPLEADO, NOMBRE,APELLIDO1,APELLIDO2,EXTENSION,EMAIL,CODIGOOFICINA,
    CODIGOJEFE,PUESTO)
    VALUES(32,'Daniel','Lorca','Sánchez','3322','daniell@riberadeltajo.es',
    'MU-ES','26','Representante Ventas');
    
    INSERT INTO EMPLEADOS (CODIGOEMPLEADO, NOMBRE,APELLIDO1,APELLIDO2,EXTENSION,EMAIL,CODIGOOFICINA,
    CODIGOJEFE,PUESTO)
    VALUES(33,'Celeste','Cervera','Morga','3344','celeste@riberadeltajo.es',
    'A-ES','26','Representante Ventas');
--3.Insertar un cliente para estos representante de ventas.
    INSERT INTO CLIENTES
    VALUES(39, 'BRITISH GARDEN, S.L.','Martina','Romero','655555555','968222222',
    'Paseo Luis Cernuda','','Murcia','Murcia','España','30005',32,15000);
    
    INSERT INTO CLIENTES
    VALUES(40,'EL JARDIN DE LORENA, S.L.','Vera','López','635444444','96333333',
    'Jorge Manrique',NULL,'Alicante','Alicante','España','03005',33,14000);
--4.Inserta un pedido de los clientes anteriores (con su detalle) de al menos 2 productos con una transacción.
    SELECT MAX(CODIGOPEDIDO) FROM PEDIDOS;
    
    SET AUTOCOMMIT=0; 
    
    INSERT INTO PEDIDOS 
    (CODIGOPEDIDO,FECHAPEDIDO,FECHAESPERADA,ESTADO,CODIGOCLIENTE)
    VALUES(129,'2020-02-16','2020-02-18','Pendiente',39);
 
    INSERT INTO DETALLEPEDIDOS
    VALUES(129,'FR-67',12,70,3);
    
    INSERT INTO DETALLEPEDIDOS
    VALUES(129,'FR-4',4,29,3);
    
    COMMIT;
    
    use jardineria;
    
    SELECT CODIGOPEDIDO,FECHAPEDIDO,ESTADO, CODIGOPRODUCTO, CANTIDAD
    FROM DETALLEPEDIDOS NATURAL JOIN PEDIDOS
    WHERE CODIGOPEDIDO=130;
--5.Borra los clientes y verifica si hubo cambios.
    DELETE FROM CLIENTES WHERE CODIGOCLIENTE=39;

    DELETE FROM CLIENTES WHERE CODIGOCLIENTE=40;





--ACTIVIDAD 5.2

--Usa subconsultas en los filtros y realiza las siguientes actualizaciones y borrados:

--1.Borra los clientes que no tengan pedidos.
    delete from clientes 
    where codigocliente 
    not in 
    (select distinct codigocliente 
    from pedidos);
--2.Incrementa en un 20% el precio de los productos que no tengan pedidos.
    update productos set precioventa=precioventa/1.20 
    where codigoproducto 
    not in 
    (select distinct codigoproducto 
    from productos);
--3.Borra los pagos del cliente con menor límite de crédito.
    delete from pagos 
    where codigoclientes = 
    (select codgigocliente from clientes 
    where limitecredito = (select min(limiteprecio) from clientes));
--4.Establece a 0 el límited de crédito del cliente que menos unidades pedidas tenga del producto 'OR-179'.
    UPDATE CLIENTES
    SET LIMITECREDITO=0
    WHERE CODIGOCLIENTE=
    (SELECT CODIGOCLIENTE
    FROM PEDIDOS NATURAL JOIN DETALLEPEDIDOS
    WHERE CANTIDAD=
    (SELECT MIN(CANTIDAD)
    FROM DETALLEPEDIDOS
    WHERE CODIGOPRODUCTO='OR-179')
    AND CODIGOPRODUCTO='OR-179');
    




--ACTIVIDAD 5.4 (BD Jardinería MySQL): 

--1.Modifica la tabla DetallePedido para insertar un campo numérico llamado IVA. Mediante una transacción, establece el valor
--de ese campo a 18 para aquellos registros cuyo pedido tenga fecha a partir de Julio de 2010. A continuación actualiza el resto 
--de pedidos estableciendo el IVA al 21.
    ALTER TABLE DETALLEPEDIDOS
    ADD COLUMN IVA INTEGGER(2) NOT NULL;
    
    SET AUTOCOMMIT=0;
    
    UPDATE DETALLEPEDIDOS
    SET IVA=18
    WHERE CODIGOPEDIDO IN
    (SELECT CODIGOPEDIDO
    FROM PEDIDOS
    WHERE FECHAPEDIDO < '2010-07-01');
--2.Modifica la tabla DetallePedido para incorporar un campo numérico llamado TotalLinea, y actualiza todos sus registros 
--para calcular su valor con la fórmula TotalLInea=(PrecioUnidad*Cantidad)+(PrecioUnidad*Cantidad*(IVA/100)).
    ALTER TABLE DETALLEPEDIDOS
    ADD COLUMN TOTALLINEA DECIMAL(9,2);
    
    UPDATE DETALLEPEDIDOS
    SET TOTALLINEA=(PrecioUnidad*Cantidad)+(PrecioUnidad*Cantidad*(IVA/100));
    
    SELECT * FROM DETALLEPEDIDOS;
--3.Borra el cliente que menor límite de crédito tenga. ¿Es posible borrarlo sólo con una consulta?¿Por qué?
    DELETE FROM PAGOS WHERE CODIGOCLIENTE=
    (SELECT CODIGOCLIENTE FROM CLIENTES WHERE LIMITECREDITO=(SELECT MIN(LIMITECREDITO) FROM CLIENTES));
    
    DELETE FROM PEDIDOS WHERE CODIGOCLIENTE=
    (SELECT CODIGOCLIENTE FROM CLIENTES WHERE LIMITECREDITO=(SELECT MIN(LIMITECREDITO) FROM CLIENTES));
    
    DELETE FROM DETALLEPEDIDOS WHERE CODIGOPEDIDO=ANY 
    (SELECT CODIGOPEDIDO FROM PEDIDOS WHERE CODIGOCLIENTE=(SELECT CODIGOCLIENTE 
    FROM CLIENTES WHERE LIMITECREDITO=(SELECT MIN(LIMITECREDITO) FROM CLIENTES)));
    
    DELETE FROM CLIENTES 
    WHERE LIMITECREDITO=(SELECT MIN(LIMITECREDITO) FROM CLIENTES);
--4.Inserta dos clientes nuevos para un empleado a tu elección. A continuación inserta un pedido con al menos 3 líneas de 
--detalle Después, ejecuta una consulta para rebajar en un 5% el precio de los productos que sean más caros de 200 €.
    INSERT INTO PEDIDOS VALUES (132,'2020-02-16','2020-02-18','20-02-18','Pendiente','NO',40); 
    
    INSERT INTO 
    DETALLEPEDIDOS 
    (CODIGOPEDIDO, CODIGOPRODUCTO, CANTIDAD, PRECIOUNIDAD, NUMEROLINEA, IVA,TOTALLINEA) VALUES (129,'OR-117',7,20,5,21,1500); 
    
    INSERT INTO 
    DETALLEPEDIDOS 
    (CODIGOPEDIDO, CODIGOPRODUCTO, CANTIDAD, PRECIOUNIDAD, NUMEROLINEA, IVA,TOTALLINEA) VALUES (129,'OR-116',7,20,3,21,1500);
    
    INSERT INTO DETALLEPEDIDOS 
    (CODIGOPEDIDO, CODIGOPRODUCTO, CANTIDAD, PRECIOUNIDAD, NUMEROLINEA, IVA,TOTALLINEA) VALUES (129,'OR-115',7,20,3,21,1500);
    
    UPDATE PRODUCTOS SET PRECIOVENTA = (PRECIOVENTA - (PRECIOVENTA*(5/100))) 
    WHERE CODIGOPRODUCTO IN (SELECT DISTINCT CODIGOPRODUCTO 
    FROM PRODUCTOS 
    WHERE PRECIOVENTA > 200);





