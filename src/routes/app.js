const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());

app.get('/api', (req, res) => {
  res.json({ message: 'Pet Vida API', status: 'Online' });
});

app.use('/api/veterinarios', require('./routes/veterinarios'));
app.use('/api/animais', require('./routes/animais'));
app.use('/api/consultas', require('./routes/consultas'));
app.use('/api/especies', require('./routes/especies'));
app.use('/api/pagamentos', require('./routes/pagamentos'));
app.use('/api/tutores', require('./routes/tutores'));

module.exports = app;