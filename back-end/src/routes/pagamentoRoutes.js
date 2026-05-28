const express = require("express");
const router = express.Router();
const PagamentoController = require("../controllers/PagamentoController");

// Definindo os caminhos
router.get("/pagamentos", PagamentoController.index);
router.post("/pagamentos", PagamentoController.store);
router.put("/pagamentos/:id", PagamentoController.update);
router.delete("/pagamentos/:id", PagamentoController.destroy);

module.exports = router;
