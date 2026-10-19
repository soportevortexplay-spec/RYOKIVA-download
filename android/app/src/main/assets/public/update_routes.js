const fs = require('fs');
let code = fs.readFileSync('server.js', 'utf8');
// Asegurarnos de que sirva la carpeta public correctamente en la raíz y /business
console.log('Verificando rutas del servidor...');
