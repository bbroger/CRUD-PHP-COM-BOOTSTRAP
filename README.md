Será Assumido neste tutorial que você já possui instalado na máquina os seguintes requisitos básicos :
- XAMPP ou PHP e Dependencias 
- MYSQL
- MYSQL WorkBanch
- Será usado neste tutorial o formato MVC para esse crud

para mais informações : http://www.devmedia.com.br/introducao-ao-padrao-mvc/29308

1 - Baixe o arquivo do Bootstrap em : http://getbootstrap.com/ 

2 - Crie um Diretório chamado crud-bootstrap-php e descompacte a o bootstrap dentro dele

3 - Crie uma Pasta inc dentro do seu diretório principal, nela colocaremos todo código PHP que será reaproveitado.

4 - Entre no phpmyadmin e crie uma base de dados : CREATE DATABASE crud-php;

5 - Crie a tabela "usuarios" onde serão cadastrados alguns usuários do sistema :
 ```php
CREATE TABLE usuarios (
  id int(11) NOT NULL,
  nome varchar(255) NOT NULL,
  cpf varchar(14) NOT NULL,
  cidade varchar(100) NOT NULL,
  estado varchar(100) NOT NULL,
  telefone int(13) NOT NULL
  
);

ALTER TABLE usuarios
  ADD PRIMARY KEY (id);
  
ALTER TABLE usuarios
MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;


```

6 - Crie um arquivo config.php na raiz do seu projeto, este arquivo conterá todo código "genérico" do sistema para ser usado em outros diretórios e arquivos. Dentro de config.php cole o código a seguir:

```php
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
```

7 - Crie um Arquivo chamado database.php dentro da sua paste inc, esse arquuivo conterá todos os códigos de acesso ao banco de dados. Depois de criado cole o código a seguir:
```php  
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
```
 
8 - Crie um Arquivo index.php na raiz do seu projeto. Cole o código a seguir para confirmar que o banco de dados está conectado com o seu projeto:


```php
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
     
      
 ```  
  Acesse: http://localhost/crud-bootstrap-php
 
9 - Crie um arquivo header.php dentro da paste inc que terá todos os arquivos do header do seu sistema que será reaproveitado. Dentro do Arquivo cole o codigo de marcação html a seguir:

```php
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>CRUD com Bootstrap</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="<?php echo BASEURL; ?>css/bootstrap.min.css">
    <style>
        body {
            padding-top: 50px;
            padding-bottom: 20px;
        }
    </style>
    <link rel="stylesheet" href="<?php echo BASEURL; ?>css/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.2/css/font-awesome.min.css">
</head>
<body>

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a href="<?php echo BASEURL; ?>index.php" class="navbar-brand">CRUD</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">          
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                    Clientes <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="<?php echo BASEURL; ?>usuarios">Gerenciar Clientes</a></li>
                    <li><a href="<?php echo BASEURL; ?>usuarios/add.php">Novo Cliente</a></li>
                </ul>
            </li>
          </ul>
        </div><!--/.navbar-collapse -->
      </div>
    </nav>


<main class="container">

```

10 - Semelhante ao tópico anterior vamos criar o arquivo footer.php na pasta inc. Dentro do footer.php cole o código a seguir :

```php

</main> <!-- /container -->

	<hr>
	<footer class="container">
	  UFRA - 2017
	</footer>

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="<?php echo BASEURL; ?>js/jquery-1.11.2.min.js"><\/script>')</script>

    <script src="<?php echo BASEURL; ?>js/bootstrap.min.js"></script>

    <script src="<?php echo BASEURL; ?>js/main.js"></script>
</body>
</html>

```
11 - Abra o arquivo config.php na raiz do projeto e adicione o caminho do header e do footer no final do código.

```php
define('HEADER_TEMPLATE', ABSPATH . 'inc/header.php');
define('FOOTER_TEMPLATE', ABSPATH . 'inc/footer.php');
```
12 - Abra o arquivo index.php onde testamos a conexão com banco de dados e cole a marcação a seguir, incluindo header e footer. Cole o código a seguir :

