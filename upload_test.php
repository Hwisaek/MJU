<?php

        	$id=$_POST[id];
echo "id:".$id;
$jpg=$id.'.jpg';
	$python = `capture.py`;
	$filename=rename("recognizeface.jpg","C:/web/Apache24/htdocs/knowns/".$jpg);

if($filename){
        echo "<br>jpgname:".$id."<br>파일이름 변경 성공";
    }else{
        echo "<파일이름 변경 실패"; 
    }
?>
<script>
location.replace("./login.php");
</script>