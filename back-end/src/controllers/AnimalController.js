const { sequelize, DataTypes } = require("../db_config/database");
const Animal = require("../models/Animal")(sequelize, DataTypes);

module.exports = {
  async index(req, res) {
    try {
      const animais = await Animal.findAll();
      return res.json(animais);
    } catch (error) {
      return res.status(500).json({ error: "Erro ao buscar animais" });
    }
  },

  async store(req, res) {
    try {
      const {
        nome,
        raca,
        data_nascimento,
        tutores_id_tutores,
        especies_id_especies,
      } = req.body;
      const novoAnimal = await Animal.create({
        nome,
        raca,
        data_nascimento,
        tutores_id_tutores,
        especies_id_especies,
      });
      return res.status(201).json(novoAnimal);
    } catch (error) {
      if (error.name === "SequelizeUniqueConstraintError") {
        return res.status(400).json({ error: "Animal já cadastrado" });
      }
      return res.status(500).json({ error: "Erro ao criar animal" });
    }
  },
  async update(req, res) {
    try {
      const { id } = req.params;
      const { nome, raca, data_nascimento, tutores_id_tutores } = req.body;
      const animal = await Animal.findByPk(id);
      if (!animal) {
        return res.status(404).json({ error: "Animal nao encontrado" });
      }
      animal.nome = nome;
      animal.raca = raca;
      animal.data_nascimento = data_nascimento;
      animal.tutores_id_tutores = tutores_id_tutores;
      await animal.save();
      return res.json(animal);
    } catch (error) {
      return res.status(500).json({ error: "Erro ao atualizar animal" });
    }
  },
  async delete(req, res) {
    try {
      const { id } = req.params;
      const animal = await Animal.findByPk(id);
      if (!animal) {
        return res.status(404).json({ error: "Animal nao encontrado" });
      }
      await animal.destroy();
      return res.json({ message: "Animal excluido com sucesso" });
    } catch (error) {
      return res.status(500).json({ error: "Erro ao excluir animal" });
    }
  },
};
