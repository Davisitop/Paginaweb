<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" 
    import="com.productos.seguridad.Bitacora" %>
<%
    // Seguridad: Solo Admin
    Integer perfil = (Integer) session.getAttribute("perfil");
    if (perfil == null || perfil != 1) { 
        response.sendRedirect("index.jsp"); 
        return; 
    }

    Bitacora b = new Bitacora();
    String reporte = b.reporteBitacora(); // Genera la tabla HTML
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bitácora - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="estilos3.css">
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm px-4" style="border-bottom: 3px solid var(--navidad-rojo);">
        <div class="container-fluid">
            <a class="navbar-brand text-danger fw-bold" href="index.jsp">📋 BITÁCORA DEL SISTEMA</a>
            <div class="ms-auto">
                <a href="admin_verUsuarios.jsp" class="btn btn-warning btn-sm fw-bold">Gestionar Usuarios</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h2 class="text-center mb-4" style="color: var(--navidad-texto);">Historial de Actividades</h2>

        <div class="table-container">
            <%= reporte %>
        </div>
        
        <div class="text-center mt-4 pb-5">
            <a href="index.jsp" class="btn btn-secondary">Volver al Inicio</a>
        </div>
    </div>

</body>
</html>