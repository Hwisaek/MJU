<?php
    session_start();
    $python = `eye.py`;
    echo $python;
<<<<<<< HEAD
 ?>
  
=======
  // <script>
  //   var win = window.open("/read_count.html", "PopupWin", "width=500,height=600");
  // </script>
>>>>>>> fce6f3e270709750d2228be142c78b1fa2420c32

    if(strpos($python,$_SESSION['eye'])==true){
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
