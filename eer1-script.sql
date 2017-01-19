drop schema if exists delivery;
create schema delivery;
use delivery;

create table clientes (
id INT 	PRIMARY KEY AUTO_INCREMENT,
nome varchar(50),
cpf varchar(11),
telefone varchar(11),
email varchar(11),
senha varchar(30)


); 
create table restaurantes(
id INT 	PRIMARY KEY AUTO_INCREMENT,
nome varchar(50),
logo varchar(50),
latlonge varchar(50),
cnpj varchar(11),
tempo_entrega int
);

create table classes(
id INT 	PRIMARY KEY AUTO_INCREMENT,
nome varchar(50)

);

create table classes_restaurantes(
restaurantes_id int,
classes_id int,
FOREIGN KEY (restaurantes_id) REFERENCES restaurantes(id),
FOREIGN KEY (classes_id) REFERENCES classes(id),
PRIMARY KEY (classes_id,restaurantes_id)
);
create table enderecos(
id INT 	PRIMARY KEY AUTO_INCREMENT,
clientes_id int,
latlonge varchar(50),
endereco varchar(50),
FOREIGN KEY (clientes_id) REFERENCES clientes(id)
);
create table pedidos(
id INT 	PRIMARY KEY AUTO_INCREMENT,
clientes_id int,
valor decimal(10,2),
data datetime,
status varchar(10),
FOREIGN KEY (clientes_id) REFERENCES clientes(id)
);
create table categorias(
id INT PRIMARY KEY auto_increment,
nome varchar (50)
);
create table produtos(
id INT PRIMARY KEY AUTO_INCREMENT,
categorias_id int,
nome varchar(50),
valor decimal (10,2),
descri varchar (200),
obs varchar (200),
fotos varchar (1),
FOREIGN KEY (categorias_id) REFERENCES categorias(id)

);

create table produtos_pedidos(

pedidos_id int,
produtos_id int,
qtd varchar(10),
valor decimal (10,2),
PRIMARY KEY (produtos_id,pedidos_id), 
FOREIGN KEY (pedidos_id) REFERENCES pedidos(id),
FOREIGN KEY (produtos_id) REFERENCES produtos(id)

);










