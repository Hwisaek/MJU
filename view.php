<?php
  $connect = mysqli_connect("localhost", "root", "", "facerecog");
  $number = $_GET['number'];
  session_start();
  $query = "select title, content, date, hit, id from board where number =$number";
  $result = $connect->query($query);
  $rows = mysqli_fetch_assoc($result);
?>
<style>
  .view_table {
    border: 1px solid #444444;
    margin-top: 30px;
  }

  .view_title {
    height: 30px;
    text-align: center;
    background-color: #cccccc;
    color: white;
    width: 1000px;
  }

  .view_id {
    text-align: center;
    background-color: #EEEEEE;
    width: 30px;
  }

  .view_id2 {
    background-color: white;
    width: 60px;
  }

  .view_hit {
    background-color: #EEEEEE;
    width: 30px;
    text-align: center;
  }

  .view_hit2 {
    background-color: white;
    width: 60px;
  }

  .view_content {
    padding-top: 20px;
    border-top: 1px solid #444444;
    height: 500px;
  }

  .view_btn {
    width: 700px;
    height: 200px;
    text-align: center;
    margin: auto;
    margin-top: 50px;
  }

  .view_btn1 {
    height: 50px;
    width: 100px;
    font-size: 20px;
    text-align: center;
    background-color: white;
    border: 2px solid black;
    border-radius: 10px;
  }

  .view_comment_input {
    width: 700px;
    height: 500px;
    text-align: center;
    margin: auto;
  }

  .view_text3 {
    font-weight: bold;
    float: left;
    margin-left: 20px;
  }

  .view_com_id {
    width: 100px;
  }

  .view_comment {
    width: 500px;
  }
</style>

<table class="view_table" align=center>
  <tr>
    <td colspan="4" class="view_title"><?php echo $rows['title']?></td>
  </tr>
  <tr>
    <td class="view_id">작성자</td>
    <td class="view_id2"><?php echo $rows['id']?></td>
    <td class="view_hit">조회수</td>
    <td class="view_hit2"><?php echo $rows['hit']?></td>
  </tr>


  <tr>
    <td colspan="4" class="view_content" valign="top">
      <?php echo $rows['content']?></td>
  </tr>
</table>

<!-- MODIFY & DELETE -->
<div class="view_btn">
  <?php
    $hit = "update board set hit=hit+1 where number=$number";
    $connect->query($hit);
  ?>
  <button class="view_btn1" onclick="location.href='./index.php'">목록으로</button>
  <form name=form action="./delete.php" method="GET">
    <input type=hidden value=<?php echo $number;?> name=number>
    <input type="submit" value="글 삭제">
  </form>
</div>
