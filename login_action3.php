<?php
    session_start();
    $python = `mouth.py`;

<<<<<<< HEAD

=======
    // var win = window.open("/read_count1.html", "PopupWin", "width=500,height=600");
>>>>>>> fce6f3e270709750d2228be142c78b1fa2420c32



    if($python>($_SESSION['mouth']*23-15)&& $python<($_SESSION['mouth']*23+15)){
    ?>      <script>

                alert("2차 입모양 성공\n 눈 깜빡임 테스트");
                location.replace("./login_action4.php");
            </script>
<?php
        }
     else{
         ?>      <script>

                     alert("로그인 실패");

                     location.replace("./login.php");
                 </script>
<?php

     }


?>
