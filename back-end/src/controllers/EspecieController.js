const { sequelize, DataTypes } = require("../db_config/database");
const Especie = require("../models/Especie")(sequelize, DataTypes);

module.exports = {
  async index(req, res) {
    try {
      const especies = await Especie.findAll();
      return res.json(especies);
    } catch (error) {
      return res.status(500).json({ error: "Erro ao buscar espécies" });
    }
  },
  async store(req, res) {
    try {
      const { nome } = req.body;
      const novaEspecie = await Especie.create({ nome });
      return res.status(201).json(novaEspecie);
    } catch (error) {
      if (error.name === "SequelizeUniqueConstraintError") {
        return res.status(400).json({ error: "Espécie já cadastrada" });
      }
      return res.status(500).json({ error: "Erro ao criar espécie" });
    }
  },
  async update(req, res) {
    try {
      const { id } = req.params;
      const { nome } = req.body;
      const especie = await Especie.findByPk(id);
      if (!especie) {
        return res.status(404).json({ error: "Espécie não encontrada" });
      }
      especie.nome = nome;
      await especie.save();
      return res.json(especie);
    } catch (error) {
      return res.status(500).json({ error: "Erro ao atualizar espécie" });
    }
  },
  async delete(req, res) {
    try {
      const { id } = req.params;
      const especie = await Especie.findByPk(id);
      if (!especie) {
        return res.status(404).json({ error: "Espécie não encontrada" });
      }
      await especie.destroy();
      return res.json({ message: "Espécie excluída com sucesso" });
    } catch (error) {
      return res.status(500).json({ error: "Erro ao excluir espécie" });
    }
  },
};
