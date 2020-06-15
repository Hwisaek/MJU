<!-- 게시물 삭제 코드 -->
<!-- delete.php -->
<?php
  $number = $_GET['number'];
  echo $number;
  $connect = mysqli_connect("localhost", "root", "", "facerecog");
  $query = "delete from facerecog.board where number =$number";
  $result = $connect->query($query);
?>
<script>
  location.replace("./index.php");
</script>
