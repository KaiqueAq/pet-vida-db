const { sequelize, DataTypes } = require("../db_config/database");
const Tutor = require("../models/Tutor")(sequelize, DataTypes);

module.exports = {
  // Listar todos os tutores
  async index(req, res) {
    try {
      const tutores = await Tutor.findAll();
      return res.json(tutores);
    } catch (error) {
      return res.status(500).json({ error: "Erro ao buscar tutores" });
    }
  },

  // Criar um novo tutor
  async store(req, res) {
    try {
      const { nome, cpf, email, telefone } = req.body;
      const novoTutor = await Tutor.create({ nome, cpf, email, telefone });
      return res.status(201).json(novoTutor);
    } catch (error) {
      if (error.name === "SequelizeUniqueConstraintError") {
        return res.status(400).json({ error: "CPF ou Email já cadastrado" });
      }
      return res.status(500).json({ error: "Erro ao criar tutor" });
    }
  },
  async update(req, res) {
    try {
      const { id } = req.params;
      const { nome, cpf, email, telefone } = req.body;
      const tutor = await Tutor.findByPk(id);
      if (!tutor) {
        return res.status(404).json({ error: "Tutor nao encontrado" });
      }
      tutor.nome = nome;
      tutor.cpf = cpf;
      tutor.email = email;
      tutor.telefone = telefone;
      await tutor.save();
      return res.json(tutor);
    } catch (error) {
      return res.status(500).json({ error: "Erro ao atualizar tutor" });
    }
  },
  async delete(req, res) {
    try {
      const { id } = req.params;
      const tutor = await Tutor.findByPk(id);
      if (!tutor) {
        return res.status(404).json({ error: "Tutor nao encontrado" });
      }
      await tutor.destroy();
      return res.json({ message: "Tutor excluido com sucesso" });
    } catch (error) {
      return res.status(500).json({ error: "Erro ao excluir tutor" });
    }
  },
};
