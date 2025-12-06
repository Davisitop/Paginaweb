<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<% if (session.getAttribute("usuario") == null) { response.sendRedirect("login.jsp"); return; } %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <title>Mini Juego Navideño</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/estilos.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { overflow: hidden; touch-action: none; }
        #game-area { position: relative; width: 100%; max-width: 800px; height: 75vh; margin: 20px auto; background: rgba(0, 0, 0, 0.4); border: 4px solid #FFD700; border-radius: 20px; overflow: hidden; box-shadow: 0 0 30px rgba(255, 215, 0, 0.3); cursor: col-resize; }
        #player { position: absolute; bottom: 20px; left: 50%; font-size: 4rem; transform: translateX(-50%); transition: left 0.05s linear; filter: drop-shadow(0 0 10px white); z-index: 5; }
        .item { position: absolute; top: -50px; font-size: 2.5rem; animation: spin 2s linear infinite; }
        @keyframes spin { 100% { transform: rotate(360deg); } }
        .hud { position: absolute; top: 15px; font-size: 1.5rem; font-weight: bold; color: white; text-shadow: 2px 2px 0 #000; z-index: 10; }
        #score-board { right: 20px; color: #FFD700; }
        #lives-board { left: 20px; }
        .overlay-screen { position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.85); display: flex; flex-direction: column; justify-content: center; align-items: center; color: white; z-index: 20; text-align: center; backdrop-filter: blur(5px); }
        .btn-jugar { font-size: 1.5rem; padding: 10px 40px; border-radius: 50px; background: #D42426; color: white; border: 2px solid #FFD700; transition: transform 0.2s; }
        .btn-jugar:hover { transform: scale(1.1); background: #b0191b; color: white;}
    </style>
</head>
<body>
    <div class="nieve-container"></div>
    <div class="container">
        <div class="d-flex justify-content-between align-items-center pt-3">
            <a href="index.jsp" class="btn btn-warning btn-sm fw-bold shadow"><i class="fas fa-arrow-left"></i> Salir</a>
            <h2 class="text-white text-shadow m-0 d-none d-md-block" style="font-family: 'Mountains of Christmas', cursive;">🎅 Atrapa los Regalos</h2>
            <div style="width: 80px;"></div>
        </div>
        <div id="game-area">
            <div id="lives-board" class="hud">❤❤❤</div>
            <div id="score-board" class="hud">Pts: 0</div>
            <div id="player">🛷</div>
            <div id="start-screen" class="overlay-screen">
                <h1 class="text-warning display-3" style="font-family: 'Mountains of Christmas';">¡Salva la Navidad!</h1>
                <p class="fs-4 mt-3">Mueve el trineo para atrapar los regalos 🎁</p>
                <p class="text-danger fw-bold mb-4">¡Evita el carbón! ⚫</p>
                <button class="btn btn-jugar shadow" onclick="startGame()"><i class="fas fa-play"></i> JUGAR</button>
            </div>
            <div id="game-over-screen" class="overlay-screen" style="display: none;">
                <h1 class="text-danger mb-3">🎄 ¡Juego Terminado!</h1>
                <h3 class="mb-4">Tu Puntuación: <span id="final-score" class="text-warning fw-bold display-4">0</span></h3>
                <button class="btn btn-primary btn-lg rounded-pill px-5 shadow" onclick="location.reload()"><i class="fas fa-redo"></i> Intentar de nuevo</button>
            </div>
        </div>
    </div>
    <script>
        const container = document.getElementById('game-area');
        const player = document.getElementById('player');
        const scoreBoard = document.getElementById('score-board');
        const livesBoard = document.getElementById('lives-board');
        const startScreen = document.getElementById('start-screen');
        const gameOverScreen = document.getElementById('game-over-screen');
        let score = 0, lives = 3, gameInterval, speedInterval, isGameOver = false, playerPos = 50, dropSpeed = 3, spawnRate = 1000;
        
        document.addEventListener('keydown', (e) => { if (isGameOver) return; if (e.key === 'ArrowLeft' && playerPos > 5) playerPos -= 8; if (e.key === 'ArrowRight' && playerPos < 95) playerPos += 8; updatePlayer(); });
        container.addEventListener('mousemove', movePlayer); container.addEventListener('touchmove', movePlayer);
        function movePlayer(e) { if (isGameOver) return; e.preventDefault(); let clientX = (e.type === 'touchmove') ? e.touches[0].clientX : e.clientX; const rect = container.getBoundingClientRect(); playerPos = ((clientX - rect.left) / rect.width) * 100; if (playerPos < 5) playerPos = 5; if (playerPos > 95) playerPos = 95; updatePlayer(); }
        function updatePlayer() { player.style.left = playerPos + '%'; }
        function startGame() { startScreen.style.display = 'none'; isGameOver = false; gameInterval = setTimeout(spawnItem, spawnRate); speedInterval = setInterval(() => { if(dropSpeed < 10) dropSpeed += 0.5; if(spawnRate > 400) spawnRate -= 50; }, 5000); }
        function spawnItem() {
            if (isGameOver) return;
            const item = document.createElement('div'); item.classList.add('item');
            const isGift = Math.random() > 0.15;
            if (isGift) { const gifts = ['🎁', '🧸', '🍬', '🎄', '⭐']; item.innerText = gifts[Math.floor(Math.random() * gifts.length)]; } else { item.innerText = '⚫'; }
            item.style.left = Math.random() * 90 + 5 + '%'; container.appendChild(item);
            let itemTop = -50;
            const fall = setInterval(() => {
                if (isGameOver) { clearInterval(fall); return; }
                itemTop += dropSpeed; item.style.top = itemTop + 'px';
                const pRect = player.getBoundingClientRect(), iRect = item.getBoundingClientRect(), cRect = container.getBoundingClientRect();
                if (iRect.bottom >= pRect.top + 20 && iRect.top <= pRect.bottom && iRect.right >= pRect.left + 10 && iRect.left <= pRect.right - 10) {
                    if (isGift) { score += 10; scoreBoard.innerText = 'Pts: ' + score; player.style.transform = "translateX(-50%) scale(1.2)"; setTimeout(() => player.style.transform = "translateX(-50%) scale(1)", 100); } else { takeDamage(); } item.remove(); clearInterval(fall);
                } else if (iRect.top > cRect.bottom) { if (isGift) takeDamage(); item.remove(); clearInterval(fall); }
            }, 20);
            setTimeout(spawnItem, spawnRate);
        }
        function takeDamage() { lives--; let hearts = ''; for(let i=0; i<lives; i++) hearts += '❤'; livesBoard.innerText = hearts; container.style.border = "4px solid red"; setTimeout(() => container.style.border = "4px solid #FFD700", 200); if (lives <= 0) endGame(); }
        function endGame() { isGameOver = true; clearTimeout(gameInterval); clearInterval(speedInterval); document.querySelectorAll('.item').forEach(e => e.remove()); document.getElementById('final-score').innerText = score; gameOverScreen.style.display = 'flex'; }
    </script>
</body>
</html>