USE almacen_the_one;
#  ---- CONSULTAS PARA LA PARTE DE USUARIOS -----
SELECT * FROM tbl_usuarios;


# consulta multitabla de tabla usuario-cliente
SELECT c.id_cliente AS ID, u.nombre_usuario AS Nombre, u.apellido_usuario AS Apellido, u.email_usuario AS EMAIL, u.rol_usuario AS ROL, c.telefono
	FROM tbl_clientes C
INNER JOIN tbl_usuarios u
	ON c.usuario_id = u.id_usuario;


#  ---- CONSULTAS PARA LA PARTE DE PRODUCTOS -----

# SELEC DE CATEGORIAS
SELECT * FROM tbl_categorias;


# SELECT DE PROVEEDORES
SELECT * FROM tbl_proveedores;


# SELECT DE PRODUCTOS
# consulta multitabla que muestra la tabla de productos.
SELECT p.id_producto AS ID, pdor.nombre_proveedor AS PROVEEDOR, c.nombre_categoria AS CATEGORIA, 
	   s.cantidad AS STOCK, p.nombre_producto AS NOMBRE, p.precio_producto AS PRECIO
	FROM tbl_productos p
INNER JOIN tbl_stock s 
    ON p.stock_id = s.id_stock
INNER JOIN tbl_proveedores pdor 
    ON p.proveedor_id = pdor.id_proveedor
INNER JOIN tbl_categorias c 
    ON p.categoria_id = c.id_categoria;
    
    

# CONSULTA DE VENTAS MULTITABLA

SELECT v.id_venta AS ID, u.nombre_usuario AS CLIENTE, p.nombre_producto AS PRODUCTO, v.cantidad_compra AS CANTIDAD, 
		v.precio_unitario AS 'PRECIO UNITARIO', v.forma_pago AS 'FORMA DE PAGO', v.descuento AS DESCUENTO, v.monto_total AS 'MONTO TOTAL', v.fecha_venta AS FECHA
	FROM tbl_ventas v
INNER JOIN tbl_clientes cli
	ON v.cliente_id = cli.id_cliente
INNER JOIN tbl_usuarios u
	ON cli.usuario_id = u.id_usuario
INNER JOIN tbl_productos p
	ON v.producto_id = p.id_producto;

#  CONSULTA DE PEDIDOS MULTITABLA

SELECT p2.id_pedido AS ID, pdor.nombre_proveedor AS PROVEEDOR, pto.nombre_producto AS PRODUCTO,
	u.nombre_usuario AS USUARIO, p2.cantidad_pedido AS CANTIDAD, p2.fecha_pedido AS FECHA
	FROM tbl_pedidos p2
INNER JOIN tbl_proveedores pdor
	ON p2.proveedor_id = pdor.id_proveedor
INNER JOIN tbl_productos pto
	ON p2.producto_id = pto.id_producto
INNER JOIN tbl_usuarios u
	ON p2.usuario_id = u.id_usuario;



# consulta de inventario multitabla
SELECT i.id_inventario AS ID, pto.nombre_producto AS PRODUCTO, c.nombre_categoria AS CATEGORIA, 
		p2.cantidad_pedido AS ENTRADAS, v.cantidad_compra AS SALIDAS, s.cantidad AS STOCK
	FROM tbl_inventarios i
INNER JOIN  tbl_productos pto
	ON i.producto_id = pto.id_producto
INNER JOIN tbl_categorias c
	ON	i.categoria_id = c.id_categoria
INNER JOIN tbl_pedidos p2
	ON i.pedido_id = p2.id_pedido
INNER JOIN tbl_ventas v
	ON i.venta_id = v.id_venta
INNER JOIN tbl_stock s
	ON i.stock_id = s.id_stock




    