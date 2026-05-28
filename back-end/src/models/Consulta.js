module.exports = (sequelize, DataTypes) => {
  const Consulta = sequelize.define(
    "Consulta",
    {
      id_consultas: {
        type: DataTypes.INTEGER.UNSIGNED,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
      },
      data_hora: {
        type: DataTypes.DATE,
        allowNull: false,
      },
      diagnostico: {
        type: DataTypes.STRING(45),
        allowNull: true,
      },
      valor: {
        type: DataTypes.DECIMAL(10, 2).UNSIGNED,
        allowNull: false,
      },
      status: {
        type: DataTypes.ENUM(
          "agendada",
          "em_atendimento",
          "concluida",
          "cancelada",
        ),
        allowNull: false,
      },
      animais_id_animais: {
        type: DataTypes.INTEGER.UNSIGNED,
        allowNull: false,
        references: { model: "animais", key: "id_animais" },
      },
      veterinarios_id_veterinarios: {
        type: DataTypes.INTEGER.UNSIGNED,
        allowNull: false,
        references: { model: "veterinarios", key: "id_veterinarios" },
      },
    },
    {
      tableName: "consultas",
      timestamps: false,
    },
  );
  return Consulta;
};
