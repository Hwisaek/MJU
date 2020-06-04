<?php
    session_start();
    $python = `python eye.py`;
    echo $python;

    if($python==($_SESSION['eye'])) {
    ?>      <script>

                alert("최종 로그인 성공");
                location.replace("./index.php");
            </script>
<?php
        }
     else{
         ?><script>

                alert("로그인 실패");
                location.replace("./login.php");
           </script>
<?php

     }


?>
