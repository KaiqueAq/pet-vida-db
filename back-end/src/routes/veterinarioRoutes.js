const express = require("express");
const router = express.Router();
const VeterinarioController = require("../controllers/VeterinarioController");

// Definindo os caminhos
router.get("/veterinarios", VeterinarioController.index);
router.post("/veterinarios", VeterinarioController.store);
router.put("/veterinarios/:id", VeterinarioController.update);
router.delete("/veterinarios/:id", VeterinarioController.destroy);

module.exports = router;
