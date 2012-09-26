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

  if(isset($_POST['agrega']) && $_POST['agrega'] == 'Agregar laboratorio')
  {
    if(isset($_POST['edificio']) && $_POST['edificio'] != '' && $_POST['sala'] != '')
    {
     $answer = $usuario->crearLaboratorio($_POST['edificio'],$_POST['sala']);
    }
    else
    {
      if($_POST['edificio'] == '')
        $edificioerror = '*Debe ingresar el edificio con el formato correcto, ejemplo: R3';
      if($_POST['sala'] == '')
        $salaerror = '*Debe ingresar una sala.';
    }
  }
    if(isset($_POST['elimina']))
  {
	$answer = $usuario->eliminarLaboratorio($_POST['idLab']);
  }

    if(isset($_POST['asigna']))
	 {
	  if($_POST['asigna'] == 'Asignar Carrera')
	  $answer = $usuario->asignarCarrera($_POST['idLab'],$_POST['carrera']);
	  if($_POST['asigna'] == 'No Asignar')
	  $answer = $usuario->noAsignarCarrera($_POST['idLab'],$_POST['carrera']);
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
          <li class="selected"><a href="laboratorios.php">Laboratorios</a></li>
          <li><a href="software.php">Software</a></li>
          <li><a href="asignaturas.php">Asignaturas</a></li>
		  <li><a href="horariolab.php">Horario Laboratorios</a></li>
          <!--<li><a href="contacto.php">Contacto</a></li>-->
          <li><a href="../logout.php">Logout</a></li>
        </ul>
      </div>
    </div>
    <div id="site_content">
	<!--Inicio Campo Asignar Carrera-->
	<?php
	  if(isset($_POST['asigna']))
	  {
		echo'<div class="sidebar"><h2>Asignar Carrera</h2>';
		//listar softwares no asignados al ramo (en combobox)
		echo '<table><form method="post" name="asignarCarrera" target="_self"><input type="hidden" name="idLab" value='.$_POST['idLab'].' />
          <tr><td>Asignar a Laboratorio con ID '.$_POST['idLab'].'</td></tr><tr><td><select name="carrera" width="100" style="width: 100px">';
		echo $usuario->listarCarreraAsignar($_POST['idLab']);
		echo '</select></td></tr><tr><td><input type="submit" name="asigna" value="Asignar Carrera" /></td></tr></form></table>';
		//listar softwares asignados al ramo

		echo $usuario->listarCarrerasAsignadas($_POST['idLab']);
		echo '</div>';		
	  }
	  ?>
	
      <div id="content">
        <!--Inicio Campo Agregar-->
        <h1>Agregar Laboratorio:</h1>
		<table>
        <form method="post" name="agregar" target="_self">
          <tr><td>Edificio</td><td>Nro. Sala</td></tr>
          <tr><td><input type="text" name="edificio" value="" maxlength="3" class="xl"></input></td>
          <td><input type="text" name="sala" value="" maxlength="3"></input></td>
          <td><input id="btt" type="submit" name="agrega" value="Agregar laboratorio"></input></td></tr>
		  
          <tr><td><?php if(isset($edificioerror)) echo '<span class="error">'.$edificioerror.'</span>';?></td>
              <td><?php if(isset($salaerror)) echo '<span class="error">'.$salaerror.'</span>';?></td>
          </tr>
		  
        </form>
        </table>
		<!--Fin Campo Agregar-->
		<!--Inicio Campo Modificar-->
		<?php
		if(isset($_POST['modifica']))
		{

		
		  if($_POST['modifica'] == 'Modificar laboratorio')
			{
			if(isset($_POST['edificio2']) && $_POST['edificio2'] != '' && $_POST['sala2'] != '')
			{
			$answer = $usuario->modificarLaboratorio($_POST['id2'],$_POST['edificio2'],$_POST['sala2']);
			}
			else
			{
			if($_POST['edificio2'] == '')
			$edificioerror2 = '*Debe ingresar el edificio con el formato correcto, ejemplo: R3 <br>';
			if($_POST['sala2'] == '')
			$salaerror2 = '*Debe ingresar una sala. <br>';
    }
  } else {
		$dato=$_POST['idLab'];
		$arrDatos=$usuario->obtenerDatosLab($dato);
		?>
			<h2>Modificar Laboratorio:</h2>
			<table>
			<form method="post" name="modificar" target="_self">
			<tr><td>ID</td><td>Edificio</td><td>Nro. Sala</td></tr>
			<tr><td><input type="hidden" name="id2" value="<?php echo $dato; ?>"><?php echo $dato; ?></input></td>
			<td><input type="text" name="edificio2" value="<?php echo $arrDatos[0]; ?>" maxlength="3" class="xl"></input></td>
			<td><input type="text" name="sala2" value="<?php echo $arrDatos[1]; ?>" maxlength="3"></input></td>
			<td><input id="btt" type="submit" name="modifica" value="Modificar laboratorio"></input></td></tr>		  
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
		<h1>Lista de laboratorios:</h1><ul>
          
		<form method="post" name="listar" target="_self">
		<?php
		$usuario->listarLaboratorio();
		?>
        </form>        
        </ul>
		<!--Fin Campo Listar-->
		</div>
		</div>
		<div id="content_footer"></div>
    <div id="footer">
		</div>
</html>

<?php
}
else
{
  header("Location: ../index.php");
  exit();
}
