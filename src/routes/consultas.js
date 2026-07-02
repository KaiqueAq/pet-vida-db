const express = require('express');
const pool = require('../config/db');

const router = express.Router();

// POST /api/consultas — chama CALL sp_agendar_consulta
router.post('/', async (req, res) => {
  try {
    const { id_animal, id_veterinario, data_consulta, descricao } = req.body;
    const connection = await pool.getConnection();
    
    await connection.query(
      'CALL sp_agendar_consulta(?, ?, ?, ?)',
      [id_animal, id_veterinario, data_consulta, descricao]
    );
    
    connection.release();
    res.status(201).json({ message: 'Consulta agendada com sucesso' });
  } catch (error) {
    console.error('Erro:', error);
    res.status(500).json({ error: error.message });
  }
});

// PUT /api/consultas/:id/concluir — chama CALL sp_concluir_consulta
router.put('/:id/concluir', async (req, res) => {
  try {
    const { id } = req.params;
    const { diagnostico, prescricao } = req.body;
    const connection = await pool.getConnection();
    
    await connection.query(
      'CALL sp_concluir_consulta(?, ?, ?)',
      [id, diagnostico, prescricao]
    );
    
    connection.release();
    res.json({ message: 'Consulta concluída com sucesso' });
  } catch (error) {
    console.error('Erro:', error);
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
