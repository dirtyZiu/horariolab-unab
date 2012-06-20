<?php
foreach (glob("../../class/*.php") as $filename) {
   include_once($filename);
}
session_start();
if(isset($_SESSION['usuario']))
{
  $usuario = unserialize($_SESSION['usuario']);
  if(get_class($usuario) == 'jefeDeCarrera') {
    $usuario = new administrador($usuario->getNombre(),$usuario->getNombreUsuario(),$usuario->getRut());
    $_SESSION['usuario'] = serialize($usuario);
  }
  
  if($_SERVER['REQUEST_METHOD'] == 'POST')
  {
    if(strlen($_POST['nombre']) > 2)
	{
	  $profesor = new profesor($_POST['hiddenRutProfesor']);
	  $res = $profesor->modificarProfesor($_POST['nombre'],$_POST['grado']);
	}
  }

  if($_SESSION['tipoUsuario'] == 2 || $_SESSION['tipoUsuario'] == 3)
  {
    if(isset($_GET['rutProfesor']))
	  $rutProfesor = $_GET['rutProfesor'];
	else
	  $rutProfesor = $_POST['hiddenRutProfesor'];
?>
<!DOCTYPE HTML>
<html>

<head>
  <title>HSC - Facultad de Ingeniería</title>
  <meta charset="utf-8" />
  <meta name="description" content="website description" />
  <meta name="keywords" content="website keywords, website keywords" />
  <meta http-equiv="content-type" content="text/html; charset=windows-1252" />
  <link rel="stylesheet" type="text/css" href="../../style/style.css" title="style" />
  <link rel="stylesheet" type="text/css" href="../../style/bsc.css" title="style" />
  <script type="text/javascript" src="../../js/js.js"></script>
</head>

<body>
  <?php $profesor = profesorInfo($rutProfesor); ?>
  <table>
        <form method="post" name="agregar" target="_self">
          <tr><td>Nombre</td><td>Grado (opcional)</td></tr>
          <tr>
          <td><input type="text" name="nombre" value="<?php if(isset($profesor[0]["nombreProfesor"])) echo $profesor[0]["nombreProfesor"];?>" maxlength="50"></input></td>
		  <input type="hidden" name="hiddenRutProfesor" value="<?php echo $rutProfesor;?>"></input>
          <td><select name="grado"><option value="0">Escoger grado</option>
              <?php obtenerGrados();?></select></td>
          <td><input id="" type="submit" name="modificarProfesor" value="Modificar"></input></td></tr>
          <tr>
              <td><?php if(isset($nombreerror)) echo '<span class="error">'.$nombreerror.'</span>';?></td>
              <td><?php if(isset($gradoerror)) echo '<span class="error">'.$gradoerror.'</span>';?></td>
          </tr>
        </form>
        </table>
		
		<?php if(isset($res)) echo '<div>'.$res.'</div>';?>
    
	<a href="../profesores.php" target="_parent">Cerrar</a>
  <script type='text/javascript' src='../../js/jquery.js'></script> 
  <script type='text/javascript' src='../../js/jquery.simplemodal.js'></script> 
  <script type='text/javascript' src='../../js/bsc.js'></script>
</body>
</html>
<?php
  }
  else
  {
    header("Location: ../../index.php");
    exit();
  }
}
else
{
  header("Location: ../../index.php");
  exit();
}
