<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Registro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="estilos3.css">
</head>
<body class="d-flex align-items-center justify-content-center vh-100 bg-light">
    <div class="card p-4 shadow" style="width: 400px; border-top: 5px solid #28a745;">
        <h3 class="text-center mb-4">Crear Cuenta</h3>
        
        <% String error = request.getParameter("msg"); 
           if(error != null) { %>
            <div class="alert alert-danger p-2 small"><%= error %></div>
        <% } %>

        <form action="registrarCliente.jsp" method="post">
            <div class="mb-3">
                <label class="form-label fw-bold">Nombre Completo:</label>
                <input type="text" name="nombre" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label fw-bold">Cédula:</label>
                <input type="text" name="cedula" class="form-control" required pattern="[0-9]+" title="Solo números">
            </div>
            <div class="mb-3">
                <label class="form-label fw-bold">Correo Electrónico:</label>
                <input type="email" name="correo" class="form-control" required placeholder="nombre@ejemplo.com">
            </div>
            <div class="mb-4">
                <label class="form-label fw-bold">Contraseña:</label>
                <input type="password" name="clave" class="form-control" required minlength="8" 
                       placeholder="Mínimo 8 caracteres" title="Debe tener al menos 8 caracteres">
            </div>
            <button type="submit" class="btn btn-success w-100 fw-bold">Registrarse</button>
        </form>
        <a href="login.jsp" class="d-block text-center mt-3 text-secondary">Volver al Login</a>
    </div>
</body>
</html>