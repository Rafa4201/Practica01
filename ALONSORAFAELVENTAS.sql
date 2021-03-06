--Ejercicios Unidad 4

--Rafael Alonso Cepeda



use ventas;

--1. Devuelve un listado con todos los pedidos que se han realizado. Los pedidos deben estar ordenados por la fecha de realizaci?n, mostrando en primer lugar los pedidos m?s recientes.
select * from pedido group by fecha order by fecha;

--2. Devuelve todos los datos de los dos pedidos de mayor valor.
select * from pedido order by total desc limit 2;

--3. Devuelve un listado con los identificadores de los clientes que han realizado alg?n pedido. Tenga en cuenta que no debe mostrar identificadores que est?n repetidos.
select distinct id_cliente from pedido;

--4. Devuelve un listado de todos los pedidos que se realizaron durante el a?o 2017, cuya cantidad total sea superior a 500?.
select * from pedido where year(fecha)=2017 AND total >=500;

--5. Devuelve un listado con el nombre y los apellidos de los comerciales que tienen una comisi?n entre 0.05 y 0.11.
select * from comercial where comision between 0.05 and 0.11;

--6. Devuelve el valor de la comisi?n de mayor valor que existe en la tabla comercial.
select max(comision) from comercial;

--7. Devuelve el identificador, nombre y primer apellido de aquellos clientes cuyo segundo apellido no es NULL. El listado deber? estar ordenado alfab?ticamente por apellidos y nombre.
select id, nombre, apellido1 from cliente where apellido2 is not null order by nombre,apellido1;

--8. Devuelve un listado de los nombres de los clientes que empiezan por A y terminan por n y tambi?n los nombres que empiezan por P. El listado deber? estar ordenado alfab?ticamente.
select nombre from cliente where nombre like 'A%n' or nombre like 'P%' order by nombre;

--9. Devuelve un listado de los nombres de los clientes que no empiezan por A. El listado deber? estar ordenado alfab?ticamente.
select nombre from cliente where nombre not like 'A%' order by nombre;

--10. Devuelve un listado con los nombres de los comerciales que terminan por el o o. Tenga en cuenta que se deber?n eliminar los nombres repetidos.
select distinct nombre from comercial where nombre like '%el' or nombre like '%o' order by nombre;
---------------------------------------------------------------------------------------------------------------------------------------
--1. Devuelve un listado con el identificador, nombre y los apellidos de todos los clientes que han realizado alg?n pedido. El listado debe estar ordenado alfab?ticamente 
--y se deben eliminar los elementos repetidos.
select distinct cliente.id, nombre, apellido1, apellido2 from cliente, pedido where cliente.id = pedido.id_cliente order by nombre;

--2. Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. El resultado debe mostrar todos los datos de los pedidos y del cliente. 
--El listado debe mostrar los datos de los clientes ordenados alfab?ticamente.
select * from comercial, pedido where comercial.id = pedido.id_comercial order by nombre;

--3. Devuelve un listado que muestre todos los pedidos en los que ha participado un comercial. El resultado debe mostrar todos los datos de los pedidos y de los comerciales.
--El listado debe mostrar los datos de los comerciales ordenados alfab?ticamente.
select * from cliente, pedido, comercial where cliente.id = pedido.id_cliente and pedido.id_comercial = comercial.id order by comercial.nombre;

--4. Devuelve un listado que muestre todos los clientes, con todos los pedidos que han realizado y con los datos de los comerciales asociados a cada pedido.
select * from cliente, pedido, comercial where cliente.id = pedido.id_cliente order by cliente.nombre;

--5. Devuelve un listado de todos los clientes que realizaron un pedido durante el a?o 2017, cuya cantidad est? entre 300 ? y 1000 ?.
select * from cliente, pedido where cliente.id = pedido.id_cliente and year(fecha) = 2017 and total between 300 and 1000;

--6. Devuelve el nombre y los apellidos de todos los comerciales que ha participado en alg?n pedido realizado por Mar?a Santana Moreno.
select cnombre, apellido1, apellido2 from comercial, pedido where comercial.id = pedido.id_comercial and pedido.id_cliente = 6;

--7. Devuelve el nombre de todos los clientes que han realizado alg?n pedido con el comercial Daniel S?ez Vega.
select nombre, apellido1, apellido2 from cliente, pedido where cliente.id = pedido.id_cliente and pedido.id_comercial = 1;
--------------------------------------------------------------------------------------------------------------------------------------

