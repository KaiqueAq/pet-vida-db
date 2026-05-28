const express = require("express");
const router = express.Router();
const AnimalController = require("../controllers/AnimalController");

// Definindo os caminhos
router.get("/animais", AnimalController.index);
router.post("/animais", AnimalController.store);
router.put("/animais/:id", AnimalController.update);
router.delete("/animais/:id", AnimalController.destroy);

module.exports = router;
