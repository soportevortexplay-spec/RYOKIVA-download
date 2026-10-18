const express = require('express');
const app = express();
app.use(express.json());
let clientsList = [{id: '1', name: 'Cliente Demo 1', profiles: [{name: 'Principal', url: 'http://example.com/get.php?username=1&password=1'}]}];
app.post('/api/business/login', (req, res) => {
  const { username, password } = req.body;
  if(username === 'demo_prof' && password === 'password123') {
    return res.json({ success: true });
  }
  return res.status(401).json({ success: false });
});
app.get('/api/business/clients', (req, res) => res.json({ success: true, clients: clientsList }));
app.post('/api/business/clients', (req, res) => {
  clientsList.push({ id: Date.now().toString(), name: req.body.name, profiles: [] });
  res.json({ success: true });
});
app.post('/api/business/profiles', (req, res) => {
  const client = clientsList.find(c => c.id === req.body.clientId);
  if(client) {
    client.profiles.push({ name: req.body.name, url: req.body.url });
    return res.json({ success: true });
  }
  res.status(404).json({ success: false });
});
app.get('/', (req, res) => res.sendFile('/root/index.html'));
app.listen(4000, () => console.log('Servidor operativo'));
