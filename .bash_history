        .profile-name { font-size: 16px; font-weight: 600; color: #f8fafc; }
    </style>
    <script src="api.js"></script>
</head>
<body>

    <h1>¿Quién está viendo RYOKIVA?</h1>
    <div class="profiles-grid" id="profilesContainer">
        <!-- Carga dinámica o fallback -->
    </div>

    <script>
        async function cargarPerfiles() {
            const container = document.getElementById('profilesContainer');
            let perfiles = [
                { id: 1, nombre: 'Principal', avatar: '📺' },
                { id: 2, nombre: 'Familia', avatar: '🎬' },
                { id: 3, nombre: 'Infantil', avatar: '🧸' }
            ];

            try {
                if (window.RyokivaAPI) {
                    const apiPerfiles = await RyokivaAPI.getPerfiles();
                    if (apiPerfiles && apiPerfiles.length > 0) perfiles = apiPerfiles;
                }
            } catch (e) {
                console.log('Cargando perfiles locales por defecto');
            }

            container.innerHTML = perfiles.map((p, idx) => `
                <div class="profile-card" tabindex="${idx + 1}" onclick="seleccionarPerfil(${p.id})">
                    <div class="avatar">${p.avatar || '👤'}</div>
                    <div class="profile-name">${p.nombre}</div>
                </div>
            `).join('');

            // Enfocar el primer perfil automáticamente para el mando a distancia
            const firstCard = document.querySelector('.profile-card');
            if (firstCard) firstCard.focus();
        }

        function seleccionarPerfil(id) {
            localStorage.setItem('ryokiva_active_profile', id);
            location.href = 'dashboard.html';
        }

        window.addEventListener('load', cargarPerfiles);
    </script>
</body>
</html>
EOF

printf '%s\n' '<!DOCTYPE html>' '<html lang="es"><head>' '<meta charset="UTF-8">' '<meta name="viewport" content="width=device-width, initial-scale=1.0">' '<title>RYOKIVA - Perfiles</title>' '<style>' '* { box-sizing: border-box; margin: 0; padding: 0; }' 'body { background: #0b0f19; color: #fff; font-family: sans-serif; height: 100vh; display: flex; flex-direction: column; align-items: center; justify-content: center; }' 'h1 { margin-bottom: 25px; font-size: 26px; }' '.profiles { display: flex; gap: 20px; }' '.card { background: #1e293b; border-radius: 12px; padding: 20px; width: 130px; text-align: center; cursor: pointer; border: 2px solid transparent; }' '.card:focus, .card:hover { border-color: #38bdf8; transform: scale(1.05); outline: none; }' '.avatar { font-size: 40px; margin-bottom: 10px; }' '</style>' '<script src="api.js"></script>' '</head><body>' '<h1>¿Quién está viendo RYOKIVA?</h1>' '<div class="profiles" id="pBox"></div>' '<script>' 'async function init() {' '  let p = [{id:1,n:"Principal",a:"📺"},{id:2,n:"Familia",a:"🎬"},{id:3,n:"Infantil",a:"🧸"}];' '  try { if(window.RyokivaAPI){ let res = await RyokivaAPI.getPerfiles(); if(res&&res.length) p = res; } } catch(e){}' '  document.getElementById("pBox").innerHTML = p.map((item,i) => `<div class="card" tabindex="${i+1}" onclick="localStorage.setItem(\x27ryokiva_active_profile\x27,${item.id});location.href=\x27dashboard.html\x27"><div class="avatar">${item.a||"👤"}</div><div>${item.n}</div></div>`).join("");' '  setTimeout(() => { let c = document.querySelector(".card"); if(c) c.focus(); }, 100);' '}' 'window.onload = init;' '</script></body></html>' > perfiles.html
ls -la perfiles.html
printf '%s\n' '<!DOCTYPE html>' '<html lang="es"><head>' '<meta charset="UTF-8">' '<meta name="viewport" content="width=device-width, initial-scale=1.0">' '<title>RYOKIVA - Panel Principal</title>' '<style>' '* { box-sizing: border-box; margin: 0; padding: 0; }' 'body { background: #0b0f19; color: #fff; font-family: sans-serif; min-height: 100vh; padding: 30px; }' '.header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }' '.logo { font-size: 24px; font-weight: bold; color: #38bdf8; letter-spacing: 2px; }' '.grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 20px; }' '.btn-card { background: #1e293b; border-radius: 12px; padding: 25px; text-align: center; cursor: pointer; border: 2px solid transparent; transition: all 0.2s; }' '.btn-card:focus, .btn-card:hover { border-color: #38bdf8; transform: scale(1.05); outline: none; background: #0284c7; }' '.icon { font-size: 40px; margin-bottom: 10px; }' '.title { font-size: 18px; font-weight: 600; }' '</style>' '<script src="api.js"></script>' '</head><body>' '<div class="header"><div class="logo">RYOKIVA</div><div id="uInfo">Perfil Activo</div></div>' '<div class="grid">' '<div class="btn-card" tabindex="1" onclick="location.href=\x27reproductor.html\x27"><div class="icon">📺</div><div class="title">TV en Directo</div></div>' '<div class="btn-card" tabindex="2" onclick="location.href=\x27vod.html\x27"><div class="icon">🎬</div><div class="title">Cine y Series</div></div>' '<div class="btn-card" tabindex="3" onclick="location.href=\x27listas.html\x27"><div class="icon">📋</div><div class="title">Mis Listas</div></div>' '<div class="btn-card" tabindex="4" onclick="location.href=\x27favoritos.html\x27"><div class="icon">⭐</div><div class="title">Favoritos</div></div>' '<div class="btn-card" tabindex="5" onclick="location.href=\x27ajustes.html\x27"><div class="icon">⚙️</div><div class="title">Ajustes</div></div>' '</div>' '<script>' 'window.onload = () => {' '  const pid = localStorage.getItem("ryokiva_active_profile") || "1";' '  document.getElementById("uInfo").innerText = "Perfil #" + pid;' '  const first = document.querySelector(".btn-card");' '  if(first) first.focus();' '};' '</script></body></html>' > dashboard.html
ls -la dashboard.html
printf '%s\n' '<!DOCTYPE html>' '<html lang="es"><head>' '<meta charset="UTF-8">' '<meta name="viewport" content="width=device-width, initial-scale=1.0">' '<title>RYOKIVA - Mis Listas</title>' '<style>' '* { box-sizing: border-box; margin: 0; padding: 0; }' 'body { background: #0b0f19; color: #fff; font-family: sans-serif; min-height: 100vh; padding: 30px; }' '.header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }' 'h1 { font-size: 24px; color: #38bdf8; }' '.back-btn { background: #334155; border: none; color: #fff; padding: 8px 18px; border-radius: 6px; cursor: pointer; font-size: 14px; }' '.back-btn:focus { background: #0284c7; outline: 2px solid #38bdf8; }' '.list-container { display: flex; flex-direction: column; gap: 15px; }' '.item { background: #1e293b; padding: 18px 24px; border-radius: 10px; display: flex; justify-content: space-between; align-items: center; border: 2px solid transparent; cursor: pointer; }' '.item:focus, .item:hover { border-color: #38bdf8; background: #0f172a; outline: none; }' '.title { font-weight: 600; font-size: 16px; }' '.status { font-size: 12px; color: #4ade80; background: rgba(74,222,128,0.1); padding: 4px 10px; border-radius: 12px; }' '</style>' '<script src="api.js"></script>' '</head><body>' '<div class="header"><h1>📋 Mis Listas IPTV / Xtream</h1><button class="back-btn" tabindex="1" onclick="location.href=\x27dashboard.html\x27">⬅ Volver</button></div>' '<div class="list-container" id="lContainer"></div>' '<script>' 'async function cargarListas() {' '  const box = document.getElementById("lContainer");' '  let listas = [{id: 1, nombre: "Lista Principal M3U", canales: 4500, estado: "Activa"}, {id: 2, nombre: "Deportes & Eventos", canales: 1200, estado: "Activa"}];' '  try {' '    if (window.RyokivaAPI) {' '      const profileId = localStorage.getItem("ryokiva_active_profile") || 1;' '      const res = await RyokivaAPI.getListas(profileId);' '      if (res && res.length) listas = res;' '    }' '  } catch (e) {}' '  box.innerHTML = listas.map((l, i) => `<div class="item" tabindex="${i+2}" onclick="location.href=\x27reproductor.html?lista=${l.id}\x27"><div><div class="title">${l.nombre}</div><div style="font-size:12px;color:#94a3b8;margin-top:4px;">${l.canales || 0} canales cargados</div></div><div class="status">${l.estado || "Conectada"}</div></div>`).join("");' '  setTimeout(() => { const f = document.querySelector(".item"); if (f) f.focus(); }, 100);' '}' 'window.onload = cargarListas;' '</script></body></html>' > listas.html
ls -la listas.html
printf '%s\n' '<!DOCTYPE html>' '<html lang="es"><head>' '<meta charset="UTF-8">' '<meta name="viewport" content="width=device-width, initial-scale=1.0">' '<title>RYOKIVA - Reproductor</title>' '<style>' '* { box-sizing: border-box; margin: 0; padding: 0; }' 'body { background: #000; color: #fff; font-family: sans-serif; height: 100vh; display: flex; flex-direction: column; justify-content: space-between; overflow: hidden; }' '.player-screen { flex: 1; display: flex; justify-content: center; align-items: center; position: relative; }' '.placeholder-video { font-size: 24px; color: #64748b; text-align: center; }' '.osd-bar { background: linear-gradient(transparent, rgba(0,0,0,0.9)); padding: 30px; display: flex; justify-content: space-between; align-items: center; }' '.channel-info h2 { font-size: 22px; margin-bottom: 5px; color: #38bdf8; }' '.channel-info p { font-size: 14px; color: #94a3b8; }' '.controls { display: flex; gap: 15px; }' '.ctrl-btn { background: #1e293b; border: 2px solid transparent; color: #fff; padding: 10px 20px; border-radius: 8px; cursor: pointer; font-size: 14px; font-weight: bold; }' '.ctrl-btn:focus, .ctrl-btn:hover { border-color: #38bdf8; background: #0284c7; outline: none; }' '</style>' '<script src="api.js"></script>' '</head><body>' '<div class="player-screen"><div class="placeholder-video">▶ Reproduciendo Canal / VOD...</div></div>' '<div class="osd-bar"><div class="channel-info"><h2 id="cName">Canal en Directo</h2><p id="cCat">Categoría IPTV • RYOKIVA</p></div><div class="controls"><button class="ctrl-btn" tabindex="1" onclick="history.back()">⬅ Volver</button><button class="ctrl-btn" tabindex="2" onclick="alert(\x27Añadido a favoritos\x27)">⭐ Favorito</button></div></div>' '<script>' 'window.onload = () => {' '  const params = new URLSearchParams(window.location.search);' '  const lista = params.get("lista");' '  if(lista) document.getElementById("cCat").innerText = "Lista ID: " + lista + " • RYOKIVA";' '  const btn = document.querySelector(".ctrl-btn");' '  if(btn) btn.focus();' '};' '</script></body></html>' > reproductor.html
ls -la reproductor.html
printf '%s\n' '<!DOCTYPE html>' '<html lang="es"><head>' '<meta charset="UTF-8">' '<meta name="viewport" content="width=device-width, initial-scale=1.0">' '<title>RYOKIVA - Guía TV (EPG)</title>' '<style>' '* { box-sizing: border-box; margin: 0; padding: 0; }' 'body { background: #0b0f19; color: #fff; font-family: sans-serif; padding: 20px; }' '.header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }' 'h1 { color: #38bdf8; font-size: 22px; }' '.epg-grid { display: flex; flex-direction: column; gap: 12px; }' '.row { display: flex; background: #1e293b; border-radius: 8px; overflow: hidden; align-items: center; border: 2px solid transparent; }' '.row:focus, .row:hover { border-color: #38bdf8; background: #0284c7; outline: none; }' '.ch-name { width: 140px; background: #0f172a; padding: 15px; font-weight: bold; font-size: 14px; text-align: center; }' '.prog-info { padding: 15px; flex: 1; }' '.prog-title { font-size: 16px; font-weight: 600; }' '.prog-time { font-size: 12px; color: #38bdf8; margin-top: 4px; }' '</style>' '<script src="api.js"></script>' '</head><body>' '<div class="header"><h1>📺 Guía de Programación (EPG)</h1><button style="background:#334155;color:#fff;border:none;padding:8px 16px;border-radius:6px;cursor:pointer;" tabindex="1" onclick="location.href=\x27dashboard.html\x27">⬅ Volver</button></div>' '<div class="epg-grid" id="epgBox"></div>' '<script>' 'window.onload = () => {' '  const epg = [' '    { c: "La 1 HD", p: "Telediario 2", t: "21:00 - 22:00" },' '    { c: "Antena 3", p: "El Hormiguero", t: "21:45 - 22:45" },' '    { c: "Movistar+", p: "Partido en Directo", t: "21:00 - 23:00" }' '  ];' '  document.getElementById("epgBox").innerHTML = epg.map((item, i) => `' '    <div class="row" tabindex="${i+2}" onclick="location.href=\x27reproductor.html\x27">' '      <div class="ch-name">${item.c}</div>' '      <div class="prog-info"><div class="prog-title">${item.p}</div><div class="prog-time">AHORA • ${item.t}</div></div>' '    </div>`' '  ).join("");' '  const f = document.querySelector(".row"); if(f) f.focus();' '};' '</script></body></html>' > epg.html
printf '%s\n' '<!DOCTYPE html>' '<html lang="es"><head>' '<meta charset="UTF-8">' '<meta name="viewport" content="width=device-width, initial-scale=1.0">' '<title>RYOKIVA - Búsqueda Universal</title>' '<style>' '* { box-sizing: border-box; margin: 0; padding: 0; }' 'body { background: #0b0f19; color: #fff; font-family: sans-serif; padding: 25px; }' '.header { display: flex; gap: 15px; margin-bottom: 25px; align-items: center; }' 'input { flex: 1; background: #1e293b; border: 2px solid #334155; color: #fff; padding: 14px; border-radius: 10px; font-size: 16px; }' 'input:focus { border-color: #38bdf8; outline: none; background: #0f172a; }' '.btn { background: #334155; border: none; color: #fff; padding: 14px 20px; border-radius: 10px; cursor: pointer; font-weight: bold; }' '.btn:focus { background: #0284c7; outline: 2px solid #38bdf8; }' '.results { display: grid; grid-template-columns: repeat(auto-fill, minmax(160px, 1fr)); gap: 15px; }' '.card { background: #1e293b; border-radius: 10px; padding: 15px; text-align: center; border: 2px solid transparent; cursor: pointer; }' '.card:focus, .card:hover { border-color: #38bdf8; background: #0284c7; outline: none; }' '</style>' '<script src="api.js"></script>' '</head><body>' '<div class="header">' '<input type="text" id="sInput" placeholder="🔍 Buscar canales, películas, series..." tabindex="1">' '<button class="btn" tabindex="2" onclick="location.href=\x27dashboard.html\x27">⬅ Volver</button>' '</div>' '<div class="results" id="rBox"></div>' '<script>' 'const dummy = [' '  { type: "TV", title: "La 1 HD", icon: "📺" },' '  { type: "Película", title: "Avatar 2", icon: "🎬" },' '  { type: "Serie", title: "Stranger Things", icon: "🍿" },' '  { type: "Deporte", title: "LaLiga TV", icon: "⚽" }' '];' 'function filter(q) {' '  const res = dummy.filter(i => i.title.toLowerCase().includes(q.toLowerCase()));' '  document.getElementById("rBox").innerHTML = res.map((item, i) => `' '    <div class="card" tabindex="${i+3}" onclick="location.href=\x27reproductor.html\x27">' '      <div style="font-size:30px;margin-bottom:8px;">${item.icon}</div>' '      <div style="font-weight:bold;font-size:14px;">${item.title}</div>' '      <div style="font-size:11px;color:#94a3b8;margin-top:4px;">${item.type}</div>' '    </div>`' '  ).join("");' '}' 'document.getElementById("sInput").addEventListener("input", (e) => filter(e.target.value));' 'window.onload = () => { filter(""); document.getElementById("sInput").focus(); };' '</script></body></html>' > buscar.html
printf '%s\n' '<!DOCTYPE html>' '<html lang="es"><head>' '<meta charset="UTF-8">' '<meta name="viewport" content="width=device-width, initial-scale=1.0">' '<title>RYOKIVA - Guía TV</title>' '<style>' '* { box-sizing: border-box; margin: 0; padding: 0; }' 'body { background: #0b0f19; color: #fff; font-family: sans-serif; padding: 25px; }' '.header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }' 'h1 { color: #38bdf8; font-size: 22px; }' '.epg-grid { display: flex; flex-direction: column; gap: 12px; }' '.row { display: flex; background: #1e293b; border-radius: 8px; overflow: hidden; align-items: center; border: 2px solid transparent; cursor: pointer; }' '.row:focus, .row:hover { border-color: #38bdf8; background: #0284c7; outline: none; }' '.ch { width: 130px; background: #0f172a; padding: 15px; font-weight: bold; text-align: center; font-size: 14px; }' '.info { padding: 15px; flex: 1; }' '.title { font-size: 15px; font-weight: bold; }' '.time { font-size: 12px; color: #38bdf8; margin-top: 4px; }' '</style>' '<script src="api.js"></script>' '</head><body>' '<div class="header"><h1>📺 Guía de Programación (EPG)</h1><button style="background:#334155;color:#fff;border:none;padding:10px 18px;border-radius:8px;cursor:pointer;" tabindex="1" onclick="location.href=\x27dashboard.html\x27">⬅ Volver</button></div>' '<div class="epg-grid" id="eBox"></div>' '<script>' 'window.onload = () => {' '  const e = [' '    { c: "Movistar+", p: "El Clásico en Directo", t: "21:00 - 23:00" },' '    { c: "La 1 HD", p: "Telediario 2", t: "21:00 - 22:00" },' '    { c: "Antena 3", p: "El Hormiguero", t: "21:45 - 22:45" },' '    { c: "HBO Max", p: "House of the Dragon", t: "22:00 - 23:10" }' '  ];' '  document.getElementById("eBox").innerHTML = e.map((item, i) => `' '    <div class="row" tabindex="${i+2}" onclick="location.href=\x27reproductor.html\x27">' '      <div class="ch">${item.c}</div>' '      <div class="info"><div class="title">${item.p}</div><div class="time">EN DIRECTO • ${item.t}</div></div>' '    </div>`' '  ).join("");' '  const f = document.querySelector(".row"); if(f) f.focus();' '};' '</script></body></html>' > epg.html
printf '%s\n' '<!DOCTYPE html>' '<html lang="es"><head>' '<meta charset="UTF-8">' '<meta name="viewport" content="width=device-width, initial-scale=1.0">' '<title>RYOKIVA - Cuenta</title>' '<style>' '* { box-sizing: border-box; margin: 0; padding: 0; }' 'body { background: #0b0f19; color: #fff; font-family: sans-serif; padding: 30px; display: flex; justify-content: center; align-items: center; min-height: 100vh; }' '.card { background: #1e293b; border-radius: 16px; padding: 30px; width: 100%; max-width: 420px; border: 1px solid #334155; }' '.title { font-size: 22px; color: #38bdf8; font-weight: bold; margin-bottom: 20px; text-align: center; }' '.info-group { margin-bottom: 15px; background: #0f172a; padding: 12px 16px; border-radius: 8px; display: flex; justify-content: space-between; font-size: 14px; }' '.label { color: #94a3b8; }' '.value { font-weight: bold; color: #4ade80; }' '.btn { width: 100%; background: #334155; border: 2px solid transparent; color: #fff; padding: 12px; border-radius: 8px; cursor: pointer; font-size: 15px; font-weight: bold; margin-top: 15px; }' '.btn:focus, .btn:hover { border-color: #38bdf8; background: #0284c7; outline: none; }' '</style>' '<script src="api.js"></script>' '</head><body>' '<div class="card">' '<div class="title">👑 Mi Suscripción RYOKIVA</div>' '<div class="info-group"><span class="label">Plan Activo:</span><span class="value">Super VIP Premium</span></div>' '<div class="info-group"><span class="label">Estado:</span><span class="value">Activo (365 días)</span></div>' '<div class="info-group"><span class="label">Dispositivos:</span><span class="value">1 / 4 Activos</span></div>' '<div class="info-group"><span class="label">ID TV:</span><span class="value" style="color:#fff;" id="dId">DEV-RYOKIVA</span></div>' '<button class="btn" tabindex="1" onclick="location.href=\x27dashboard.html\x27">⬅ Volver al Menú</button>' '</div>' '<script>' 'window.onload = () => {' '  const dev = localStorage.getItem("ryokiva_device") || "DEV-RYOKIVA-8821";' '  document.getElementById("dId").innerText = dev;' '  const btn = document.querySelector(".btn"); if(btn) btn.focus();' '};' '</script></body></html>' > cuenta.html
printf '%s\n' '<!DOCTYPE html>' '<html lang="es"><head>' '<meta charset="UTF-8">' '<meta name="viewport" content="width=device-width, initial-scale=1.0">' '<title>RYOKIVA - Super App Dashboard</title>' '<style>' '* { box-sizing: border-box; margin: 0; padding: 0; }' 'body { background: #0b0f19; color: #fff; font-family: sans-serif; min-height: 100vh; padding: 25px; }' '.header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }' '.logo { font-size: 24px; font-weight: bold; color: #38bdf8; letter-spacing: 2px; }' '.grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 15px; }' '.btn-card { background: #1e293b; border-radius: 12px; padding: 20px 15px; text-align: center; cursor: pointer; border: 2px solid transparent; transition: all 0.2s; }' '.btn-card:focus, .btn-card:hover { border-color: #38bdf8; transform: scale(1.05); outline: none; background: #0284c7; }' '.icon { font-size: 36px; margin-bottom: 8px; }' '.title { font-size: 15px; font-weight: 600; }' '</style>' '<script src="api.js"></script>' '</head><body>' '<div class="header"><div class="logo">RYOKIVA</div><div id="uInfo" style="font-size:14px;color:#94a3b8;">Perfil Activo</div></div>' '<div class="grid">' '<div class="btn-card" tabindex="1" onclick="location.href=\x27reproductor.html\x27"><div class="icon">📺</div><div class="title">TV Directo</div></div>' '<div class="btn-card" tabindex="2" onclick="location.href=\x27vod.html\x27"><div class="icon">🎬</div><div class="title">Cine & Series</div></div>' '<div class="btn-card" tabindex="3" onclick="location.href=\x27epg.html\x27"><div class="icon">📅</div><div class="title">Guía EPG</div></div>' '<div class="btn-card" tabindex="4" onclick="location.href=\x27buscar.html\x27"><div class="icon">🔍</div><div class="title">Buscador</div></div>' '<div class="btn-card" tabindex="5" onclick="location.href=\x27listas.html\x27"><div class="icon">📋</div><div class="title">Mis Listas</div></div>' '<div class="btn-card" tabindex="6" onclick="location.href=\x27favoritos.html\x27"><div class="icon">⭐</div><div class="title">Favoritos</div></div>' '<div class="btn-card" tabindex="7" onclick="location.href=\x27cuenta.html\x27"><div class="icon">👑</div><div class="title">Mi Cuenta</div></div>' '<div class="btn-card" tabindex="8" onclick="location.href=\x27ajustes.html\x27"><div class="icon">⚙️</div><div class="title">Ajustes</div></div>' '</div>' '<script>' 'window.onload = () => {' '  const pid = localStorage.getItem("ryokiva_active_profile") || "1";' '  document.getElementById("uInfo").innerText = "Perfil #" + pid;' '  const first = document.querySelector(".btn-card");' '  if(first) first.focus();' '};' '</script></body></html>' > dashboard.html
ls -la buscar.html epg.html cuenta.html dashboard.html
printf '%s\n' '<!DOCTYPE html>' '<html lang="es"><head>' '<meta charset="UTF-8">' '<meta name="viewport" content="width=device-width, initial-scale=1.0">' '<title>RYOKIVA - Categorías</title>' '<style>' '* { box-sizing: border-box; margin: 0; padding: 0; }' 'body { background: #0b0f19; color: #fff; font-family: sans-serif; padding: 25px; }' '.header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }' 'h1 { font-size: 22px; color: #38bdf8; }' '.grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(160px, 1fr)); gap: 15px; }' '.card { background: #1e293b; border-radius: 12px; padding: 20px; text-align: center; border: 2px solid transparent; cursor: pointer; }' '.card:focus, .card:hover { border-color: #38bdf8; background: #0284c7; outline: none; }' '</style>' '<script src="api.js"></script>' '</head><body>' '<div class="header"><h1>📺 Categorías de TV</h1><button style="background:#334155;color:#fff;border:none;padding:10px 18px;border-radius:8px;cursor:pointer;" tabindex="1" onclick="location.href=\x27dashboard.html\x27">⬅ Volver</button></div>' '<div class="grid" id="cBox"></div>' '<script>' 'window.onload = () => {' '  const cats = [{n:"Deportes",i:"⚽"},{n:"Cine",i:"🎬"},{n:"Noticias",i:"📰"},{n:"Infantil",i:"🧸"},{n:"Documentales",i:"🌍"}];' '  document.getElementById("cBox").innerHTML = cats.map((item, i) => `<div class="card" tabindex="${i+2}" onclick="location.href=\x27reproductor.html\x27"><div style="font-size:32px;margin-bottom:8px;">${item.i}</div><div style="font-weight:bold;">${item.n}</div></div>`).join("");' '  const f = document.querySelector(".card"); if(f) f.focus();' '};' '</script></body></html>' > categorias.html
printf '%s\n' '<!DOCTYPE html>' '<html lang="es"><head>' '<meta charset="UTF-8">' '<meta name="viewport" content="width=device-width, initial-scale=1.0">' '<title>RYOKIVA - VOD</title>' '<style>' '* { box-sizing: border-box; margin: 0; padding: 0; }' 'body { background: #0b0f19; color: #fff; font-family: sans-serif; padding: 25px; }' '.header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }' 'h1 { font-size: 22px; color: #38bdf8; }' '.grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(150px, 1fr)); gap: 15px; }' '.poster { background: #1e293b; height: 180px; border-radius: 10px; display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center; border: 2px solid transparent; cursor: pointer; padding: 10px; }' '.poster:focus, .poster:hover { border-color: #38bdf8; background: #0284c7; outline: none; }' '</style>' '<script src="api.js"></script>' '</head><body>' '<div class="header"><h1>🎬 Cine y Series (VOD)</h1><button style="background:#334155;color:#fff;border:none;padding:10px 18px;border-radius:8px;cursor:pointer;" tabindex="1" onclick="location.href=\x27dashboard.html\x27">⬅ Volver</button></div>' '<div class="grid" id="vBox"></div>' '<script>' 'window.onload = () => {' '  const vods = [{t:"Estrenos 2026",i:"🍿"},{t:"Top Películas",i:"⭐"},{t:"Series Tendencia",i:"🔥"},{t:"Acción & Sci-Fi",i:"🚀"}];' '  document.getElementById("vBox").innerHTML = vods.map((item, i) => `<div class="poster" tabindex="${i+2}" onclick="location.href=\x27reproductor.html\x27"><div style="font-size:36px;margin-bottom:8px;">${item.i}</div><div style="font-weight:bold;font-size:14px;">${item.t}</div></div>`).join("");' '  const f = document.querySelector(".poster"); if(f) f.focus();' '};' '</script></body></html>' > vod.html
printf '%s\n' '<!DOCTYPE html>' '<html lang="es"><head>' '<meta charset="UTF-8">' '<meta name="viewport" content="width=device-width, initial-scale=1.0">' '<title>RYOKIVA - Favoritos</title>' '<style>' '* { box-sizing: border-box; margin: 0; padding: 0; }' 'body { background: #0b0f19; color: #fff; font-family: sans-serif; padding: 25px; }' '.header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }' 'h1 { font-size: 22px; color: #38bdf8; }' '.list { display: flex; flex-direction: column; gap: 12px; }' '.item { background: #1e293b; padding: 15px 20px; border-radius: 8px; display: flex; justify-content: space-between; align-items: center; border: 2px solid transparent; cursor: pointer; }' '.item:focus, .item:hover { border-color: #38bdf8; background: #0284c7; outline: none; }' '</style>' '<script src="api.js"></script>' '</head><body>' '<div class="header"><h1>⭐ Mis Canales Favoritos</h1><button style="background:#334155;color:#fff;border:none;padding:10px 18px;border-radius:8px;cursor:pointer;" tabindex="1" onclick="location.href=\x27dashboard.html\x27">⬅ Volver</button></div>' '<div class="list" id="fBox"></div>' '<script>' 'window.onload = () => {' '  const favs = [{n:"La 1 HD",t:"TV"},{n:"Movistar Deportes",t:"Deportes"},{n:"HBO Max",t:"VOD"}];' '  document.getElementById("fBox").innerHTML = favs.map((item, i) => `<div class="item" tabindex="${i+2}" onclick="location.href=\x27reproductor.html\x27"><div style="font-weight:bold;">${item.n}</div><div style="font-size:12px;color:#94a3b8;">${item.t}</div></div>`).join("");' '  const f = document.querySelector(".item"); if(f) f.focus();' '};' '</script></body></html>' > favoritos.html
printf '%s\n' '<!DOCTYPE html>' '<html lang="es"><head>' '<meta charset="UTF-8">' '<meta name="viewport" content="width=device-width, initial-scale=1.0">' '<title>RYOKIVA - Ajustes</title>' '<style>' '* { box-sizing: border-box; margin: 0; padding: 0; }' 'body { background: #0b0f19; color: #fff; font-family: sans-serif; padding: 25px; }' '.header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }' 'h1 { font-size: 22px; color: #38bdf8; }' '.opts { display: flex; flex-direction: column; gap: 12px; max-width: 500px; margin: 0 auto; }' '.btn { background: #1e293b; padding: 16px; border-radius: 10px; border: 2px solid transparent; color: #fff; font-weight: bold; cursor: pointer; text-align: left; }' '.btn:focus, .btn:hover { border-color: #38bdf8; background: #0284c7; outline: none; }' '</style>' '<script src="api.js"></script>' '</head><body>' '<div class="header"><h1>⚙️ Ajustes y Soporte</h1><button style="background:#334155;color:#fff;border:none;padding:10px 18px;border-radius:8px;cursor:pointer;" tabindex="1" onclick="location.href=\x27dashboard.html\x27">⬅ Volver</button></div>' '<div class="opts">' '<button class="btn" tabindex="2" onclick="alert(\x27Caché limpiada con éxito\x27)">🧹 Limpiar Caché y Canales</button>' '<button class="btn" tabindex="3" onclick="location.href=\x27cuenta.html\x27">👑 Ver Suscripción</button>' '<button class="btn" tabindex="4" onclick="alert(\x27Soporte enviado a RYOKIVA\x27)">📩 Contactar Soporte Técnico</button>' '<button class="btn" tabindex="5" onclick="location.href=\x27index.html\x27" style="background:#7f1d1d;">🚪 Cerrar Sesión</button>' '</div>' '<script>' 'window.onload = () => { const f = document.querySelector(".btn"); if(f) f.focus(); };' '</script></body></html>' > ajustes.html
ls -la index.html api.js perfiles.html dashboard.html listas.html categorias.html reproductor.html vod.html epg.html buscar.html favoritos.html cuenta.html ajustes.html
printf '%s\n' '<!DOCTYPE html>' '<html lang="es"><head>' '<meta charset="UTF-8">' '<meta name="viewport" content="width=device-width, initial-scale=1.0">' '<title>RYOKIVA - Reproductor Pro</title>' '<style>' '* { box-sizing: border-box; margin: 0; padding: 0; }' 'body { background: #000; color: #fff; font-family: sans-serif; height: 100vh; overflow: hidden; display: flex; flex-direction: column; justify-content: space-between; position: relative; }' 'video { width: 100%; height: 100%; object-fit: contain; position: absolute; top:0; left:0; z-index: 1; }' '.osd { position: absolute; bottom: 0; left: 0; right: 0; z-index: 10; background: linear-gradient(transparent, rgba(0,0,0,0.95)); padding: 25px 35px; display: flex; flex-direction: column; gap: 15px; transition: opacity 0.3s; }' '.info h2 { font-size: 22px; color: #38bdf8; margin-bottom: 4px; }' '.info p { font-size: 13px; color: #94a3b8; }' '.progress-bar { width: 100%; background: rgba(255,255,255,0.2); height: 8px; border-radius: 4px; overflow: hidden; cursor: pointer; position: relative; }' '.progress-fill { background: #38bdf8; width: 0%; height: 100%; transition: width 0.1s linear; }' '.controls-row { display: flex; justify-content: space-between; align-items: center; }' '.btn-group { display: flex; gap: 12px; }' '.btn { background: #1e293b; border: 2px solid transparent; color: #fff; padding: 10px 18px; border-radius: 8px; font-weight: bold; cursor: pointer; font-size: 14px; }' '.btn:focus, .btn:hover { border-color: #38bdf8; background: #0284c7; outline: none; }' '.time-display { font-size: 14px; color: #cbd5e1; font-family: monospace; }' '</style>' '<script src="api.js"></script>' '</head><body>' '<video id="myVideo" src="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4" autoplay></video>' '<div class="osd" id="osdBox">' '<div class="info"><h2 id="cTitle">Canal / Vídeo en Directo</h2><p id="cSub">RYOKIVA • Transmisión HD</p></div>' '<div class="progress-bar" onclick="seekClick(event)"><div class="progress-fill" id="pFill"></div></div>' '<div class="controls-row">' '<div class="btn-group">' '<button class="btn" tabindex="1" onclick="history.back()">⬅ Volver</button>' '<button class="btn" tabindex="2" onclick="rewind(10)">⏪ -10s</button>' '<button class="btn" tabindex="3" id="playBtn" onclick="togglePlay()">⏸ Pausa</button>' '<button class="btn" tabindex="4" onclick="forward(10)">⏩ +10s</button>' '<button class="btn" tabindex="5" onclick="toggleMute()">🔊 Audio</button>' '</div>' '<div class="time-display" id="tDisp">00:00 / 00:00</div>' '</div>' '</div>' '<script>' 'const v = document.getElementById("myVideo");' 'const pFill = document.getElementById("pFill");' 'const tDisp = document.getElementById("tDisp");' 'const playBtn = document.getElementById("playBtn");' 'function togglePlay() { if(v.paused) { v.play(); playBtn.innerText="⏸ Pausa"; } else { v.pause(); playBtn.innerText="▶ Play"; } }' 'function rewind(s) { v.currentTime = Math.max(0, v.currentTime - s); }' 'function forward(s) { v.currentTime = Math.min(v.duration, v.currentTime + s); }' 'function toggleMute() { v.muted = !v.muted; }' 'function fmt(sec) { if(isNaN(sec)) return "00:00"; const m=Math.floor(sec/60), s=Math.floor(sec%60); return (m<10?"0":"")+m+":"+(s<10?"0":"")+s; }' 'v.addEventListener("timeupdate", () => {' '  if(v.duration) {' '    pFill.style.width = (v.currentTime / v.duration * 100) + "%";' '    tDisp.innerText = fmt(v.currentTime) + " / " + fmt(v.duration);' '  }' '});' 'document.addEventListener("keydown", (e) => {' '  if(e.key==="ArrowLeft") rewind(10);' '  else if(e.key==="ArrowRight") forward(10);' '  else if(e.key===" " || e.key==="MediaPlayPause") togglePlay();' '});' 'window.onload = () => { const b = document.getElementById("playBtn"); if(b) b.focus(); };' '</script></body></html>' > reproductor.html
printf '%s\n' '<!DOCTYPE html>' '<html lang="es"><head>' '<meta charset="UTF-8">' '<meta name="viewport" content="width=device-width, initial-scale=1.0">' '<title>RYOKIVA - Reproductor Smart TV</title>' '<style>' '* { box-sizing: border-box; margin: 0; padding: 0; }' 'body { background: #000; color: #fff; font-family: sans-serif; height: 100vh; overflow: hidden; display: flex; flex-direction: column; justify-content: space-between; position: relative; }' 'video { width: 100%; height: 100%; object-fit: contain; position: absolute; top:0; left:0; z-index: 1; }' '.osd { position: absolute; bottom: 0; left: 0; right: 0; z-index: 10; background: linear-gradient(transparent, rgba(0,0,0,0.95)); padding: 30px; display: flex; flex-direction: column; gap: 15px; opacity: 0; pointer-events: none; transition: opacity 0.4s ease; }' '.osd.visible { opacity: 1; pointer-events: auto; }' '.info h2 { font-size: 22px; color: #38bdf8; margin-bottom: 4px; }' '.info p { font-size: 13px; color: #94a3b8; }' '.progress-bar { width: 100%; background: rgba(255,255,255,0.2); height: 8px; border-radius: 4px; overflow: hidden; position: relative; }' '.progress-fill { background: #38bdf8; width: 0%; height: 100%; transition: width 0.1s linear; }' '.controls-row { display: flex; justify-content: space-between; align-items: center; }' '.btn-group { display: flex; gap: 12px; }' '.btn { background: #1e293b; border: 2px solid transparent; color: #fff; padding: 10px 18px; border-radius: 8px; font-weight: bold; cursor: pointer; font-size: 14px; }' '.btn:focus, .btn:hover { border-color: #38bdf8; background: #0284c7; outline: none; }' '.time-display { font-size: 14px; color: #cbd5e1; font-family: monospace; }' '</style>' '<script src="api.js"></script>' '</head><body>' '<video id="myVideo" src="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4" autoplay></video>' '<div class="osd" id="osdBox">' '<div class="info"><h2 id="cTitle">Canal / Vídeo en Directo</h2><p id="cSub">RYOKIVA • Transmisión HD</p></div>' '<div class="progress-bar"><div class="progress-fill" id="pFill"></div></div>' '<div class="controls-row">' '<div class="btn-group">' '<button class="btn" tabindex="1" onclick="history.back()">⬅ Volver</button>' '<button class="btn" tabindex="2" onclick="rewind(10)">⏪ -10s</button>' '<button class="btn" tabindex="3" id="playBtn" onclick="togglePlay()">⏸ Pausa</button>' '<button class="btn" tabindex="4" onclick="forward(10)">⏩ +10s</button>' '<button class="btn" tabindex="5" onclick="toggleMute()">🔊 Audio</button>' '</div>' '<div class="time-display" id="tDisp">00:00 / 00:00</div>' '</div>' '</div>' '<script>' 'const v = document.getElementById("myVideo");' 'const osd = document.getElementById("osdBox");' 'const pFill = document.getElementById("pFill");' 'const tDisp = document.getElementById("tDisp");' 'const playBtn = document.getElementById("playBtn");' 'let hideTimer = null;' 'function showOSD() {' '  osd.classList.add("visible");' '  clearTimeout(hideTimer);' '  hideTimer = setTimeout(() => { osd.classList.remove("visible"); }, 4000);' '}' 'function togglePlay() { showOSD(); if(v.paused) { v.play(); playBtn.innerText="⏸ Pausa"; } else { v.pause(); playBtn.innerText="▶ Play"; } }' 'function rewind(s) { showOSD(); v.currentTime = Math.max(0, v.currentTime - s); }' 'function forward(s) { showOSD(); v.currentTime = Math.min(v.duration, v.currentTime + s); }' 'function toggleMute() { showOSD(); v.muted = !v.muted; }' 'function fmt(sec) { if(isNaN(sec)) return "00:00"; const m=Math.floor(sec/60), s=Math.floor(sec%60); return (m<10?"0":"")+m+":"+(s<10?"0":"")+s; }' 'v.addEventListener("timeupdate", () => {' '  if(v.duration) {' '    pFill.style.width = (v.currentTime / v.duration * 100) + "%";' '    tDisp.innerText = fmt(v.currentTime) + " / " + fmt(v.duration);' '  }' '});' 'document.addEventListener("keydown", (e) => {' '  showOSD();' '  if(e.key==="ArrowLeft") rewind(10);' '  else if(e.key==="ArrowRight") forward(10);' '  else if(e.key==="Enter" || e.key===" ") { if(!osd.classList.contains("visible")) { playBtn.focus(); } }' '});' 'window.onload = () => { showOSD(); document.getElementById("playBtn").focus(); };' '</script></body></html>' > reproductor.html
python3 -m http.server 3000
fuser -k 3000/tcp
python3 -m http.server 3000
python3 -m http.server 3000
python3 -m http.server 8080
 builtin printf "\e[?1049h"
 if [ "$_termius_si_installed" = "" ]; then  _termius_si_installed="yes";  _termius_si_executing="";  _termius_si_last_cwd="";  _termius_si_precmd() {  builtin local ret="$?";  if [ -n "$_termius_si_executing" ]; then  builtin printf "\e]133;D;%s\a" "$ret";  fi;  if [ "$_termius_si_last_cwd" != "$PWD" ]; then  _termius_si_last_cwd="$PWD";  builtin printf "\e]7;file://%s%s\a" "${HOSTNAME:-}" "$PWD";  fi;  builtin printf "\e]133;A\a";  if [[ "$PS1" != *$'\e]133;B'* ]]; then  PS1='\[\e]133;P;k=i\a\]'"$PS1"'\[\e]133;B\a\]';  fi;  _termius_si_executing="";  };  _termius_si_preexec() {  builtin printf "\e]133;C\a";  _termius_si_executing="1";  };  if [[ -n "${bash_preexec_imported:-}" ]]; then  precmd_functions+=(_termius_si_precmd);  preexec_functions+=(_termius_si_preexec);  else  _termius_si_dbg() {  if [ -z "$_termius_si_executing" ]; then  _termius_si_preexec;  fi;  };  if [[ $(builtin declare -p PROMPT_COMMAND 2>/dev/null) == "declare -a "* ]]; then  PROMPT_COMMAND+=(_termius_si_precmd);  elif [[ -n "${PROMPT_COMMAND:-}" ]]; then  PROMPT_COMMAND="_termius_si_precmd;${PROMPT_COMMAND}";  else  PROMPT_COMMAND="_termius_si_precmd";  fi;  trap '_termius_si_dbg' DEBUG;  fi;  fi
 builtin printf "\e[?1049l\e]777;ShellIntegrationReady\a"
printf '%s\n' '<!DOCTYPE html>' '<html lang="es"><head>' '<meta charset="UTF-8">' '<meta name="viewport" content="width=device-width, initial-scale=1.0">' '<title>RYOKIVA - Tu entretenimiento en tus manos</title>' '<style>' '* { box-sizing: border-box; margin: 0; padding: 0; }' 'body { background: #0b0f19; color: #fff; font-family: sans-serif; height: 100vh; display: flex; flex-direction: column; justify-content: center; align-items: center; padding: 20px; text-align: center; }' 'h1 { font-size: 32px; color: #38bdf8; margin-bottom: 10px; letter-spacing: 2px; }' 'p { color: #94a3b8; font-size: 16px; margin-bottom: 30px; }' '.btn { background: #0284c7; border: 2px solid #38bdf8; color: #fff; padding: 15px 40px; border-radius: 12px; font-size: 18px; font-weight: bold; cursor: pointer; text-decoration: none; display: inline-block; }' '.btn:focus, .btn:hover { background: #38bdf8; color: #0b0f19; outline: none; transform: scale(1.05); }' '</style>' '<script src="api.js"></script>' '</head><body>' '<h1>RYOKIVA</h1>' '<p>Tu entretenimiento en tus manos</p>' '<a href="perfiles.html" class="btn" tabindex="1">ENTRAR A LA SUPER APP</a>' '<script>' 'window.onload = () => { const b = document.querySelector(".btn"); if(b) b.focus(); };' '</script></body></html>' > index.html
ls -la index.*
rm -f index.php
printf '%s\n' '<!DOCTYPE html>' '<html lang="es"><head>' '<meta charset="UTF-8">' '<meta name="viewport" content="width=device-width, initial-scale=1.0">' '<title>RYOKIVA - Tu entretenimiento en tus manos</title>' '<style>' '* { box-sizing: border-box; margin: 0; padding: 0; }' 'body { background: #070a13; color: #fff; font-family: sans-serif; height: 100vh; overflow: hidden; display: flex; flex-direction: column; padding: 30px 40px; }' 'header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }' '.logo { font-size: 28px; font-weight: bold; color: #f43f5e; letter-spacing: 2px; }' '.badge-box { background: rgba(255,255,255,0.08); padding: 8px 18px; border-radius: 20px; font-size: 13px; display: flex; gap: 15px; color: #cbd5e1; border: 1px solid rgba(255,255,255,0.1); }' '.grid-13 { display: grid; grid-template-columns: repeat(5, 1fr); gap: 15px; flex: 1; }' '.card { background: #111827; border: 2px solid rgba(255,255,255,0.1); border-radius: 12px; padding: 15px; display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center; cursor: pointer; text-decoration: none; color: #fff; transition: all 0.2s; }' '.card:focus, .card:hover { border-color: #38bdf8; background: #1e293b; transform: scale(1.03); outline: none; }' '.card h3 { font-size: 15px; margin-bottom: 5px; color: #38bdf8; }' '.card p { font-size: 11px; color: #94a3b8; }' '</style>' '<script src="api.js"></script>' '</head><body>' '<header>' '<div class="logo">RYOKIVA</div>' '<div class="badge-box"><span>⭐ Caduca: 5 días</span><span>👤 Perfil: Principal</span></div>' '</header>' '<div class="grid-13">' '<a href="perfiles.html" class="card" tabindex="1"><h3>01. Perfiles</h3><p>Gestión de cuentas</p></a>' '<a href="dashboard.html" class="card" tabindex="2"><h3>02. Dashboard</h3><p>Panel principal</p></a>' '<a href="listas.html" class="card" tabindex="3"><h3>03. Listas M3U</h3><p>Gestión de listas</p></a>' '<a href="categorias.html" class="card" tabindex="4"><h3>04. Categorías</h3><p>Filtro de canales</p></a>' '<a href="reproductor.html" class="card" tabindex="5"><h3>05. Reproductor</h3><p>OSD y Controles</p></a>' '<a href="vod.html" class="card" tabindex="6"><h3>06. VOD Películas</h3><p>Catálogo de cine</p></a>' '<a href="epg.html" class="card" tabindex="7"><h3>07. Guía EPG</h3><p>Programación TV</p></a>' '<a href="buscar.html" class="card" tabindex="8"><h3>08. Buscador</h3><p>Búsqueda global</p></a>' '<a href="favoritos.html" class="card" tabindex="9"><h3>09. Favoritos</h3><p>Tus canales top</p></a>' '<a href="cuenta.html" class="card" tabindex="10"><h3>10. Mi Cuenta</h3><p>Suscripción y datos</p></a>' '<a href="ajustes.html" class="card" tabindex="11"><h3>11. Ajustes</h3><p>Configuración app</p></a>' '<a href="reproductor.html" class="card" tabindex="12"><h3>12. Live Stream</h3><p>Emisión en vivo</p></a>' '<a href="index.html" class="card" tabindex="13"><h3>13. Inicio</h3><p>Pantalla principal</p></a>' '</div>' '<script>' 'window.onload = () => { document.querySelector(".card").focus(); };' '</script></body></html>' > index.html
printf '%s\n' '<!DOCTYPE html>' '<html lang="es"><head>' '<meta charset="UTF-8">' '<meta name="viewport" content="width=device-width, initial-scale=1.0">' '<title>RYOKIVA - Tu entretenimiento en tus manos</title>' '<style>' '* { box-sizing: border-box; margin: 0; padding: 0; }' 'body { background: #070a13; color: #fff; font-family: sans-serif; height: 100vh; overflow: hidden; display: flex; flex-direction: column; padding: 20px 30px; }' 'header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 10px; }' '.logo { font-size: 26px; font-weight: bold; color: #f43f5e; letter-spacing: 2px; }' '.slogan { font-size: 13px; color: #94a3b8; }' '.badge-box { background: rgba(255,255,255,0.08); padding: 6px 14px; border-radius: 20px; font-size: 12px; display: flex; gap: 12px; color: #cbd5e1; border: 1px solid rgba(255,255,255,0.1); }' '.main-layout { display: flex; gap: 20px; flex: 1; align-items: stretch; }' '.welcome-panel { width: 320px; background: #111827; border: 2px solid #f43f5e; border-radius: 12px; padding: 20px; display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center; }' '.welcome-panel h2 { font-size: 18px; margin-bottom: 10px; color: #fff; }' '.welcome-panel p { font-size: 12px; color: #94a3b8; margin-bottom: 15px; line-height: 1.4; }' '.qr-box { background: #fff; padding: 10px; border-radius: 8px; margin-bottom: 15px; width: 120px; height: 120px; display: flex; align-items: center; justify-content: center; }' '.qr-box img { width: 100%; height: 100%; object-fit: contain; }' '.grid-13 { display: grid; grid-template-columns: repeat(4, 1fr); gap: 12px; flex: 1; overflow-y: auto; align-content: start; }' '.card { background: #111827; border: 2px solid rgba(255,255,255,0.1); border-radius: 10px; padding: 12px; display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center; cursor: pointer; text-decoration: none; color: #fff; transition: all 0.2s; }' '.card:focus, .card:hover { border-color: #38bdf8; background: #1e293b; transform: scale(1.02); outline: none; }' '.card h3 { font-size: 13px; margin-bottom: 3px; color: #38bdf8; }' '.card p { font-size: 10px; color: #94a3b8; }' '</style>' '<script src="api.js"></script>' '</head><body>' '<header>' '<div><div class="logo">RYOKIVA</div><div class="slogan">Tu entretenimiento en tus manos</div></div>' '<div class="badge-box"><span>⭐ Caduca: 5 días</span><span>👤 Perfil: Principal</span></div>' '</header>' '<div class="main-layout">' '<div class="welcome-panel">' '<h2>Bienvenido a la TV</h2>' '<p>Escanea el QR para activar tu dispositivo o introduce tus datos en ryokiva.app</p>' '<div class="qr-box">' '<img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=https://ryokiva.app" alt="QR Activacion">' '</div>' '<span style="font-size: 11px; color: #38bdf8;">Código Único TV</span>' '</div>' '<div class="grid-13">' '<a href="perfiles.html" class="card" tabindex="1"><h3>01. Perfiles</h3><p>Gestión de cuentas</p></a>' '<a href="dashboard.html" class="card" tabindex="2"><h3>02. Dashboard</h3><p>Panel principal</p></a>' '<a href="listas.html" class="card" tabindex="3"><h3>03. Listas M3U</h3><p>Fuentes y Xtream</p></a>' '<a href="categorias.html" class="card" tabindex="4"><h3>04. Categorías</h3><p>Filtro de canales</p></a>' '<a href="reproductor.html" class="card" tabindex="5"><h3>05. Reproductor</h3><p>OSD y Controles</p></a>' '<a href="vod.html" class="card" tabindex="6"><h3>06. VOD Películas</h3><p>Catálogo de cine</p></a>' '<a href="epg.html" class="card" tabindex="7"><h3>07. Guía EPG</h3><p>Programación TV</p></a>' '<a href="buscar.html" class="card" tabindex="8"><h3>08. Buscador</h3><p>Búsqueda global</p></a>' '<a href="favoritos.html" class="card" tabindex="9"><h3>09. Favoritos</h3><p>Tus canales top</p></a>' '<a href="cuenta.html" class="card" tabindex="10"><h3>10. Mi Cuenta</h3><p>Suscripción y datos</p></a>' '<a href="ajustes.html" class="card" tabindex="11"><h3>11. Ajustes</h3><p>Configuración app</p></a>' '<a href="reproductor.html" class="card" tabindex="12"><h3>12. Live Stream</h3><p>Emisión en vivo</p></a>' '<a href="index.html" class="card" tabindex="13"><h3>13. Inicio</h3><p>Pantalla principal</p></a>' '</div>' '</div>' '<script>' 'window.onload = () => { document.querySelector(".card").focus(); };' '</script></body></html>' > index.html
pwd && ls -la
printf '%s\n' '<!DOCTYPE html>' '<html lang="es"><head>' '<meta charset="UTF-8">' '<meta name="viewport" content="width=device-width, initial-scale=1.0">' '<title>RYOKIVA - Tu entretenimiento en tus manos</title>' '<style>' '* { box-sizing: border-box; margin: 0; padding: 0; }' 'body { background: #070a13; color: #fff; font-family: sans-serif; height: 100vh; overflow: hidden; display: flex; flex-direction: column; padding: 20px 30px; }' 'header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 10px; }' '.logo { font-size: 26px; font-weight: bold; color: #f43f5e; letter-spacing: 2px; }' '.slogan { font-size: 13px; color: #94a3b8; }' '.badge-box { background: rgba(255,255,255,0.08); padding: 6px 14px; border-radius: 20px; font-size: 12px; display: flex; gap: 12px; color: #cbd5e1; border: 1px solid rgba(255,255,255,0.1); }' '.main-layout { display: flex; gap: 20px; flex: 1; align-items: stretch; }' '.welcome-panel { width: 320px; background: #111827; border: 2px solid #f43f5e; border-radius: 12px; padding: 20px; display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center; }' '.welcome-panel h2 { font-size: 18px; margin-bottom: 10px; color: #fff; }' '.welcome-panel p { font-size: 12px; color: #94a3b8; margin-bottom: 15px; line-height: 1.4; }' '.qr-box { background: #fff; padding: 10px; border-radius: 8px; margin-bottom: 15px; width: 120px; height: 120px; display: flex; align-items: center; justify-content: center; }' '.qr-box img { width: 100%; height: 100%; object-fit: contain; }' '.grid-13 { display: grid; grid-template-columns: repeat(4, 1fr); gap: 12px; flex: 1; overflow-y: auto; align-content: start; }' '.card { background: #111827; border: 2px solid rgba(255,255,255,0.1); border-radius: 10px; padding: 12px; display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center; cursor: pointer; text-decoration: none; color: #fff; transition: all 0.2s; }' '.card:focus, .card:hover { border-color: #38bdf8; background: #1e293b; transform: scale(1.02); outline: none; }' '.card h3 { font-size: 13px; margin-bottom: 3px; color: #38bdf8; }' '.card p { font-size: 10px; color: #94a3b8; }' '</style>' '</head><body>' '<header>' '<div><div class="logo">RYOKIVA</div><div class="slogan">Tu entretenimiento en tus manos</div></div>' '<div class="badge-box"><span>⭐ Caduca: 5 días</span><span>👤 Perfil: Principal</span></div>' '</header>' '<div class="main-layout">' '<div class="welcome-panel">' '<h2>Bienvenido a la TV</h2>' '<p>Escanea el QR para activar tu dispositivo o introduce tus datos en ryokiva.app</p>' '<div class="qr-box">' '<img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=https://ryokiva.app" alt="QR Activacion">' '</div>' '<span style="font-size: 11px; color: #38bdf8;">Código Único TV</span>' '</div>' '<div class="grid-13">' '<a href="perfiles.html" class="card" tabindex="1"><h3>01. Perfiles</h3><p>Gestión de cuentas</p></a>' '<a href="dashboard.html" class="card" tabindex="2"><h3>02. Dashboard</h3><p>Panel principal</p></a>' '<a href="listas.html" class="card" tabindex="3"><h3>03. Listas M3U</h3><p>Fuentes y Xtream</p></a>' '<a href="categorias.html" class="card" tabindex="4"><h3>04. Categorías</h3><p>Filtro de canales</p></a>' '<a href="reproductor.html" class="card" tabindex="5"><h3>05. Reproductor</h3><p>OSD y Controles</p></a>' '<a href="vod.html" class="card" tabindex="6"><h3>06. VOD Películas</h3><p>Catálogo de cine</p></a>' '<a href="epg.html" class="card" tabindex="7"><h3>07. Guía EPG</h3><p>Programación TV</p></a>' '<a href="buscar.html" class="card" tabindex="8"><h3>08. Buscador</h3><p>Búsqueda global</p></a>' '<a href="favoritos.html" class="card" tabindex="9"><h3>09. Favoritos</h3><p>Tus canales top</p></a>' '<a href="cuenta.html" class="card" tabindex="10"><h3>10. Mi Cuenta</h3><p>Suscripción y datos</p></a>' '<a href="ajustes.html" class="card" tabindex="11"><h3>11. Ajustes</h3><p>Configuración app</p></a>' '<a href="reproductor.html" class="card" tabindex="12"><h3>12. Live Stream</h3><p>Emisión en vivo</p></a>' '<a href="index.html" class="card" tabindex="13"><h3>13. Inicio</h3><p>Pantalla principal</p></a>' '</div>' '</div>' '<script>' 'window.onload = () => { document.querySelector(".card").focus(); };' '</script></body></html>' > index.html && cp index.html índice.html
 builtin printf "\e[?1049h"
 if [ "$_termius_si_installed" = "" ]; then  _termius_si_installed="yes";  _termius_si_executing="";  _termius_si_last_cwd="";  _termius_si_precmd() {  builtin local ret="$?";  if [ -n "$_termius_si_executing" ]; then  builtin printf "\e]133;D;%s\a" "$ret";  fi;  if [ "$_termius_si_last_cwd" != "$PWD" ]; then  _termius_si_last_cwd="$PWD";  builtin printf "\e]7;file://%s%s\a" "${HOSTNAME:-}" "$PWD";  fi;  builtin printf "\e]133;A\a";  if [[ "$PS1" != *$'\e]133;B'* ]]; then  PS1='\[\e]133;P;k=i\a\]'"$PS1"'\[\e]133;B\a\]';  fi;  _termius_si_executing="";  };  _termius_si_preexec() {  builtin printf "\e]133;C\a";  _termius_si_executing="1";  };  if [[ -n "${bash_preexec_imported:-}" ]]; then  precmd_functions+=(_termius_si_precmd);  preexec_functions+=(_termius_si_preexec);  else  _termius_si_dbg() {  if [ -z "$_termius_si_executing" ]; then  _termius_si_preexec;  fi;  };  if [[ $(builtin declare -p PROMPT_COMMAND 2>/dev/null) == "declare -a "* ]]; then  PROMPT_COMMAND+=(_termius_si_precmd);  elif [[ -n "${PROMPT_COMMAND:-}" ]]; then  PROMPT_COMMAND="_termius_si_precmd;${PROMPT_COMMAND}";  else  PROMPT_COMMAND="_termius_si_precmd";  fi;  trap '_termius_si_dbg' DEBUG;  fi;  fi
 builtin printf "\e[?1049l\e]777;ShellIntegrationReady\a"
pkill -f python3; python3 -m http.server 8080 --bind 0.0.0.0
sudo ufw allow 8080
python3 -m http.server 80 --bind 0.0.0.0
python3 -m http.server 9090 --bind 0.0.0.0
mv índice.html index.html
sudo systemctl restart nginx 2>/dev/null || sudo systemctl restart apache2 2>/dev/null || pkill -f node
pwd; ls -la index.html
cp index.html /var/www/html/index.html && sudo systemctl restart nginx 2>/dev/null || sudo systemctl restart apache2 2>/dev/null
curl -I http://localhost
cp /root/index.html /var/www/html/index.html && chmod 644 /var/www/html/index.html && sudo systemctl restart nginx
curl -I http://localhost
grep -rn "root " /etc/nginx/sites-enabled/
cat /etc/nginx/sites-enabled/default | grep -i "root"
ls -la /etc/nginx/sites-enabled/
grep -E "server_name|root" /etc/nginx/sites-enabled/*
cat /etc/nginx/sites-enabled/ryokiva-app | grep -i "root"
cat /etc/nginx/sites-enabled/ryokiva-app
cat /etc/nginx/sites-available/ryokiva-app
cat /etc/nginx/sites-available/ryokiva-app | head -n 40
cat << 'EOF' > /etc/nginx/sites-available/ryokiva-app
server {
    listen 80;
    server_name ryokiva.app www.ryokiva.app;
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    server_name ryokiva.app www.ryokiva.app;

    ssl_certificate /etc/letsencrypt/live/ryokiva.app/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/ryokiva.app/privkey.pem;

    root /var/www/html;
    index index.html index.htm;

    location / {
        try_files $uri $uri/ =404;
    }
}
EOF

sudo nginx -t && sudo systemctl restart nginx
 builtin printf "\e[?1049h"
 if [ "$_termius_si_installed" = "" ]; then  _termius_si_installed="yes";  _termius_si_executing="";  _termius_si_last_cwd="";  _termius_si_precmd() {  builtin local ret="$?";  if [ -n "$_termius_si_executing" ]; then  builtin printf "\e]133;D;%s\a" "$ret";  fi;  if [ "$_termius_si_last_cwd" != "$PWD" ]; then  _termius_si_last_cwd="$PWD";  builtin printf "\e]7;file://%s%s\a" "${HOSTNAME:-}" "$PWD";  fi;  builtin printf "\e]133;A\a";  if [[ "$PS1" != *$'\e]133;B'* ]]; then  PS1='\[\e]133;P;k=i\a\]'"$PS1"'\[\e]133;B\a\]';  fi;  _termius_si_executing="";  };  _termius_si_preexec() {  builtin printf "\e]133;C\a";  _termius_si_executing="1";  };  if [[ -n "${bash_preexec_imported:-}" ]]; then  precmd_functions+=(_termius_si_precmd);  preexec_functions+=(_termius_si_preexec);  else  _termius_si_dbg() {  if [ -z "$_termius_si_executing" ]; then  _termius_si_preexec;  fi;  };  if [[ $(builtin declare -p PROMPT_COMMAND 2>/dev/null) == "declare -a "* ]]; then  PROMPT_COMMAND+=(_termius_si_precmd);  elif [[ -n "${PROMPT_COMMAND:-}" ]]; then  PROMPT_COMMAND="_termius_si_precmd;${PROMPT_COMMAND}";  else  PROMPT_COMMAND="_termius_si_precmd";  fi;  trap '_termius_si_dbg' DEBUG;  fi;  fi
 builtin printf "\e[?1049l\e]777;ShellIntegrationReady\a"
curl -I https://ryokiva.app
 builtin printf "\e[?1049h"
 if [ "$_termius_si_installed" = "" ]; then  _termius_si_installed="yes";  _termius_si_executing="";  _termius_si_last_cwd="";  _termius_si_precmd() {  builtin local ret="$?";  if [ -n "$_termius_si_executing" ]; then  builtin printf "\e]133;D;%s\a" "$ret";  fi;  if [ "$_termius_si_last_cwd" != "$PWD" ]; then  _termius_si_last_cwd="$PWD";  builtin printf "\e]7;file://%s%s\a" "${HOSTNAME:-}" "$PWD";  fi;  builtin printf "\e]133;A\a";  if [[ "$PS1" != *$'\e]133;B'* ]]; then  PS1='\[\e]133;P;k=i\a\]'"$PS1"'\[\e]133;B\a\]';  fi;  _termius_si_executing="";  };  _termius_si_preexec() {  builtin printf "\e]133;C\a";  _termius_si_executing="1";  };  if [[ -n "${bash_preexec_imported:-}" ]]; then  precmd_functions+=(_termius_si_precmd);  preexec_functions+=(_termius_si_preexec);  else  _termius_si_dbg() {  if [ -z "$_termius_si_executing" ]; then  _termius_si_preexec;  fi;  };  if [[ $(builtin declare -p PROMPT_COMMAND 2>/dev/null) == "declare -a "* ]]; then  PROMPT_COMMAND+=(_termius_si_precmd);  elif [[ -n "${PROMPT_COMMAND:-}" ]]; then  PROMPT_COMMAND="_termius_si_precmd;${PROMPT_COMMAND}";  else  PROMPT_COMMAND="_termius_si_precmd";  fi;  trap '_termius_si_dbg' DEBUG;  fi;  fi
 builtin printf "\e[?1049l\e]777;ShellIntegrationReady\a"
cd ryokiva
ls -la
cat << 'EOF' > index.html
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RYOKIVA</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
        }

        body {
            background-color: #0d1527;
            color: #ffffff;
            display: flex;
            justify-content: center;
            padding: 20px 15px;
            min-height: 100vh;
        }

        .container {
            width: 100%;
            max-width: 480px;
            display: flex;
            flex-direction: column;
            gap: 20px;
            text-align: center;
        }

        /* 1. Cabecera */
        .header {
            margin-top: 10px;
            margin-bottom: 5px;
        }

        .title {
            font-size: 2.2rem;
            font-weight: 900;
            color: #0091ff;
            letter-spacing: -0.5px;
            margin-bottom: 5px;
        }

        .slogan {
            font-size: 1.05rem;
            font-weight: 600;
            color: #e0e6ed;
            margin-bottom: 10px;
            font-style: italic;
        }

        .subtitle {
            font-size: 0.95rem;
            color: #94a3b8;
            line-height: 1.4;
            padding: 0 10px;
        }

        /* 2. Botoneras con desplegables */
        .actions {
            display: flex;
            flex-direction: column;
            gap: 12px;
            margin: 10px 0;
        }

        .dropdown {
            width: 100%;
        }

        .btn {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 16px;
            border-radius: 12px;
            font-size: 1.05rem;
            font-weight: 700;
            color: #ffffff;
            border: none;
            cursor: pointer;
            transition: background-color 0.2s ease, transform 0.1s ease;
        }

        .btn:active {
            transform: scale(0.98);
        }

        .btn-particular {
            background-color: #0084d6;
        }

        .btn-guide {
            background-color: #273549;
            color: #cbd5e1;
        }

        .btn-business {
            background-color: #16a34a;
        }

        /* Contenido del desplegable */
        .dropdown-content {
            display: none;
            background-color: #162235;
            border: 1px solid #1e2d42;
            border-radius: 12px;
            margin-top: 8px;
            padding: 18px;
            text-align: left;
            font-size: 0.95rem;
            color: #cbd5e1;
            line-height: 1.5;
        }

        .dropdown-content.show {
            display: block;
        }

        /* Estilos de Formularios e Inputs */
        .form-group {
            margin-bottom: 12px;
        }

        .form-group label {
            display: block;
            font-size: 0.85rem;
            font-weight: 600;
            color: #94a3b8;
            margin-bottom: 5px;
        }

        .form-control {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #273549;
            background-color: #0d1527;
            color: #ffffff;
            font-size: 0.95rem;
        }

        .form-control:focus {
            outline: none;
            border-color: #0084d6;
        }

        .btn-submit {
            width: 100%;
            padding: 12px;
            background-color: #0084d6;
            border: none;
            border-radius: 8px;
            color: white;
            font-weight: 700;
            cursor: pointer;
            margin-top: 5px;
        }

        .mini-panel-info {
            background-color: #0d1527;
            padding: 12px;
            border-radius: 8px;
            margin-top: 15px;
            border-left: 3px solid #0084d6;
            font-size: 0.85rem;
        }

        /* 3. Tarjetas Informativas */
        .features {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-top: 10px;
        }

        .card {
            background-color: #162235;
            border: 1px solid #1e2d42;
            border-radius: 14px;
            padding: 20px;
            text-align: left;
        }

        .card-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 8px;
        }

        .card-icon {
            font-size: 1.4rem;
        }

        .card-title {
            font-size: 1.25rem;
            font-weight: 800;
            color: #ffffff;
        }

        .card-desc {
            font-size: 0.9rem;
            color: #94a3b8;
            line-height: 1.4;
        }
    </style>
