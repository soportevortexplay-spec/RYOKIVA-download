const express = require('express');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = 3000;
const DATA_FILE = path.join(__dirname, 'db.json');

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));

function initDB() {
  if (!fs.existsSync(DATA_FILE)) {
    const initialData = {
      adminUser: "admin",
      adminPass: "ryokiva2026",
      clients: [],
      profiles: []
    };
    fs.writeFileSync(DATA_FILE, JSON.stringify(initialData, null, 2));
  }
}

function readDB() {
  initDB();
  try {
    return JSON.parse(fs.readFileSync(DATA_FILE, 'utf8'));
  } catch(e) {
    return { adminUser: "admin", adminPass: "ryokiva2026", clients: [], profiles: [] };
  }
}

function writeDB(data) {
  fs.writeFileSync(DATA_FILE, JSON.stringify(data, null, 2));
}

app.post('/api/login', (req, res) => {
  const user = req.body.user || req.body.username;
  const pass = req.body.pass || req.body.password;
  const db = readDB();

  if (user === (db.adminUser || "admin") && pass === (db.adminPass || "ryokiva2026")) {
    return res.json({ success: true, token: "admin-authenticated-token" });
  }
  return res.status(401).json({ success: false, message: "Credenciales incorrectas" });
});

app.get('/api/clients', (req, res) => {
  const db = readDB();
  res.json(db.clients || []);
});

app.post('/api/clients', (req, res) => {
  const db = readDB();
  const newClient = { id: Date.now(), ...req.body };
  db.clients = db.clients || [];
  db.clients.push(newClient);
  writeDB(db);
  res.json({ success: true, client: newClient });
});

app.listen(PORT, () => {
  console.log(`RYOKIVA Business listo en puerto ${PORT}`);
});
