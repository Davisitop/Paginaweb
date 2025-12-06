<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<% if (session.getAttribute("usuario") == null) { response.sendRedirect("login.jsp"); return; } %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <title>Pesebre 3D Interactivo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>
    
    <style>
        body { margin: 0; background: radial-gradient(circle at center, #1a472a, #0d2b1a); overflow: hidden; font-family: 'Segoe UI', sans-serif; }
        model-viewer { width: 100vw; height: 100vh; --poster-color: transparent; }
        .nav-flotante { position: absolute; top: 20px; left: 20px; z-index: 100; }
        .personajes-menu { position: absolute; top: 50%; left: 20px; transform: translateY(-50%); display: flex; flex-direction: column; gap: 20px; z-index: 100; }
        .btn-personaje { width: 60px; height: 60px; border-radius: 50%; border: 3px solid #FFD700; background: #D42426; color: white; font-size: 1.5rem; display: flex; align-items: center; justify-content: center; transition: transform 0.2s; cursor: pointer; box-shadow: 0 4px 10px rgba(0,0,0,0.5); }
        .btn-personaje:nth-child(even) { background: #165B33; }
        .btn-personaje:hover { transform: scale(1.2); box-shadow: 0 0 15px #FFD700; }
        
        #modalInfo { display: none; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 90%; max-width: 400px; background-color: #ffffff; border: 5px solid #D42426; border-radius: 20px; padding: 30px; z-index: 9999; text-align: center; box-shadow: 0 0 50px rgba(0,0,0,0.8); }
        #tituloModal { color: #D42426; font-weight: 800; font-size: 2rem; margin: 15px 0; text-shadow: none; }
        #textoModal { color: #000000; font-size: 1.1rem; line-height: 1.5; margin-bottom: 25px; font-weight: 500; }
        #iconoModal { color: #FFD700; text-shadow: 2px 2px 4px rgba(0,0,0,0.2); }
        .btn-cerrar-modal { background-color: #165B33; color: white; border: none; padding: 10px 30px; border-radius: 50px; font-size: 1.1rem; font-weight: bold; cursor: pointer; }
        .btn-cerrar-modal:hover { background-color: #0f4224; }
        .close-icon { position: absolute; top: 10px; right: 15px; background: none; border: none; font-size: 1.5rem; color: #333; cursor: pointer; }
        .instrucciones { position: absolute; bottom: 30px; left: 50%; transform: translateX(-50%); background: rgba(0,0,0,0.6); color: white; padding: 8px 20px; border-radius: 20px; pointer-events: none; }
    </style>
</head>
<body>
    <div class="nav-flotante"><a href="index.jsp" class="btn btn-warning btn-sm fw-bold shadow border-white"><i class="fas fa-arrow-left"></i> Volver</a></div>
    <div class="personajes-menu">
        <div class="btn-personaje" onclick="mostrarInfo('jesus')" title="Niño Jesús"><i class="fas fa-baby"></i></div>
        <div class="btn-personaje" onclick="mostrarInfo('maria')" title="Virgen María"><i class="fas fa-female"></i></div>
        <div class="btn-personaje" onclick="mostrarInfo('jose')" title="San José"><i class="fas fa-male"></i></div>
        <div class="btn-personaje" onclick="mostrarInfo('reyes')" title="Reyes Magos"><i class="fas fa-crown"></i></div>
        <div class="btn-personaje" onclick="mostrarInfo('animales')" title="Animales"><i class="fas fa-horse-head"></i></div>
    </div>
    <model-viewer src="<%=request.getContextPath()%>/image/nacimiento.glb" alt="Nacimiento Navideño" auto-rotate camera-controls shadow-intensity="1.5" exposure="1" camera-orbit="45deg 55deg 2.5m"></model-viewer>
    <div id="modalInfo">
        <button class="close-icon" onclick="cerrarInfo()">&times;</button>
        <div id="contenedorIcono"><i id="iconoModal" class="fas fa-star fa-4x"></i></div>
        <h3 id="tituloModal">Título</h3>
        <p id="textoModal">Descripción...</p>
        <button class="btn-cerrar-modal" onclick="cerrarInfo()">¡Entendido!</button>
    </div>
    <div class="instrucciones"><i class="fas fa-hand-pointer"></i> Toca las esferas para ver información</div>
    <script>
        const infoPersonajes = {
            'jesus': { titulo: "El Niño Jesús", texto: "El centro de la Navidad. Representa la luz, la esperanza y el amor incondicional que ha nacido en Belén.", icono: "fa-baby" },
            'maria': { titulo: "Virgen María", texto: "Madre de Jesús. Símbolo de pureza, valentía y amor maternal infinito. Su 'sí' cambió la historia.", icono: "fa-female" },
            'jose': { titulo: "San José", texto: "El protector de la Sagrada Familia. Carpintero humilde y justo, ejemplo de fortaleza silenciosa.", icono: "fa-male" },
            'reyes': { titulo: "Los Reyes Magos", texto: "Sabios de oriente guiados por la estrella. Trajeron Oro (Rey), Incienso (Dios) y Mirra (Hombre).", icono: "fa-crown" },
            'animales': { titulo: "El Buey y la Mula", texto: "Testigos humildes del nacimiento. Con su aliento brindaron calor al niño en la fría noche de Belén.", icono: "fa-horse-head" }
        };
        function mostrarInfo(clave) {
            const data = infoPersonajes[clave];
            if (data) {
                document.getElementById('iconoModal').className = "fas " + data.icono + " fa-4x";
                document.getElementById('tituloModal').innerText = data.titulo;
                document.getElementById('textoModal').innerText = data.texto;
                document.getElementById('modalInfo').style.display = 'block';
            }
        }
        function cerrarInfo() { document.getElementById('modalInfo').style.display = 'none'; }
    </script>
</body>
</html>