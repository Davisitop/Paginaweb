<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" 
    import="com.productos.seguridad.Usuario" %>
<%
    // Seguridad: Solo Admin (Perfil 1)
    Integer perfil = (Integer) session.getAttribute("perfil");
    if (perfil == null || perfil != 1) { 
        response.sendRedirect("index.jsp"); 
        return; 
    }

    Usuario u = new Usuario();
    String tablaUsuarios = u.reporteUsuarios(); // Genera la tabla HTML desde Java
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Usuarios - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="estilos3.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm px-4" style="border-bottom: 3px solid var(--navidad-dorado);">
        <div class="container-fluid">
            <a class="navbar-brand text-warning fw-bold" href="index.jsp">🎅 PANEL ADMIN</a>
            <div class="ms-auto">
                <a href="index.jsp" class="btn btn-outline-light btn-sm me-2">Ir al Inicio</a>
                <a href="admin_bitacora.jsp" class="btn btn-navidad-verde btn-sm">Ver Bitácora</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h2 class="text-center mb-4" style="color: var(--navidad-texto); text-shadow: 1px 1px 2px white;">
            👥 Gestión de Usuarios Registrados
        </h2>

        <div class="table-container">
            <%= tablaUsuarios %>
        </div>
        
        <div class="text-center mt-4">
            <a href="index.jsp" class="btn btn-secondary">Volver</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>