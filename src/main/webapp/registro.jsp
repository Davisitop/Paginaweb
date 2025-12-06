<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Registro Navideño</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="d-flex align-items-center justify-content-center vh-100">
    <div class="nieve-container"></div>
    <div class="card p-4 shadow-lg" style="width: 450px;">
        <span style="font-size:3rem; display:block; text-align:center;">🎄</span>
        <h2 class="text-center mb-4">Únete a la Magia</h2>
        <% String error = request.getParameter("msg"); if(error != null) { %>
            <div class="alert alert-warning p-2 small text-center"><%= error %></div>
        <% } %>
        <form action="registrarCliente.jsp" method="post">
            <div class="mb-3"><label class="form-label fw-bold text-success">Nombre:</label><input type="text" name="nombre" class="form-control" required></div>
            <div class="mb-3"><label class="form-label fw-bold text-success">Cédula:</label><input type="text" name="cedula" class="form-control" required pattern="[0-9]+"></div>
            <div class="mb-3"><label class="form-label fw-bold text-success">Correo:</label><input type="email" name="correo" class="form-control" required></div>
            <div class="mb-4"><label class="form-label fw-bold text-success">Contraseña:</label><input type="password" name="clave" class="form-control" required minlength="8"></div>
            <button type="submit" class="btn btn-navidad-verde w-100 py-2"><i class="fas fa-check-circle"></i> Registrarse</button>
        </form>
        <a href="login.jsp" class="d-block text-center mt-3 text-secondary small">¿Ya tienes cuenta? Inicia sesión</a>
    </div>
</body>
</html>