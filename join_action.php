<?php
  // php 에러 출력 안하기
  error_reporting(0);

  // php와 mysql 연동
  $connect = mysqli_connect("localhost", "root", "", "facerecog") or die("fail");

  // 회원가입 페이지로부터 값 받아오기
  $id=$_POST[id];
  $pw=$_POST[pw];
  $email=$_POST[email];
  $name=$_POST[name];
  $userfile = $_POST[userfile];
  $mouth = $_POST[mouth];
  $eye = $_POST[eye];
  $date = date('Y-m-d H:i:s');

  // id 중복 검사용
  $query = "select * from member where id='$id'";
  $result = $connect->query($query);

  //아이디가 있다면 비밀번호 검사
  if (mysqli_num_rows($result)==1) {
    ?>
    <script>
      alert("아이디가 중복됩니다.");
      history.back();
    </script>
    <?php
  } else {
  //입력받은 데이터를 DB에 저장
    $query = "insert into member (id, pw, name,mail, date, permit,mouth,eye) values ('$id', '$pw','$name', '$email', '$date', 0,'$mouth','$eye')";
    $result = $connect->query($query);
    if ($result) {
      ?>

      <!-- 얼굴 사진 촬영을 위해 id값을 넘김 -->
      <form name=form action="./upload_test.php" method="POST">
      <input type = hidden value = <?php echo $id; ?> name = id>
      </form>
      <script>
      alert("사진 찍습니다. 정면을 바라봐주세요");
      document.form.submit();
      </script>
      <?php
    } else {
      ?>
      <script>
        alert("fail");
      </script>
  <?php
    }
    mysqli_close($connect);
  }
?>
