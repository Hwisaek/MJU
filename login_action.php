<?php

        session_start();

        $connect = mysqli_connect("localhost", "root", "", "facerecog") or die("fail");

        //입력 받은 id와 password
        $id=$_POST['id'];
        $pw=$_POST['pw'];

        //아이디가 있는지 검사
        $query = "select * from member where id='$id'";
        $result = $connect->query($query);


        //아이디가 있다면 비밀번호 검사
        if(mysqli_num_rows($result)==1) {

                $row=mysqli_fetch_assoc($result);

                //비밀번호가 맞다면 세션 생성
                if($row['pw']==$pw){
                        $_SESSION['userid']=$id;
                        $_SESSION['eye']=$row['eye'];
                        $_SESSION['mouth']=$row['mouth'];
                        if(isset($_SESSION['userid'])){
                        ?>      <script>
                                        alert("얼굴인식 시작하겠습니다.");
                                        location.replace("./login_action2.php");
                                </script>
<?php
                        }
                        else{
                                echo "로그인에 실패하였습니다.";
                        }
                }

                else {
        ?>              <script>
                                alert("아이디 혹은 비밀번호가 잘못되었습니다.");
                                history.back();
                        </script>
        <?php
                }

        }

                else{
?>              <script>
                        alert("아이디 혹은 비밀번호가 잘못되었습니다.");
                        history.back();
                </script>
<?php
        }


?>
