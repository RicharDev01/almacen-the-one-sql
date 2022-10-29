
#  ---- CONSULTAS PARA LA PARTE DE USUARIOS -----
SELECT * FROM tbl_usuarios;

# consulta multitabla de tabla usuario-cliente
SELECT c.id_cliente AS ID, u.nombre_usuario AS Nombre, u.apellido_usuario AS Apellido, u.email_usuario AS EMAIL, u.rol_usuario AS ROL, c.telefono
	FROM tbl_clientes C
INNER JOIN tbl_usuarios u
	ON c.usuario_id = u.id_usuario;


#  ---- CONSULTAS PARA LA PARTE DE PRODUCTOS -----

SELECT * FROM tbl_categorias;

# consulta multitabla que muestra la tabla de productos.
SELECT p.id_producto AS ID, pdor.nombre_proveedor AS proveedor, c.nombre_categoria AS categoria, 
	   s.cantidad, p.nombre_producto AS nombre, p.precio_producto AS precio 
	FROM tbl_productos p
INNER JOIN tbl_stock s 
    ON p.stock_id = s.id_stock
INNER JOIN tbl_proveedores pdor 
    ON p.proveedor_id = pdor.id_proveedor
INNER JOIN tbl_categorias c 
    ON p.categoria_id = c.id_categoria;