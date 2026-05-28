const { sequelize, DataTypes } = require("../db_config/database");
const Consulta = require("../models/Consulta")(sequelize, DataTypes);

module.exports = {
  async index(req, res) {
    try {
      const consultas = await Consulta.findAll();
      return res.json(consultas);
    } catch (error) {
      return res.status(500).json({ error: "Erro ao buscar consultas" });
    }
  },
  async store(req, res) {
    try {
      const { data_hora, diagnostico, valor, status, animais_id_animais } =
        req.body;
      const novaConsulta = await Consulta.create({
        data_hora,
        diagnostico,
        valor,
        status,
        animais_id_animais,
      });
      return res.status(201).json(novaConsulta);
    } catch (error) {
      if (error.name === "SequelizeUniqueConstraintError") {
        return res.status(400).json({ error: "CPF ou Email já cadastrado" });
      }
      return res.status(500).json({ error: "Erro ao criar consulta" });
    }
  },
  async update(req, res) {
    try {
      const { id } = req.params;
      const { data_hora, diagnostico, valor, status, animais_id_animais } =
        req.body;
      const consulta = await Consulta.findByPk(id);
      if (!consulta) {
        return res.status(404).json({ error: "Consulta nao encontrada" });
      }
      consulta.data_hora = data_hora;
      consulta.diagnostico = diagnostico;
      consulta.valor = valor;
      consulta.status = status;
      consulta.animais_id_animais = animais_id_animais;
      await consulta.save();
      return res.json(consulta);
    } catch (error) {
      return res.status(500).json({ error: "Erro ao atualizar consulta" });
    }
  },
  async delete(req, res) {
    try {
      const { id } = req.params;
      const consulta = await Consulta.findByPk(id);
      if (!consulta) {
        return res.status(404).json({ error: "Consulta nao encontrada" });
      }
      await consulta.destroy();
      return res.json({ message: "Consulta excluida com sucesso" });
    } catch (error) {
      return res.status(500).json({ error: "Erro ao excluir consulta" });
    }
  },
};
