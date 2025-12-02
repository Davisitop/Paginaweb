<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" 
    import="com.productos.seguridad.Usuario" %>
<%
    // Verificar Sesión
    if (session.getAttribute("usuario") == null) { response.sendRedirect("login.jsp"); return; }

    // Obtener datos del usuario actual usando su ID de sesión
    Integer idUser = (Integer) session.getAttribute("id_usuario");
    Usuario uHelper = new Usuario();
    Usuario misDatos = uHelper.obtenerUsuarioPorId(String.valueOf(idUser));
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Perfil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="estilos3.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-light">

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm px-4">
        <div class="container-fluid">
            <a class="navbar-brand text-warning" href="index.jsp">INICIO</a>
            <div class="ms-auto">
                <a href="logout.jsp" class="btn btn-danger btn-sm">Cerrar Sesión</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow border-0">
                    <div class="card-header bg-primary text-white text-center py-3">
                        <h3><i class="fas fa-user-circle"></i> Mi Información</h3>
                    </div>
                    <div class="card-body p-4">
                        <div class="mb-3 border-bottom pb-2">
                            <label class="text-muted small">Nombre Completo</label>
                            <p class="fs-5 fw-bold text-dark"><%= misDatos.getNombre() %></p>
                        </div>
                        
                        <div class="mb-3 border-bottom pb-2">
                            <label class="text-muted small">Cédula</label>
                            <p class="fs-5 text-dark"><%= misDatos.getCedula() %></p>
                        </div>

                        <div class="mb-3 border-bottom pb-2">
                            <label class="text-muted small">Correo Electrónico</label>
                            <p class="fs-5 text-primary"><%= misDatos.getCorreo() %></p>
                        </div>

                        <div class="mb-3">
                            <label class="text-muted small">Rol de Usuario</label>
                            <p class="badge bg-success fs-6">
                                <%= (misDatos.getPerfil() == 1) ? "Administrador" : "Usuario / Cliente" %>
                            </p>
                        </div>
                    </div>
                    <div class="card-footer text-center bg-white border-0 pb-4">
                        <a href="index.jsp" class="btn btn-secondary">Volver al Inicio</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>