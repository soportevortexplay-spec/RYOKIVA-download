const fs = require('fs');
const html = `<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>RYOKIVA Business</title>
  <style>
    body { background: #0f172a; color: #f8fafc; font-family: sans-serif; margin: 0; padding: 15px; }
    .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
    .logo { font-size: 24px; font-weight: bold; color: #38bdf8; }
    .badge { background: #0284c7; padding: 2px 8px; border-radius: 4px; font-size: 12px; }
    .btn-logout { background: #ef4444; color: white; border: none; padding: 8px 15px; border-radius: 6px; cursor: pointer; }
    .grid-14 { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-bottom: 20px; }
    .box-card { background: #1e293b; border: 1px solid #334155; padding: 12px; border-radius: 8px; cursor: pointer; text-align: center; }
    .box-card:active { background: #334155; }
    .box-title { font-size: 11px; color: #94a3b8; margin-bottom: 5px; }
    .box-val { font-size: 15px; font-weight: bold; color: #38bdf8; }
    .tabs { display: flex; gap: 10px; margin-bottom: 15px; }
    .tab-btn { flex: 1; padding: 12px; background: #3b82f6; color: white; border: none; border-radius: 8px; font-weight: bold; cursor: pointer; text-align: center; }
    .section { background: #1e293b; padding: 15px; border-radius: 8px; margin-bottom: 15px; }
    input, select { width: 100%; padding: 10px; margin: 8px 0; background: #0f172a; border: 1px solid #334155; color: white; border-radius: 6px; box-sizing: border-box; }
    .btn-action { width: 100%; background: #0284c7; color: white; border: none; padding: 12px; border-radius: 6px; font-weight: bold; cursor: pointer; margin-top: 10px; }
    .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.8); justify-content: center; align-items: center; z-index: 1000; }
    .modal-content { background: #1e293b; border: 1px solid #38bdf8; padding: 20px; border-radius: 12px; width: 85%; max-width: 350px; text-align: center; }
    .plan-option { background: #0f172a; border: 1px solid #334155; padding: 12px; margin: 8px 0; border-radius: 8px; color: #38bdf8; font-weight: bold; cursor: pointer; text-align: left; display: flex; justify-content: space-between; align-items: center; }
    .plan-option:active { background: #0284c7; color: white; }
    .method-btn { background: #0f172a; border: 1px solid #38bdf8; padding: 12px; margin: 8px 0; border-radius: 8px; color: white; font-weight: bold; cursor: pointer; width: 100%; }
  </style>
</head>
<body>
  <div class="header">
    <div><span class="logo">RYOKIVA</span> <span class="badge">Business</span></div>
    <button class="btn-logout" onclick="localStorage.clear(); location.reload();">Salir</button>
  </div>
  <div class="grid-14">
    <div class="box-card" onclick="openPlanSelector()"><div class="box-title">1. Plan Actual ⚙️</div><div class="box-val" id="b1">250 Usuarios (20€)</div></div>
    <div class="box-card" onclick="switchTab('clients')"><div class="box-title">2. Clientes Activos</div><div class="box-val" id="b2">0</div></div>
    <div class="box-card" onclick="switchTab('resellers')"><div class="box-title">3. Revendedores</div><div class="box-val" style="color:#a855f7;" id="b3">0 Activos</div></div>
    <div class="box-card" onclick="openRechargeModal()"><div class="box-title">4. Recargar Panel 💳</div><div class="box-val" style="color:#eab308;" id="b4">Elegir Tarifa</div></div>
    <div class="box-card" onclick="alert('Casilla 5')"><div class="box-title">5. Dispositivos</div><div class="box-val">5 Máx</div></div>
    <div class="box-card" onclick="alert('Casilla 6')"><div class="box-title">6. Perfiles Config</div><div class="box-val">5 Pines</div></div>
    <div class="box-card" onclick="alert('Casilla 7')"><div class="box-title">7. Listas M3U</div><div class="box-val" style="color:#22c55e;">Activas</div></div>
    <div class="box-card" onclick="alert('Casilla 8')"><div class="box-title">8. Xtream Codes</div><div class="box-val" style="color:#22c55e;">OK</div></div>
    <div class="box-card" onclick="alert('Casilla 9')"><div class="box-title">9. Estado VPS</div><div class="box-val" style="color:#22c55e;">Online</div></div>
    <div class="box-card" onclick="alert('Casilla 10')"><div class="box-title">10. SSL Dominio</div><div class="box-val" style="color:#22c55e;">Seguro</div></div>
    <div class="box-card" onclick="alert('Casilla 11')"><div class="box-title">11. Pagos Stripe/Bizum</div><div class="box-val" style="color:#22c55e;">Conectado</div></div>
    <div class="box-card" onclick="alert('Casilla 12')"><div class="box-title">12. Alertas Vencidas</div><div class="box-val" style="color:#eab308;">0</div></div>
    <div class="box-card" onclick="alert('Casilla 13')"><div class="box-title">13. Copias Backup</div><div class="box-val">Diarias</div></div>
    <div class="box-card" onclick="alert('Casilla 14')"><div class="box-title">14. Soporte Técnico</div><div class="box-val" style="color:#22c55e;">Activo</div></div>
  </div>
  <div class="tabs">
    <button class="tab-btn" onclick="switchTab('clients')">👥 Clientes (Particulares)</button>
    <button class="tab-btn" style="background:#9333ea;" onclick="switchTab('resellers')">🤝 Revendedores</button>
  </div>
  <div id="sectionClients" class="section">
    <h3>➕ Registrar Cliente (Particular)</h3>
    <input type="text" id="cUser" placeholder="Usuario Cliente">
    <input type="password" id="cPass" placeholder="Contraseña">
    <select id="cPlan">
      <option value="Demo 7 Dias">Demo 7 Días Gratis</option>
      <option value="1 Año - 7€">1 Año - 7€</option>
      <option value="Por Vida - 14€">Por Vida - 14€</option>
    </select>
    <button class="btn-action" onclick="alert('Cliente registrado')">Guardar Cliente</button>
  </div>
  <div id="sectionResellers" class="section" style="display:none;">
    <h3>➕ Registrar Revendedor</h3>
    <input type="text" id="rUser" placeholder="Usuario Revendedor">
    <input type="password" id="rPass" placeholder="Contraseña">
    <select id="rPlan">
      <option value="250">250 Usuarios - 20€</option>
      <option value="500">500 Usuarios - 40€</option>
      <option value="1000">1000 Usuarios - 70€</option>
      <option value="Ilimitado">Ilimitado - 170€</option>
    </select>
    <button class="btn-action" style="background:#9333ea;" onclick="alert('Revendedor registrado')">Guardar Revendedor</button>
  </div>
  
  <!-- MODAL PLANES -->
  <div id="planModal" class="modal">
    <div class="modal-content">
      <h3 style="margin-top:0; color:#38bdf8;">Planes Revendedor</h3>
      <div class="plan-option" onclick="selectPlan('250 Usuarios (20€)')"><span>250 Usuarios</span><span style="color:#22c55e;">20€</span></div>
      <div class="plan-option" onclick="selectPlan('500 Usuarios (40€)')"><span>500 Usuarios</span><span style="color:#22c55e;">40€</span></div>
      <div class="plan-option" onclick="selectPlan('1000 Usuarios (70€)')"><span>1000 Usuarios</span><span style="color:#22c55e;">70€</span></div>
      <div class="plan-option" onclick="selectPlan('Ilimitado (170€)')"><span>Ilimitado</span><span style="color:#22c55e;">170€</span></div>
      <button class="btn-action" style="background:#ef4444; margin-top:15px;" onclick="closePlanSelector()">Cancelar</button>
    </div>
  </div>

  <!-- MODAL RECARGAR PANEL (PASO 1: SELECCIONAR PLAN) -->
  <div id="rechargeModal" class="modal">
    <div class="modal-content">
      <h3 style="margin-top:0; color:#eab308;">Recargar Panel 💳</h3>
      <p style="font-size:12px; color:#94a3b8;">Selecciona la tarifa y cantidad:</p>
      <div class="plan-option" onclick="selectRecharge('250 Usuarios', 20)"><span>250 Usuarios</span><span style="color:#22c55e;">20€</span></div>
      <div class="plan-option" onclick="selectRecharge('500 Usuarios', 40)"><span>500 Usuarios</span><span style="color:#22c55e;">40€</span></div>
      <div class="plan-option" onclick="selectRecharge('1000 Usuarios', 70)"><span>1000 Usuarios</span><span style="color:#22c55e;">70€</span></div>
      <div class="plan-option" onclick="selectRecharge('Ilimitado', 170)"><span>Ilimitado</span><span style="color:#22c55e;">170€</span></div>
      <button class="btn-action" style="background:#ef4444; margin-top:15px;" onclick="closeRechargeModal()">Cancelar</button>
    </div>
  </div>

  <!-- MODAL SELECCIONAR MÉTODO DE PAGO (PASO 2: STRIPE O BIZUM) -->
  <div id="paymentMethodModal" class="modal">
    <div class="modal-content">
      <h3 style="margin-top:0; color:#38bdf8;">Método de Pago</h3>
      <p style="font-size:13px; color:#f8fafc;" id="selectedSummary"></p>
      <button class="method-btn" style="border-color:#22c55e;" onclick="payWithStripe()">💳 Tarjeta / Stripe</button>
      <button class="method-btn" style="border-color:#a855f7;" onclick="payWithBizum()">📱 Pago por Bizum</button>
      <button class="btn-action" style="background:#ef4444; margin-top:15px;" onclick="closePaymentMethodModal()">Atrás</button>
    </div>
  </div>

  <script>
    let currentTarifa = '';
    let currentPrecio = 0;

    function openPlanSelector() { document.getElementById('planModal').style.display = 'flex'; }
    function closePlanSelector() { document.getElementById('planModal').style.display = 'none'; }
    function selectPlan(p) { document.getElementById('b1').innerText = p; closePlanSelector(); }
    
    function openRechargeModal() { document.getElementById('rechargeModal').style.display = 'flex'; }
    function closeRechargeModal() { document.getElementById('rechargeModal').style.display = 'none'; }
    
    function selectRecharge(tarifa, cantidad) {
      currentTarifa = tarifa;
      currentPrecio = cantidad;
      closeRechargeModal();
      document.getElementById('selectedSummary').innerText = tarifa + ' - ' + cantidad + '€';
      document.getElementById('paymentMethodModal').style.display = 'flex';
    }

    function closePaymentMethodModal() {
      document.getElementById('paymentMethodModal').style.display = 'none';
      openRechargeModal();
    }

    function payWithStripe() {
      alert('Redirigiendo a pasarela segura de Tarjeta/Stripe para ' + currentTarifa + ' (' + currentPrecio + '€)...');
      document.getElementById('paymentMethodModal').style.display = 'none';
    }

    function payWithBizum() {
      alert('Instrucciones Bizum:\\n\\n1. Envía ' + currentPrecio + '€ por Bizum al teléfono: 600000000\\n2. Concepto: Tu Nombre de Usuario\\n\\nUna vez realizado, los créditos se activarán al instante.');
      document.getElementById('paymentMethodModal').style.display = 'none';
    }

    function switchTab(t) {
      if(t === 'clients') {
        document.getElementById('sectionClients').style.display = 'block';
        document.getElementById('sectionResellers').style.display = 'none';
      } else {
        document.getElementById('sectionClients').style.display = 'none';
        document.getElementById('sectionResellers').style.display = 'block';
      }
    }
  </script>
</body>
</html>`;

fs.writeFileSync('/root/public/index.html', html);
console.log('¡INDEX CREADO CON BIZUM Y STRIPE!');
