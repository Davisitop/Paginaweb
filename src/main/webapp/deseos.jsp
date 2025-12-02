<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" import="com.productos.datos.Conexion" %>
<%
    if (session.getAttribute("usuario") == null) { response.sendRedirect("login.jsp"); return; }
    String msg = "";
    if("POST".equalsIgnoreCase(request.getMethod())){
        String deseo = request.getParameter("mensaje");
        if(deseo != null) deseo = new String(deseo.getBytes("ISO-8859-1"), "UTF-8");
        int idU = (Integer) session.getAttribute("id_usuario");
        Conexion con = new Conexion();
        con.Ejecutar("INSERT INTO tb_deseos (id_usuario, mensaje, fecha) VALUES ("+idU+", '"+deseo+"', NOW())");
        if(con.getConexion()!=null)con.getConexion().close();
        msg = "¡Deseo enviado! ✨";
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Caja de Deseos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="estilos3.css">
    <script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background: linear-gradient(135deg, #fdfbfb 0%, #ebedee 100%); min-height: 100vh; }
        .music-control { position: fixed; bottom: 15px; right: 15px; z-index: 1000; background: #D42426; color: white; border-radius: 50%; width: 50px; height: 50px; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 10px rgba(0,0,0,0.3); }
        .nav-top { padding: 15px; }
    </style>
</head>
<body>
    <audio id="audioFondo" loop><source src="<%=request.getContextPath()%>/image/error_key.mp3" type="audio/mpeg"></audio>
    <div class="music-control" onclick="toggleMusic()"><i id="musicIcon" class="fas fa-play"></i></div>

    <div class="nav-top">
        <a href="index.jsp" class="btn btn-outline-dark btn-sm">⬅ Inicio</a>
    </div>

    <div class="container pb-5">
        <div class="row align-items-center">
            <div class="col-12 col-md-6 text-center mb-3">
                <div style="height: 300px; md-height: 500px; width: 100%;">
                    <model-viewer src="<%=request.getContextPath()%>/image/jesus_love.glb" alt="Jesús" auto-rotate camera-controls shadow-intensity="1" style="width: 100%; height: 100%;"></model-viewer>
                </div>
                <h3 class="text-secondary mt-2" style="font-family: serif;">"Pide y se te dará..."</h3>
            </div>

            <div class="col-12 col-md-6">
                <div class="card shadow p-4 border-warning">
                    <div class="card-body">
                        <% if(!msg.isEmpty()) { %><div class="alert alert-success text-center"><%= msg %></div><% } %>
                        <h4 class="text-center text-danger mb-3">Escribe tu carta</h4>
                        <form method="post">
                            <div class="mb-3">
                                <textarea name="mensaje" class="form-control" rows="6" required placeholder="Querido niño Jesús..."></textarea>
                            </div>
                            <button type="submit" class="btn btn-warning w-100 text-white fw-bold">Enviar Deseo</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        var audio = document.getElementById("audioFondo");
        var icon = document.getElementById("musicIcon");
        var isPlaying = false;
        function toggleMusic() {
            if (isPlaying) { audio.pause(); icon.className = "fas fa-play"; } 
            else { audio.play(); icon.className = "fas fa-pause"; }
            isPlaying = !isPlaying;
        }
    </script>
</body>
</html>