--1. Devuelve un listado con todos los clientes junto con los datos de los pedidos que han realizado. Este listado tambi?n debe incluir los clientes que no han realizado ning?n pedido.
--El listado debe estar ordenado alfab?ticamente por el primer apellido, segundo apellido y nombre de los clientes.
select * from cliente left join pedido on cliente.id = pedido.id_cliente order by apellido1, apellido2, nombre;

--2. Devuelve un listado con todos los comerciales junto con los datos de los pedidos que han realizado. Este listado tambi?n debe incluir los comerciales que no han realizado ning?n pedido.
--El listado debe estar ordenado alfab?ticamente por el primer apellido, segundo apellido y nombre de los comerciales.
select * from comercial left join pedido on comercial.id = pedido.id_comercial order by apellido1, apellido2, nombre;

--3. Devuelve un listado que solamente muestre los clientes que no han realizado ning?n pedido.
select * from cliente left join pedido on cliente.id = pedido.id_cliente where pedido.id is null order by apellido1, apellido2, nombre;

--4. Devuelve un listado que solamente muestre los comerciales que no han realizado ning?n pedido.
select * from comercial left join pedido on comercial.id = pedido.id_comercial where pedido.id is null order by apellido1, apellido2, nombre;

--5. Devuelve un listado con los clientes que no han realizado ning?n pedido y de los comerciales que no han participado en ning?n pedido. Ordene el listado alfab?ticamente por los apellidos y el nombre.
--En en listado deber? diferenciar de alg?n modo los clientes y los comerciales.
select nombre as comercial_n, apellido1 as comercial_a from comercial left join pedido on comercial.id = pedido.id_comercial where pedido.id is null union all
select nombre as cliente_n, apellido1 as cliente_a from cliente left join pedido on cliente.id = pedido.id_cliente where pedido.id is null;
----yo creo que no se podria usar natural join debido a que el campo id en la tabla pedido y cliente/comercial tiene el mismo nombre
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--1. Calcula la cantidad total que suman todos los pedidos que aparecen en la tabla pedido.
select sum(total) as total from pedido;

--2. Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido.
select avg(total) as total from pedido;

--3. Calcula el n?mero total de comerciales distintos que aparecen en la tabla pedido.
select count(distinct id_comercial) from pedido;

--4. Calcula el n?mero total de clientes que aparecen en la tabla cliente.
select max(total) from pedido;

--5. Calcula cu?l es la mayor cantidad que aparece en la tabla pedido.
select min(total) from pedido;

--6. Calcula cu?l es la menor cantidad que aparece en la tabla pedido.
select max(categoria), ciudad from cliente group by ciudad;

--7. Calcula cu?l es el valor m?ximo de categor?a para cada una de las ciudades que aparece en la tabla cliente.
select max(total), id_cliente, fecha from pedido group by fecha;

--8. Calcula cu?l es el m?ximo valor de los pedidos realizados durante el mismo d?a para cada uno de los clientes.
--Es decir, el mismo cliente puede haber realizado varios pedidos de diferentes cantidades el mismo d?a. 
--Se pide que se calcule cu?l es el pedido de m?ximo valor para cada uno de los d?as en los que un cliente ha realizado un pedido.
--Muestra el identificador del cliente, nombre, apellidos, la fecha y el valor de la cantidad.
select max(total), id_cliente, fecha from pedido group by fecha;

--9. Calcula cu?l es el m?ximo valor de los pedidos realizados durante el mismo d?a para cada uno de los clientes, teniendo en cuenta que s?lo
--queremos mostrar aquellos pedidos que superen la cantidad de 2000 ?.
select max(total), id_cliente, fecha from pedido where total >= 2000 group by fecha;

--10. Calcula el m?ximo valor de los pedidos realizados para cada uno de los comerciales durante la fecha 2016-08-17. Muestra el identificador del comercial, nombre, apellidos y total.
select comercial.id, nombre, apellido1, apellido2, max(total) from comercial join pedido on comercial.id = pedido.id_comercial where fecha = '2016-08-17' group by nombre;

