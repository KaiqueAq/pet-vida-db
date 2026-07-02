const express = require('express');
const pool = require('../config/db');

const router = express.Router();

// GET /api/animais — usa vw_animais_detalhados
router.get('/', async (req, res) => {
  try {
    const connection = await pool.getConnection();
    const [rows] = await connection.query('SELECT * FROM vw_animais_detalhados');
    connection.release();
    res.json(rows);
  } catch (error) {
    console.error('Erro:', error);
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
