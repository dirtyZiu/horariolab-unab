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

  if(isset($_POST['agrega']) && $_POST['agrega'] == 'Agregar por NRC')
  {
	if(isset($_POST['nrc']) && $_POST['nrc'] != '')
    {
     $answer = '1';
    }
    else
    {
     $nrcerror = '*Debe ingresar un NRC';
	 }
  }
    if(isset($_POST['agrega']) && $_POST['agrega'] == 'Agregar por codigo')
  {
	if(isset($_POST['codigo']) && $_POST['codigo'] != '' && $_POST['seccion'] != '')
    {
     $answer = '2';
    }
    else
    {
      if($_POST['codigo'] == '')
        $codigoerror = '*Debe ingresar el codigo de la asignatura';
      if($_POST['seccion'] == '')
        $seccionerror = '*Debe ingresar una seccion.';
    }
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
      <div id="content">
        <!-- Inicio Campo Listar -->
        <h1>Lista de Asignaturas que usan Laboratorio</h1>
		<?php
		$usuario->listarAsignaturasUsanLab();
		?>
		<!-- Fin Campo Listar -->
		
		<!-- Inicio Campo Añadir -->
		<!-- Se deben agregar 2 formularios, uno para agregar por codigo de asignatura + seccion, otro solo con NRC, si existe mas de un resultado mostrar error. si existe, automaticamente asignar laboratorio en todos sus campos. -->
		<h1>A&ntildeadir Asignaturas que usan Laboratorio</h1>
		<?php if(isset($answer)) echo '<span class="error">'.$answer.'</span>';?>
		<!-- por NRC -->
		<h2>Agregar por NRC:</h2>
		<table>
        <form method="post" name="agregar" target="_self">
          <tr><td>NRC</td></tr>
          <tr><td><input type="text" name="nrc" value="" maxlength="11" class="xl"></input></td>
          <td><input id="btt" type="submit" name="agrega" value="Agregar por NRC"></input></td></tr>		  
          <tr><td><?php if(isset($nrcerror)) echo '<span class="error">'.$nrcerror.'</span>';?></td>
          </tr>		  
        </form>
        </table>
		<!-- por codigo asignatura y seccion -->
		<h2>Agregar por C&oacutedigo de Asignatura y Secci&oacuten: </h2>
		<table>
        <form method="post" name="agregar" target="_self">
          <tr><td>C&oacutedigo Asignatura</td><td>Secci&oacuten </td></tr>
          <tr><td><input type="text" name="codigo" value="" maxlength="11" class="xl"></input></td>
          <td><input type="text" name="seccion" value="" maxlength="3"></input></td>
          <td><input id="btt" type="submit" name="agrega" value="Agregar por codigo"></input></td></tr>		  
          <tr><td><?php if(isset($codigoerror)) echo '<span class="error">'.$codigoerror.'</span>';?></td>
              <td><?php if(isset($seccionerror)) echo '<span class="error">'.$seccionerror.'</span>';?></td>
          </tr>		  
        </form>
        </table>
		<!-- Fin Campo Añadir -->
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
?>