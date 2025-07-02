<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login - KiddyKart</title>
<link rel="icon" type="assets/logo2.png" href="assets/logo2.png">
<style>
  body {
    font-family: 'Comic Sans MS', cursive, sans-serif;
    background: linear-gradient(to right, #f6d365, #fda085);
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
  }

  .login-container {
    background-color: #fff5e6;
    padding: 40px;
    border-radius: 25px;
    box-shadow: 0 10px 20px rgba(0,0,0,0.1);
    text-align: center;
    width: 300px;
  }

  h2 {
    color: #ff6f61;
    margin-bottom: 30px;
  }

  input[type="email"],
  input[type="password"] {
    width: 90%;
    padding: 10px;
    margin: 10px 0;
    border: 2px solid #ffdab9;
    border-radius: 10px;
    font-size: 1em;
  }

  input[type="submit"] {
    background-color: #ff6f61;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 20px;
    font-size: 1em;
    cursor: pointer;
    margin-top: 15px;
  }

  input[type="submit"]:hover {
    background-color: #ff3e30;
  }

  .back-link {
    margin-top: 20px;
    display: block;
    color: #555;
    text-decoration: none;
    font-size: 0.9em;
  }
</style>
</head>
<body>

  <div class="login-container">
    <h2>Login to KiddyKart</h2>
    <form method="post" action="../LoginServlet">
      <input type="email" name="email" placeholder="Email" required><br>
      <input type="password" name="password" placeholder="Password" required><br>
      <input type="submit" value="Login">
    </form>
    <a href="../index.html" class="back-link">← Back to Home</a>
  </div>

</body>
</html>
