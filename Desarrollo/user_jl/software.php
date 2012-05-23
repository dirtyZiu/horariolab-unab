<?php
foreach (glob("../class/*.php") as $filename) {
   include_once($filename);
}
session_start();
if(isset($_SESSION['usuario']))
{
  $usuario = unserialize($_SESSION['usuario']);
  if(get_class($usuario) == 'jefeDeCarrera') {
    $usuario = new JefeDeLaboratorio($usuario->getNombre(),$usuario->getNombreUsuario(),$usuario->getRut());
    $_SESSION['usuario'] = serialize($usuario);
  }    

  if(isset($_POST['agrega']) && $_POST['agrega'] == 'Agregar software')
  {
    if(isset($_POST['nombre']) && $_POST['nombre'] != '' && $_POST['version'] != '')
    {
     $answer = $usuario->crearSoftware($_POST['nombre'],$_POST['version']);
    }
    else
    {
      if($_POST['nombre'] == '')
        $nombreerror = '*Debe ingresar el nombre.';
      if($_POST['version'] == '')
        $versionerror = '*Debe ingresar una version.';
    }
  }
  
      if(isset($_POST['elimina']))
  {
	$answer = $usuario->eliminarSoftware($_POST['elimina']);
  }

?>

<!DOCTYPE HTML>
<html>

<head>
  <title>colour_blue</title>
  <meta charset="utf-8" />
  <meta name="description" content="website description" />
  <meta name="keywords" content="website keywords, website keywords" />
  <meta http-equiv="content-type" content="text/html; charset=windows-1252" />
  <link rel="stylesheet" type="text/css" href="../style/style.css" title="style" />
</head>

<body>
  <div id="main">
    <div id="header">
      <div id="logo">
        <div id="logo_text">
          <!-- class="logo_colour", allows you to change the colour of the text -->
          <h1><a href="../index.php">Universidad<span class="logo_colour"> Andr&eacutes Bello</span></a></h1>
          <h2>Herramienta de programaci&oacuten de horarios.</h2>
        </div>
      </div>
      <div id="menubar">
        <ul id="menu">
          <!-- put class="selected" in the li tag for the selected page - to highlight which page you're on -->
          <li><a href="jefelab.php">Home</a></li>
          <li><a href="laboratorios.php">Laboratorios</a></li>
          <li class="selected"><a href="software.php">Software</a></li>
          <li><a href="asignaturas.php">Asignaturas</a></li>
		  <li><a href="horariolab.php">Horario Laboratorios</a></li>
          <!--<li><a href="contacto.php">Contacto</a></li>-->
          <li><a href="../logout.php">Logout</a></li>
        </ul>
      </div>
    </div>
    <div id="site_content">
      <div class="sidebar">
      <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
      </div>
      <div id="content">
	<!--Inicio Campo Agregar-->
	  <h2>Agregar Software:</h2>
		
		<table>
        <form method="post" name="agregar" target="_self">
          <tr><td>Nombre de software</td><td>Versi&oacuten</td></tr>
          <tr><td><input type="text" name="nombre" value="" maxlength="30" class="xl"></input></td>
          <td><input type="text" name="version" value="" maxlength="30"></input></td>
          <td><input id="btt" type="submit" name="agrega" value="Agregar software"></input></td></tr>
		  
          <tr><td><?php if(isset($nombreerror)) echo '<span class="error">'.$nombreerror.'</span>';?></td>
              <td><?php if(isset($versionerror)) echo '<span class="error">'.$versionerror.'</span>';?></td>
          </tr>
		  
        </form>
        </table>
	  <!--Fin Campo Agregar-->
	  <!--Inicio Campo Modificar-->
	  <?php
		if(isset($_POST['modifica']))
		{
		$dato=$_POST['modifica'];		
		  if($_POST['modifica'] == 'Modificar software')
			{
			if(isset($_POST['nombre2']) && $_POST['nombre2'] != '' && $_POST['version2'] != '')
			{
			$answer = $usuario->modificarSoftware($_POST['id2'],$_POST['nombre2'],$_POST['version2']);
			}
			else
			{
			if($_POST['nombre2'] == '')
			$edificioerror2 = '*Debe ingresar el nombre <br>';
			if($_POST['version2'] == '')
			$salaerror2 = '*Debe ingresar la version. <br>';
    }
  } else {
		
		?>
			<h2>Modificar Software:</h2>
			<table>
			<form method="post" name="modificar" target="_self">
			<tr><td>ID</td><td>Nombre de software</td><td>Versi&oacuten</td></tr>
			<tr><td><input type="hidden" name="id2" value="<?php echo $dato; ?>"><?php echo $_POST['modifica']; ?></input></td>
			<td><input type="text" name="nombre2" value="<?php $usuario->obtenerNombreSw($dato); ?>" maxlength="30" class="xl"></input></td>
			<td><input type="text" name="version2" value="<?php $usuario->obtenerVersionSw($dato); ?>" maxlength="30"></input></td>
			<td><input id="btt" type="submit" name="modifica" value="Modificar software"></input></td></tr>
        </form>
        </table>
		<?php
		}
		}
		?>
	  <!--Fin Campo Modificar-->	  		  
      <?php if(isset($edificioerror2)) echo '<span class="error">'.$edificioerror2.'</span>';?>
      <?php if(isset($salaerror2)) echo '<span class="error">'.$salaerror2.'</span>';?> 
	  <?php if(isset($answer)) echo '<span class="error">'.$answer.'</span>';?>
	  <!--Inicio Campo Listar-->
	  <h2>Lista de software:</h2><ul>
	  
	  <form method="post" name="listar" target="_self">
		<?php
		$usuario->listarSoftware();
		?>
        </form>
		
        </ul>
		<!--Fin Campo Listar-->
					
	  
      </div>
    </div>
    </div>
  </div>
</body>
</html>

<?php
}
else
{
  header("Location: ../index.php");
  exit();
}
