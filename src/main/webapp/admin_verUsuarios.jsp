<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" import="com.productos.seguridad.Usuario" %>
<%
    Integer perfil = (Integer) session.getAttribute("perfil");
    if (perfil == null || perfil != 1) { response.sendRedirect("index.jsp"); return; }
    Usuario u = new Usuario();
    String tablaUsuarios = u.reporteUsuarios();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Usuarios - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg px-4 bg-white">
        <div class="container-fluid">
            <a class="navbar-brand text-danger" href="index.jsp">⚙ PANEL ADMIN</a>
            <div class="ms-auto">
                <a href="index.jsp" class="btn btn-outline-dark btn-sm me-2">Volver</a>
                <a href="admin_bitacora.jsp" class="btn btn-navidad-verde btn-sm">Ver Bitácora</a>
            </div>
        </div>
    </nav>
    <div class="container mt-5 pb-5">
        <h2 class="text-center mb-4 text-white text-shadow">👥 Gestión de Elfos (Usuarios)</h2>
        <div class="table-container p-4">
            <%= tablaUsuarios %>
        </div>
    </div>
</body>
</html>