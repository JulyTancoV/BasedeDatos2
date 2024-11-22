CREATE DATABASE ProyectoPasteleria;
GO

USE ProyectoPasteleria;
GO

CREATE TABLE clientes(
id_cliente INT IDENTITY (1,1) PRIMARY KEY,
nom_cliente VARCHAR(255) NOT NULL,
cc_nit NVARCHAR(50) UNIQUE NOT NULL,
tel_cliente NVARCHAR(50) NOT NULL,
email_cliente VARCHAR(255),
fecha_creacion DATE,
estado CHAR(1) DEFAULT 'A' -- 'A' = ACTIVO
);
GO

CREATE TABLE facturas(
id_factura INT IDENTITY (1,1) PRIMARY KEY,
id_cliente INT,
total INT NOT NULL,
fecha_factura DATE,
FOREIGN KEY	(id_cliente) REFERENCES clientes(id_cliente)
);
GO

-- esta parte se me olvido hacerla directo en la creacion inicial
ALTER TABLE facturas
ADD Estado VARCHAR(10) CHECK (Estado IN ('Pendiente', 'Enviado', 'Entregado', 'Cancelado')),
    Fecha_Pedido DATETIME DEFAULT GETDATE();
GO

CREATE TABLE proveedores(
id_proveedor INT IDENTITY (1,1) PRIMARY KEY,
nom_prove VARCHAR(255) NOT NULL,
cc_nit_prove NVARCHAR(50) UNIQUE NOT NULL,
tel_prove NVARCHAR(50) NOT NULL,
email_prove VARCHAR(255),
fecha_creacion DATE,
estado CHAR(1) DEFAULT 'A' -- 'A' = ACTIVO
);
GO

CREATE TABLE productos(
id_producto INT IDENTITY (1,1) PRIMARY KEY,
id_proveedor INT,
nom_produc VARCHAR(255)NOT NULL,
descrip_produc VARCHAR(255)NOT NULL,
stock INT NOT NULL,
precio DECIMAL(20,2)
FOREIGN KEY(id_proveedor) REFERENCES proveedores(id_proveedor)
);
GO

