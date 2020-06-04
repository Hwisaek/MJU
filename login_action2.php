<?php
    session_start();
    $python = `face_recog.py`;



    if(strpos($python,$_SESSION['userid'])!==false){
    ?>      <script>

                alert('1차 얼굴인식 성공\n입 모양 테스트');

                location.replace("./login_action3.php");;
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