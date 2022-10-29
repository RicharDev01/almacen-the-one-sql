
-- ## INSERT'S DE LA BASE DE DATOS. ## 
USE almacen_the_one;
## INSERT INTO tbl_name (column1, column2) VALUES(value1, value2);

## rol_usuario 		ENUM('Admin', 'Cliente'),
DELIMITER $$
CREATE PROCEDURE registro_usuario(Pnombre_usuario VARCHAR(100), Papellido_usuario VARCHAR(100), Pemail_usuario VARCHAR(150), Ppassword_usuario VARCHAR(100), Prol_usuario VARCHAR(20), Ptelefono VARCHAR(9))

	BEGIN
		DECLARE usuarioID INT;
        # ANTES DE INSERTAR, VALIDO SI ES O NO UN CLIENTE
        # YA QUE SI NO LO ES, SOLO SE DEBE DE REGISTRAR EL USUARIO, NO UN CLIENTE
		IF(Prol_usuario = 'Cliente') THEN
			
			INSERT INTO tbl_usuarios(nombre_usuario, apellido_usuario, email_usuario, password_usuario, rol_usuario) 
									VALUE(Pnombre_usuario, Papellido_usuario, Pemail_usuario, Ppassword_usuario, Prol_usuario);
			SET usuarioID = LAST_INSERT_ID();
					
			INSERT INTO tbl_clientes(usuario_id, telefono) 
									VALUE(usuarioID, Ptelefono);
		ELSE
			INSERT INTO tbl_usuarios(nombre_usuario, apellido_usuario, email_usuario, password_usuario, rol_usuario) 
									VALUE(Pnombre_usuario, Papellido_usuario, Pemail_usuario, Ppassword_usuario, Prol_usuario);
		END IF;
    END $$

DELIMITER ;

/*
SET FOREIGN_KEY_CHECKS = 0; 
TRUNCATE TABLE tbl_usuarios;
SET FOREIGN_KEY_CHECKS = 1;
*/
CALL registro_usuario('Ricardo', 'Pineda', 'rpineda@mail.com', 'Admin', 'Admin', null);
CALL registro_usuario('Jorge', 'Ramirez', 'jramirez@mail.com', 'Cliente', 'Cliente', '6120-7076');

                    
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
					
select * from tbl_proveedores;

## PROCEDIMIENTO ALMACENADO PARA INSERT DE PRODUCTO Y STOCK

DELIMITER $$
CREATE PROCEDURE registro_producto(Pproveedor_id INT, Pcategoria_id INT, Pcantidad DECIMAL(10, 2), Pnombre_producto VARCHAR(250), Pprecio_producto DECIMAL(10, 2))

	BEGIN
		DECLARE stockID INT;
        INSERT INTO tbl_stock(cantidad) VALUE(Pcantidad);
        SET stockID := LAST_INSERT_ID();
        INSERT INTO tbl_productos(proveedor_id, categoria_id, stock_id, nombre_producto, precio_producto) 
							VALUE(Pproveedor_id, Pcategoria_id, stockID, Pnombre_producto, Pprecio_producto);
    END $$

DELIMITER ;

CALL registro_producto(1,  4, 50, 'Monitor 24" HP 24F', 185.00);


                    