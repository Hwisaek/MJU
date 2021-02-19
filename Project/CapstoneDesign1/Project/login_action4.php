<!-- 눈 깜빡임 감지 -->
<!-- login_action4.php -->
<?php
  session_start();
  $python = `python eye.py`;
  echo $python;
  if (strpos($python,$_SESSION['eye'])==true) { // DB에 저장된 눈 깜빡임 횟수와 일치하면 로그인
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
