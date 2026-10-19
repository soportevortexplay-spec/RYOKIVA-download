const fs = require('fs');
let code = fs.readFileSync('index.js', 'utf8');
code = code.replace(/app\.get\(\s*['"]\/['"]\s*,\s*[\s\S]*?\);/, "app.get('/', (req, res) => res.sendFile(__dirname + '/public/panel.html'));");
fs.writeFileSync('index.js', code);
console.log('Ruta raiz actualizada correctamente.');
