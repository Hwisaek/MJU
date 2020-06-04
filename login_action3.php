<!-- 입모양 감지 -->
<?php
  session_start();
  $python = `python mouth.py`;
  if ($python>($_SESSION['mouth']*23-15)&& $python<($_SESSION['mouth']*23+15)) {
    ?>
    <script>
      alert("2차 입모양 성공\n 눈 깜빡임 테스트");
      var win = window.open("/read_count.html", "PopupWin", "width=500,height=600");
      location.replace("./login_action4.php");
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
