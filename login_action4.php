<?php
  session_start();
  $python = `eye.py`;
  if(strpos($python,$_SESSION['eye'])==true){
    ?>
    <script>
      alert("최종 로그인 성공");
      location.replace("./index.php");
    </script>
    <?php
  } else {
    ?>
    <script>
      alert("로그인 실패");
      location.replace("./login.php");
    </script>
    <?php
  }
?>
