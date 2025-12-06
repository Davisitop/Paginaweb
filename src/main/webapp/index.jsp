<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%
    String usuario = (String) session.getAttribute("usuario");
    Integer perfil = (Integer) session.getAttribute("perfil"); 
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portal Navideño 🎅</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="d-flex flex-column min-vh-100">

    <div class="nieve-container"></div>

    <nav class="navbar navbar-expand-lg px-4">
        <div class="container-fluid">
            <a class="navbar-brand" href="index.jsp">
                <i class="fas fa-snowflake fa-spin" style="color:var(--navidad-rojo)"></i> Portal Navideño
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menuNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="menuNav">
                <div class="ms-auto d-flex align-items-center gap-2">
                    <% if (usuario != null) { %>
                        <% if (perfil == 2) { %>
                            <a class="btn btn-navidad-verde btn-sm" href="pesebre.jsp"><i class="fas fa-church"></i> Pesebre 3D</a>
                            <a class="btn btn-warning btn-sm text-dark fw-bold" href="minijuego.jsp"><i class="fas fa-gamepad"></i> Jugar</a>
                            <a class="btn btn-navidad-rojo btn-sm" href="deseos.jsp"><i class="fas fa-star"></i> Deseos</a>
                            <a class="btn btn-outline-success btn-sm fw-bold" href="mi_perfil.jsp"><i class="fas fa-user"></i> Mi Perfil</a>
                        <% } %>
                        <% if (perfil == 1) { %>
                            <a class="btn btn-warning btn-sm fw-bold text-dark" href="admin_verUsuarios.jsp"><i class="fas fa-users-cog"></i> Usuarios</a>
                            <a class="btn btn-secondary btn-sm fw-bold" href="admin_bitacora.jsp"><i class="fas fa-clipboard-list"></i> Bitácora</a>
                        <% } %>
                        <div class="d-none d-lg-block border-start mx-2" style="height: 25px; border-color: #ccc;"></div>
                        <span class="fw-bold text-danger me-2 d-none d-md-inline">Hola, <%= usuario %></span>
                        <a href="logout.jsp" class="btn btn-outline-danger btn-sm rounded-pill">Salir <i class="fas fa-sign-out-alt"></i></a>
                    <% } else { %>
                        <span class="me-2 fw-bold text-muted d-none d-md-inline">¡Únete a la fiesta! 👉</span>
                        <a href="login.jsp" class="btn btn-navidad-verde btn-sm">Iniciar Sesión</a>
                        <a href="registro.jsp" class="btn btn-navidad-rojo btn-sm">Registrarse</a>
                    <% } %>
                </div>
            </div>
        </div>
    </nav>

    <header class="text-center py-4 mt-3">
        <h1 class="display-3">🎅 ¡Feliz Navidad! 🎄</h1>
        <p class="lead text-white text-shadow fw-bold">Faltan pocos días para la gran noche...</p>
        
        <div class="contador-container">
            <div class="caja-tiempo"><span id="dias">00</span><small>Días</small></div>
            <div class="caja-tiempo"><span id="horas">00</span><small>Horas</small></div>
            <div class="caja-tiempo"><span id="minutos">00</span><small>Min</small></div>
            <div class="caja-tiempo"><span id="segundos">00</span><small>Seg</small></div>
        </div>
    </header>

    <div class="container flex-grow-1">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card p-2 mb-5 bg-dark border-danger">
                    <div class="ratio ratio-16x9 rounded overflow-hidden">
                         <video controls autoplay muted loop playsinline>
                            <source src="<%=request.getContextPath()%>/image/bienvenida.mp4" type="video/mp4">
                            Tu navegador no soporta video.
                        </video>
                    </div>
                    <div class="card-body text-center bg-white">
                        <h4 class="text-danger m-0" style="font-family: 'Mountains of Christmas';">✨ El Espíritu de la Navidad ✨</h4>
                    </div>
                </div>
            </div>
        </div>

        <div class="row justify-content-center mb-5">
            <div class="col-md-8">
                <div class="welcome-card text-center p-5">
                    <% if (usuario == null) { %>
                        <h2 class="mb-3">🎁 ¡Únete a la Celebración!</h2>
                        <p class="fs-5">Regístrate ahora para acceder al <strong>Pesebre Interactivo 3D</strong>, jugar a atrapar regalos y enviar tu carta al Niño Jesús.</p>
                        <div class="mt-4">
                            <a href="registro.jsp" class="btn btn-navidad-rojo btn-lg px-5 shadow"><i class="fas fa-gift"></i> Crear Cuenta Gratis</a>
                        </div>
                    <% } else { %>
                        <h2 class="mb-3 text-success">¡Qué alegría verte, <%= usuario %>! 🌟</h2>
                        <p class="fs-5">Tenemos muchas sorpresas para ti. Visita el pesebre o diviértete con nuestro juego exclusivo.</p>
                        <div class="d-flex justify-content-center gap-3 mt-4 flex-wrap">
                            <a href="pesebre.jsp" class="btn btn-navidad-verde btn-lg shadow"><i class="fas fa-church"></i> Ver Pesebre</a>
                            <a href="minijuego.jsp" class="btn btn-warning btn-lg fw-bold shadow text-dark border-white"><i class="fas fa-gamepad"></i> Jugar Ahora</a>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p class="mb-0">&copy; 2025 Portal Navideño | Hecho con mucho 💖 y espíritu navideño ❄️</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function actualizarContador() {
            const ahora = new Date();
            const anioActual = ahora.getFullYear();
            let navidad = new Date("December 25, " + anioActual + " 00:00:00");
            if (ahora.getMonth() == 11 && ahora.getDate() > 25) {
                navidad = new Date("December 25, " + (anioActual + 1) + " 00:00:00");
            }
            const diferencia = navidad - ahora;
            const dias = Math.floor(diferencia / (1000 * 60 * 60 * 24));
            const horas = Math.floor((diferencia % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            const minutos = Math.floor((diferencia % (1000 * 60 * 60)) / (1000 * 60));
            const segundos = Math.floor((diferencia % (1000 * 60)) / 1000);
            document.getElementById("dias").innerText = dias < 10 ? "0" + dias : dias;
            document.getElementById("horas").innerText = horas < 10 ? "0" + horas : horas;
            document.getElementById("minutos").innerText = minutos < 10 ? "0" + minutos : minutos;
            document.getElementById("segundos").innerText = segundos < 10 ? "0" + segundos : segundos;
        }
        setInterval(actualizarContador, 1000);
        actualizarContador();
    </script>
</body>
</html>