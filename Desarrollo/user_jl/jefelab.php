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
  
  //obtener semestre actual si no se tiene definido
  if(!isset($_SESSION['codigoSemestre'])){
    $_SESSION['codigoSemestre'] = obtenerSemestre(1);
  }

  //cambiar semestre manualmente
  if(isset($_POST['cambiar']) && $_POST['cambiar'] == 'Cambiar Semestre')
  {
	$_SESSION['codigoSemestre'] = $_POST['semestre'];
  }
  

  ?>
  
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
          <li class="selected"><a href="jefelab.php">Home</a></li>
          <li><a href="laboratorios.php">Laboratorios</a></li>
          <li><a href="software.php">Software</a></li>
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
        <!-- insert the page content here -->
        <h1>Bienvenido Jefe de Laboratorio</h1>
		En Construcci&oacuten (M&oacutedulo de Monitoreo)
		
		<!-- formulario cambio de Semestre -->
		<h1>Semestre "<?php echo $_SESSION['codigoSemestre']; ?>" actualmente seleccionado.</h1>
		<h2>Cambiar Semestre</h2>
		<table>
        <form method="post" name="cambiarSemestre" target="_self">
          <tr><td>C&oacutedigo semestre</td><td></td></tr>
          <tr><td>
		  <select name="semestre">
		  <?php seleccionarSemestres(); ?>
		  </select>
		  </td>
          <td><input id="btt" type="submit" name="cambiar" value="Cambiar Semestre"></input></td></tr>
        </form>
        </table>
		
      </div>
    </div>
    <div id="content_footer"></div>
    <div id="footer">
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