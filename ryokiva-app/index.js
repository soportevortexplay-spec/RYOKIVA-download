const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html lang="es">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Ryokiva</title>
      <style>
        body { font-family: system-ui, sans-serif; background: #0f172a; color: #f8fafc; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; text-align: center; }
        .card { background: #1e293b; padding: 2rem; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.3); border: 1px solid #334155; }
        h1 { color: #38bdf8; margin-bottom: 0.5rem; }
        p { color: #94a3b8; }
      </style>
    </head>
    <body>
      <div class="card">
        <h1>¡Bienvenido a Ryokiva!</h1>
        <p>La aplicación está en línea y funcionando con éxito.</p>
      </div>
    </body>
    </html>
  `);
});

app.listen(3000, () => console.log('Servidor listo en puerto 3000'));