--11. Devuelve un listado con el identificador de cliente, nombre y apellidos y el n?mero total de pedidos que ha realizado cada uno de clientes.
--Tenga en cuenta que pueden existir clientes que no han realizado ning?n pedido.
--Estos clientes tambi?n deben aparecer en el listado indicando que el n?mero de pedidos realizados es 0.
select cliente.id, nombre,apellido1,apellido2,count(pedido.id) from cliente left join pedido on cliente.id = pedido.id_cliente group by nombre;

--12. Devuelve un listado con el identificador de cliente, nombre y apellidos y el n?mero total de pedidos que ha realizado cada uno de clientes durante el a?o 2017.
select cliente.id, nombre,apellido1,apellido2,count(pedido.id) from cliente left join pedido on cliente.id = pedido.id_cliente where year(fecha) = 2017 group by nombre;

--13. Devuelve un listado que muestre el identificador de cliente, nombre, primer apellido y el valor de la m?xima cantidad del pedido realizado por cada uno de los clientes.
--El resultado debe mostrar aquellos clientes que no han realizado ning?n pedido indicando que la m?xima cantidad de sus pedidos realizados es 0. Puede hacer uso de la funci?n IFNULL.
select cliente.id, nombre,apellido1,apellido2,ifnull(max(total), 0) from cliente left join pedido on cliente.id = pedido.id_cliente group by nombre;

--Devuelve cu?l ha sido el pedido de m?ximo valor que se ha realizado cada a?o.
select id, max(total), year(fecha) as a?o from pedido group by a?o;

--15. Devuelve el n?mero total de pedidos que se han realizado cada a?o.
select count(id), year(fecha) as a?o from pedido group by a?o;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--1. Devuelve un listado con todos los pedidos que ha realizado Adela Salas D?az. (Sin utilizar INNER JOIN).
select * from pedido where id_cliente = (select id from cliente where nombre = 'Adela');

--2. Devuelve el n?mero de pedidos en los que ha participado el comercial Daniel S?ez Vega. (Sin utilizar INNER JOIN)
select count(id) from pedido where id_comercial = (select id from comercial where nombre = 'Daniel');

--3. Devuelve los datos del cliente que realiz? el pedido m?s caro en el a?o 2019. (Sin utilizar INNER JOIN)
select * from cliente where id = (select id_cliente from (select id_cliente, max(total) as total, fecha from pedido group by year(fecha)) as totales where year(fecha) = 2019);

--4. Devuelve la fecha y la cantidad del pedido de menor valor realizado por el cliente Pepe Ruiz Santana.
select min(total), fecha from pedido where id_cliente = (select id from cliente where nombre = 'Pepe');

--5. Devuelve un listado con los datos de los clientes y los pedidos, de todos los clientes que han realizado un pedido durante el a?o 2017 con un valor mayor
--o igual al valor medio de los pedidos realizados durante ese mismo a?o.
select* from (select * from pedido where total >= (select avg(total) from pedido where year(fecha)=2017)) as pedidos inner join cliente on pedidos.id_cliente = cliente.id where year(fecha) = 2017;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--1. Devuelve el pedido m?s caro que existe en la tabla pedido si hacer uso de MAX, ORDER BY ni LIMIT.
select * from pedido where total >= all(select total from pedido);

--2. Devuelve un listado de los clientes que no han realizado ning?n pedido. (Utilizando ANY o ALL).
select * from cliente where id != all(select id_cliente from pedido);

--3. Devuelve un listado de los comerciales que no han realizado ning?n pedido. (Utilizando ANY o ALL).
select * from comercial where id != all(select id_comercial from pedido);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--1. Devuelve un listado de los clientes que no han realizado ning?n pedido. (Utilizando IN o NOT IN).
select * from cliente where id not in (select id_cliente from pedido);

--2. Devuelve un listado de los comerciales que no han realizado ning?n pedido. (Utilizando IN o NOT IN).
select * from comercial where id not in (select id_comercial from pedido);
---------------------------------------------------------------------------------------------------------
--1. Devuelve un listado de los clientes que no han realizado ning?n pedido. (Utilizando EXISTS o NOT EXISTS).
select * from cliente where not exists (select * from pedido where cliente.id = pedido.id_cliente);

--2. Devuelve un listado de los comerciales que no han realizado ning?n pedido. (Utilizando EXISTS o NOT EXISTS).
select * from comercial where not exists (select * from pedido where comercial.id = pedido.id_comercial);