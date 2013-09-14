<?php

$response = http_get("http://www.appaddict.org/mass-upload.php?api=1&cracker=yourcrname&links=jsonlinks&url=itunesurl", $info);
print_r($info);

?>