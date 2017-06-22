<?php
require_once('../config.php');
require_once(DBAPI);

$usuarios = null;
$usuario = null;

function index() {
	global $usuarios;
	$usuarios = find_all('usuarios');
}


?>



<?php
function add() {
  if (!empty($_POST['usuario'])) {
    
    
    $usuario = $_POST['usuario'];
    
    
    save('usuarios', $usuario);
    header('location: index.php');
  }
}
?>

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
?>
<?php

function view($id = null) {
  global $usuario;
  $usuario = find('usuarios', $id);
}
?>
<?php

function delete($id = null) {
  global $usuario;
  $usuario = remove('usuarios', $id);
  header('location: index.php');
}
