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

    if(isset($_POST['modifica']))
  {
	if($_POST['modifica'] == 'Agregar'){
		if(isset($_POST['codigo']) && $_POST['codigo'] != '')
		{
		$answer = $usuario->agregarAsigConLab($_POST['codigo']);
		}
		else
		{
		if($_POST['codigo'] == '')
        $codigoerror = '*Debe ingresar el codigo de la asignatura';
		}
	}
  }
  
        if(isset($_POST['elimina'])&& $_POST['elimina'] == 'Eliminar')
  {
	$answer = $usuario->eliminarRamoLab($_POST['codigo']);
  }
  
  if(isset($_POST['asigna']))
	 {
	  if($_POST['asigna'] == 'Asignar Software')
	  $answer = $usuario->asignarSoftware($_POST['codigo'],$_POST['software']);
	  if($_POST['asigna'] == 'No Asignar')
	  $answer = $usuario->noAsignarSoftware($_POST['codigo'],$_POST['software']);
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
          <li><a href="software.php">Software</a></li>
          <li class="selected"><a href="asignaturas.php">Asignaturas</a></li>
		  <li><a href="horariolab.php">Horario Laboratorios</a></li>
          <!--<li><a href="contacto.php">Contacto</a></li>-->
          <li><a href="../logout.php">Logout</a></li>
        </ul>
      </div>
    </div>
    <div id="site_content">
	
      <?php
	  if(isset($_POST['asigna']))
	  {
		echo'<div class="sidebar">';
		//listar softwares no asignados al ramo (en combobox)
		echo '<table><form method="post" name="asignarSoftware" target="_self"><input type="hidden" name="codigo" value='.$_POST['codigo'].' />
          <tr><td>Asignar Software a '.$_POST['codigo'].'</td></tr><tr><td><select name="software">';
		echo $usuario->listarSoftwareAsignar($_POST['codigo']);
		echo '</select></td></tr><tr><td><input type="submit" name="asigna" value="Asignar Software" /></td></tr></form></table>';
		//listar softwares asignados al ramo

		echo $usuario->listarSoftwareAsignados($_POST['codigo']);
		echo '</div>';		
	  }
	  ?>
      <div id="content">
	  	<?php if(isset($answer)) echo '<span class="error">'.$answer.'</span>';?>
		
				<!-- Inicio Campo Añadir -->
		<h1>A&ntildeadir Asignaturas que usan Laboratorio</h1>
		<table>
        <form method="post" name="agregar" target="_self">
          <tr><td>C&oacutedigo</td></tr>
          <tr>
		  <td><input type="text" name="codigo" value="" maxlength="11" class="xl"></input></td>
          <td><input id="btt" type="submit" name="modifica" value="Agregar"></input></td>
		  </tr>		  
          <tr><td><?php if(isset($codigoerror)) echo '<span class="error">'.$codigoerror.'</span>';?></td>
          </tr>		  
        </form>
        </table>
		<!-- Fin Campo Añadir -->
		
		<!-- Inicio Respaldo Campo Añadir
		<h1>A&ntildeadir Asignaturas que usan Laboratorio</h1>
		<table>
        <form method="post" name="agregar" target="_self">
          <tr><td>C&oacutedigo</td><td>Teor&iacutea</td><td>Ayudant&iacutea</td><td>Laboratorio</td><td>Taller</td></tr>
          <tr>
		  <td><input type="text" name="codigo" value="" maxlength="11" class="xl"></input></td>
		  <td><input type="checkbox" name="teoria" value="si"> usa lab </input></td>
		  <td><input type="checkbox" name="ayudantia" value="si"> usa lab </input></td>
		  <td><input type="checkbox" name="laboratorio" value="si"> usa lab </input></td>
		  <td><input type="checkbox" name="taller" value="si"> usa lab </input></td>
          <td><input id="btt" type="submit" name="agrega" value="Agregar"></input></td>
		  </tr>		  
          <tr><td><?php if(isset($codigoerror)) echo '<span class="error">'.$codigoerror.'</span>';?></td>
          </tr>		  
        </form>
        </table>
		 Fin Respaldo Campo Añadir -->
		 
		 <!-- Inicio Modificar Horas que usan Lab -->
<?php
		if(isset($_POST['agrega']) || isset($_POST['modifica']))
		{	
		if(!(isset($answer))) $answer = "";
		
		if(isset($codigoerror) || $answer == "*Codigo no existe." || $answer == "*Asignatura no agregada.")
		{			
		} else {		
		if ($_POST['modifica'] == "Modificar ramo"){
		$teo = 'no';
		$ayu = 'no';
		$lab = 'no';
		$tal = 'no';
		if(isset($_POST['teoria'])) $teo = 'si';
		if(isset($_POST['ayudantia'])) $ayu = 'si';
		if(isset($_POST['laboratorio'])) $lab = 'si';
		if(isset($_POST['taller'])) $tal = 'si';
		$answer = $usuario->modificarRamoLab($_POST['codigo'],$teo,$ayu,$lab,$tal);		
	}else{

?>
		<span id='modificar'><h2>Modificar Horas que usan Laboratorios</h2></span>
		 <form method="post" name="agregar" target="_self"><table>
          <tr><td>C&oacutedigo: </td><td> <?php echo $_POST['codigo']; ?> </td></tr>
		  <?php
		  $usuario->formModificarRamo($_POST['codigo']);	  
		  ?>
		  </table></form>
<?php
		}
		}
		}
?>
		 <!-- Fin Modificar Horas que usan Lab -->
		
        <!-- Inicio Campo Listar -->
        <h1>Lista de Asignaturas que usan Laboratorio</h1>
		<?php
		$usuario->listarAsignaturasUsanLab();
		?>
		<!-- Fin Campo Listar -->
		
      </div>
    </div>
	<div id="content_footer"></div>
    <div id="footer">
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
?>