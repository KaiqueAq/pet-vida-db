const express = require('express');
const pool = require('../db');

const router = express.Router();

// GET /api/agenda/:data — usa vw_consultas_completas filtrada
router.get('/:data', async (req, res) => {
  try {
    const { data } = req.params;
    const connection = await pool.getConnection();
    const [rows] = await connection.query(
      'SELECT * FROM vw_consultas_completas WHERE DATE(data_consulta) = ?',
      [data]
    );
    connection.release();
    res.json(rows);
  } catch (error) {
    console.error('Erro:', error);
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
