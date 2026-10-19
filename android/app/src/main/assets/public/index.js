const express = require('express');
const app = express();
const { clients, currentPlan, superAdminProfessionals, styles } = require('./db');

app.use(express.urlencoded({ extended: true }));
app.use((req, res, next) => {
  res.set('Cache-Control', 'no-store, no-cache, must-revalidate, private');
  next();
});

const meta = '<meta name="viewport" content="width=device-width, initial-scale=1.0">';

app.get('/', (req, res) => res.sendFile(require('path').join(__dirname, 'public/panel.html')));

app.get('/login', (req, res) => {
  res.send(`<!DOCTYPE html><html><head>${meta}<style>${styles}</style></head><body>
    <div class="container">
      <h1>RYOKIVA BUSINESS</h1>
      <p class="subtitle">Acceso Privado Profesional</p>
      <form action="/login" method="POST">
        <label>Usuario (admin o superadmin)</label>
        <input name="username" required placeholder="admin">
        <label>Contraseña</label>
        <input type="password" name="password" required placeholder="admin o superadmin">
        <button class="btn" type="submit">Iniciar Sesión</button>
      </form>
    </div>
  </body></html>`);
});

app.post('/login', (req, res) => {
  const { username, password } = req.body;
  if (username === 'superadmin' && password === 'superadmin') {
    res.redirect('/superadmin');
  } else if (username === 'admin' && password === 'admin') {
    res.redirect('/business');
  } else {
    res.send(`<!DOCTYPE html><html><head>${meta}<style>${styles}</style></head><body>
      <div class="container">
        <h1>Error de Autenticación</h1>
        <p style="color:#ef4444">Credenciales incorrectas.</p>
        <a class="back" href="/login">← Volver</a>
      </div>
    </body></html>`);
  }
});

// Panel Principal Profesional (Admin)
app.get('/business', (req, res) => {
  res.send(`<!DOCTYPE html><html><head>${meta}<style>${styles}</style></head><body>
    <div class="container">
      <h1>PANEL BUSINESS</h1>
      <p class="subtitle">Plan Activo: ${currentPlan.name}</p>
      
      <a class="card" href="/business/clients"><h2>👥 Gestión de Clientes</h2><p>CRUD y fichas individuales</p></a>
      <a class="card" href="/business/stripe"><h2>💳 Suscripciones y Pagos</h2><p>Planes Business y Stripe</p></a>

      <a class="back" href="/login">Cerrar sesión</a>
    </div>
  </body></html>`);
});

// Punto 12: Panel del Administrador Principal (SuperAdmin)
app.get('/superadmin', (req, res) => {
  let html = `<!DOCTYPE html><html><head>${meta}<style>${styles}</style></head><body>
    <div class="container">
      <h1 style="color:#f59e0b;">ADMINISTRADOR PRINCIPAL</h1>
      <p class="subtitle">Supervisión Global de Profesionales</p>`;

  superAdminProfessionals.forEach(p => {
    html += `<div class="card" style="border-color:#f59e0b;">
      <h2>${p.name}</h2>
      <p>• Usuario: <b>${p.username}</b></p>
      <p>• Plan Asignado: <b>${p.plan}</b></p>
      <p>• Estado: <b style="color:#22c55e;">${p.status}</b></p>
      <a href="/superadmin/delete?id=${p.id}" class="btn btn-danger" style="margin-top:8px; padding:6px; font-size:0.8rem;">Suspender Profesional</a>
    </div>`;
  });

  html += `<form action="/superadmin/create" method="POST" style="background:#1e293b; padding:16px; border-radius:12px; border:1px solid #334155; margin-top:20px; text-align:left;">
    <h2 style="font-size:1rem; color:#f8fafc; margin-bottom:10px;">+ Crear Nuevo Profesional</h2>
    <label>Nombre Empresa</label>
    <input name="name" required>
    <label>Usuario</label>
    <input name="username" required>
    <label>Plan Asignado</label>
    <select name="plan">
      <option value="BUSINESS 250">BUSINESS 250 (250 usuarios)</option>
      <option value="BUSINESS 500">BUSINESS 500 (500 usuarios)</option>
      <option value="BUSINESS 1000">BUSINESS 1000 (1000 usuarios)</option>
    </select>
    <button class="btn" type="submit" style="background:#f59e0b; color:#000;">Registrar Profesional</button>
  </form>

  <a class="back" href="/login">Cerrar Sesión SuperAdmin</a></div></body></html>`;
  res.send(html);
});

app.post('/superadmin/create', (req, res) => {
  superAdminProfessionals.push({
    id: superAdminProfessionals.length ? superAdminProfessionals[superAdminProfessionals.length - 1].id + 1 : 1,
    name: req.body.name,
    username: req.body.username,
    plan: req.body.plan,
    status: 'Activo'
  });
  res.redirect('/superadmin');
});

app.get('/superadmin/delete', (req, res) => {
  const id = parseInt(req.query.id);
  superAdminProfessionals = superAdminProfessionals.filter(p => p.id !== id);
  res.redirect('/superadmin');
});

// Rutas auxiliares
app.get('/business/clients', (req, res) => res.send(`<!DOCTYPE html><html><head>${meta}<style>${styles}</style></head><body><div class="container"><h1>CLIENTES</h1><a class="back" href="/business">← Volver</a></div></body></html>`));
app.get('/business/stripe', (req, res) => res.send(`<!DOCTYPE html><html><head>${meta}<style>${styles}</style></head><body><div class="container"><h1>STRIPE</h1><a class="back" href="/business">← Volver</a></div></body></html>`));

app.listen(3000, () => console.log('SuperAdmin Panel Server running on port 3000'));

// Ruta protegida para obtener las sesiones activas (solo administradores)
app.get('/api/v1/active-sessions', async (req, res) => {
    // Verificamos si hay una sesión de administrador activa
        return res.status(401).json({ success: false, message: 'Acceso no autorizado' });
    }
    try {
        const result = await pool.query('SELECT * FROM active_sessions ORDER BY connected_at DESC');
        res.json({
            success: true,
            count: result.rows.length,
            sessions: result.rows
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({ success: false, message: 'Error al obtener las sesiones activas' });
    }
});
