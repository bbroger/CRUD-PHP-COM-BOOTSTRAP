Será Assumido neste tutorial que você já possui instalado na máquina os seguintes requisitos básicos :
- XAMPP ou PHP e Dependencias 
- MYSQL
- MYSQL WorkBanch
Será usado neste tutorial o formato MVC para esse crud

para mais informações : http://www.devmedia.com.br/introducao-ao-padrao-mvc/29308

1 - Baixe o arquivo do Bootstrap em : http://getbootstrap.com/ 
2 - Crie um Diretório e descompacte a o bootstrap dentro dele
3 - Crie uma Pasta inc dentro do seu diretório principal, nela colocaremos todo código PHP que será reaproveitado.

4 - Entre no phpmyadmin e crie uma base de dados : CREATE DATABASE crud-php;

5 - Crie a tabela "usuarios" onde serão cadastrados alguns usuários do sistema :
'''php
CREATE TABLE usuarios (
  id int(11) NOT NULL,
  nome varchar(255) NOT NULL,
  cpf varchar(14) NOT NULL,
  cidade varchar(100) NOT NULL,
  estado varchar(100) NOT NULL,
  telefone int(13) NOT NULL,
  
);

ALTER TABLE usuarios
  ADD PRIMARY KEY (id);
  
ALTER TABLE usuarios
MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

'''

6 - Crie um arquivo config.php na raiz do seu projeto, est arquivo conterá todo código "genérico" do sistema para ser usado em outros diretórios e arquivos. Dentro de config.php cole o código a seguir:

<?php

define('DB_NAME', 'crud-php');

define('DB_USER', 'root');

define('DB_PASSWORD', '');

define('DB_HOST', 'localhost');

if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');
	

if ( !defined('BASEURL') )
	define('BASEURL', '/crud-bootstrap-php/');
	

if ( !defined('DBAPI') )
	define('DBAPI', ABSPATH . 'inc/database.php');
  ?>
  
7 - Crie um Arquivo chamado database.php dentro da sua paste inc, esse arquuivo conterá todos os códigos de acesso ao banco de dados. Depois de criado cole o código a seguir:

<?php
mysqli_report(MYSQLI_REPORT_STRICT);
function open_database() {
	try {
		$conn = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
		return $conn;
	} catch (Exception $e) {
		echo $e->getMessage();
		return null;
	}
}
function close_database($conn) {
	try {
		mysqli_close($conn);
	} catch (Exception $e) {
		echo $e->getMessage();
	}
}
?>

8 - Crie um Arquivo index.php na raiz do seu projeto. Cole o código a seguir para confirmar que o banco de dados está conectado com o seu projeto:


<?php require_once 'config.php'; ?>
<?php require_once DBAPI; ?>

<?php 
	$db = open_database(); 
	
	if ($db) {
		echo '<h1>Banco de Dados Conectado!</h1>';
	} else {
		echo '<h1>ERRO: Não foi possível Conectar!</h1>';
	}
?>
      Acesse: http://localhost/crud-bootstrap-php
      


