const express = require("express");
const router = express.Router();
const EspecieController = require("../controllers/EspecieController");

// Definindo os caminhos
router.get("/especies", EspecieController.index);
router.post("/especies", EspecieController.store);
router.put("/especies/:id", EspecieController.update);
router.delete("/especies/:id", EspecieController.destroy);

module.exports = router;
