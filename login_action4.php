<?php
  session_start();
  $python = `eye.py`;
  ?>
  <script>
    var win = window.open("/read_count.html", "PopupWin", "width=500,height=600");
  </script>
  <?php
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
