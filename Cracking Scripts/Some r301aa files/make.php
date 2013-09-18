<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>
<?php
$crname = $_POST['crname'];
$desc = $_POST['desc'];
$filecontent = "The App Was Cracked By:$crname <br> Message From Cracker: $desc" ;
$file = '/var/rasticrac/cracker.txt';
// Open the file to get existing content
$current = file_get_contents($file);
// Append a new person to the file
$current .= $filecontent ;
// Write the contents back to the file
file_put_contents($file, $current);
?>

<body>
</body>
</html>