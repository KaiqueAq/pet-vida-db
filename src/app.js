const express = require('express');
const cors = require('cors');
const veterinarios = require('./routes/veterinarios');
const animais = require('./routes/animais');
const agenda = require('./routes/agenda');
const consultas = require('./routes/consultas');
const pagamentos = require('./routes/pagamentos');
const relatorios = require('./routes/relatorios');

const app = express();
app.use(cors());
app.use(express.json());

app.use('/api/veterinarios', veterinarios);
app.use('/api/animais', animais);
app.use('/api/agenda', agenda);
app.use('/api/consultas', consultas);
app.use('/api/pagamentos', pagamentos);
app.use('/api/relatorios', relatorios);

module.exports = app;
