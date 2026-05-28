const express = require("express");
const router = express.Router();
const TutorController = require("../controllers/TutorController");

// Definindo os caminhos
router.get("/tutores", TutorController.index);
router.post("/tutores", TutorController.store);
router.put("/tutores/:id", TutorController.update);
router.delete("/tutores/:id", TutorController.destroy);

module.exports = router;
