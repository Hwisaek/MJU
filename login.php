<!DOCTYPE>
<!-- 로그인 페이지 -->
<html>

<head>
  <meta charset='utf-8'>
</head>

<body>

  <body background="good.png">
    <div align='center'>
      <span>로그인</span>
      <?php
        session_start();
        $result = session_destroy(); //로그인 페이지에 들어올 경우 로그아웃
      ?>
      <form method='POST' action='login_action.php'>
        <p>ID: <input name="id" type="text"></p>
        <p>PW: <input name="pw" type="password"></p>
        <input type="submit" value="로그인">
      </form>
      <br>
      <button id="join" onclick="location.href='./join.php'">회원가입</button>
    </div>
  </body>

</html>
