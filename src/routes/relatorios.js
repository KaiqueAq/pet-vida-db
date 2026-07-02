const express = require('express');
const pool = require('../config/db');

const router = express.Router();

// GET /api/relatorios/dashboard — query do dashboard financeiro
router.get('/dashboard', async (req, res) => {
  try {
    const connection = await pool.getConnection();
    
    const [totalReceitas] = await connection.query(
      'SELECT COALESCE(SUM(valor), 0) as total FROM pagamentos WHERE status = "pago"'
    );
    
    const [totalDividas] = await connection.query(
      'SELECT COALESCE(SUM(valor), 0) as total FROM pagamentos WHERE status = "pendente"'
    );
    
    const [consultasMes] = await connection.query(
      'SELECT COUNT(*) as total FROM consultas WHERE MONTH(data_consulta) = MONTH(NOW())'
    );
    
    connection.release();
    
    res.json({
      receitas_totais: totalReceitas[0].total,
      dividas_totais: totalDividas[0].total,
      consultas_mes: consultasMes[0].total
    });
  } catch (error) {
    console.error('Erro:', error);
    res.status(500).json({ error: error.message });
  }
});

// GET /api/relatorios/inadimplentes — usa vw_inadimplentes
router.get('/inadimplentes', async (req, res) => {
  try {
    const connection = await pool.getConnection();
    const [rows] = await connection.query('SELECT * FROM vw_inadimplentes');
    connection.release();
    res.json(rows);
  } catch (error) {
    console.error('Erro:', error);
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
