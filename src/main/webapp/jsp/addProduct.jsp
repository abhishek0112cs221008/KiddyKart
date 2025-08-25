<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add New Product | QuickKartKids</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="assets/logo2.png" href="assets/logo2.png">
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      background: linear-gradient(120deg, #ffe2e2, #fad0c4);
      font-family: 'Segoe UI', sans-serif;
      padding-top: 40px;
    }
    .form-container {
      max-width: 600px;
      background: #fff;
      margin: auto;
      padding: 30px;
      border-radius: 16px;
      box-shadow: 0 6px 20px rgba(0,0,0,0.1);
    }
    .form-title {
      text-align: center;
      font-size: 28px;
      font-weight: bold;
      color: #ff6f61;
      margin-bottom: 25px;
    }
    .btn-add {
      background-color: #ff6f61;
      border: none;
    }
    .btn-add:hover {
      background-color: #ff3e30;
    }
  </style>
</head>
<body>

  <div class="form-container">
    <div class="form-title">🧸 Add New Product</div>
    <form method="post" action="../ProductServlet">
      <input type="hidden" name="action" value="add">

      <div class="mb-3">
        <label class="form-label">Product Name</label>
        <input type="text" class="form-control" name="name" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Category</label>
        <input type="text" class="form-control" name="category" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Price (₹)</label>
        <input type="number" step="0.01" class="form-control" name="price" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Quantity</label>
        <input type="number" class="form-control" name="quantity" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Image URL</label>
        <input type="text" class="form-control" name="imageUrl" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Description</label>
        <textarea class="form-control" name="description" rows="4" required></textarea>
      </div>

      <div class="d-grid">
        <button type="submit" class="btn btn-add btn-lg text-white">➕ Add Product</button>
      </div>
    </form>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add New Product | QuickKartKids</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="assets/logo2.png" href="assets/logo2.png">
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      background: linear-gradient(120deg, #ffe2e2, #fad0c4);
      font-family: 'Segoe UI', sans-serif;
      padding-top: 40px;
    }
    .form-container {
      max-width: 600px;
      background: #fff;
      margin: auto;
      padding: 30px;
      border-radius: 16px;
      box-shadow: 0 6px 20px rgba(0,0,0,0.1);
    }
    .form-title {
      text-align: center;
      font-size: 28px;
      font-weight: bold;
      color: #ff6f61;
      margin-bottom: 25px;
    }
    .btn-add {
      background-color: #ff6f61;
      border: none;
    }
    .btn-add:hover {
      background-color: #ff3e30;
    }
  </style>
</head>
<body>

  <div class="form-container">
    <div class="form-title">🧸 Add New Product</div>
    <form method="post" action="../ProductServlet">
      <input type="hidden" name="action" value="add">

      <div class="mb-3">
        <label class="form-label">Product Name</label>
        <input type="text" class="form-control" name="name" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Category</label>
        <input type="text" class="form-control" name="category" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Price (₹)</label>
        <input type="number" step="0.01" class="form-control" name="price" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Quantity</label>
        <input type="number" class="form-control" name="quantity" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Image URL</label>
        <input type="text" class="form-control" name="imageUrl" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Description</label>
        <textarea class="form-control" name="description" rows="4" required></textarea>
      </div>

      <div class="d-grid">
        <button type="submit" class="btn btn-add btn-lg text-white">➕ Add Product</button>
      </div>
    </form>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
>>>>>>> 7b9624a1060791e2afa1cd9a789ecd481afb6739
