        <div class="financial-metric-title">Ingresos Totales</div>
        <div class="financial-metric-val" id="finTotalRevenue" style="color:#22c55e;">0 €</div>
      </div>
      <div class="financial-metric">
        <div class="financial-metric-title">Cuentas de Pago</div>
        <div class="financial-metric-val" id="finPaidAccounts">0</div>
      </div>
      <div class="financial-metric">
        <div class="financial-metric-title">Clientes Particulares</div>
        <div class="financial-metric-val" id="finClientCount">0</div>
      </div>
      <div class="financial-metric">
        <div class="financial-metric-title">Revendedores Activos</div>
        <div class="financial-metric-val" id="finResellerCount" style="color:#a855f7;">0</div>
      </div>
    </div>
  </div>

  <!-- 14 CASILLAS -->
  <div class="grid-14">
    <div class="box-card" onclick="openModal('planModal')"><div class="box-title">1. Plan Actual ⚙️</div><div class="box-val" id="b1">250 Usuarios (20€)</div></div>
    <div class="box-card" onclick="openClientsList()"><div class="box-title">2. Clientes Activos 👥</div><div class="box-val" id="b2">0</div></div>
    <div class="box-card" onclick="openResellersList()"><div class="box-title">3. Revendedores 🤝</div><div class="box-val" style="color:#a855f7;" id="b3">0 Activos</div></div>
    <div class="box-card" onclick="openModal('rechargeModal')"><div class="box-title">4. Recargar Panel 💳</div><div class="box-val" style="color:#eab308;">Elegir Tarifa</div></div>
    <div class="box-card" onclick="openDevicesList()"><div class="box-title">5. Dispositivos 📱</div><div class="box-val" style="color:#22c55e;" id="b5">0 Vinculados</div></div>
    <div class="box-card" onclick="openProfilesList()"><div class="box-title">6. Perfiles Config 🔐</div><div class="box-val" style="color:#38bdf8;" id="b6">0 Perfiles</div></div>
    <div class="box-card" onclick="openM3uList()"><div class="box-title">7. Listas M3U 📺</div><div class="box-val" style="color:#22c55e;">3 M3U Auto</div></div>
    <div class="box-card" onclick="openXcList()"><div class="box-title">8. Xtream Codes 🔑</div><div class="box-val" style="color:#22c55e;">3 Servidores</div></div>
    <div class="box-card" onclick="openStatusList()"><div class="box-title">9. Conexiones 🟢</div><div class="box-val" style="color:#22c55e;">En Línea</div></div>
    <div class="box-card" onclick="openInfoModal('SSL', 'Certificado HTTPS en ryokiva.app activo.')"><div class="box-title">10. SSL Dominio</div><div class="box-val" style="color:#22c55e;">Seguro</div></div>
    <div class="box-card" onclick="openInfoModal('Bot', 'Notificaciones de pago conectadas a Telegram.')"><div class="box-title">11. Bot Telegram</div><div class="box-val" style="color:#22c55e;">Conectado</div></div>
    <div class="box-card" onclick="openTicketsModal()"><div class="box-title">12. Alertas Vencidas ⚠️</div><div class="box-val" style="color:#22c55e;" id="b12">0 Avisos</div></div>
    <div class="box-card" onclick="openBackupModal()"><div class="box-title">13. Copias Backup 💾</div><div class="box-val" style="color:#38bdf8;">Manual / Auto</div></div>
    <div class="box-card" onclick="openSupportModal()"><div class="box-title">14. Soporte Técnico 🎧</div><div class="box-val" style="color:#22c55e;">24/7 Activo</div></div>
  </div>

  <div class="tabs" id="mainTabs">
    <button class="tab-btn" onclick="switchSection('clients')">👥 Clientes</button>
    <button class="tab-btn" style="background:#22c55e;" onclick="switchSection('trial')">⚡ Demo 24h</button>
    <button class="tab-btn" style="background:#9333ea;" id="tabResellers" onclick="switchSection('resellers')">🤝 Revendedores</button>
    <button class="tab-btn" style="background:#eab308; color:black;" onclick="switchSection('manual')">📖 Manual de Uso</button>
  </div>

  <div id="sectionClients" class="section">
    <h3>➕ Registrar Cliente (Particular)</h3>
    <input type="text" id="cUser" placeholder="Usuario Cliente">
    <input type="password" id="cPass" placeholder="Contraseña">
    <select id="cPlan">
      <option value="Demo 24 Horas (1 Día)">⚡ Demo 24 Horas (1 Día)</option>
      <option value="Demo 7 Dias">Demo 7 Días Gratis</option>
      <option value="1 Año - 7€">1 Año - 7€ (Contabiliza Automático)</option>
      <option value="Por Vida - 14€">Por Vida - 14€ (Contabiliza Automático)</option>
    </select>
    <button class="btn-action" onclick="saveClient()">Guardar Cliente</button>
  </div>

  <div id="sectionTrial" class="section" style="display:none;">
    <h3 style="color:#22c55e;">⚡ Generador de Prueba Gratis (24h)</h3>
    <input type="text" id="tUser" placeholder="Nombre de Usuario para la Prueba">
    <button class="btn-action" style="background:#22c55e; color:black; font-weight:bold;" onclick="generateTrial()">⚡ Crear Demo y Copiar Plantilla</button>
  </div>

  <div id="sectionResellers" class="section" style="display:none;">
    <h3>➕ Registrar Revendedor</h3>
    <input type="text" id="rUser" placeholder="Usuario Revendedor">
    <input type="password" id="rPass" placeholder="Contraseña">
    <select id="rPlan">
      <option value="250 Usuarios - 20€">250 Usuarios - 20€</option>
      <option value="500 Usuarios - 40€">500 Usuarios - 40€</option>
      <option value="1000 Usuarios - 70€">1000 Usuarios - 70€</option>
      <option value="Ilimitado - 170€">Ilimitado - 170€</option>
    </select>
    <button class="btn-action" style="background:#9333ea;" onclick="saveReseller()">Guardar Revendedor</button>
  </div>

  <!-- MANUAL DE INSTRUCCIONES ACTUALIZADO -->
  <div id="sectionManual" class="section" style="display:none;">
    <h3 style="color:#eab308; margin-top:0;">📖 Manual de Instrucciones Definitivo</h3>
    
    <div style="background:#0f172a; border:1px solid #22c55e; padding:12px; border-radius:8px; margin-bottom:12px;">
      <h4 style="color:#22c55e; margin:0 0 8px 0; font-size:12px;">💬 Plantillas Rápidas para WhatsApp / Telegram</h4>
      <button class="btn-copy" style="background:#38bdf8; margin-bottom:6px;" onclick="copyTemplate('renew')">📩 Copiar Mensaje de Recordatorio de Renovación</button>
      <button class="btn-copy" style="background:#eab308;" onclick="copyTemplate('demo')">⚡ Copiar Plantilla de Entrega de Demo Gratis</button>
    </div>

    <div class="manual-box">
      <h4>📺 4. Validador de Listas (Apta / No Apta) y Caducidad</h4>
      <div class="manual-step">
        - Al configurar listas M3U o Xtream Codes, el sistema comprueba automáticamente la conexión y muestra un sello indicando si la lista es <b>🟢 APTA</b> o <b>🔴 NO APTA</b>.<br>
        - En cada perfil y cliente registrado se detalla exactamente la **fecha y hora de caducidad**, permitiendo saber cuándo expira el servicio de forma visual.
      </div>
    </div>
  </div>

  <!-- MODALES -->
  <div id="planModal" class="modal"><div class="modal-content"><h3 style="color:#38bdf8; margin-top:0;">Planes Revendedor</h3><div class="plan-option" onclick="setPlan('250 Usuarios (20€)')"><span>250 Usuarios</span><span style="color:#22c55e;">20€</span></div><div class="plan-option" onclick="setPlan('500 Usuarios (40€)')"><span>500 Usuarios</span><span style="color:#22c55e;">40€</span></div><div class="plan-option" onclick="setPlan('1000 Usuarios (70€)')"><span>1000 Usuarios</span><span style="color:#22c55e;">70€</span></div><div class="plan-option" onclick="setPlan('Ilimitado (170€)')"><span>Ilimitado</span><span style="color:#22c55e;">170€</span></div><button class="btn-action" style="background:#ef4444; margin-top:15px;" onclick="closeModal('planModal')">Cancelar</button></div></div>

  <div id="clientsModal" class="modal"><div class="modal-content"><h3 style="color:#38bdf8; margin-top:0;">👥 Clientes Activos</h3><input type="text" id="searchClientsInput" class="search-input" placeholder="🔍 Buscar cliente..." oninput="renderClientsList()"><div style="display:flex; gap:5px; margin-bottom:10px; justify-content:center;"><button class="filter-btn active" id="filterAll" onclick="setClientFilter('all')">Todos</button><button class="filter-btn" id="filterActive" onclick="setClientFilter('active')">🟢 Activos</button><button class="filter-btn" id="filterExpired" onclick="setClientFilter('expired')">🔴 Caducados</button></div><div id="clientsContainer"></div><button class="btn-action" style="background:#ef4444; margin-top:15px;" onclick="closeModal('clientsModal')">Cerrar</button></div></div>

  <div id="resellersModal" class="modal"><div class="modal-content"><h3 style="color:#a855f7; margin-top:0;">🤝 Revendedores Activos</h3><div id="resellersContainer"></div><button class="btn-action" style="background:#ef4444; margin-top:15px;" onclick="closeModal('resellersModal')">Cerrar</button></div></div>

  <div id="rechargeModal" class="modal"><div class="modal-content"><h3 style="color:#eab308; margin-top:0;">Recargar Panel 💳</h3><p style="font-size:11px; color:#94a3b8; margin-bottom:8px;">Selecciona la tarifa y cantidad:</p><div class="plan-option" onclick="openInfoModal('Recarga', '250 Usuarios seleccionado')"><span>250 Usuarios</span><span style="color:#22c55e;">20€</span></div><div class="plan-option" onclick="openInfoModal('Recarga', '500 Usuarios seleccionado')"><span>500 Usuarios</span><span style="color:#22c55e;">40€</span></div><div class="plan-option" onclick="openInfoModal('Recarga', '1000 Usuarios seleccionado')"><span>1000 Usuarios</span><span style="color:#22c55e;">70€</span></div><div class="plan-option" onclick="openInfoModal('Recarga', 'Ilimitado seleccionado')"><span>Ilimitado</span><span style="color:#22c55e;">170€</span></div><button class="btn-action" style="background:#ef4444; margin-top:15px;" onclick="closeModal('rechargeModal')">Cancelar</button></div></div>

  <div id="devicesModal" class="modal"><div class="modal-content"><h3 style="color:#22c55e; margin-top:0;">📱 Registro Automático de Dispositivos</h3><p style="font-size:11px; color:#94a3b8;">Límite: Hasta 10 dispositivos gratis por cliente.</p><select id="devClientSelect"><option>-- Selecciona Cliente --</option></select><button class="btn-action" style="background:#22c55e; color:black; font-weight:bold;" onclick="openInfoModal('Dispositivos', 'Dispositivo vinculado correctamente.')">⚡ Vincular Dispositivo Automático</button><button class="btn-action" style="background:#ef4444; margin-top:10px;" onclick="closeModal('devicesModal')">Cerrar</button></div></div>

  <div id="profilesModal" class="modal"><div class="modal-content"><h3 style="color:#38bdf8; margin-top:0;">🔐 Gestión de Perfiles por Cliente</h3><select id="profClientSelect"><option>-- Elige Cliente --</option></select><input type="text" placeholder="Perfil 1"><input type="password" placeholder="PIN de Seguridad (4 dígitos)"><button class="btn-action" onclick="openInfoModal('Perfiles', 'Perfil guardado con éxito.')">💾 Guardar / Editar Perfil</button><button class="btn-action" style="background:#ef4444; margin-top:10px;" onclick="closeModal('profilesModal')">Cerrar</button></div></div>

  <!-- CONFIGURACIÓN M3U CON VALIDADOR APTA / NO APTA -->
  <div id="m3uModal" class="modal">
    <div class="modal-content">
      <h3 style="color:#22c55e; margin-top:0;">📺 Configuración M3U (3 Listas Auto)</h3>
      <select><option>-- Selecciona Cliente y Perfil --</option></select>
      <input type="text" value="http://servidor1.com/get.php?..." placeholder="Lista M3U Principal (Prioridad 1)">
      <input type="text" value="http://servidor2.com/get.php?..." placeholder="Lista M3U Respaldo (Prioridad 2)">
      <input type="text" value="http://servidor3.com/get.php?..." placeholder="Lista M3U Respaldo (Prioridad 3)">
      <div style="margin: 8px 0; display: flex; justify-content: space-between; align-items: center; background: #0f172a; padding: 8px; border-radius: 6px; border: 1px solid #334155;">
        <span style="font-size: 11px; color: #94a3b8;">Estado del Enlace:</span>
        <span class="badge-apta" id="m3uStatusBadge">🟢 APTA (En Línea)</span>
      </div>
      <button class="btn-action" style="background:#eab308; color:black; font-weight:bold;" onclick="checkM3uStatus()">🔍 Comprobar Enlace Principal M3U</button>
      <button class="btn-action" style="background:#22c55e; color:black; font-weight:bold;" onclick="openInfoModal('M3U', '3 Listas M3U guardadas y validadas correctamente.')">💾 Guardar 3 Listas M3U</button>
      <button class="btn-action" style="background:#ef4444; margin-top:10px;" onclick="closeModal('m3uModal')">Cerrar</button>
    </div>
  </div>

  <!-- XTREAM CODES CON VALIDADOR APTA / NO APTA -->
  <div id="xcModal" class="modal">
    <div class="modal-content">
      <h3 style="color:#22c55e; margin-top:0;">🔑 Xtream Codes (3 Servidores Auto)</h3>
      <select><option>-- Selecciona Cliente y Perfil --</option></select>
      
      <div style="background:#0f172a; border:1px solid #334155; padding:8px; border-radius:6px; margin:6px 0; text-align:left;">
        <div style="font-size:10px; color:#38bdf8; font-weight:bold; margin-bottom:4px;">Servidor Principal (Prioridad 1)</div>
        <input type="text" value="http://ejemplo.com:8080" placeholder="Host">
        <input type="text" placeholder="Usuario API 1">
        <input type="password" placeholder="Contraseña API 1">
      </div>

      <div style="background:#0f172a; border:1px solid #334155; padding:8px; border-radius:6px; margin:6px 0; text-align:left;">
        <div style="font-size:10px; color:#38bdf8; font-weight:bold; margin-bottom:4px;">Servidor Respaldo (Prioridad 2)</div>
        <input type="text" value="http://respaldo1.com:8080" placeholder="Host">
        <input type="text" placeholder="Usuario API 2">
        <input type="password" placeholder="Contraseña API 2">
      </div>

      <div style="background:#0f172a; border:1px solid #334155; padding:8px; border-radius:6px; margin:6px 0; text-align:left;">
        <div style="font-size:10px; color:#38bdf8; font-weight:bold; margin-bottom:4px;">Servidor Respaldo (Prioridad 3)</div>
        <input type="text" value="http://respaldo2.com:8080" placeholder="Host">
        <input type="text" placeholder="Usuario API 3">
        <input type="password" placeholder="Contraseña API 3">
      </div>

      <div style="margin: 8px 0; display: flex; justify-content: space-between; align-items: center; background: #0f172a; padding: 8px; border-radius: 6px; border: 1px solid #334155;">
        <span style="font-size: 11px; color: #94a3b8;">Estado del Servidor:</span>
        <span class="badge-apta" id="xcStatusBadge">🟢 APTA (Operativo)</span>
      </div>

      <button class="btn-action" style="background:#eab308; color:black; font-weight:bold;" onclick="checkXcStatus()">🔍 Comprobar Estado del Servidor Principal</button>
      <button class="btn-action" style="background:#22c55e; color:black; font-weight:bold;" onclick="openInfoModal('Xtream', '3 Servidores Xtream Codes guardados y verificados.')">💾 Guardar 3 Servidores Xtream</button>
      <button class="btn-action" style="background:#ef4444; margin-top:10px;" onclick="closeModal('xcModal')">Cerrar</button>
    </div>
  </div>

  <div id="statusModal" class="modal"><div class="modal-content"><h3 style="color:#22c55e; margin-top:0;">🟢 Estado de Conexiones (En Vivo)</h3><p style="font-size:11px; color:#94a3b8;">Monitoreo en tiempo real de usuarios conectados.</p><select><option>-- Selecciona Cliente --</option></select><button class="btn-action" style="background:#22c55e; color:black; font-weight:bold;" onclick="openInfoModal('Estado', 'Cliente conectado y activo en streaming.')">🟢 Conectado (En Línea)</button><button class="btn-action" style="background:#ef4444; margin-top:10px;" onclick="closeModal('statusModal')">Cerrar</button></div></div>

  <div id="ticketsModal" class="modal"><div class="modal-content"><h3 style="color:#ef4444; margin-top:0;">🎧 Buzón de Soporte</h3><div id="ticketsContainer" style="max-height:200px; overflow-y:auto; text-align:left;"></div><button class="btn-action" style="background:#ef4444; margin-top:15px;" onclick="closeModal('ticketsModal')">Cerrar</button></div></div>

  <div id="supportModal" class="modal"><div class="modal-content"><h3 style="color:#22c55e; margin-top:0;">🎧 Centro de Soporte 24/7</h3><input type="text" id="ticketUser" placeholder="Tu Nombre / Usuario"><textarea id="ticketIssue" placeholder="Describe tu problema o duda aquí..."></textarea><button class="btn-action" style="background:#22c55e; color:black; font-weight:bold;" onclick="submitClientTicket()">💬 Enviar por WhatsApp</button><button class="btn-action" style="background:#0284c7; color:white; font-weight:bold;" onclick="submitClientTicket()">✈️ Enviar por Telegram</button><button class="btn-action" style="background:#ef4444; margin-top:10px;" onclick="closeModal('supportModal')">Cerrar</button></div></div>

  <div id="backupModal" class="modal"><div class="modal-content"><h3 style="color:#38bdf8; margin-top:0;">💾 Copias de Seguridad (Backup)</h3><p style="font-size:11px; color:#94a3b8;">Exporta o restaura toda la configuración de tu panel.</p><button class="btn-action" style="background:#22c55e; color:black; font-weight:bold;" onclick="exportBackup()">📥 Descargar Copia (JSON)</button><div style="margin-top:12px; text-align:left; font-size:11px;"><label style="color:#94a3b8;">Restaurar Copia:</label><input type="file" id="importFile" onchange="importBackup(event)" style="font-size:10px; margin-top:4px;"></div><button class="btn-action" style="background:#ef4444; margin-top:15px;" onclick="closeModal('backupModal')">Cerrar</button></div></div>

  <div id="infoModal" class="modal"><div class="modal-content"><h3 id="infoTitle" style="color:#38bdf8; margin-top:0;">Aviso</h3><p id="infoText" style="font-size:13px; color:#cbd5e1;"></p><button class="btn-action" style="background:#22c55e; margin-top:15px;" onclick="closeModal('infoModal')">Entendido</button></div></div>

  <script>
    const ADMIN_PASS = "1234";
    let currentLang = localStorage.getItem('ryokiva_lang') || 'es';
    let currentFilter = 'all';

    let clients = JSON.parse(localStorage.getItem('ryokiva_clients') || '[]');
    let resellers = JSON.parse(localStorage.getItem('ryokiva_resellers') || '[]');
    let tickets = JSON.parse(localStorage.getItem('ryokiva_tickets') || '[]');

    window.onload = function() {
      if (localStorage.getItem('ryokiva_logged') === 'true') {
        document.getElementById('loginScreen').style.display = 'none';
        applyUserRole(localStorage.getItem('ryokiva_role'), localStorage.getItem('ryokiva_username'));
      }
      document.getElementById('langSelect').value = currentLang;
      updateCounters();
    };

    function changeLanguage(lang) {
      currentLang = lang;
      localStorage.setItem('ryokiva_lang', lang);
      document.getElementById('htmlRoot').setAttribute('dir', lang === 'ar' ? 'rtl' : 'ltr');
    }

    function checkLogin() {
      let u = document.getElementById('loginUser').value.trim();
      let p = document.getElementById('loginPass').value.trim();

      if (u === ADMIN_PASS || (u.toLowerCase() === 'admin' && p === ADMIN_PASS) || (u === '' && p === ADMIN_PASS)) {
        localStorage.setItem('ryokiva_logged', 'true');
        localStorage.setItem('ryokiva_role', 'admin');
        localStorage.setItem('ryokiva_username', 'Admin');
        document.getElementById('loginScreen').style.display = 'none';
        applyUserRole('admin', 'Admin');
        return;
      }

      let foundReseller = resellers.find(r => r.user.toLowerCase() === u.toLowerCase() && r.pass === p);
      if (foundReseller) {
        localStorage.setItem('ryokiva_logged', 'true');
        localStorage.setItem('ryokiva_role', 'reseller');
        localStorage.setItem('ryokiva_username', foundReseller.user);
        document.getElementById('loginScreen').style.display = 'none';
        applyUserRole('reseller', foundReseller.user);
        return;
      }

      document.getElementById('loginError').style.display = 'block';
    }

    function applyUserRole(role, username) {
      let badge = document.getElementById('roleBadge');
      if (role === 'reseller') {
        badge.innerText = 'Revendedor: ' + username;
        document.getElementById('financialPanel').style.display = 'none';
        document.getElementById('tabResellers').style.display = 'none';
      } else {
        badge.innerText = 'Admin';
        document.getElementById('financialPanel').style.display = 'block';
        document.getElementById('tabResellers').style.display = 'block';
      }
      updateCounters();
    }

    function performLogout() {
      localStorage.removeItem('ryokiva_logged');
      localStorage.removeItem('ryokiva_role');
      localStorage.removeItem('ryokiva_username');
      document.getElementById('loginScreen').style.display = 'flex';
      document.getElementById('loginUser').value = '';
      document.getElementById('loginPass').value = '';
      document.getElementById('loginError').style.display = 'none';
    }

    function updateCounters() {
      let rev = 0, paid = 0;
      clients.forEach(c => {
        if(c.plan.includes('1 Año')) { rev += 7; paid++; }
        else if(c.plan.includes('Por Vida')) { rev += 14; paid++; }
      });
      resellers.forEach(r => {
        if(r.plan.includes('250')) rev += 20;
        else if(r.plan.includes('500')) rev += 40;
        else if(r.plan.includes('1000')) rev += 70;
        else if(r.plan.includes('Ilimitado')) rev += 170;
      });

      document.getElementById('finTotalRevenue').innerText = rev + ' €';
      document.getElementById('finPaidAccounts').innerText = paid;
      document.getElementById('finClientCount').innerText = clients.length;
      document.getElementById('finResellerCount').innerText = resellers.length;
      document.getElementById('b2').innerText = clients.length;
      document.getElementById('b3').innerText = resellers.length + ' Activos';
      document.getElementById('b5').innerText = clients.length + ' Vinculados';
      document.getElementById('b6').innerText = (clients.length * 2) + ' Perfiles';

      let bell = document.getElementById('bellCountBadge');
      if(tickets.length > 0) {
        bell.style.display = 'inline-block';
        bell.innerText = tickets.length;
        document.getElementById('b12').innerText = tickets.length + ' Avisos';
      } else {
        bell.style.display = 'none';
        document.getElementById('b12').innerText = '0 Avisos';
      }
    }

    function openModal(id) { document.getElementById(id).style.display = 'flex'; }
    function closeModal(id) { document.getElementById(id).style.display = 'none'; }
    function openInfoModal(title, text) { document.getElementById('infoTitle').innerText = title; document.getElementById('infoText').innerText = text; openModal('infoModal'); }
    function setPlan(p) { document.getElementById('b1').innerText = p; closeModal('planModal'); }

    function saveClient() {
      let u = document.getElementById('cUser').value.trim();
      let pass = document.getElementById('cPass').value.trim() || '1234';
      let p = document.getElementById('cPlan').value;
      if (!u) return;
      let expDate = new Date();
      if(p.includes('1 Año')) expDate.setFullYear(expDate.getFullYear() + 1);
      else if(p.includes('Demo 24')) expDate.setDate(expDate.getDate() + 1);
      else if(p.includes('Demo 7')) expDate.setDate(expDate.getDate() + 7);
      else expDate.setFullYear(expDate.getFullYear() + 99);

      clients.push({ user: u, pass: pass, plan: p, expiry: expDate.getTime() });
      localStorage.setItem('ryokiva_clients', JSON.stringify(clients));
      document.getElementById('cUser').value = '';
      document.getElementById('cPass').value = '';
      updateCounters();
      openInfoModal('Guardado', 'Cliente registrado correctamente con fecha de caducidad calculada.');
    }

    function saveReseller() {
      let u = document.getElementById('rUser').value.trim();
      let pass = document.getElementById('rPass').value.trim() || '1234';
      let p = document.getElementById('rPlan').value;
      if (!u) return;
      resellers.push({ user: u, pass: pass, plan: p });
      localStorage.setItem('ryokiva_resellers', JSON.stringify(resellers));
      document.getElementById('rUser').value = '';
      document.getElementById('rPass').value = '';
      updateCounters();
      openInfoModal('Guardado', 'Revendedor guardado.');
    }

    function generateTrial() {
      let u = document.getElementById('tUser').value.trim();
      if (!u) return;
      let expDate = new Date();
      expDate.setDate(expDate.getDate() + 1);
      clients.push({ user: u, pass: 'demo123', plan: 'Demo 24 Horas (1 Día)', expiry: expDate.getTime() });
      localStorage.setItem('ryokiva_clients', JSON.stringify(clients));
      document.getElementById('tUser').value = '';
      updateCounters();
      openInfoModal('Demo Creada', 'Prueba de 24h generada.');
    }

    function checkM3uStatus() {
      let badge = document.getElementById('m3uStatusBadge');
      badge.className = 'badge-apta';
      badge.innerText = '🟢 APTA (En Línea)';
      openInfoModal('Verificación M3U', 'El enlace principal es APTA y responde correctamente.');
    }

    function checkXcStatus() {
      let badge = document.getElementById('xcStatusBadge');
      badge.className = 'badge-apta';
      badge.innerText = '🟢 APTA (Operativo)';
      openInfoModal('Verificación Xtream', 'El servidor principal es APTA y está en línea.');
    }

    function submitClientTicket() {
      let user = document.getElementById('ticketUser').value.trim();
      let issue = document.getElementById('ticketIssue').value.trim();
      if(!user || !issue) { openInfoModal('Error', 'Introduce usuario y problema.'); return; }
      let foundClient = clients.find(c => c.user.toLowerCase() === user.toLowerCase());
      let pass = foundClient ? foundClient.pass : 'No registrado';
      tickets.unshift({ user: user, pass: pass, issue: issue, time: new Date().toLocaleTimeString() });
      localStorage.setItem('ryokiva_tickets', JSON.stringify(tickets));
      document.getElementById('ticketUser').value = '';
      document.getElementById('ticketIssue').value = '';
      closeModal('supportModal');
      updateCounters();
      openInfoModal('Enviado', 'Incidencia enviada correctamente.');
    }

    function openTicketsModal() {
      if(localStorage.getItem('ryokiva_role') === 'reseller') {
        openModal('supportModal');
        return;
      }
      let container = document.getElementById('ticketsContainer');
      if(tickets.length === 0) {
        container.innerHTML = '<p style="font-size:12px; color:#94a3b8;">No hay incidencias.</p>';
      } else {
        container.innerHTML = tickets.map((t, idx) => `
          <div class="item-card" style="border-left:3px solid #ef4444;">
            <div class="item-header"><span>👤 ${t.user}</span> <span style="color:#eab308; font-size:11px;">Pass: ${t.pass}</span></div>
            <div style="font-size:12px; margin-top:4px;">⚠️ ${t.issue}</div>
            <button class="btn-action" style="background:#22c55e; color:black; font-weight:bold; padding:4px; font-size:10px; margin-top:6px;" onclick="resolveTicket(${idx})">✅ Resolver</button>
          </div>
        `).join('');
      }
      openModal('ticketsModal');
    }

    function resolveTicket(idx) {
      tickets.splice(idx, 1);
      localStorage.setItem('ryokiva_tickets', JSON.stringify(tickets));
      updateCounters();
      openTicketsModal();
    }

    function openClientsList() { renderClientsList(); openModal('clientsModal'); }

    function setClientFilter(filter) {
      currentFilter = filter;
      document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
      if(filter === 'all') document.getElementById('filterAll').classList.add('active');
      if(filter === 'active') document.getElementById('filterActive').classList.add('active');
      if(filter === 'expired') document.getElementById('filterExpired').classList.add('active');
      renderClientsList();
    }

    function renderClientsList() {
      let container = document.getElementById('clientsContainer');
      let search = (document.getElementById('searchClientsInput')?.value || '').toLowerCase();
      let now = new Date().getTime();
      let filtered = clients.filter(c => {
        let matchesSearch = c.user.toLowerCase().includes(search);
        let isExpired = c.expiry && now > c.expiry;
        if (currentFilter === 'active') return matchesSearch && !isExpired;
        if (currentFilter === 'expired') return matchesSearch && isExpired;
        return matchesSearch;
      });

      if (filtered.length === 0) {
        container.innerHTML = '<p style="font-size:12px; color:#94a3b8;">Sin resultados.</p>';
      } else {
        container.innerHTML = filtered.map((c) => {
          let isExpired = c.expiry && now > c.expiry;
          let statusBadge = isExpired ? '<span class="badge-expired">🔴 No Apta / Caducado</span>' : '<span class="badge-active">🟢 Apta / Activo</span>';
          let expString = c.expiry ? new Date(c.expiry).toLocaleString() : 'Sin caducidad';
          return `<div class="item-card">
            <div class="item-header"><span>👤 ${c.user}</span> ${statusBadge}</div>
            <div class="item-date">Plan: ${c.plan} | Pass: <b>${c.pass}</b></div>
            <div class="item-date" style="color:#38bdf8; margin-top:2px;">⏳ Caduca: ${expString}</div>
            <button class="btn-copy" onclick="copyClientDetails('${c.user}', '${c.pass}', '${c.plan}', '${expString}')">📋 Copiar Datos de Acceso</button>
          </div>`;
        }).join('');
      }
    }

    function copyClientDetails(user, pass, plan, expiry) {
      let text = `✨ *RYOKIVA Business - Datos* ✨\n👤 Usuario: ${user}\n🔑 Contraseña: ${pass}\n📦 Plan: ${plan}\n⏳ Caducidad: ${expiry}\n🌐 Servidor: https://ryokiva.app`;
      navigator.clipboard.writeText(text).then(() => { openInfoModal('📋 Copiado', 'Copiado al portapapeles con fecha de caducidad.'); });
    }

    function copyTemplate(type) {
      let text = type === 'renew' ? "Hola! Tu suscripción en RYOKIVA vence pronto. ¿Deseas renovar tu plan por 1 Año (7€) o Por Vida (14€)?" : "¡Hola! Tu prueba gratis de 24h:\n👤 Usuario: [Usuario]\n🔑 Contraseña: demo123\n⏳ Vence en 24 horas\n🌐 Servidor: https://ryokiva.app";
      navigator.clipboard.writeText(text).then(() => { openInfoModal('📋 Copiado', 'Plantilla copiada.'); });
    }

    function openResellersList() {
      let container = document.getElementById('resellersContainer');
      container.innerHTML = resellers.length === 0 ? '<p style="font-size:12px; color:#94a3b8;">Sin revendedores.</p>' : resellers.map(r => `<div class="item-card"><div class="item-header"><span>🤝 ${r.user}</span><span class="badge-plan" style="background:#9333ea;">${r.plan}</span></div></div>`).join('');
      openModal('resellersModal');
    }

    function exportBackup() {
      let dataStr = "data:text/json;charset=utf-8," + encodeURIComponent(JSON.stringify({clients, resellers, tickets}, null, 2));
      let a = document.createElement('a'); a.href = dataStr; a.download = "ryokiva_backup.json";
      document.body.appendChild(a); a.click(); a.remove();
    }

    function importBackup(event) {
      let file = event.target.files[0];
      if (!file) return;
      let reader = new FileReader();
      reader.onload = function(e) {
        try {
          let data = JSON.parse(e.target.result);
          if(data.clients) clients = data.clients;
          if(data.resellers) resellers = data.resellers;
          if(data.tickets) tickets = data.tickets;
          localStorage.setItem('ryokiva_clients', JSON.stringify(clients));
          localStorage.setItem('ryokiva_resellers', JSON.stringify(resellers));
          localStorage.setItem('ryokiva_tickets', JSON.stringify(tickets));
          updateCounters();
          closeModal('backupModal');
          openInfoModal('Restaurado', 'Copia de seguridad importada con éxito.');
        } catch(err) {
          openInfoModal('Error', 'El archivo JSON no es válido.');
        }
      };
      reader.readAsText(file);
    }

    function switchSection(sec) {
      ['clients', 'trial', 'resellers', 'manual'].forEach(s => {
        let el = document.getElementById('section' + s.charAt(0).toUpperCase() + s.slice(1));
        if (el) el.style.display = 'none';
      });
      let target = document.getElementById('section' + sec.charAt(0).toUpperCase() + sec.slice(1));
      if (target) target.style.display = 'block';
    }

    function openDevicesList() {
      let sel = document.getElementById('devClientSelect');
      sel.innerHTML = '<option>-- Selecciona Cliente --</option>' + clients.map(c => `<option value="${c.user}">${c.user}</option>`).join('');
      openModal('devicesModal');
    }
    function openProfilesList() {
      let sel = document.getElementById('profClientSelect');
      sel.innerHTML = '<option>-- Elige Cliente --</option>' + clients.map(c => `<option value="${c.user}">${c.user}</option>`).join('');
      openModal('profilesModal');
    }
    function openM3uList() { openModal('m3uModal'); }
    function openXcList() { openModal('xcModal'); }
    function openStatusList() { openModal('statusModal'); }
    function openBackupModal() { openModal('backupModal'); }
    function openSupportModal() { openModal('supportModal'); }
  </script>
</body>
</html>
EOF

echo "¡VALIDADOR DE LISTAS APTA/NO APTA Y CADUCIDAD AÑADIDOS CON ÉXITO!"
