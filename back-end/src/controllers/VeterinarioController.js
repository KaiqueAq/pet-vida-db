const { sequelize, DataTypes } = require("../db_config/database");
const Veterinario = require("../models/Veterinario")(sequelize, DataTypes);

module.exports = {
  async index(req, res) {
    try {
      const veterinarios = await Veterinario.findAll();
      return res.json(veterinarios);
    } catch (error) {
      return res.status(500).json({ error: "Erro ao buscar veterinários" });
    }
  },
  async store(req, res) {
    try {
      const { nome, cpf, email, telefone } = req.body;
      const novoVeterinario = await Veterinario.create({
        nome,
        cpf,
        email,
        telefone,
      });
      return res.status(201).json(novoVeterinario);
    } catch (error) {
      if (error.name === "SequelizeUniqueConstraintError") {
        return res.status(400).json({ error: "CPF ou Email já cadastrado" });
      }
      return res.status(500).json({ error: "Erro ao criar veterinário" });
    }
  },
  async update(req, res) {
    try {
      const { id } = req.params;
      const { nome, cpf, email, telefone } = req.body;
      const veterinario = await Veterinario.findByPk(id);
      if (!veterinario) {
        return res.status(404).json({ error: "Veterinário nao encontrado" });
      }
      veterinario.nome = nome;
      veterinario.cpf = cpf;
      veterinario.email = email;
      veterinario.telefone = telefone;
      await veterinario.save();
      return res.json(veterinario);
    } catch (error) {
      return res.status(500).json({ error: "Erro ao atualizar veterinário" });
    }
  },
  async delete(req, res) {
    try {
      const { id } = req.params;
      const veterinario = await Veterinario.findByPk(id);
      if (!veterinario) {
        return res.status(404).json({ error: "Veterinário nao encontrado" });
      }
      await veterinario.destroy();
      return res.json({ message: "Veterinário excluido com sucesso" });
    } catch (error) {
      return res.status(500).json({ error: "Erro ao excluir veterinário" });
    }
  },
};
