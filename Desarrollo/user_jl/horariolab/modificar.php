<?php
foreach (glob("../../class/*.php") as $filename) {
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
//obtener semestre
  if(!isset($_SESSION['codigoSemestre'])){
    $_SESSION['codigoSemestre'] = obtenerSemestre(1);
  }  

  if(isset($_POST['modifica']) && $_POST['modifica'] == 'Modificar')
  {
  $idLab = $_POST['laboratorio'];
  if( $idLab < 0 ){
		$answer = borrarDeHorario($_GET['id'],$_SESSION['codigoSemestre']);
  }else{
		$answer = modificarDeHorario($_POST['id'],$idLab,$_SESSION['codigoSemestre']);
  }     
  }
  
      if(isset($_POST['elimina']))
  {
	$answer = $usuario->eliminarSoftware($_POST['idSw']);
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
  <link rel="stylesheet" type="text/css" href="../../style/style.css" title="style" />
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
          <li><a href="../jefelab.php">Home</a></li>
          <li><a href="../laboratorios.php">Laboratorios</a></li>
          <li><a href="../software.php">Software</a></li>
          <li><a href="../asignaturas.php">Asignaturas</a></li>
		  <li class="selected"><a href="../horariolab.php">Horario Laboratorios</a></li>
          <!--<li><a href="contacto.php">Contacto</a></li>-->
          <li><a href="../logout.php">Logout</a></li>
        </ul>
      </div>
    </div>
    <div id="site_content">
	
	<h1>Modificar Horario de Laboratorio</h1>
	Cambiar Asignatura de Laboratorio
	<?php if(isset($answer)) echo '<br></br><span class="error">'.$answer.'</span>';?>
	<form method="post" name="modificar" target="_self">
	<input type="hidden" name="id" value="<?php echo $_GET['id']; ?>"></input>
	<?php $arrDatos = arrInfoClases($_SESSION['codigoSemestre'],$_GET['id']);	?>
	<table>
	<tr><td>NRC</td><td>Asignatura</td><td>Secci&oacuten</td><!--<td>Laboratorio Actual</td>--><td>Nuevo Laboratorio</td></tr>
	<tr><td><?php echo $arrDatos[1].' - '.$arrDatos[2]; ?></td><td><?php echo $arrDatos[3]; ?></td><td><?php echo $arrDatos[4].' - '.$arrDatos[5]; ?></td><!--<td>estatico lab act</td>-->
	<td><select name="laboratorio" width="200" style="width: 200px">
	<option value="-1">Sin Asignar</option>
	<?php
	$arrLaboratorios = arrLaboratorios();
	$sizeof_arr = sizeof($arrLaboratorios);
          for($i = 0;$i<$sizeof_arr;$i++)
          {
		  echo '<option value="'.($arrLaboratorios[$i][0]).'">'.($arrLaboratorios[$i][1]).'-'.($arrLaboratorios[$i][2]).'</option>';
          }
          echo '</tr></table>';
	?>
	
	</select></td>
	</tr></table>
	<input id="btt" type="submit" name="modifica" value="Modificar"></input>
	</form>
	
	  
      <div id="content">

      </div>
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