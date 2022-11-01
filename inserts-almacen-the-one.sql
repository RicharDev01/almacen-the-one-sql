
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
TRUNCATE TABLE tbl_inventarios;
SET FOREIGN_KEY_CHECKS = 1;
*/
CALL registro_usuario('Ricardo', 'Pineda', 'rpineda@mail.com', 'rpineda', 'Admin', null);
CALL registro_usuario('Jorge', 'Ramirez', 'jramirez@mail.com', 'jramirez', 'Admin', null);
CALL registro_usuario('Josue', 'Jacobo', 'jjacobo@mail.com', 'jjacobo', 'Cliente', '7076-6120');
CALL registro_usuario('Nelso', 'Martinez', 'nmartinez@mail.com', 'nmartinez', 'Cliente', '7076-6120');
CALL registro_usuario('Cristian', 'Flores', 'cflores@mail.com', 'cflores', 'Cliente', '7076-6120');
CALL registro_usuario('Rolando', 'Monterrosa', 'rmonterrosa@mail.com', 'rmonterrosa', 'Admin', null);
CALL registro_usuario('Liliana', 'Hernandez', 'lhernandez@mail.com', 'lhernandez', 'Cliente', '7076-6120');
CALL registro_usuario('Pedro', 'Hernandez', 'phernandez@mail.com', 'phernandez', 'Cliente', '7076-6120');
CALL registro_usuario('Mauricio', 'Naves', 'mnaves@mail.com', 'mnaves', 'Cliente', '7076-6120');
CALL registro_usuario('Angel', 'Rodriguez', 'arodriguez@mail.com', 'arodriguez', 'Cliente', '7076-6120');

                    
                    
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
					



## PROCEDIMIENTO ALMACENADO PARA INSERT DE PRODUCTO Y STOCK

DELIMITER $$
CREATE PROCEDURE registro_producto(Pproveedor_id INT, Pcategoria_id INT, Pcantidad DECIMAL(10, 2), 
							Pnombre_producto VARCHAR(250), Pprecio_de_compra DECIMAL(10, 2), Pprecio_de_venta DECIMAL(10, 2), Pfecha_ingreso TIMESTAMP)

	BEGIN
		DECLARE stockID INT;
        DECLARE productoID INT;
        INSERT INTO tbl_stock(cantidad) VALUE(Pcantidad);
        SET stockID := LAST_INSERT_ID();
        INSERT INTO tbl_productos(proveedor_id, categoria_id, stock_id, nombre_producto, precio_de_compra, precio_de_venta, fecha_ingreso) 
							VALUE(Pproveedor_id, Pcategoria_id, stockID, Pnombre_producto, Pprecio_de_compra, Pprecio_de_venta, Pfecha_ingreso);
		SET productoID := LAST_INSERT_ID();
		INSERT INTO tbl_inventarios(producto_id, entradas, egresos) VALUE(productoID, Pcantidad, (Pcantidad*Pprecio_de_compra));
    END $$

DELIMITER ;
/*
    producto_id		INT NOT NULL,
    entradas		INT NULL,
    salidas			INT NULL,
    ingresos		DECIMAL(10,2),
    egresos			DECIMAL(10,2),
*/

CALL registro_producto(4,  4, 160, 'Sceptre 20 "1600x900 75Hz Monitor LED ultradelgado 2x HDMI VGA Altavoces incorporados', 70.00, 80.00, NOW());
CALL registro_producto(4,  4, 160, 'BenQ Monitor de computadora GW2780 IPS 1080P FHD de 27 pulgadas con altavoces integrados', 130.00, 149.00, NOW());
CALL registro_producto(4,  4, 160, 'Acer SB220Q bi - Monitor de 21.5 pulgadas Full HD (1920 x 1080), monitor IPS Ultra delgado', 80.00, 95.00, NOW());
CALL registro_producto(4,  4, 160, 'SAMSUNG LC27F398FWNXZA SAMSUNG C27F398 Monitor LED curvado de 27 pulgadas', 140.00, 149.00, NOW());

