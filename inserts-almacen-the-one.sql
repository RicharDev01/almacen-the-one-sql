
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
CALL registro_usuario('Ricardo', 'Pineda', 'rpineda@mail.com', 'rpineda', 'Admin', null),
					 ('Jorge', 'Ramirez', 'jramirez@mail.com', 'jramirez', 'Admin', '6120-7076'),
					 ('Josue', 'Jacobo', 'jjacobo@mail.com', 'jjacobo', 'Cliente', '7076-6120'),
					 ('Nelso', 'Martinez', 'nmartinez@mail.com', 'nmartinez', 'Cliente', '7076-6120'),
					 ('Cristian', 'Flores', 'cflores@mail.com', 'cflores', 'Cliente', '7076-6120'),
					 ('Rolando', 'Monterrosa', 'rmonterrosa@mail.com', 'rmonterrosa', 'Admin', '7076-6120'),
					 ('Liliana', 'Hernandez', 'lhernandez@mail.com', 'lhernandez', 'Cliente', '7076-6120'),
					 ('Pedro', 'Hernandez', 'phernandez@mail.com', 'phernandez', 'Cliente', '7076-6120'),
					 ('Mauricio', 'Naves', 'mnaves@mail.com', 'mnaves', 'Cliente', '7076-6120'),
					 ('Angel', 'Rodriguez', 'arodriguez@mail.com', 'arodriguez', 'Cliente', '7076-6120');

                    
                    
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

CALL registro_producto(4,  4, 160, 'Sceptre 20 "1600x900 75Hz Monitor LED ultradelgado 2x HDMI VGA Altavoces incorporados', 80.00),
			(4,  4, 160, 'BenQ Monitor de computadora GW2780 IPS 1080P FHD de 27 pulgadas con altavoces integrados', 149.00),
			(4,  4, 160, 'Acer SB220Q bi - Monitor de 21.5 pulgadas Full HD (1920 x 1080), monitor IPS Ultra delgado', 95.00),
			(4,  4, 160, 'SAMSUNG LC27F398FWNXZA SAMSUNG C27F398 Monitor LED curvado de 27 pulgadas', 149.00),
			(5,  8, 400, 'Interruptor TP-Link de red Gigabit Ethernet de 5 puerto', 16.00),
			(5,  8, 400, 'TP-Link AC1200 - Extensor de rango de WiFi, Blanco', 23.00),
			(5,  8, 350, 'TP-Link AX1800 WiFi 6 Router - Enrutador de Internet inalámbrico de doble banda, enrutador Gigabit', 80.00),
			(5,  8, 160, 'TP-Link Adaptador de WiFi USB AC600 para PC - Adaptador de red inalámbrica para escritorio con 2.4GHz', 20.00),
			(2,  9, 160, 'Unidad de disco duro externo portátil Seagate de 2 TB con puerto USB 3.0', 62.00),
			(2,  9, 160, 'SSD M.2 980 PRO 2TB PCIe NVMe Gen4 interno para juegos', 220.00),
			(2,  9, 160, 'SAMSUNG 870 EVO 2.5 pulgadas SATA III SSD interno', 99.00),
			(2,  9, 160, 'Western Digital Unidad interna de estado sólido SSD WD Blue SA510 SATA de 1 TB', 75.00),
			(9,  10, 160, 'HP DeskJet 2752 Impresora de inyección de tinta a color inalámbrica todo en uno', 69.00),
			(9,  10, 160, 'Epson EcoTank ET-2720 - Impresora multifuncional inalámbrica a color con escáner y copiadora',185.00),
			(9,  10, 160, 'Canon TS202 Inkjet impresora fotográfica, color negro',219.00),
			(9,  10, 160, 'Brother Impresora láser compacta monocromática, HLL2390DW, cómoda copia y escaneo',189.00),
			(10,  1, 160, 'Auricular USB H390 ClearChat Comfort de Logitech', 35.00),
			(10,  1, 160, 'Logitech M510 - Mouse inalámbrico para computador USB', 27.00),
			(10,  1, 160, 'Logitech Brio, webcam Ultra HD para videoconferencias y grabación de videos', 136.00),
			(10,  1, 160, 'Logitech MK270 - Combo inalámbrico de teclado y mouse para Windows', 23.00);



## INSERT DE VENTAS
INSERT INTO tbl_ventas(cliente_id, producto_id, cantidad_compra, precio_unitario, forma_pago, descuento, monto_total, fecha_venta) 
					VALUE(1, 3, 10, 385.00, 'Tarjeta', 0.0, 3850, NOW()),
						 (1, 1, 10, 185.00, 'Tarjeta', 0.0, 1850, NOW());


DELIMITER $$
CREATE TRIGGER IF NOT EXISTS tbl_ventas_AI 
AFTER INSERT ON tbl_ventas FOR EACH ROW
	BEGIN
		UPDATE tbl_stock SET cantidad = cantidad - NEW.cantidad_compra WHERE id_stock = producto_id;
	END; $$

DELIMITER ;



# INSERT DE PEDIDOS
INSERT INTO tbl_pedidos(proveedor_id, producto_id, usuario_id, cantidad_pedido, fecha_pedido) 
		VALUE(10, 2, 1, 100, NOW()),
			(10, 1, 1, 50, NOW());
        
CREATE TRIGGER IF NOT EXISTS tbl_pedidos_AI
AFTER INSERT ON tbl_pedidos FOR EACH ROW
	BEGIN
		UPDATE tbl_stock SET cantidad = cantidad + cantidad_pedido WHERE id_stock = producto_id;
	END; $$

DELIMITER;




# INSERT DE INVENTARIOS 
INSERT INTO tbl_inventarios(producto_id, categoria_id, pedido_id, venta_id, stock_id) 
					  VALUE(1, 4, 2, 2, 1);

# CREATE TRIGGER NOMBRE_TRIGGER_BU BEFORE UPDATE ON TABLA_DE_ACTUAR_DEL_TRIGGER FOR EACH ROW INSERT INTO XXXXXX OLD & NEW

                    