</head>
<body>

    <div class="container">
        <!-- 1. CABECERA -->
        <div class="header">
            <h1 class="title">RYOKIVA</h1>
            <p class="slogan">La plataforma que lo tiene todo en tus manos</p>
            <p class="subtitle">Plataforma multimedia para Android TV, Fire TV, tablets y dispositivos móviles.</p>
        </div>

        <!-- 2. BOTONERAS (DESPLEGABLES) -->
        <div class="actions">
            <!-- Botonera 1: Registrarse / Particular -->
            <div class="dropdown">
                <button class="btn btn-particular" onclick="toggleDropdown('dropdown-particular')">
                    <span>Registrarse / Particular</span>
                    <span>▼</span>
                </button>
                <div id="dropdown-particular" class="dropdown-content">
                    <form onsubmit="return false;">
                        <div class="form-group">
                            <label for="usuario">Usuario:</label>
                            <input type="text" id="usuario" class="form-control" placeholder="Introduce tu usuario">
                        </div>
                        <div class="form-group">
                            <label for="password">Contraseña:</label>
                            <input type="password" id="password" class="form-control" placeholder="Introduce tu contraseña">
                        </div>
                        <button class="btn-submit">Entrar al Mini Panel</button>
                    </form>

                    <div class="mini-panel-info">
                        <strong>Mini Panel Particulares:</strong>
                        <ul style="margin-left: 18px; margin-top: 5px;">
                            <li>Acceso a 10 perfiles protegidos por PIN.</li>
                            <li>Gestión de 3 listas M3U y 3 Xtream Codes.</li>
                            <li>Sistema de respaldo automático (Failover).</li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Botonera 2: Guía de Instalación -->
            <div class="dropdown">
                <button class="btn btn-guide" onclick="toggleDropdown('dropdown-guide')">
                    <span>Guía de Instalación</span>
                    <span>▼</span>
                </button>
                <div id="dropdown-guide" class="dropdown-content">
                    <p>Guía paso a paso para configurar tu dispositivo (Android TV, Fire TV, Tablet o Móvil).</p>
                </div>
            </div>

            <!-- Botonera 3: Panel Business / Revendedores -->
            <div class="dropdown">
                <button class="btn btn-business" onclick="toggleDropdown('dropdown-business')">
                    <span>Panel Business / Revendedores</span>
                    <span>▼</span>
                </button>
                <div id="dropdown-business" class="dropdown-content">
                    <p>Acceso exclusivo al panel de administración y gestión para revendedores.</p>
                </div>
            </div>
        </div>

        <!-- 3. PARTE INFORMATIVA -->
        <div class="features">
            <div class="card">
                <div class="card-header">
                    <span class="card-icon">📺</span>
                    <h2 class="card-title">10 Dispositivos</h2>
                </div>
                <p class="card-desc">Conecta y gestiona hasta 10 televisores, tablets o móviles.</p>
            </div>

            <div class="card">
                <div class="card-header">
                    <span class="card-icon">👤</span>
                    <h2 class="card-title">10 Perfiles</h2>
                </div>
                <p class="card-desc">Perfiles aislados con avatares, PIN e historial propio.</p>
            </div>

            <div class="card">
                <div class="card-header">
                    <span class="card-icon">🛡️</span>
                    <h2 class="card-title">VPN Integrada</h2>
                </div>
                <p class="card-desc">Conexión segura y optimizada.</p>
            </div>
        </div>
    </div>

    <script>
        function toggleDropdown(id) {
            const content = document.getElementById(id);
            const isVisible = content.classList.contains('show');
            
            document.querySelectorAll('.dropdown-content').forEach(el => el.classList.remove('show'));
            
            if (!isVisible) {
                content.classList.add('show');
            }
        }
    </script>
