const { sequelize, DataTypes } = require("../db_config/database");
const Pagamento = require("../models/Pagamento")(sequelize, DataTypes);

module.exports = {
  async index(req, res) {
    try {
      const pagamentos = await Pagamento.findAll();
      return res.json(pagamentos);
    } catch (error) {
      return res.status(500).json({ error: "Erro ao buscar pagamentos" });
    }
  },
  async store(req, res) {
    try {
      const { data_hora, valor, status, consultas_id_consultas } = req.body;
      const novoPagamento = await Pagamento.create({
        data_hora,
        valor,
        status,
        consultas_id_consultas,
      });
      return res.status(201).json(novoPagamento);
    } catch (error) {
      if (error.name === "SequelizeUniqueConstraintError") {
        return res
          .status(400)
          .json({ error: "Pagamento já realizado para esta consulta" });
      }
      return res.status(500).json({ error: "Erro ao criar pagamento" });
    }
  },
  async update(req, res) {
    try {
      const { id } = req.params;
      const { data_hora, valor, status, consultas_id_consultas } = req.body;
      const pagamento = await Pagamento.findByPk(id);
      if (!pagamento) {
        return res.status(404).json({ error: "Pagamento nao encontrado" });
      }
      pagamento.data_hora = data_hora;
      pagamento.valor = valor;
      pagamento.status = status;
      pagamento.consultas_id_consultas = consultas_id_consultas;
      await pagamento.save();
      return res.json(pagamento);
    } catch (error) {
      return res.status(500).json({ error: "Erro ao atualizar pagamento" });
    }
  },
  async delete(req, res) {
    try {
      const { id } = req.params;
      const pagamento = await Pagamento.findByPk(id);
      if (!pagamento) {
        return res.status(404).json({ error: "Pagamento nao encontrado" });
      }
      await pagamento.destroy();
      return res.json({ message: "Pagamento excluido com sucesso" });
    } catch (error) {
      return res.status(500).json({ error: "Erro ao excluir pagamento" });
    }
  },
};
