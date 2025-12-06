<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión - Navidad</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="d-flex align-items-center justify-content-center vh-100">
    <div class="nieve-container"></div>
    <div class="card p-4 shadow-lg text-center" style="width: 380px;">
        <span style="font-size:3rem; display:block; text-align:center;">🎅</span>
        <h2 class="mb-4">Ingreso Navideño</h2>
        <% String error = request.getParameter("error"); if(error != null) { %>
            <div class="alert alert-danger py-2 small rounded-pill"><i class="fas fa-exclamation-circle"></i> <%= error %></div>
        <% } %>
        <form action="validarLogin.jsp" method="post">
            <div class="mb-3 text-start">
                <label class="form-label fw-bold text-success"><i class="fas fa-envelope"></i> Correo:</label>
                <input type="email" name="usuario" class="form-control" required>
            </div>
            <div class="mb-4 text-start">
                <label class="form-label fw-bold text-success"><i class="fas fa-key"></i> Contraseña:</label>
                <input type="password" name="clave" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-navidad-rojo w-100 py-2">Entrar a la Fiesta <i class="fas fa-sleigh"></i></button>
        </form>
        <div class="mt-4 border-top pt-3">
            <p class="small mb-1">¿Aún no tienes cuenta?</p>
            <a href="registro.jsp" class="text-decoration-none fw-bold text-success"><i class="fas fa-gift"></i> Regístrate aquí</a>
            <div class="mt-2"><a href="index.jsp" class="text-secondary small">Volver al inicio</a></div>
        </div>
    </div>
</body>
</html>