```php
<?php require_once 'config.php'; ?>
<?php require_once DBAPI; ?>

<?php include(HEADER_TEMPLATE); ?>
<?php $db = open_database(); ?>

<h1>Painel do Cliente</h1>
<hr />

<?php if ($db) : ?>

<div class="row">
	<div class="col-xs-6 col-sm-3 col-md-2">
		<a href="usuarios/add.php" class="btn btn-primary">
			<div class="row">
				<div class="col-xs-12 text-center">
					<i class="fa fa-plus fa-5x"></i>
				</div>
				<div class="col-xs-12 text-center">
					<p>Novo Cliente</p>
				</div>
			</div>
		</a>
	</div>

	<div class="col-xs-6 col-sm-3 col-md-2">
		<a href="usuarios" class="btn btn-default">
			<div class="row">
				<div class="col-xs-12 text-center">
					<i class="fa fa-user fa-5x"></i>
				</div>
				<div class="col-xs-12 text-center">
					<p>Clientes</p>
				</div>
			</div>
		</a>
	</div>
</div>

<?php else : ?>
	<div class="alert alert-danger" role="alert">
		<p><strong>ERRO:</strong> Não foi possível Conectar ao Banco de Dados!</p>
	</div>

<?php endif; ?>

<?php include(FOOTER_TEMPLATE); ?>
```
13 - Crie uma pasta chamada usuarios para colocarmos todos os códigos referentes aos nossos clientes. Dentro da pasta usuarios crie um arquivo chamado functions.php. Dentro do arquivo functions.php cole o código a seguir:

```php
<?php
require_once('../config.php');
require_once(DBAPI);
$usuarios = null;
$usuario = null;
 {
	global $usuarios;
	$usuarios = find_all('usuarios');
}
?>
```

14 - No passo anterior nos estamos fazendo uma busca no banco de alguns usuarios para que isso funcione precisamos implementar isso no arquivo database.php, entre no arquivo database php e cole o código a seguir abaixo do existente: 

```php



function find( $table = null, $id = null ) {
  
	$database = open_database();
	$found = null;
	try {
	  if ($id) {
	    $sql = "SELECT * FROM " . $table . " WHERE id = " . $id;
	    $result = $database->query($sql);
	    
	    if ($result->num_rows > 0) {
	      $found = $result->fetch_assoc();
	    }
	    
	  } else {
	    
	    $sql = "SELECT * FROM " . $table;
	    $result = $database->query($sql);
	    
	    if ($result->num_rows > 0) {
	      $found = $result->fetch_all(MYSQLI_ASSOC);
       
	    }
	  }
	} catch (Exception $e) {
	  $_SESSION['message'] = $e->GetMessage();
	  $_SESSION['type'] = 'danger';
  }
	
	close_database($database);
	return $found;
}

```
15 - Adicione no mesmo arquivo do tópico anterior a função a seguir, se trata apenas de outro caminho para puxar dados da tabela:


```php
<?php

function find_all( $table ) {
  return find($table);
}
?>
```
16 - Crie um Arquivo index.php na paste usuarios, que concentrará toda marcação e dados da tabela. Cole o código a seguir

