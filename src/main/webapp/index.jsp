<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%
    // Recuperamos la sesión del usuario
    String usuario = (String) session.getAttribute("usuario");
    Integer perfil = (Integer) session.getAttribute("perfil"); 
    // Perfil 1 = Admin, Perfil 2 = Usuario, etc.
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inicio - Portal Navideño</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="estilos3.css">
</head>
<body>

    <header>
        <h1>🎅 ¡Bienvenidos al Portal Navideño! 🎄</h1>
        <p>Donde tus deseos se hacen realidad</p>
    </header>

    <nav class="navbar navbar-expand-lg shadow-sm px-4">
        <div class="container-fluid">
            <a class="navbar-brand" href="index.jsp">🎁 INICIO</a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menuNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="menuNav">
                <div class="ms-auto d-flex align-items-center">
                    <% if (usuario != null) { %>
                        
                        <% if (perfil == 2) { %>
                            <a class="btn btn-navidad-verde me-2" href="pesebre.jsp">🎄 Ver Pesebre</a>
                            <a class="btn btn-navidad-rojo me-2" href="deseos.jsp">✨ Caja de Deseos</a>
                        <% } %>

                        <% if (perfil == 1) { %>
                            <a class="btn btn-warning me-2 fw-bold" href="admin_verUsuarios.jsp">👥 Usuarios</a>
                            <a class="btn btn-secondary me-2 fw-bold" href="admin_bitacora.jsp">📋 Bitácora</a>
                        <% } %>

                        <span class="badge bg-danger ms-3 me-3 p-2 border border-warning">Hola, <%= usuario %></span>
                        <a href="logout.jsp" class="btn btn-outline-dark btn-sm">Cerrar Sesión</a>
                    
                    <% } else { %>
                        <span class="me-3 fw-bold text-muted">¡Únete a la fiesta! 👉</span>
                        <a href="login.jsp" class="btn btn-navidad-verde me-2">Iniciar Sesión</a>
                        <a href="registro.jsp" class="btn btn-navidad-rojo">Registrarse</a>
                    <% } %>
                </div>
            </div>
        </div>
    </nav>

    <div class="container">
        
        <h2 class="video-title">✨ Jesús bailando animándote a registrarte ✨</h2>
        
        <div class="video-frame">
            <video width="100%" height="auto" controls autoplay muted loop playsinline>
                <source src="<%=request.getContextPath()%>/image/bienvenida.mp4" type="video/mp4">
                
                <p class="text-white p-3 text-center">
                    Tu navegador no puede reproducir este video. 
                    <a href="<%=request.getContextPath()%>/image/bienvenida.mp4" class="text-warning">Haz clic aquí para verlo</a>
                </p>
            </video>
        </div>

        <div class="row justify-content-center mt-5 mb-5">
            <div class="col-md-8">
                <div class="welcome-card card text-center">
                    <div class="card-header-custom">
                        🎁 ¡Felices Fiestas!
                    </div>
                    <div class="card-body p-4">
                        <% if (usuario == null) { %>
                            <h3>¡Únete a la celebración!</h3>
                            <p class="text-muted">Regístrate ahora para acceder al <strong>Pesebre 3D</strong> y enviar tus cartas en la <strong>Caja de Deseos</strong>.</p>
                            <a href="registro.jsp" class="btn btn-navidad-rojo btn-lg mt-3">¡Regístrate Ahora!</a>
                        <% } else { %>
                            <h3 class="text-success">¡Qué bueno verte, <%= usuario %>!</h3>
                            <p>Disfruta de todas las funciones exclusivas que hemos preparado para ti.</p>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <footer>
        <p class="mb-0">&copy; 2025 Portal Navideño | Desarrollado con alegría 🎅</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>