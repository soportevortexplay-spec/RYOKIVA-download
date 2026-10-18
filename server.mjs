import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';
import { exec } from 'child_process';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

function createServer(port) {
    const app = express();
    
    app.use((req, res, next) => {
        res.setHeader('Cache-Control', 'no-store, no-cache, must-revalidate, proxy-revalidate');
        res.setHeader('Pragma', 'no-cache');
        res.setHeader('Expires', '0');
        next();
    });

    app.use(express.static(path.join(__dirname, 'public')));

    // Endpoint API para obtener conexiones activas del VPS
    app.get('/api/vps-connections', (req, res) => {
        exec("ss -tn state established '( dport = :3000 or sport = :3000 )' | awk 'NR>1 {print $5}'", (error, stdout) => {
            const connections = stdout.trim() ? stdout.trim().split('\n') : [];
            res.json({
                total: connections.length,
                ips: connections,
                uptime: process.uptime()
            });
        });
    });

    app.get(/(.*)/, (req, res) => {
        res.sendFile(path.join(__dirname, 'public', 'index.html'));
    });

    app.listen(port, '0.0.0.0', () => {
        console.log(`RYOKIVA Business listo en puerto ${port}`);
    });
}

createServer(3000);
createServer(4000);