```php
<?php
    require_once('functions.php');
    index();
?>

<?php include(HEADER_TEMPLATE); ?>

<header>
	<div class="row">
		<div class="col-sm-6">
			<h2>Clientes</h2>
		</div>
		<div class="col-sm-6 text-right h2">
	    	<a class="btn btn-primary" href="add.php"><i class="fa fa-plus"></i> Novo Cliente</a>
	    	<a class="btn btn-default" href="index.php"><i class="fa fa-refresh"></i> Atualizar</a>
	    </div>
	</div>
</header>

<?php if (!empty($_SESSION['message'])) : ?>
	<div class="alert alert-<?php echo $_SESSION['type']; ?> alert-dismissible" role="alert">
		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		<?php echo $_SESSION['message']; ?>
	</div>
	<?php clear_messages(); ?>
<?php endif; ?>

<hr>

<table class="table table-hover">
<thead>
	<tr>
		<th>ID</th>
		<th width="30%">Nome</th>
		<th>CPF</th>
		<th>Telefone</th>
		<th>Cidade</th>
		<th>Estado</th>
		
		
	</tr>
</thead>
<tbody>
<?php if ($usuarios) : ?>
<?php foreach ($usuarios as $usuario) : ?>
	<tr>
		<td><?php echo $usuario['id']; ?></td>
		<td><?php echo $usuario['nome']; ?></td>
		<td><?php echo $usuario['cpf']; ?></td>
		<td><?php echo $usuario['telefone']; ?></td>
		<td><?php echo $usuario['cidade']; ?></td>
		<td><?php echo $usuario['estado']; ?></td>
		
		<td class="actions text-right">
			<a href="view.php?id=<?php echo $usuario['id']; ?>" class="btn btn-sm btn-success"><i class="fa fa-eye"></i> Visualizar</a>
			<a href="edit.php?id=<?php echo $usuario['id']; ?>" class="btn btn-sm btn-warning"><i class="fa fa-pencil"></i> Editar</a>
			<a href="#" class="btn btn-sm btn-danger" data-toggle="modal" data-target="#delete-modal" data-usuario="<?php echo $usuario['id']; ?>">
				<i class="fa fa-trash"></i> Excluir
			</a>
		</td>
	</tr>
<?php endforeach; ?>
<?php else : ?>
	<tr>
		<td colspan="6">Nenhum registro encontrado.</td>
	</tr>
<?php endif; ?>
</tbody>
</table>

<?php include(FOOTER_TEMPLATE); ?>


```
17 - Entre no Phpmyadmin e popule um pouco a sua tabela para ver se o index.php dos usuarios está puxando todas as informaçes. Use o código:

```php
INSERT INTO `usuarios` (`id`, `nome`, `cpf`, `cidade`, `estado`, 
`telefone`) 
VALUES ('0', 'usuario1', '000000', '000000', '000000', '000000');

```
18 - Vamos Para dentro da Paste Usuarios e vamos  adicionar a função de adicionar. No arquivo functions.php cole o código a seguir:

```php
<?php
function add() {
  if (!empty($_POST['usuario'])) {
    
    
    $usuario = $_POST['usuario'];
    
    
    save('usuarios', $usuario);
    header('location: index.php');
  }
}
?>
```
19 - Uma vez com a função implementada vamos abrir a pasta usuarios e vamos criar o arquivo add.php, neste arquivo colocaremos todos os formularios para adicionar um usuario. Cole o código a seguir:

```php
<?php 
  require_once('functions.php'); 
  add();
?>

<?php include(HEADER_TEMPLATE); ?>

<h2>Novo Cliente</h2>

<form action="add.php" method="post">
  <!-- area de campos do form -->
  <hr />
  <div class="row">
    <div class="form-group col-md-7">
      <label for="nome">Nome</label>
      <input type="text" class="form-control" name="usuario['nome']">
    </div>

    <div class="form-group col-md-3">
      <label for="campo2">CPF</label>
      <input type="text" class="form-control" name="usuario['cpf']">
    </div>

    <div class="form-group col-md-2">
      <label for="campo3">Cidade</label>
      <input type="text" class="form-control" name="usuario['cidade']">
    </div>
  </div>
  
  <div class="row">
    <div class="form-group col-md-5">
      <label for="campo1">Estado</label>
      <input type="text" class="form-control" name="usuario['estado']">
    </div>

    <div class="form-group col-md-3">
      <label for="campo2">Telefone</label>
      <input type="text" class="form-control" name="usuario['telefone']">
    </div>
    </div>
    
   
   <div id="actions" class="row">
    <div class="col-md-12">
      <button type="submit" class="btn btn-primary">Salvar</button>
      <a href="index.php" class="btn btn-default">Cancelar</a>
    </div>
  </div>
</form>

<?php include(FOOTER_TEMPLATE); ?>
```
20 - Para finalizar a adição de usuario iremos agora implementar todo esses comandos no arquivo database.php Cole o seguinte código:
```php
<?php

function save($table = null, $data = null) {
  $database = open_database();
  $columns = null;
  $values = null;
  //print_r($data);
  foreach ($data as $key => $value) {
    $columns .= trim($key, "'") . ",";
    $values .= "'$value',";
  }
  // remove a ultima virgula
  $columns = rtrim($columns, ',');
  $values = rtrim($values, ',');
  
  $sql = "INSERT INTO " . $table . "($columns)" . " VALUES " . "($values);";
  try {
    $database->query($sql);
    $_SESSION['message'] = 'Registro cadastrado com sucesso.';
    $_SESSION['type'] = 'success';
  
  } catch (Exception $e) { 
  
    $_SESSION['message'] = 'Nao foi possivel realizar a operacao.';
    $_SESSION['type'] = 'danger';
  } 
  close_database($database);
}
?>
```

