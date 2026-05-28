const express = require("express");
const router = express.Router();
const ConsultaController = require("../controllers/ConsultaController");

// Definindo os caminhos
router.get("/consultas", ConsultaController.index);
router.post("/consultas", ConsultaController.store);
router.put("/consultas/:id", ConsultaController.update);
router.delete("/consultas/:id", ConsultaController.destroy);

module.exports = router;
