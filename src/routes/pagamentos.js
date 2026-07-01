const express = require('express');
const pool = require('../db');

const router = express.Router();

// POST /api/pagamentos/:consulta_id — chama CALL sp_registrar_pagamento
router.post('/:consulta_id', async (req, res) => {
  try {
    const { consulta_id } = req.params;
    const { valor, metodo_pagamento, data_pagamento } = req.body;
    const connection = await pool.getConnection();
    
    await connection.query(
      'CALL sp_registrar_pagamento(?, ?, ?, ?)',
      [consulta_id, valor, metodo_pagamento, data_pagamento]
    );
    
    connection.release();
    res.status(201).json({ message: 'Pagamento registrado com sucesso' });
  } catch (error) {
    console.error('Erro:', error);
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
