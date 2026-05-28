module.exports = (sequelize, DataTypes) => {
    const Tutor = sequelize.define('Tutor', {
        id_tutores: {
            type: DataTypes.INTEGER.UNSIGNED,
            primaryKey: true,
            autoIncrement: true,
            allowNull: false,
        },
        nome: {
            type: DataTypes.STRING(100),
            allowNull: false,
        },
        cpf: {
            type: DataTypes.STRING(14),
            allowNull: false,
            unique: true,
        },
        email: {
            type: DataTypes.STRING(100),
            allowNull: true,
            unique: true,
        },
        telefone: {
            type: DataTypes.STRING(20),
            allowNull: true,
        },
    }, {
        tableName: 'tutores', // Nome explícito da tabela no banco de dados
        timestamps: false, // Desabilita createdAt e updatedAt, pois não estão no schema
    });
    return Tutor;
};
