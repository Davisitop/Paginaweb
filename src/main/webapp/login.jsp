<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="estilos3.css">
</head>
<body class="d-flex align-items-center justify-content-center vh-100 bg-light">
    <div class="card p-4 shadow" style="width: 350px;">
        <h3 class="text-center mb-3">Iniciar Sesión</h3>
        
        <% String error = request.getParameter("error"); 
           if(error != null) { %>
            <div class="alert alert-danger py-2"><%= error %></div>
        <% } %>

        <form action="validarLogin.jsp" method="post">
            <div class="mb-3">
                <label>Correo:</label>
                <input type="email" name="usuario" class="form-control" required>
            </div>
            <div class="mb-3">
                <label>Contraseña:</label>
                <input type="password" name="clave" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-custom w-100">Entrar</button>
        </form>
        <div class="mt-3 text-center">
            <a href="registro.jsp" class="text-decoration-none">¿No tienes cuenta? Regístrate</a><br>
            <a href="index.jsp" class="text-secondary small">Volver al inicio</a>
        </div>
    </div>
</body>
</html>