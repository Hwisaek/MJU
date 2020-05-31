<?php
    $myfilename = "count_blink.txt";
    if(file_exists($myfilename)){
        echo file_get_contents($myfilename);
    }
?>