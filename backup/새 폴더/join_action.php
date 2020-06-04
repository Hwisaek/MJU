<?php
        error_reporting(0);
 
        $connect = mysqli_connect("localhost", "root", "", "facerecog") or die("fail");
 

        $id=$_GET[id];
        $pw=$_GET[pw];
        $email=$_GET[email];
        $name=$_GET[name];
        $userfile = $_get[userfile];
        $mouth = $_GET[mouth];
        $eye = $_GET[eye];
        $date = date('Y-m-d H:i:s');
        $query = "select * from member where id='$id'";
        $result = $connect->query($query);
        //아이디가 있다면 비밀번호 검사
        if(mysqli_num_rows($result)==1) {
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
                        if($result) {
                            ?>
                            <html>
                                <body>
                                <script>

                                    alert("사진 찍습니다. 정면을 바라봐주세요");
                                </script>
            		            
                                <form name=form action="./upload_test.php" method="POST">
                                <input type = hidden value = <?php echo $id;?> name = id>
                                </form>
                                </body>
                            </html>
                            <script>
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