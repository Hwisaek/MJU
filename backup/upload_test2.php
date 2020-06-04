
<?php
$uploaddir = './knowns/';
$uploadfile = $uploaddir . basename($_FILES['userfile']['name']);

echo '<pre>';
if($_POST['MAX_FILE_SIZE'] < $_FILES['userfile']['size']){
	echo "업로드 파일이 지정된 파일크기보다 큽니다.\n";
} else {
	if(($_FILES['userfile']['error'] > 0) || ($_FILES['userfile']['size'] <= 0)){
		echo "사진을 등록해주세요.";
	} else {
		if(!is_uploaded_file($_FILES['userfile']['tmp_name'])) {
			echo "HTTP로 전송된 파일이 아닙니다.";
		} else {
			if (move_uploaded_file($_FILES['userfile']['tmp_name'], $uploadfile)) {
				echo "성공적으로 사진이 업로드 되었습니다.\n";

			} else {
				echo "파일 업로드 실패입니다.\n";
			}
		}
	}
}
?>
 <div class = text>
        <font style="cursor: hand"onClick="location.href='./login.php'">완료</font>
</div>