</body>
</html>
EOF

rm -f index.html
echo "PCFET0NUWVBFIGh0bWw+CjxodG1sIGxhbmc9ImVzIj4KPGhlYWQ+CiAgICA8bWV0YSBjaGFyc2V0PSJVRkYtOCI+CiAgICA8bWV0YSBuYW1lPSJ2aWV3cG9ydCIgY29udGVudD0id2lkdGg9ZGV2aWNlLXdpZHRoLCBpbml0aWFsLXNjYWxlPTEuMCI+CiAgICA8dGl0bGU+UllPS0lWQTwvdGl0bGU+CiAgICA8c3R5bGU+CiAgICAgICAgKiB7CiAgICAgICAgICAgIGJveC1zaXppbmc6IGJvcmRlci1ib3g7CiAgICAgICAgICAgIG1hcmdpbjogMDsKICAgICAgICAgICAgcGFkZGluZzogMDsKICAgICAgICAgICAgZm9udC1mYW1pbHk6IC1hcHBsZS1zeXN0ZW0sIEJsaW5rTWFjU3lzdGVtRm9udCwgIlNlZ29lIFVJIiwgUm9ib3RvLCBIZWx2ZXRpY2EsIEFyaWFsLCBzYW5zLXNlcmlmOwogICAgICAgIH0KCiAgICAgICAgYm9keSB7CiAgICAgICAgICAgIGJhY2tncm91bmQtY29sb3I6ICMwZDE1Mjc7CiAgICAgICAgICAgIGNvbG9yOiAjZmZmZmZmOwogICAgICAgICAgICBkaXNwbGF5OiBmbGV4OwogICAgICAgICAgICBqdXN0aWZ5LWNvbnRlbnQ6IGNlbnRlcjsKICAgICAgICAgICAgcGFkZGluZzogMjBweCAxNXB4OwogICAgICAgICAgICBtaW4taGVpZ2h0OiAxMDB2aDsKICAgICAgICB9CgogICAgICAgIC5jb250YWluZXIgewogICAgICAgICAgICB3aWR0aDogMTAwJTsKICAgICAgICAgICAgbWF4LXdpZHRoOiA0ODBweDsKICAgICAgICAgICAgZGlzcGxheTogZmxleDsKICAgICAgICAgICAgZmxleC1kaXJlY3Rpb246IGNvbHVtbjsKICAgICAgICAgICAgZ2FwOiAyMHB4OwogICAgICAgICAgICB0ZXh0LWFsaWduOiBjZW50ZXI7CiAgICAgICAgfQoKICAgICAgICAvKiAxLiBDYWJlY2VyYSAqLwogICAgICAgIC5oZWFkZXIgewogICAgICAgICAgICBtYXJnaW4tdG9wOiAxMHB4OwogICAgICAgICAgICBtYXJnaW4tYm90dG9tOiA1cHg7CiAgICAgICAgfQoKICAgICAgICAudGl0bGUgewogICAgICAgICAgICBmb250LXNpemU6IDIuMnJlbTsKICAgICAgICAgICAgZm9udC13ZWlnaHQ6IDkwMDsKICAgICAgICAgICAgY29sb3I6ICMwMDkxZmY7CiAgICAgICAgICAgIGxldHRlci1zcGFjaW5nOiAtMC41cHg7CiAgICAgICAgICAgIG1hcmdpbi1ib3R0b206IDVweDsKICAgICAgICB9CgogICAgICAgIC5zbG9nYW4gewogICAgICAgICAgICBmb250LXNpemU6IDEuMDVyZW07CiAgICAgICAgICAgIGZvbnQtd2VpZ2h0OiA2MDA7CiAgICAgICAgICAgIGNvbG9yOiAjZTBlNmVkOwogICAgICAgICAgICBtYXJnaW4tYm90dG9tOiAxMHB4OwogICAgICAgICAgICBmb250LXN0eWxlOiBpdGFsaWM7CiAgICAgICAgfQoKICAgICAgICAuc3VidGl0bGUgewogICAgICAgICAgICBmb250LXNpemU6IDAuOTVyZW07CiAgICAgICAgICAgIGNvbG9yOiAjOTRhM2I4OwogICAgICAgICAgICBsaW5lLWhlaWdodDogMS40OwogICAgICAgICAgICBwYWRkaW5nOiAwIDEwcHg7CiAgICAgICAgfQoKICAgICAgICAvKiAyLiBCb3RvbmVyYXMgY29uIGRlc3BsZWdhYmxlcyAqLwogICAgICAgIC5hY3Rpb25zIHsKICAgICAgICAgICAgZGlzcGxheTogZmxleDsKICAgICAgICAgICAgZmxleC1kaXJlY3Rpb246IGNvbHVtbjsKICAgICAgICAgICAgZ2FwOiAxMnB4OwogICAgICAgICAgICBtYXJnaW46IDEwcHggMDsKICAgICAgICB9CgogICAgICAgIC5kcm9wZG93biB7CiAgICAgICAgICAgIHdpZHRoOiAxMDAlOwogICAgICAgIH0KCiAgICAgICAgLmJ0biB7CiAgICAgICAgICAgIHdpZHRoOiAxMDAlOwogICAgICAgICAgICBkaXNwbGF5OiBmbGV4OwogICAgICAgICAgICBhbGlnbi1pdGVtczogY2VudGVyOwogICAgICAgICAgICBqdXN0aWZ5LWNvbnRlbnQ6IHNwYWNlLWJldHdlZW47CiAgICAgICAgICAgIHBhZGRpbmc6IDE2cHg7CiAgICAgICAgICAgIGJvcmRlci1yYWRpdXM6IDEycHg7CiAgICAgICAgICAgIGZvbnQtc2l6ZTogMS4wNXJlbTsKICAgICAgICAgICAgZm9udC13ZWlnaHQ6IDcwMDsKICAgICAgICAgICAgY29sb3I6ICNmZmZmZmY7CiAgICAgICAgICAgIGJvcmRlcjogbm9uZTsKICAgICAgICAgICAgY3Vyc29yOiBwb2ludGVyOwogICAgICAgICAgICB0cmFuc2l0aW9uOiBiYWNrZ3JvdW5kLWNvbG9yIDAuMnMgZWFzZSwgdHJhbnNmb3JtIDAuMXMgZWFzZTsKICAgICAgICB9CgogICAgICAgIC5idG46YWN0aXZlIHsKICAgICAgICAgICAgdHJhbnNmb3JtOiBzY2FsZSgwLjk4KTsKICAgICAgICB9CgogICAgICAgIC5idG4tcGFydGljdWxhciB7CiAgICAgICAgICAgIGJhY2tncm91bmQtY29sb3I6ICMwMDg0ZDY7CiAgICAgICAgfQoKICAgICAgICAuYnRuLWd1aWRlIHsKICAgICAgICAgICAgYmFja2dyb3VuZC1jb2xvcjogIzI3MzU0OTsKICAgICAgICAgICAgY2

