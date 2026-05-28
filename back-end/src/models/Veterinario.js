module.exports = (sequelize, DataTypes) => {
  const Veterinario = sequelize.define(
    "Veterinario",
    {
      id_veterinarios: {
        type: DataTypes.INTEGER.UNSIGNED,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
      },
      nome: {
        type: DataTypes.STRING(100),
        allowNull: false,
      },
      crmv: {
        type: DataTypes.STRING(20),
        allowNull: false,
        unique: true,
      },
      especialidade: {
        type: DataTypes.STRING(45),
        allowNull: true,
      },
      telefone: {
        type: DataTypes.STRING(20),
        allowNull: true,
      },
    },
    {
      tableName: "veterinarios",
      timestamps: false,
    },
  );
  return Veterinario;
};
