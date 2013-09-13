<?php

$response = http_get("http://www.appaddict.org/login.php?email=youremail&password=yourpass", $info);
print_r($info);

?>