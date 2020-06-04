<?php
                $connect = mysqli_connect("localhost", "root", "", "facerecog") or die("fail");
                
                $id = $_GET[name];                      //Writer

                $title = $_GET[title];                  //Title
                $content = $_GET[content];              //Content
                $date = date('Y-m-d H:i:s');            //Date
 
                $URL = './index.php';                   //return URL
 
 
                $query = "insert into board (number,title, content, date, hit, id)
                        values(null,'$title', '$content', '$date',0, '$id')";
 
 
                $result = $connect->query($query);
                if($result){
?>                  <script>
                        alert("<?php echo "글이 등록되었습니다."?>");
                        location.replace("<?php echo $URL?>");
                    </script>
<?php
                }
                else{
                        echo "FAIL";
                }
 
                mysqli_close($connect);
?>


