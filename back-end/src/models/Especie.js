module.exports = (sequelize, DataTypes) => {
  const Especie = sequelize.define(
    "Especie",
    {
      id_especies: {
        type: DataTypes.INTEGER.UNSIGNED,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
      },
      nome: {
        type: DataTypes.STRING(45),
        allowNull: false,
        unique: true,
      },
    },
    {
      tableName: "especies",
      timestamps: false,
    },
  );
  return Especie;
};