git add index.html

git commit -m "Actualizar portada con desplegables y mini panel"

git push origin main


git status
git add index.html
git commit -m "Actualizar portada con desplegables"
git push origin main
 builtin printf "\e[?1049h"
 if [ "$_termius_si_installed" = "" ]; then  _termius_si_installed="yes";  _termius_si_executing="";  _termius_si_last_cwd="";  _termius_si_precmd() {  builtin local ret="$?";  if [ -n "$_termius_si_executing" ]; then  builtin printf "\e]133;D;%s\a" "$ret";  fi;  if [ "$_termius_si_last_cwd" != "$PWD" ]; then  _termius_si_last_cwd="$PWD";  builtin printf "\e]7;file://%s%s\a" "${HOSTNAME:-}" "$PWD";  fi;  builtin printf "\e]133;A\a";  if [[ "$PS1" != *$'\e]133;B'* ]]; then  PS1='\[\e]133;P;k=i\a\]'"$PS1"'\[\e]133;B\a\]';  fi;  _termius_si_executing="";  };  _termius_si_preexec() {  builtin printf "\e]133;C\a";  _termius_si_executing="1";  };  if [[ -n "${bash_preexec_imported:-}" ]]; then  precmd_functions+=(_termius_si_precmd);  preexec_functions+=(_termius_si_preexec);  else  _termius_si_dbg() {  if [ -z "$_termius_si_executing" ]; then  _termius_si_preexec;  fi;  };  if [[ $(builtin declare -p PROMPT_COMMAND 2>/dev/null) == "declare -a "* ]]; then  PROMPT_COMMAND+=(_termius_si_precmd);  elif [[ -n "${PROMPT_COMMAND:-}" ]]; then  PROMPT_COMMAND="_termius_si_precmd;${PROMPT_COMMAND}";  else  PROMPT_COMMAND="_termius_si_precmd";  fi;  trap '_termius_si_dbg' DEBUG;  fi;  fi
 builtin printf "\e[?1049l\e]777;ShellIntegrationReady\a"
