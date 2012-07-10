<?php
include_once('db/connect.php');
include_once('db/funciones.php');

class profesor {
  public $rut;
  public $nombre;
  public $grado;

function __construct($rut)
{
  $this->rut = $rut;
}

function __destruct()
{
}

public function modificarProfesor($nombre,$grado)
{
  global $mysqli,$db_host,$db_user,$db_pass,$db_database;
  $rutProfesor = $this->getRut();
  $mysqli = @new mysqli($db_host, $db_user, $db_pass, $db_database);
  if($grado == 0)
    $sql = "UPDATE Profesor SET Nombre = '{$nombre}' WHERE RUT_Profesor = '{$rutProfesor}';";
  else
    $sql = "UPDATE Profesor SET Nombre = '{$nombre}', Profesor_Grado = '{$grado}' WHERE RUT_Profesor = '{$rutProfesor}';";
  if(($mysqli->query($sql)) == true)
  {
    $answer = '*Profesor modificado.';
  }
  else
  {
    $answer = '*Profesor no modificado.';
  }
  return $answer;
}

public function setNombre($nombre)
{
  $this->nombre = $nombre;
}

public function setGrado($grado)
{
  $this->grado = $grado;
}

public function getRut()
{
  return $this->rut;
}

public function getNombre()
{
  return $this->nombre;
}

public function getGrado()
{
  return $this->grado;
}
}
?>
