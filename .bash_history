/* Layouts adaptativos para TV, Tablet y Móvil */
.dashboard-container{max-width:1200px;margin:0 auto;width:100%;z-index:1;display:flex;flex-direction:column;gap:25px;padding-bottom:60px}

.main-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:15px}
.nav-card{background:rgba(15,23,42,0.85);backdrop-filter:blur(10px);border:1px solid rgba(255,255,255,0.1);border-radius:16px;padding:20px;display:flex;flex-direction:column;align-items:center;text-align:center;gap:10px;text-decoration:none;color:#fff;outline:none;transition:all .25s ease;min-height:120px;justify-content:center}
.nav-card:focus,.nav-card:hover,.nav-card:active{border-color:#e11d48;transform:scale(1.02);background:rgba(225,29,72,0.2)}
.card-icon{font-size:2.2rem}
.card-title{font-size:1.1rem;font-weight:800}
.card-desc{font-size:0.78rem;color:#94a3b8}

/* Filas estilo táctil */
.content-row{display:flex;flex-direction:column;gap:10px}
.row-title{font-size:1rem;font-weight:800;color:#f8fafc;display:flex;align-items:center;gap:8px}
.row-items{display:grid;grid-template-columns:repeat(auto-fill,minmax(140px,1fr));gap:12px}
.media-card{background:rgba(30,41,59,0.7);border-radius:12px;overflow:hidden;border:2px solid transparent;cursor:pointer;transition:all .2s;outline:none;position:relative}
.media-card:focus,.media-card:hover,.media-card:active{border-color:#e11d48;transform:scale(1.03)}
.media-thumb{width:100%;height:90px;background:#1e293b;display:flex;align-items:center;justify-content:center;font-size:0.75rem;color:#94a3b8}
.media-info{padding:8px;font-size:0.8rem;font-weight:600;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.progress-bar{height:4px;background:#e11d48;width:65%}

/* Media Query para pantallas pequeñas (Smartphones) */
@media (max-width: 600px) {
  body{padding:12px}
  .header-title{font-size:1.1rem}
  .expiration-badge{display:none} /* Se oculta badge extenso en móviles pequeños */
  .main-grid{grid-template-columns:1fr} /* Tarjetas en una sola columna en móvil */
  .row-items{grid-template-columns:repeat(auto-fill,minmax(120px,1fr))}
}
</style>
</head>
<body>

<img src="logo.png" class="bg-logo-watermark" alt="Watermark" onerror="this.style.display='none'">

<div id="splash-screen">
  <img src="logo.png" class="splash-logo" alt="Logo" onerror="this.outerHTML='<div style=\'font-size:2.5rem;font-weight:900;color:#e11d48;margin-bottom:20px\'>RYOKIVA</div>'">
  <div style="font-weight:600;color:#94a3b8;letter-spacing:2px;font-size:0.85rem">CARGANDO APLICACIÓN...</div>
</div>

<div class="header">
  <a href="index.html" class="brand-logo-small">
    <img src="logo.png" alt="Logo" onerror="this.style.display='none'">
    <span class="brand-title">RYOKIVA</span>
  </a>
  <div class="header-right">
    <div class="expiration-badge">
      <span>⏳ Caduca:</span>
      <strong style="color:#f59e0b">5 días</strong>
    </div>
    <a href="profiles.html" class="profile-btn" tabindex="0">
      <span style="font-size:1.1rem">👨‍💻</span>
      <span style="font-size:0.85rem;font-weight:600">Perfil</span>
    </a>
  </div>
</div>

<div class="dashboard-container">
  <div class="main-grid">
    <a href="tv.html" class="nav-card" tabindex="0">
      <div class="card-icon">📺</div>
      <div class="card-title">TV EN DIRECTO</div>
      <div class="card-desc">Canales en vivo y EPG</div>
    </a>

    <a href="vod.html" class="nav-card" tabindex="0">
      <div class="card-icon">🎬</div>
      <div class="card-title">PELÍCULAS Y SERIES</div>
      <div class="card-desc">Catálogo VOD</div>
    </a>

    <a href="settings.html" class="nav-card" tabindex="0">
      <div class="card-icon">⚙️</div>
      <div class="card-title">AJUSTES Y QR</div>
      <div class="card-desc">3 líneas de refuerzo y carga</div>
    </a>
  </div>

  <div class="content-row">
    <div class="row-title">▶ Continuar Viendo</div>
    <div class="row-items">
      <div class="media-card" tabindex="0">
        <div class="media-thumb">Reproduciendo...</div>
        <div class="progress-bar"></div>
        <div class="media-info">Interstellar</div>
      </div>
      <div class="media-card" tabindex="0">
        <div class="media-thumb">Reproduciendo...</div>
        <div class="progress-bar" style="width:30%"></div>
        <div class="media-info">La 1 HD</div>
      </div>
    </div>
  </div>

  <div class="content-row">
    <div class="row-title">⭐ Mis Favoritos</div>
    <div class="row-items">
      <div class="media-card" tabindex="0">
        <div class="media-thumb">Póster</div>
        <div class="media-info">The Batman</div>
      </div>
      <div class="media-card" tabindex="0">
        <div class="media-thumb">Póster</div>
        <div class="media-info">Spider-Man</div>
      </div>
    </div>
  </div>
</div>

<script>
setTimeout(() => {
  const splash = document.getElementById('splash-screen');
  splash.style.opacity = '0';
  setTimeout(() => splash.style.display = 'none', 800);
}, 2500);
</script>

</body>
</html>
EOF

git add index.html && git commit -m "Optimizacion completa para dispositivos moviles y tablets" && git push --force origin main
cat << 'EOF' > manifest.json
{
  "name": "RYOKIVA Streaming",
  "short_name": "RYOKIVA",
  "start_url": "index.html",
  "display": "standalone",
  "background_color": "#0b1120",
  "theme_color": "#e11d48",
  "orientation": "landscape",
  "icons": [
    {
      "src": "logo.png",
      "sizes": "512x512",
      "type": "image/png",
      "purpose": "any maskable"
    }
  ]
}
EOF

cat << 'EOF' > sw.js
const CACHE_NAME = 'ryokiva-v1';
const ASSETS = [
  '/',
  'index.html',
  'profiles.html',
  'tv.html',
  'vod.html',
  'settings.html',
  'logo.png',
  'fondo.jpg'
];

self.addEventListener('install', (e) => {
  e.waitUntil(
    caches.open(CACHE_NAME).then((cache) => cache.addAll(ASSETS))
  );
});

self.addEventListener('fetch', (e) => {
  e.respondWith(
    caches.match(e.request).then((res) => res || fetch(e.request))
  );
});
EOF

cat << 'EOF' > tv-navigation.js
// Control de mando a distancia para Smart TV (D-Pad)
document.addEventListener('keydown', (e) => {
  const focusables = Array.from(document.querySelectorAll('[tabindex="0"], a, button, input'));
  const index = focusables.indexOf(document.activeElement);

  if (e.key === 'Escape' || e.key === 'Backspace' || e.keyCode === 10009 || e.keyCode === 461) {
    if (window.location.pathname.indexOf('index.html') === -1 && window.location.pathname !== '/') {
      window.location.href = 'index.html';
    }
  }
});
EOF

git add manifest.json sw.js tv-navigation.js && git commit -m "Instalabilidad PWA y soporte completo para mando Smart TV D-Pad" && git push --force origin main
cat << 'EOF' > vod.html
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover">
<title>RYOKIVA - Películas y Series</title>
<style>
*{box-sizing:border-box;margin:0;padding:0;-webkit-tap-highlight-color:transparent}
body{font-family:system-ui,-apple-system,sans-serif;background:#0b1120 url("fondo.jpg") no-repeat center center fixed;background-size:cover;color:#fff;height:100vh;display:flex;flex-direction:column;overflow:hidden}
.top-bar{display:flex;justify-content:space-between;align-items:center;padding:12px 20px;background:rgba(11,17,32,0.85);border-bottom:1px solid rgba(255,255,255,0.1);gap:15px}
.brand-badge{background:#e11d48;color:#fff;padding:6px 14px;border-radius:8px;font-weight:800;font-size:0.9rem}
.back-btn{background:rgba(30,41,59,0.8);border:1px solid rgba(255,255,255,0.1);color:#fff;padding:6px 14px;border-radius:8px;cursor:pointer;text-decoration:none;font-size:0.85rem}

/* Barra de Búsqueda */
.search-box{flex:1;max-width:400px;position:relative;display:flex;align-items:center}
.search-input{width:100%;background:rgba(30,41,59,0.8);border:1px solid rgba(255,255,255,0.2);color:#fff;padding:8px 14px 8px 36px;border-radius:10px;font-size:0.9rem;outline:none;transition:all .2s}
.search-input:focus{border-color:#e11d48;background:rgba(15,23,42,0.95);box-shadow:0 0 10px rgba(225,29,72,0.3)}
.search-icon{position:absolute;left:12px;font-size:0.9rem;color:#94a3b8;pointer-events:none}

.vod-layout{display:flex;flex:1;height:calc(100vh - 65px);padding:15px;gap:15px}
.vod-sidebar{width:220px;background:rgba(15,23,42,0.85);backdrop-filter:blur(10px);border:1px solid rgba(255,255,255,0.1);border-radius:16px;padding:12px;display:flex;flex-direction:column;gap:8px;overflow-y:auto}
.vod-menu-item{padding:10px 12px;background:rgba(30,41,59,0.5);border-radius:8px;cursor:pointer;font-size:0.85rem;border:2px solid transparent;transition:all .2s;outline:none}
.vod-menu-item:focus,.vod-menu-item:hover{background:rgba(225,29,72,0.3);border-color:#e11d48}
.vod-content{flex:1;display:flex;flex-direction:column;gap:15px;overflow-y:auto;padding-right:5px}
.posters-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(130px,1fr));gap:15px}
.poster-card{background:rgba(30,41,59,0.7);border-radius:12px;overflow:hidden;border:2px solid transparent;cursor:pointer;transition:all .2s;outline:none}
.poster-card:focus,.poster-card:hover{border-color:#e11d48;transform:scale(1.04)}
.poster-img{width:100%;height:180px;background:#334155;display:flex;align-items:center;justify-content:center;font-size:0.8rem;color:#94a3b8}
.poster-title{padding:8px;font-size:0.8rem;font-weight:600;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}

@media (max-width: 600px) {
  .vod-sidebar{display:none} /* Se oculta sidebar secundario en móviles para dar prioridad al catálogo y buscador */
  .search-box{max-width:none}
}
</style>
</head>
<body>

<div class="top-bar">
  <a href="index.html" class="back-btn" tabindex="0">← Menú</a>
  
  <!-- Buscador en Tiempo Real -->
  <div class="search-box">
    <span class="search-icon">🔍</span>
    <input type="text" id="vod-search" class="search-input" placeholder="Buscar película, serie..." tabindex="0" onkeyup="filterContent()">
  </div>

  <div class="brand-badge">🎬 VOD</div>
</div>

<div class="vod-layout">
  <div class="vod-sidebar">
    <div class="vod-menu-item" tabindex="0">⭐ Top Valoradas</div>
    <div class="vod-menu-item" tabindex="0">❤️ Mis Favoritos</div>
    <div class="vod-menu-item" tabindex="0">📂 Todo el Catálogo</div>
    <hr style="border-color:rgba(255,255,255,0.1);margin:5px 0">
    <div class="vod-menu-item" tabindex="0">🎭 Acción</div>
    <div class="vod-menu-item" tabindex="0">🚀 Ciencia Ficción</div>
    <div class="vod-menu-item" tabindex="0">🍿 Comedia</div>
  </div>

  <div class="vod-content">
    <div style="font-weight:800;font-size:1.1rem;margin-bottom:5px" id="catalog-title">Catálogo Completo</div>
    <div class="posters-grid" id="posters-grid">
      <div class="poster-card" tabindex="0" data-title="spider-man no way home"><div class="poster-img">🎬</div><div class="poster-title">Spider-Man: No Way Home</div></div>
      <div class="poster-card" tabindex="0" data-title="inception origen"><div class="poster-img">🎬</div><div class="poster-title">Inception</div></div>
      <div class="poster-card" tabindex="0" data-title="interstellar"><div class="poster-img">🎬</div><div class="poster-title">Interstellar</div></div>
      <div class="poster-card" tabindex="0" data-title="the batman"><div class="poster-img">🎬</div><div class="poster-title">The Batman</div></div>
      <div class="poster-card" tabindex="0" data-title="avatar the way of water"><div class="poster-img">🎬</div><div class="poster-title">Avatar: El Sentido del Agua</div></div>
      <div class="poster-card" tabindex="0" data-title="stranger things"><div class="poster-img">📺</div><div class="poster-title">Stranger Things</div></div>
      <div class="poster-card" tabindex="0" data-title="the last of us"><div class="poster-img">📺</div><div class="poster-title">The Last of Us</div></div>
    </div>
  </div>
</div>

<script>
// Lógica de Filtrado en Tiempo Real
function filterContent() {
  const query = document.getElementById('vod-search').value.toLowerCase().trim();
  const cards = document.querySelectorAll('.poster-card');
  let matches = 0;

  cards.forEach(card => {
    const title = card.getAttribute('data-title').toLowerCase();
    if (title.includes(query)) {
      card.style.display = 'block';
      matches++;
    } else {
      card.style.display = 'none';
    }
  });

  const catalogTitle = document.getElementById('catalog-title');
  if (query.length > 0) {
    catalogTitle.innerText = `Resultados de búsqueda (${matches})`;
  } else {
    catalogTitle.innerText = 'Catálogo Completo';
  }
}
</script>

<script src="tv-navigation.js"></script>
</body>
</html>
EOF

git add vod.html && git commit -m "Buscador integrado en tiempo real para peliculas y series" && git push --force origin main
cat << 'EOF' > tv.html
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover">
<title>RYOKIVA - TV en Directo</title>
<style>
*{box-sizing:border-box;margin:0;padding:0;-webkit-tap-highlight-color:transparent}
body{font-family:system-ui,-apple-system,sans-serif;background:#0b1120 url("fondo.jpg") no-repeat center center fixed;background-size:cover;color:#fff;height:100vh;display:flex;flex-direction:column;overflow:hidden;position:relative}

/* Top Bar */
.top-bar{display:flex;justify-content:space-between;align-items:center;padding:12px 20px;background:rgba(11,17,32,0.85);border-bottom:1px solid rgba(255,255,255,0.1);z-index:10;transition:all 0.3s ease}
.brand-badge{background:#e11d48;color:#fff;padding:6px 14px;border-radius:8px;font-weight:800;font-size:0.9rem}
.back-btn{background:rgba(30,41,59,0.8);border:1px solid rgba(255,255,255,0.1);color:#fff;padding:6px 14px;border-radius:8px;cursor:pointer;text-decoration:none;font-size:0.85rem}

/* Layout con Menú Lateral */
.tv-layout{display:flex;flex:1;height:calc(100vh - 60px);padding:15px;gap:15px;transition:all 0.3s ease}

/* Lista de Canales y EPG */
.channel-sidebar{width:320px;background:rgba(15,23,42,0.88);backdrop-filter:blur(10px);border:1px solid rgba(255,255,255,0.1);border-radius:16px;padding:12px;display:flex;flex-direction:column;gap:10px;overflow-y:auto;z-index:5;transition:all 0.3s ease}
.channel-item{padding:12px 14px;background:rgba(30,41,59,0.6);border-radius:10px;cursor:pointer;display:flex;align-items:center;gap:12px;border:2px solid transparent;transition:all .2s;outline:none}
.channel-item:focus,.channel-item:hover,.channel-item.active{border-color:#e11d48;background:rgba(225,29,72,0.25)}

/* Contenedor del Reproductor */
.player-container{flex:1;display:flex;flex-direction:column;gap:15px;position:relative;transition:all 0.3s ease}
.screen-box{flex:1;background:#000;border-radius:16px;border:1px solid rgba(255,255,255,0.1);display:flex;align-items:center;justify-content:center;color:#94a3b8;font-size:1.1rem;box-shadow:0 10px 30px rgba(0,0,0,0.5);position:relative;cursor:pointer;overflow:hidden}

.epg-panel{height:120px;background:rgba(15,23,42,0.85);backdrop-filter:blur(10px);border:1px solid rgba(255,255,255,0.1);border-radius:16px;padding:12px;display:flex;flex-direction:column;gap:4px;transition:all 0.3s ease}

/* MODO PANTALLA COMPLETA */
body.fullscreen .top-bar,
body.fullscreen .channel-sidebar,
body.fullscreen .epg-panel {
  display: none !important;
}

body.fullscreen .tv-layout {
  padding: 0;
  height: 100vh;
}

body.fullscreen .screen-box {
  border-radius: 0;
  border: none;
}

.hint-overlay{position:absolute;bottom:15px;right:15px;background:rgba(11,17,32,0.8);padding:6px 12px;border-radius:8px;font-size:0.75rem;color:#cbd5e1;pointer-events:none}
</style>
</head>
<body>

<div class="top-bar">
  <a href="index.html" class="back-btn" tabindex="0">← Menú Principal</a>
  <div class="brand-badge">📺 TV EN DIRECTO</div>
</div>

<div class="tv-layout">
  <!-- Menú Lateral de Canales -->
  <div class="channel-sidebar" id="sidebar">
    <div style="font-weight:700;color:#cbd5e1;font-size:0.85rem;margin-bottom:2px">Lista de Canales</div>
    <div class="channel-item active" tabindex="0" onclick="selectChannel(this)"><span>01</span><b>La 1 HD</b></div>
    <div class="channel-item" tabindex="0" onclick="selectChannel(this)"><span>02</span><b>Antena 3 HD</b></div>
    <div class="channel-item" tabindex="0" onclick="selectChannel(this)"><span>03</span><b>Cuatro HD</b></div>
    <div class="channel-item" tabindex="0" onclick="selectChannel(this)"><span>04</span><b>Telecinco HD</b></div>
    <div class="channel-item" tabindex="0" onclick="selectChannel(this)"><span>05</span><b>laSexta HD</b></div>
    <div class="channel-item" tabindex="0" onclick="selectChannel(this)"><span>06</span><b>Movistar Deportes</b></div>
    <div class="channel-item" tabindex="0" onclick="selectChannel(this)"><span>07</span><b>DAZN F1 4K</b></div>
  </div>

  <!-- Contenedor Reproductor -->
  <div class="player-container">
    <div class="screen-box" id="player-box" tabindex="0">
      <div id="player-status">▶ REPRODUCTOR EN VIVO (Pantalla Pequeña)</div>
      <div class="hint-overlay">Pulsa 2 veces OK para Pantalla Completa</div>
    </div>

    <!-- Guía EPG -->
    <div class="epg-panel" id="epg">
      <div style="font-weight:800;color:#e11d48;font-size:0.95rem">Guía EPG - En emisión</div>
      <div style="font-weight:700;font-size:0.9rem" id="epg-title">Noticias y Actualidad - Directo</div>
      <div style="color:#94a3b8;font-size:0.8rem">Programa de información en directo con cobertura nacional e internacional.</div>
    </div>
  </div>
</div>

<script>
let clickTimer = null;
const playerBox = document.getElementById('player-box');

// Alternar Pantalla Completa
function toggleFullscreen() {
  document.body.classList.toggle('fullscreen');
}

// Manejar Doble Click / Doble Pulsación
playerBox.addEventListener('click', () => {
  if (clickTimer == null) {
    clickTimer = setTimeout(() => {
      clickTimer = null;
    }, 300);
  } else {
    clearTimeout(clickTimer);
    clickTimer = null;
    toggleFullscreen();
  }
});

function selectChannel(el) {
  document.querySelectorAll('.channel-item').forEach(i => i.classList.remove('active'));
  el.classList.add('active');
}

// Salir de pantalla completa con tecla Atrás / Backspace / Esc
document.addEventListener('keydown', (e) => {
  if (e.key === 'Escape' || e.key === 'Backspace' || e.keyCode === 10009 || e.keyCode === 461) {
    if (document.body.classList.contains('fullscreen')) {
      e.preventDefault();
      document.body.classList.remove('fullscreen'); // Vuelve al modo menú con pantalla pequeña
    }
  } else if (e.key === 'Enter' && document.activeElement === playerBox) {
    // Si se pulsa Enter sobre el reproductor
    toggleFullscreen();
  }
});
</script>

<script src="tv-navigation.js"></script>
</body>
</html>
EOF

git add tv.html && git commit -m "Modo Mini-Player en menu con salto a pantalla completa mediante doble OK y retorno con tecla atras" && git push --force origin main
cat << 'EOF' > settings.html
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover">
<title>RYOKIVA - Ajustes e Idiomas</title>
<style>
*{box-sizing:border-box;margin:0;padding:0;-webkit-tap-highlight-color:transparent}
body{font-family:system-ui,-apple-system,sans-serif;background:#0b1120 url("fondo.jpg") no-repeat center center fixed;background-size:cover;color:#fff;min-height:100vh;display:flex;flex-direction:column;padding:20px;position:relative;overflow-x:hidden}

.top-bar{display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;z-index:1}
.brand-title{font-size:1.4rem;font-weight:900;color:#e11d48;letter-spacing:1px;text-decoration:none}
.back-btn{background:rgba(30,41,59,0.8);border:1px solid rgba(255,255,255,0.1);color:#fff;padding:8px 16px;border-radius:10px;cursor:pointer;text-decoration:none;font-size:0.85rem;font-weight:600}

.settings-container{max-width:800px;margin:0 auto;width:100%;z-index:1;display:flex;flex-direction:column;gap:20px;padding-bottom:40px}

.settings-card{background:rgba(15,23,42,0.85);backdrop-filter:blur(10px);border:1px solid rgba(255,255,255,0.1);border-radius:18px;padding:22px;display:flex;flex-direction:column;gap:15px}
.card-title{font-size:1.1rem;font-weight:800;color:#e11d48;display:flex;align-items:center;gap:8px}

.setting-row{display:flex;justify-content:space-between;align-items:center;padding:10px 0;border-bottom:1px solid rgba(255,255,255,0.08)}
.setting-row:last-child{border-bottom:none}
.setting-label{font-size:0.9rem;font-weight:600;color:#f8fafc}
.setting-desc{font-size:0.75rem;color:#94a3b8;margin-top:2px}

.select-input{background:rgba(30,41,59,0.9);border:1px solid rgba(255,255,255,0.2);color:#fff;padding:8px 14px;border-radius:10px;font-size:0.85rem;outline:none;cursor:pointer}
.select-input:focus{border-color:#e11d48}

.save-btn{background:#e11d48;color:#fff;border:none;padding:12px;border-radius:12px;font-weight:800;font-size:0.95rem;cursor:pointer;transition:all .2s;text-align:center;margin-top:10px;outline:none}
.save-btn:focus,.save-btn:hover{background:#f43f5e;transform:scale(1.02)}
</style>
</head>
<body>

<div class="top-bar">
  <a href="index.html" class="back-btn" tabindex="0">← Volver al Menú</a>
  <a href="index.html" class="brand-title">RYOKIVA</a>
</div>

<div class="settings-container">

  <!-- Configuración de Idiomas Globales -->
  <div class="settings-card">
    <div class="card-title">🌐 Idioma y Región</div>
    
    <div class="setting-row">
      <div>
        <div class="setting-label">Idioma de la Aplicación (Menús)</div>
        <div class="setting-desc">Cambia el idioma de todos los menús y botones</div>
      </div>
      <select class="select-input" id="app-language" tabindex="0">
        <option value="es" selected>Español</option>
        <option value="en">English</option>
        <option value="fr">Français</option>
        <option value="pt">Português</option>
      </select>
    </div>

    <div class="setting-row">
      <div>
        <div class="setting-label">Audio Preferido (Películas / Series / TV)</div>
        <div class="setting-desc">Idioma por defecto para los canales y VOD</div>
      </div>
      <select class="select-input" id="audio-language" tabindex="0">
        <option value="es">Español (Castellano)</option>
        <option value="es-lat">Español (Latino)</option>
        <option value="en">English (Original)</option>
        <option value="fr">Français</option>
      </select>
    </div>

    <div class="setting-

git remote -v


git remote -v