git remote set-url origin git@github.com:soportevortexplay-spec/RYOKIVA-download.git && git add index.html && git commit -m "Actualizar portada" && git push -u origin main
cd ~/RYOKIVA-download 2>/dev/null || cd RYOKIVA-download 2>/dev/null || true
echo "PCFET0NUWVBFIGh0bWw+CjxodG1sIGxhbmc9ImVzIj4KPGhlYWQ+CiAgPG1ldGEgY2hhcnNldD0iVVRGLTgiPgogIDxtZXRhIG5hbWU9InZpZXdwb3J0IiBjb250ZW50PSJ3aWR0aD1kZXZpY2Utd2lkdGgsIGluaXRpYWwtc2NhbGU9MS4wIj4KICA8dGl0bGU+UllPS0lWQTwvdGl0bGU+CiAgPHNjcmlwdCBzcmM9Imh0dHBzOi8vY2RuLnRhaWx3aW5kY3NzLmNvbSI+PC9zY3JpcHQ+CjwvaGVhZD4KPGJvZHkgY2xhc3M9ImJnLWdyYXktOTAwIHRleHQtd2hpdGUgZm9udC1zYW5zIj4KICA8ZGl2IGNsYXNzPSJjb250YWluZXJtLXhvIG14LWF1dG8gcC02IHRleHQtY2VudGVyIj4KICAgIDxoMSBjbGFzcz0idGV4dC00eGwgd2VpZ2h0LWJvbGQgbWItNCI+UllPS0lWQTwvaDE+CiAgICA8cCBjbGFzcz0idGV4dC14bCBtYi04Ij4gUGxhdGFmb3JtYSBkZSBEZXNjYXJnYXMgeSBTZXJ2aWNpb3M8L3A+CiAgPC9kaXY+CjwvYm9keT4KPC9odG1sPgo=" | base64 -d > index.html
git add index.html
git commit -m "Actualizar portada RYOKIVA"
git push origin main
git remote set-url origin https://github.com/soportevortexplay-spec/RYOKIVA-download.git && git push origin main
ssh-keygen -t ed25519 -C "vps" -f ~/.ssh/id_ed25519 -N "" 2>/dev/null || true
clear
echo "=== COPIA LA SIGUIENTE CLAVE ==="
cat ~/.ssh/id_ed25519.pub
echo "==============================="
curl -s -u "soportevortexplay-spec" https://api.github.com/user/keys -d '{"title":"vps-key","key":"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAAIHdXGvMpnHN1k2JL7fIoiDzgGYZpIGsgPKkqwj8e26 vps"}'
cd ~/RYOKIVA-download 2>/dev/null || cd RYOKIVA-download 2>/dev/null || true
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519 2>/dev/null || true
git remote set-url origin git@github.com:soportevortexplay-spec/RYOKIVA-download.git
git push -u origin main