21 - Agora vamos criar a função de update do sistema. Primeiro no Arquivo functions.php cole o seguinte código

```php
<?php

function edit() {
  
  if (isset($_GET['id'])) {
    $id = $_GET['id'];
    if (isset($_POST['usuario'])) {
      $usuario = $_POST['usuario'];
      
      update('usuarios', $id, $usuario);
      header('location: index.php');
    } else {
      global $usuario;
      $usuario = find('usuarios', $id);
    } 
  } else {
    header('location: index.php');
  }
}



```

22 - Vamos criar a função de Edição agora. Crie um arquivo edit.php na pasta usuarios e cole o código a seguie:

```php
<?php 
  require_once('functions.php'); 
  edit();
?>

<?php include(HEADER_TEMPLATE); ?>

<h2>Atualizar Cliente</h2>

<form action="edit.php?id=<?php echo $usuario['id']; ?>" method="post">
  <hr />
  <div class="row">
    <div class="form-group col-md-7">
      <label for="name">Nome</label>
      <input type="text" class="form-control" name="usuario['nome']" value="<?php echo $usuario['nome']; ?>">
    </div>

    <div class="form-group col-md-3">
      <label for="campo2">CPF</label>
      <input type="text" class="form-control" name="usuario['cpf']" value="<?php echo $usuario['cpf']; ?>">
    </div>

    <div class="form-group col-md-2">
      <label for="campo3">Cidade</label>
      <input type="text" class="form-control" name="usuario['cidade']" value="<?php echo $usuario['cidade']; ?>">
    </div>
  </div>
  <div class="row">
    <div class="form-group col-md-5">
      <label for="campo1">Estado</label>
      <input type="text" class="form-control" name="usuario['estado']" value="<?php echo $usuario['estado']; ?>">
    </div>

    <div class="form-group col-md-3">
      <label for="campo2">Telefone</label>
      <input type="text" class="form-control" name="usuario['telefone']" value="<?php echo $usuario['telefone']; ?>">
    </div>

    

  </div>
  <div id="actions" class="row">
    <div class="col-md-12">
      <button type="submit" class="btn btn-primary">Salvar</button>
      <a href="index.php" class="btn btn-default">Cancelar</a>
    </div>
  </div>
</form>

<?php include(FOOTER_TEMPLATE); ?>

```
23 - Vamos Implementar a edição no banco de dados. Abra o database.php e cole o código a seguir:

```php

<?php

function update($table = null, $id = 0, $data = null) {
  $database = open_database();
  $items = null;
  foreach ($data as $key => $value) {
    $items .= trim($key, "'") . "='$value',";
  }
  // remove a ultima virgula
  $items = rtrim($items, ',');
  $sql  = "UPDATE " . $table;
  $sql .= " SET $items";
  $sql .= " WHERE id=" . $id . ";";
  try {
    $database->query($sql);
    $_SESSION['message'] = 'Registro atualizado com sucesso.';
    $_SESSION['type'] = 'success';
  } catch (Exception $e) { 
    $_SESSION['message'] = 'Nao foi possivel realizar a operacao.';
    $_SESSION['type'] = 'danger';
  } 
  close_database($database);
}

```

24 - Vamos criar a função de vizualizar as informaçoes do cliente. Dentro de usuarios no arquivo functions.php cole a função de vizulização a seguir:

