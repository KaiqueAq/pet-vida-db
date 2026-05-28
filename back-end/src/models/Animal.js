module.exports = (sequelize, DataTypes) => {
  const Animal = sequelize.define(
    "Animal",
    {
      id_animais: {
        type: DataTypes.INTEGER.UNSIGNED,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
      },
      nome: {
        type: DataTypes.STRING(50),
        allowNull: false,
      },
      raca: {
        type: DataTypes.STRING(30),
        allowNull: true,
      },
      data_nascimento: {
        type: DataTypes.DATEONLY, // Usando DATEONLY para data de nascimento
        allowNull: true,
      },
      tutores_id_tutores: {
        type: DataTypes.INTEGER.UNSIGNED,
        allowNull: false,
        references: { model: "tutores", key: "id_tutores" },
      },
      especies_id_especies: {
        type: DataTypes.INTEGER.UNSIGNED,
        allowNull: false,
        references: { model: "especies", key: "id_especies" },
      },
    },
    {
      tableName: "animais",
      timestamps: false,
    },
  );
  return Animal;
};
