<?php
  // php 에러 출력 안하기
  error_reporting(0);

  $id=$_POST[id];
  // echo "id:".$id;
  $jpg=$id.'.jpg';
  $python = `python capture.py`;
  $filename=rename("recognizeface.jpg", "F:/web/Apache24/htdocs/knowns/".$jpg);

  // 개발용 echo
  if ($filename) {
    // echo "<br>jpgname:".$id."<br>사진 찍기 완료";
  } else {
    echo "사진 찍기 실패";
  }
?>
<html>
  <body>
  <br>
  <img src="knowns/<?php echo $id;?>.jpg">
  <br>
  <button id="submit" onclick="location.href='./login.php'">제출</button>
  <button id="recapture" onClick="window.location.reload();">재촬영</button>
</body>
</html>
