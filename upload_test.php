<!-- 회원가입시 사진 업로드 -->
<!-- upload_test.php -->
<?php
  header("Content-Type:text/html;charset=utf-8");
  // php 에러 출력 안하기
  error_reporting(0);

  $id=$_POST[id];
  // echo "id:".$id;
  $jpg=$id.'.jpg';
  $python = `python capture.py`;
  // 파일 명을 변경하여 업로드;
  $python = `python face_recog_img.py`;
  $filename=rename("recognizeface.jpg", "F:/web/Apache24/htdocs/knowns/".$jpg);

  // 개발용 echo
  if ($filename) {
    // echo "<br>jpgname:".$id."<br>사진 찍기 완료";
  } else {
    echo "사진 찍기 실패";
  }

  echo '<h1 id = "forremove">'.$python.'</h1>';
?>

<html>
    <head>
        <meta charset="utf-8" />
        <script src="https://code.jquery.com/jquery-3.1.1.js"></script>
        <script>
            $(document).ready(function () {

                var phpecho = $('h1').html();
                var btn_submit = document.getElementById('submit');
                if(phpecho.indexOf('error') > 2){
                    //alert('bad');
                    btn_submit.disabled = true;
                } else {
                    //alert('good');
                }
                var tag_h1 = document.getElementById('forremove');
                tag_h1.style.visibility = "hidden";
            });
        </script>
    </head>

    <body>
      <br>
      <img src="knowns/<?php echo $id;?>.jpg">
      <br>
      <button id="submit" onclick="location.href='./login.php'">제출</button>
      <button id="recapture" onClick="window.location.reload();">재촬영</button>
    </body>
</html>
