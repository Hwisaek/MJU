<?php
  $id=$_POST[id];
  echo "id:".$id;
  $jpg=$id.'.jpg';

  $python = `python capture.py`;
  $filename=rename("recognizeface.jpg", "F:/web/Apache24/htdocs/knowns/".$jpg);

  if ($filename) {
      echo "<br>jpgname:".$id."<br>파일이름 변경 성공";
  } else {
      echo "파일이름 변경 실패";
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
