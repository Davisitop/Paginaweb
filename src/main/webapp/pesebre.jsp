<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<% if (session.getAttribute("usuario") == null) { response.sendRedirect("login.jsp"); return; } %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <title>Pesebre 3D</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="estilos3.css">
    <script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>
    <style>
        body { margin: 0; background: radial-gradient(circle, #1a2a6c, #b21f1f, #fdbb2d); overflow: hidden; }
        /* El modelo ocupa toda la pantalla del celular */
        model-viewer { width: 100vw; height: 100vh; }
        .nav-flotante { position: absolute; top: 10px; left: 10px; z-index: 100; }
        .instrucciones {
            position: absolute; bottom: 20px; left: 50%; transform: translateX(-50%);
            background: rgba(0,0,0,0.6); color: white; padding: 10px; border-radius: 20px;
            font-size: 0.9rem; text-align: center; width: 90%; pointer-events: none;
        }
    </style>
</head>
<body>

    <div class="nav-flotante">
        <a href="index.jsp" class="btn btn-warning btn-sm fw-bold">⬅ Volver</a>
    </div>

    <model-viewer 
        src="<%=request.getContextPath()%>/image/nacimiento.glb" 
        alt="Nacimiento" 
        auto-rotate camera-controls 
        shadow-intensity="1.5" exposure="1">
    </model-viewer>

    <div class="instrucciones">
        👆 <strong>Usa tus dedos:</strong><br>
        Arrastra para girar | Pellizca para acercar
    </div>

</body>
</html>