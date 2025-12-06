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
        msg = "¡Tu deseo ha sido enviado al Polo Norte! 🎅✨";
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Caja de Deseos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos.css">
    <script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .music-control { 
            position: fixed; bottom: 20px; right: 20px; z-index: 1000;
            background: var(--navidad-rojo); color: white; border-radius: 50%; 
            width: 60px; height: 60px; display: flex; align-items: center; justify-content: center;
            box-shadow: 0 0 15px var(--navidad-dorado); cursor: pointer; border: 3px solid white;
        }
    </style>
</head>
<body>
    <div class="nieve-container"></div>
    <audio id="audioFondo" loop><source src="<%=request.getContextPath()%>/image/error_key.mp3" type="audio/mpeg"></audio>
    
    <div class="music-control" onclick="toggleMusic()">
        <i id="musicIcon" class="fas fa-play fa-lg"></i>
    </div>

    <div class="container py-4">
        <a href="index.jsp" class="btn btn-outline-light mb-3"><i class="fas fa-arrow-left"></i> Volver al Inicio</a>
        
        <div class="row align-items-center">
            <div class="col-lg-6 text-center mb-4">
                <div class="card p-2" style="background: rgba(0,0,0,0.2) !important; border:none !important; box-shadow:none !important;">
                    <model-viewer src="<%=request.getContextPath()%>/image/jesus_love.glb" 
                        alt="Jesús" auto-rotate camera-controls shadow-intensity="1" 
                        style="width: 100%; height: 400px;"></model-viewer>
                </div>
                <h2 class="text-white mt-2 fst-italic text-shadow">"Pide y se te dará..."</h2>
            </div>

            <div class="col-lg-6">
                <div class="card p-5 border-warning bg-white">
                    <div class="text-center mb-3">
                        <i class="fas fa-envelope-open-text fa-3x text-danger"></i>
                        <h3 class="mt-2 text-danger">Tu Carta de Deseos</h3>
                    </div>

                    <% if(!msg.isEmpty()) { %>
                        <div class="alert alert-success text-center fw-bold border-success">
                            <i class="fas fa-magic"></i> <%= msg %>
                        </div>
                    <% } %>

                    <form method="post">
                        <div class="mb-4">
                            <label class="form-label text-muted fw-bold">Escribe aquí tu deseo:</label>
                            <textarea name="mensaje" class="form-control" rows="6" required 
                                style="background-color: #fffcf5; border: 2px dashed #d4af37;"
                                placeholder="Querido niño Jesús, este año deseo..."></textarea>
                        </div>
                        <button type="submit" class="btn btn-warning w-100 text-dark fw-bold py-3 fs-5 shadow">
                            <i class="fas fa-paper-plane"></i> Enviar Deseo
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        var audio = document.getElementById("audioFondo");
        var icon = document.getElementById("musicIcon");
        var isPlaying = false;
        function toggleMusic() {
            if (isPlaying) { 
                audio.pause(); icon.className = "fas fa-play fa-lg"; 
            } else { 
                audio.play(); icon.className = "fas fa-pause fa-lg"; 
            }
            isPlaying = !isPlaying;
        }
    </script>
</body>
</html>