CALL registro_producto(5,  8, 400, 'Interruptor TP-Link de red Gigabit Ethernet de 5 puerto', 10.00, 16.00, NOW());
CALL registro_producto(5,  8, 400, 'TP-Link AC1200 - Extensor de rango de WiFi, Blanco', 15.00, 23.00, NOW());
CALL registro_producto(5,  8, 350, 'TP-Link AX1800 WiFi 6 Router - Enrutador de Internet inalámbrico de doble banda, enrutador Gigabit', 60.00, 80.00, NOW());
CALL registro_producto(5,  8, 500, 'TP-Link Adaptador de WiFi USB AC600 para PC - Adaptador de red inalámbrica para escritorio con 2.4GHz', 8.00, 20.00, NOW());

CALL registro_producto(2,  9, 280, 'Unidad de disco duro externo portátil Seagate de 2 TB con puerto USB 3.0', 50.00, 62.00, NOW());
CALL registro_producto(2,  9, 360, 'SSD M.2 980 PRO 2TB PCIe NVMe Gen4 interno para juegos', 185.00, 220.00, NOW());
CALL registro_producto(2,  9, 175, 'SAMSUNG 870 EVO 2.5 pulgadas SATA III SSD interno', 90.00, 99.00, NOW());
CALL registro_producto(2,  9, 625, 'Western Digital Unidad interna de estado sólido SSD WD Blue SA510 SATA de 1 TB', 60.00, 75.00, NOW());

CALL registro_producto(9,  10, 100, 'HP DeskJet 2752 Impresora de inyección de tinta a color inalámbrica todo en uno', 60.00, 69.00, NOW());
CALL registro_producto(9,  10, 50, 'Epson EcoTank ET-2720 - Impresora multifuncional inalámbrica a color con escáner y copiadora', 170.00, 185.00, NOW());
CALL registro_producto(9,  10, 200, 'Canon TS202 Inkjet impresora fotográfica, color negro', 200.00, 219.00, NOW());
CALL registro_producto(9,  10, 25, 'Brother Impresora láser compacta monocromática, HLL2390DW, cómoda copia y escaneo', 180.00, 189.00, NOW());

CALL registro_producto(10,  1, 650, 'Auricular USB H390 ClearChat Comfort de Logitech', 15.00, 35.00, NOW());
CALL registro_producto(10,  1, 125, 'Logitech M510 - Mouse inalámbrico para computador USB', 20.00, 27.00, NOW());
CALL registro_producto(10,  1, 325, 'Logitech Brio, webcam Ultra HD para videoconferencias y grabación de videos', 100.00, 136.00, NOW());
CALL registro_producto(10,  1, 85, 'Logitech MK270 - Combo inalámbrico de teclado y mouse para Windows', 20.00, 23.00, NOW());



-- DROP TRIGGER tbl_ventas_AI
DELIMITER $$
CREATE TRIGGER tbl_ventas_AI 
AFTER INSERT ON tbl_ventas FOR EACH ROW
	BEGIN
		UPDATE tbl_stock SET cantidad = cantidad - NEW.cantidad_compra WHERE id_stock = NEW.producto_id;
        UPDATE tbl_inventarios SET salidas = salidas + NEW.cantidad_compra, ingresos = ingresos + (NEW.precio_unitario * NEW.cantidad_compra) WHERE tbl_inventarios.producto_id = NEW.producto_id;
	END; $$

DELIMITER ;

## INSERT DE VENTAS
INSERT INTO tbl_ventas(cliente_id, producto_id, cantidad_compra, precio_unitario, forma_pago, descuento, monto_total, fecha_venta) 
					VALUE(1, 2, 1, 149.00, 'Tarjeta', 0.0, 149.00, NOW()),
						 (3, 12, 1, 75.00, 'Efectivo', 0.0, 75.0, NOW()),
                         (6, 20, 5, 23.00, 'Tarjeta', 0.0, 115.00, NOW());


-- DROP TRIGGER tbl_pedidos_AI
DELIMITER $$
CREATE TRIGGER tbl_pedidos_AI
AFTER INSERT ON tbl_pedidos FOR EACH ROW
	BEGIN
		UPDATE tbl_stock SET cantidad = cantidad + NEW.cantidad_pedido WHERE id_stock = NEW.producto_id;
        UPDATE tbl_inventarios SET entradas = entradas + NEW.cantidad_pedido WHERE producto_id = NEW.producto_id;
	END; $$

DELIMITER ;

# INSERT DE PEDIDOS
INSERT INTO tbl_pedidos(proveedor_id, producto_id, usuario_id, cantidad_pedido, fecha_pedido) 
		VALUE(10, 20, 1, 10, NOW());
    


                    
