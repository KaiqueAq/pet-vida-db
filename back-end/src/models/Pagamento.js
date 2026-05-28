module.exports = (sequelize, DataTypes) => {
  const Pagamento = sequelize.define(
    "Pagamento",
    {
      id_pagamentos: {
        type: DataTypes.INTEGER.UNSIGNED,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
      },
      valor_pago: {
        type: DataTypes.DECIMAL(10, 2).UNSIGNED,
        allowNull: false,
      },
      forma_pagamento: {
        type: DataTypes.ENUM("pix", "cartao", "dinheiro", "convênio"),
        allowNull: false,
      },
      data_pagamento: {
        type: DataTypes.DATE,
        allowNull: false,
      },
      status: {
        type: DataTypes.ENUM("pago", "pendente", "cancelado"),
        allowNull: false,
      },
      // A chave estrangeira (consultas_id_consultas)
      // será definida através das associações no index.js
      consultas_id_consultas: {
        type: DataTypes.INTEGER.UNSIGNED,
        allowNull: false,
        references: { model: "consultas", key: "id_consultas" },
      },
    },
    {
      tableName: "pagamentos",
      timestamps: false,
    },
  );
  return Pagamento;
};