CREATE TABLE inventarios(
id_inventario INT IDENTITY (1,1) PRIMARY KEY,
id_producto INT,
cantidad_stock INT NOT NULL,
fecha_actualizacion DATE NOT NULL
FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
GO

CREATE TABLE factura_detalle(
id_fac_detalle INT IDENTITY (1,1) PRIMARY KEY,	
id_factura INT,
id_producto INT,
cantidad INT NOT NULL,
precio INT NOT NULL,
foreign key (id_factura) references facturas(id_factura),
foreign key (id_producto) references productos(id_producto)
);
GO

INSERT INTO clientes (nom_cliente,cc_nit,tel_cliente,email_cliente,fecha_creacion) VALUES(
'Luis Perez', '900111222', '3111234567', 'luisperez@example.com','2024-11-16'
);
GO

SELECT * FROM clientes
GO

INSERT INTO clientes (nom_cliente, cc_nit, tel_cliente, email_cliente, fecha_creacion) VALUES
('Ana Gomez', '900112233', '3112345678', 'anagomez@example.com', '2024-11-16'),
('Carlos Sanchez', '900113344', '3113456789', 'carlossanchez@example.com', '2024-11-16'),
('Mariana Ruiz', '900114455', '3114567890', 'marianaruiz@example.com', '2024-11-16');
GO

INSERT INTO proveedores (nom_prove,cc_nit_prove,tel_prove,email_prove,fecha_creacion) VALUES
('Harina Pan', '800123000', '3210001234', 'harinapan@example.com', '2024-11-16');
GO

SELECT * FROM proveedores
GO

INSERT INTO proveedores (nom_prove, cc_nit_prove, tel_prove, email_prove, fecha_creacion) VALUES
('Bebidas La Sombra', '800124000', '3210005678', 'bebidaslsombra@example.com', '2024-11-16'),
('Distribuciones ABC', '800125000', '3210009876', 'distribucionesabc@example.com', '2024-11-16'),
('Alimentos Delicias', '800126000', '3210012345', 'alimentosdelicias@example.com', '2024-11-16'),
('Productos Frescos', '800127000', '3210016789', 'productosfrescos@example.com', '2024-11-16'),
('Lácteos La Vaquita', '800128000', '3210023456', 'lacteosvaquita@example.com', '2024-11-16');
GO

INSERT INTO clientes (nom_cliente, cc_nit, tel_cliente, email_cliente, fecha_creacion) VALUES
('Pedro Martínez', '900115566', '3115678901', 'pedromartinez@example.com', '2024-11-16'),
('Laura Fernández', '900116677', '3116789012', 'laurafernandez@example.com', '2024-11-16'),
('Juan Pérez', '900117788', '3117890123', 'juanperez@example.com', '2024-11-16'),
('Marta López', '900118899', '3118901234', 'martalopez@example.com', '2024-11-16'),
('Antonio García', '900119900', '3119012345', 'antoniogarcia@example.com', '2024-11-16'),
('Paola Rodríguez', '900120011', '3110123456', 'paolarodriguez@example.com', '2024-11-16'),
('Ricardo Díaz', '900121122', '3111234567', 'ricardodiaz@example.com', '2024-11-16'),
('Elena Torres', '900122233', '3112345678', 'elenatorres@example.com', '2024-11-16'),
('Victor Ramírez', '900123344', '3113456789', 'victorramirez@example.com', '2024-11-16'),
('Sofía Martínez', '900124455', '3114567890', 'sofia.martinez@example.com', '2024-11-16');
GO

INSERT INTO proveedores (nom_prove, cc_nit_prove, tel_prove, email_prove, fecha_creacion) VALUES
('Aceites El Sol', '800129000', '3210034567', 'aceitelsol@example.com', '2024-11-16'),
('Cárnicos La Montaña', '800130000', '3210045678', 'carne.montana@example.com', '2024-11-16'),
('Frutas Tropicales', '800131000', '3210056789', 'frutastropicales@example.com', '2024-11-16'),
('Verduras Del Campo', '800132000', '3210067890', 'verdurascampo@example.com', '2024-11-16'),
('Mariscos El Delfín', '800133000', '3210078901', 'mariscosdelfin@example.com', '2024-11-16'),
('Panadería San José', '800134000', '3210089012', 'panaderiasanjose@example.com', '2024-11-16');
GO

INSERT INTO productos (id_proveedor,nom_produc,descrip_produc,stock,precio) VALUES
(1,'Galleta 500g','50 Unidades',100,10.00);
GO

INSERT INTO productos (id_proveedor,nom_produc,descrip_produc,stock,precio) VALUES (
(SELECT id_proveedor FROM proveedores WHERE nom_prove = 'Aceites El Sol'),
'Galleta 1000g','100 Unidades',100,30.00
);
GO

SELECT * FROM productos
GO

INSERT INTO productos (id_proveedor,nom_produc,descrip_produc,stock,precio) VALUES
(2,'Gomitas 500g','50 Unidades',100,5.00),
(2,'Gomitas 1000g','100 Unidades',100,25.00),
(3,'Chocolatina 500g','5 Unidades',100,8.00),
(3,'Chocolatina 1000g','10 Unidades',100,10.00)
GO

INSERT INTO facturas(id_cliente,total,fecha_factura,Estado) VALUES
(1,5,'2024-11-16','Entregado');
GO

SELECT * FROM facturas
GO

INSERT INTO facturas(id_cliente,total,fecha_factura,Estado) VALUES
(4,10,'2024-11-16','Entregado'),
(5,20,'2024-11-16','Entregado'),
(6,1,'2024-11-16','Entregado'),
(7,10,'2024-11-16','Entregado')
GO

INSERT INTO factura_detalle (id_factura,id_producto,cantidad,precio) VALUES
(1,1,5,150.00);
GO

SELECT * FROM factura_detalle
GO

INSERT INTO factura_detalle (id_factura,id_producto,cantidad,precio) VALUES
(2,2,5,300.00),
(2,3,5,15.00),
(2,4,5,100.00),
(2,5,5,40.00)
GO

SELECT * FROM clientes
GO

SELECT * FROM proveedores
GO

SELECT * FROM productos
GO

SELECT * FROM facturas
GO

SELECT * FROM factura_detalle
GO