# DROP DATABASE almacen_the_one;

CREATE DATABASE almacen_the_one;

USE almacen_the_one;


# ## CREAMOS LA TABLA USUARIOS ##
CREATE TABLE tbl_usuarios (
    id_usuario 			INT NOT NULL AUTO_INCREMENT,
    nombre_usuario 		VARCHAR(100) NOT NULL,
    apellido_usuario 	VARCHAR(100) NOT NULL,
    email_usuario 		VARCHAR(150) NOT NULL,
    password_usuario 	VARCHAR(100) NOT NULL,
    rol_usuario 		ENUM('Admin', 'Cliente'),
    
    CONSTRAINT pk_usuario PRIMARY KEY (id_usuario),
    CONSTRAINT uq_email UNIQUE (email_usuario)
);

# ## CREAMOS LA TABLA CLIENTES ##
CREATE TABLE tbl_clientes (
    id_cliente  INT NOT NULL AUTO_INCREMENT,
    usuario_id  INT NOT NULL,
    telefono 	VARCHAR(9),
    
    CONSTRAINT pk_id_cliente PRIMARY KEY (id_cliente),
    CONSTRAINT fk_cliente_usuario FOREIGN KEY tbl_cliente(usuario_id)
        REFERENCES tbl_usuarios (id_usuario)
);

# ## CREAMOS LA TABLA CATEGORIAS ##
CREATE TABLE tbl_categorias (
    id_categoria 		INT NOT NULL AUTO_INCREMENT,
    nombre_categoria	VARCHAR(150) NOT NULL,
    
    CONSTRAINT pk_categoria PRIMARY KEY (id_categoria)
);

# ## CREAMOS LA TABLA PROVEEDORES ##
CREATE TABLE tbl_proveedores(
	id_proveedor 		INT NOT NULL AUTO_INCREMENT,
    nombre_proveedor	VARCHAR(150) NOT NULL,
    direccion			VARCHAR(250) DEFAULT "SIN DIRECCION ESPECIFICADA",
    telefono			VARCHAR(9) NULL DEFAULT '0000-0000',
    CONSTRAINT pk_proveedor PRIMARY KEY (id_proveedor)
);

# ## CREAMOS LA TABLA STOCK ##
CREATE TABLE tbl_stock(
	id_stock INT NOT NULL AUTO_INCREMENT,
    cantidad INT NOT NULL,
    CONSTRAINT pk_stock PRIMARY KEY (id_stock)
);


# ## CREAMOS LA TABLA PRODUCTOS ##
CREATE TABLE tbl_productos(
	id_producto		INT NOT NULL AUTO_INCREMENT,
    proveedor_id	INT NOT NULL,
    categoria_id	INT NOT NULL,
    stock_id		INT NOT NULL,
    nombre_producto	VARCHAR(250) NOT NULL,
    precio_de_compra DECIMAL(10, 2),
    precio_de_venta DECIMAL(10,2),
    fecha_ingreso	TIMESTAMP,
    CONSTRAINT pk_producto PRIMARY KEY (id_producto),
    
    CONSTRAINT fk_producto_proveedor FOREIGN KEY tbl_productos(proveedor_id)
		REFERENCES tbl_proveedores (id_proveedor),
        
	CONSTRAINT fk_producto_categoria FOREIGN KEY tbl_productos(categoria_id)
		REFERENCES tbl_categorias(id_categoria),
        
	CONSTRAINT fk_producto_stock FOREIGN KEY tbl_productos(stock_id)
		REFERENCES tbl_stock(id_stock)
    
);


# ## CREAMOS LA TABLA VENTAS ##
CREATE TABLE tbl_ventas(
	id_venta 		INT NOT NULL AUTO_INCREMENT,
    cliente_id 		INT NOT NULL,
    producto_id 	INT NOT NULL,
    cantidad_compra INT NULL,
    precio_unitario DECIMAL(10,2),
    forma_pago		ENUM('Tarjeta', 'Efectivo'),
    descuento		DECIMAL(2, 2),
    monto_total 	DECIMAL(10, 2),
    fecha_venta		TIMESTAMP,
    CONSTRAINT pk_venta PRIMARY KEY (id_venta),
    
    CONSTRAINT fk_venta_cliente FOREIGN KEY tbl_ventas(cliente_id) 
		REFERENCES tbl_clientes (id_cliente),
        
	CONSTRAINT fk_venta_producto FOREIGN KEY tbl_ventas(producto_id)
		REFERENCES tbl_productos(id_producto)
);

# ## CREAMOS LA TABLA PEDIDOS ##
CREATE TABLE tbl_pedidos(
	id_pedido		INT NOT NULL AUTO_INCREMENT,
    proveedor_id	INT NOT NULL,
    producto_id		INT NOT NULL,
    usuario_id		INT NOT NULL,
    cantidad_pedido INT NOT NULL,
    fecha_pedido	TIMESTAMP,
    CONSTRAINT pk_pedidos PRIMARY KEY (id_pedido),
    
    CONSTRAINT fk_pedido_proveedor FOREIGN KEY tbl_pedidios(proveedor_id)
		REFERENCES tbl_proveedores(id_proveedor),
        
	CONSTRAINT fk_pedido_producto FOREIGN KEY tbl_pedidos(producto_id)
		REFERENCES tbl_productos(id_producto),
        
	CONSTRAINT fk_pedido_usuario FOREIGN KEY tbl_pedidos(usuario_id)
		REFERENCES tbl_usuarios(id_usuario)
);

# ## CREAMOS LA TABLA INVENTARIOS ##
CREATE TABLE tbl_inventarios(
	id_inventario 	INT NOT NULL AUTO_INCREMENT,
    producto_id		INT NOT NULL,
    entradas		INT NULL,
    salidas			INT NULL,
    ingresos		DECIMAL(10,2),
    egresos			DECIMAL(10,2),
    CONSTRAINT pk_inventario PRIMARY KEY (id_inventario),
    
    CONSTRAINT fk_inventario_producto FOREIGN KEY tbl_inventarios(producto_id)
		REFERENCES tbl_productos(id_producto)
);




