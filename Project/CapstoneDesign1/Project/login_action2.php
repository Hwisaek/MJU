<!-- 얼굴 인식 로그인 -->
<!-- login_action2.php -->
<?php
  session_start();
  $python = `python face_recog.py`;
  if(strpos($python,$_SESSION['userid'])!==false){
    ?>
    <script>
      alert('1차 얼굴인식 성공\n입 모양 테스트');
      // var win = window.open("/read_count1.html", "PopupWin", "width=500,height=600"); // 입 모양 카운트 수 출력을 위해 새 창 띄우기
      location.replace("./login_action3.php");;
    </script>
    <?php
    }
  else{
   ?>
   <script>
     alert("로그인 실패");
     location.replace("./login.php");
   </script>
   <?php
  }
?>
