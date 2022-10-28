
-- ## INSERT'S DE LA BASE DE DATOS. ## 
USE almacen_the_one;
## INSERT INTO tbl_name (column1, column2) VALUES(value1, value2);

## rol_usuario 		ENUM('Admin', 'Vendedor', 'Cliente'),
INSERT INTO tbl_usuarios(nombre_usuario, apellido_usuario, email_usuario, password_usuario, rol_usuario) 
				VALUE('Ricardo', 'Pineda', 'rpineda@mail.com', 'admin', 'Admin'),
                ('Jorge', 'Ramirez', 'jramirez@mail.com', 'cliente', 'Cliente');
                
                
INSERT INTO tbl_clientes(usuario_id, telefono) 
					VALUE(2, '7600-5000');
                    
# --- INSERTS DE TABLA DE CATEGORIAS ---
INSERT INTO tbl_categorias(nombre_categoria) 
					VALUE('Periféricos'),
						('Software'),
                        ('Desktop'),
                        ('Monitores'),
                        ('Laptops'),
                        ('Limpieza'),
                        ('Muebles'),
                        ('Redes'),
                        ('Almacenamiento'),
                        ('Impresores');
                        
# --- inserts de la tabla proveedores ---

/*
1161-0080 SEMIC IT Solutions
1269-0078 innovaTECH
0603-0468 Top Tech
1107-3134 Tecnologías OGX
4326-5524 Futura
2244-2146 Súper TECH
9302-4121 Tecnologías Supernova
4496-9295 Meteoro
4720-0444 Track Tech
6938-8680 Vita Chips

*/
INSERT INTO tbl_proveedores(nombre_proveedor, direccion, telefono)
					VALUE('SEMIC IT Solutions', 'Madrid, España', '1161-0080'),
						('innovaTECH', 'Urb. Samantha Torres # 77 Hab. 113', '1269-0078'),
                        ('Top Tech', 'Jr. Diego Alejandro Guerrero # 757', '0603-0468'),
                        ('Tecnologías OGX', 'Urb. Alex Reséndez # 0401 Piso 24', '1107-3134'),
                        ('Futura', 'Jr. Juan David Barrientos # 95', '4326-5524'),
                        ('Súper TECH', 'Av. Ivanna Alba # 1288 Piso 2', '2244-2146'),
                        ('Tecnologías Supernova', 'Av. Emiliano Cisneros # 238', '9302-4121'),
                        ('Meteoro', 'Av. Juana Caraballo # 7031 Piso 18', '4496-9295'),
                        ('Track Tech', 'Jr. Matthew Guerrero # 23', '4720-0444'),
                        ('Vita Chips', 'Cl. Franco Ceja # 4202 Piso 9', '6938-8680');
					
select * from tbl_proveedores

## PROCEDIMIENTO ALMACENADO PARA INSERT DE PRODUCTO Y STOCK

DELIMITER $$
CREATE PROCEDURE registro_producto(Pproveedor_id INT, Pcategoria_id INT, Pcantidad DECIMAL(10, 2), Pnombre_producto VARCHAR(250), Pprecio_producto DECIMAL(10, 2))

	BEGIN
		INSERT INTO tbl_stock(cantidad) VALUE(Pcantidad);
        ## DECLARE stockId INT = SELECT LAST_INSERT_ID();
        INSERT INTO tbl_producto(proveedor_id, categoria_id, stock_id, nombre_producto, precio_producto) 
							VALUE(Pproveedor_id, Pcategoria_id, Pnombre_producto, Pprecio_producto);
    END $$

DELIMITER ;
	
                    