```php

<?php

function view($id = null) {
  global $usuario;
  $usuario = find('usuarios', $id);
}
?>


```

25 - Na paste usuarios crie um arquivo chamado view.php, esse arquivo renderizará toda a pagina de vizualização fazendo a busca na tabela pelo id do usuario.

```php
<?php 
	require_once('functions.php'); 
	view($_GET['id']);
?>

<?php include(HEADER_TEMPLATE); ?>

<h2>Cliente de Id: <?php echo $usuario['id']; ?></h2>
<hr>

<?php if (!empty($_SESSION['message'])) : ?>
	<div class="alert alert-<?php echo $_SESSION['type']; ?>"><?php echo $_SESSION['message']; ?></div>
<?php endif; ?>

<dl class="dl-horizontal">
	<dt>Nome:</dt>
	<dd><?php echo $usuario['nome']; ?></dd>

	<dt>CPF:</dt>
	<dd><?php echo $usuario['cpf']; ?></dd>

	


 
	<dt>Cidade:</dt>
	<dd><?php echo $usuario['cidade']; ?></dd>

	<dt>Estado:</dt>
	<dd><?php echo $usuario['estado']; ?></dd>

	
	<dt>Telefone</dt>
	<dd><?php echo $usuario['telefone']; ?></dd>
</dl>



<div id="actions" class="row">
	<div class="col-md-12">
	  <a href="edit.php?id=<?php echo $usuario['id']; ?>" class="btn btn-primary">Editar</a>
	  <a href="index.php" class="btn btn-default">Voltar</a>
	</div>
</div>

<?php include(FOOTER_TEMPLATE); ?>

```

26 - Para criar a função de exclusão do sistema, como de costume vamos ao functions.php dentro da pasta usuarios e vamos adicionar o código a seguir:

```php

<?php

function delete($id = null) {
  global $usuario;
  $usuario = remove('usuarios', $id);
  header('location: index.php');
}
```

27 - Para que fique mais "seguro" criaremos uma janela modal para quando o usuario excluir um registro, a pagina responder com uma confirmação neste modal. Para isto dentro da pasta usuarios crie um arquivo chamado modal.php e dentro dele cole o codigo a seguir:

```php
div class="modal fade" id="delete-modal" tabindex="-1" role="dialog" aria-labelledby="modalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="modalLabel">Excluir Item</h4>
      </div>
      <div class="modal-body">
        Deseja realmente excluir este item?
      </div>
      <div class="modal-footer">
        <a id="confirm" class="btn btn-primary" href="#">Sim</a>
        <a id="cancel" class="btn btn-default" data-dismiss="modal">N&atilde;o</a>
      </div>
    </div>
  </div>
</div> <!-- /.modal -->

```

28 -  Não podemos esquecer de implementar no index.php da pasta de usuarios este modal. Para isso Basta calocar a marcação a seguir antes do footer:

```php
<?php include('modal.php'); ?>
```

29 -  Para que o evento acorra precisamos criar um arquivo dentro da pasta js chamado main.js, ele passará os dados deste evento e puxará a função de exlusão.Cole o código a seguir.

```php
/**
 * Passa os dados do cliente para o Modal, e atualiza o link para exclusão
 */
$('#delete-modal').on('show.bs.modal', function (event) {
  
  var button = $(event.relatedTarget);
  var id = button.data('usuario');
  
  var modal = $(this);
  modal.find('.modal-title').text('Excluir Cliente #' + id);
  modal.find('#confirm').attr('href', 'delete.php?id=' + id);
})

```

30 - Vamos agora abrir nosso "querido" functions.php dentro de usuarios e criar a função de exclusão, basta colar o código a seguir:

```php
<?php 
  require_once('functions.php'); 
  if (isset($_GET['id'])){
    delete($_GET['id']);
  } else {
    die("ERRO: ID não definido.");
  }
?>
```

31 - Para finalizar vamos Implementar essa exclusão no banco de dados com o seguinte código :


FIM

OBS: com a mudança dos nomes de tabelas, diretorios ou base dados os respectivos nomes devem ser mudados no codigo também.


      


