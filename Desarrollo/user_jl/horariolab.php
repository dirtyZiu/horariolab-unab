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
  
  //obtener regimen y semestre actual si no se tiene definido
  if(!isset($_SESSION['codigoSemestre'])){
    $_SESSION['codigoSemestre'] = obtenerSemestre(1);
  }
  if(!isset($_SESSION['regimen'])){
    $_SESSION['regimen'] = 'D';
  }

  //cambiar regimen y semestre manualmente
  if(isset($_POST['cambiar']) && $_POST['cambiar'] == 'Cambiar Semestre')
  {
	$_SESSION['codigoSemestre'] = $_POST['semestre'];
  }
  if(isset($_POST['cambiar']) && $_POST['cambiar'] == 'Cambiar Regimen')
  {
	$_SESSION['regimen'] = $_POST['regimen'];
  }
  
  if(isset($_GET['lab']) && isset($_GET['lab'])!=NULL){
	$_SESSION['lab'] = $_GET['lab'];
  }
    

  ?>
<html>

<head>
  <title>JL Horario</title>
  <meta charset="utf-8" />
  <meta name="description" content="website description" />
  <meta name="keywords" content="website keywords, website keywords" />
  <meta http-equiv="content-type" content="text/html; charset=windows-1252" />
  <link rel="stylesheet" type="text/css" href="../style/style.css" title="style" />
  <link rel="stylesheet" type="text/css" href="../style/bsc.css" title="style" />
  <script type="text/javascript" src="../js/jquery-1.6.1.min.js"></script>
  <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
  <script type="text/javascript" src="../js/js.js"></script>

  <script>
		$(function(){
                        $('.bin td.drop').droppable({
                                onDragEnter:function(){
                                        $(this).addClass('over');
                                },
                                onDragLeave:function(){
                                        $(this).removeClass('over');
                                },
                                onDrop:function(e,source){
                                        $(this).removeClass('over');
                                        ans = noAsignarHorarioLab($(source).attr('id'));
                                        if(ans == 1)
                                        {
                                          var b = $(source).addClass('assigned');
                                          $('.last').append(b);
                                          b.draggable({
                                                revert: true
                                          });
                                          document.getElementById("resp").innerHTML = '<span class="error">Horario de la clase borrado.</span>';
                                        }
                                        else if(ans == 2)
                                        {
                                          document.getElementById("resp").innerHTML = '<span class="error">No se puede borrar horario de la clase.</span>';
                                        }
                                }
                        });
			$('.up .item').draggable({
				revert:true
			});
                        $('.down .item').draggable({
                                revert:true
                        });
			$('.down td.drop').droppable({
				onDragEnter:function(){
					$(this).addClass('over');
				},
				onDragLeave:function(){
					$(this).removeClass('over');
				},
				onDrop:function(e,source){
					$(this).removeClass('over');
                                                var err1 = '<span class="error">*Horario ya pertenece a un ramo diferente.</span>';
                                                var err2 = '<span class="error">*Ya existe una clase de la misma sección en este horario.</span>';
                                                var err3 = '<span class="error">*Este horario tiene una clase de una sección obtenida por solicitud.</span>';
                                                var scc = '<span class="error">*Horario asignado.</span>';
                                                var err4 = '<span class="error">*Horario no asignado, intentelo más tarde.</span>';
                                                var resp;
                                                resp = asignarHorarioLab($(source).attr('id'),$(this).attr('id'));
                                                if(resp == '-2')
                                                {
                                                  document.getElementById("resp").innerHTML=err1;
                                                }
                                                else if(resp == '-1')
                                                {
                                                  document.getElementById("resp").innerHTML=err2;
                                                }
                                                else if(resp == '0')
                                                {
                                                  document.getElementById("resp").innerHTML=err3;
                                                }
                                                else if(resp == '1')
                                                {
                                                  document.getElementById("resp").innerHTML=scc;
                                                  var c = $(source).addClass('assigned');
						  $(this).append(c);
						  c.draggable({
						       	revert:true
						  });
                                                }
                                                else if(resp == '2')
                                                {
                                                  document.getElementById("resp").innerHTML=err4;
                                                }
				}
			});
		});
	</script>
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
          <li><a href="asignaturas.php">Asignaturas</a></li>
		  <li class="selected"><a href="horariolab.php">Horario Laboratorios</a></li>
          <!--<li><a href="contacto.php">Contacto</a></li>-->
          <li><a href="../logout.php">Logout</a></li>
        </ul>
      </div>
    </div>
	<div id="site_content"><div id="content">
	<!-- Formulario codigo semestre -->
		<h1>Semestre "<?php echo $_SESSION['codigoSemestre']; ?>" y R&eacutegimen "<?php echo $_SESSION['regimen']; ?>" actualmente seleccionados.</h1>
		<h2>Cambiar Valores</h2>
		<table>
        <form method="post" name="cambiarSemestre" target="_self">
          <tr><td>C&oacutedigo semestre</td>
          <td><select name="semestre">
		  <?php seleccionarSemestres(); ?>
		  </select></td>
          <td><input id="btt" type="submit" name="cambiar" value="Cambiar Semestre"></input></td></tr>
		  <tr><td>R&eacutegimen</td>
		  <td><select name="regimen">
		  <option value="D">D</option><option value="V">V</option>
		  </select></td>
		  <td><input id="btt" type="submit" name="cambiar" value="Cambiar Regimen"></input></td></tr>
        </form>
        </table>
	

        <!-- insert the page content here -->
		
		<!-- Horario -->
        <h2>Horario</h2>
        <div>
		
        <?php
				
		// Cantidad de laboratorios existentes		
          $arrLaboratorios = arrLaboratorios();
          echo '<table class="centerTable"><tr>';	
		  $sizeof_arr = sizeof($arrLaboratorios);
          for($i = 0;$i<$sizeof_arr;$i++)
          {
            if(isset($_GET['lab']) && $_GET['lab'] == ($arrLaboratorios[$i][0]))
              echo '<td class="dc"><a href="horariolab.php?lab='.($arrLaboratorios[$i][0]).'">'.($arrLaboratorios[$i][1]).'-'.($arrLaboratorios[$i][2]).'</a></td>';
            else
              echo '<td><a href="horariolab.php?lab='.($arrLaboratorios[$i][0]).'">'.($arrLaboratorios[$i][1]).'-'.($arrLaboratorios[$i][2]).'</a></td>';
          }
          echo '</tr></table>';
		
		
		//clases sin asignacion de horario en laboratorio
		
          echo '<div class="up">';
          if(isset($_GET['lab']))
            verClasesSinHorarioLab($_SESSION['codigoSemestre'],$_SESSION['regimen']);
          elseif(isset($_POST['lab']))
            verClasesSinHorarioLab($_SESSION['codigoSemestre'],$_SESSION['regimen']);
          echo '</div>';
		
		
		// abajo: boton borrar asignatura del horario
          echo '<div class="bin"><table><tr><td class="drop" style="border: 1px black solid;">Borrar el horario<br>de una clase</td></tr></table></div>';

          echo '<div id="resp"></div>';
 
		// abajo: ver horario deacuerdo a laboratorio
		
          if(isset($_GET['lab']) || (isset($_POST['submit']) && $_POST['submit'] == 'Cambiar' && isset($_POST['lab'])))
          {
            if(isset($_GET['lab'])) 
            {
              verHorarioLab($_SESSION['codigoSemestre'],$_GET['lab'],$_SESSION['regimen']);
              echo '</div>';
            }
            elseif(isset($_POST['submit']) && $_POST['submit'] == 'Cambiar' && isset($_POST['lab']))
            {
              verHorarioLab($_SESSION['codigoSemestre'],$_POST['lab'],$_SESSION['regimen']);
              echo '</div>';
            }
          }
		  /*
          else
          {
            verHorarioLab($_SESSION['codigoSemestre'],$_SESSION['regimen']);
            echo '</div>';
          }   
		*/
		  
		// Cantidad de laboratorios existentes
          echo '<table class="centerTable"><tr>';
          for($i = 0;$i<$sizeof_arr;$i++)
          {
            if(isset($_GET['lab']) && $_GET['lab'] == ($arrLaboratorios[$i][0]))
              echo '<td class="dc"><a href="horariolab.php?lab='.($arrLaboratorios[$i][0]).'">'.($arrLaboratorios[$i][1]).'-'.($arrLaboratorios[$i][2]).'</a></td>';
            else
              echo '<td><a href="horariolab.php?lab='.($arrLaboratorios[$i][0]).'">'.($arrLaboratorios[$i][1]).'-'.($arrLaboratorios[$i][2]).'</a></td>';
          }
          echo '</tr></table>';
        ?>
        <br><br>
      </div>
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