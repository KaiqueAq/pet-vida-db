const { Sequelize, DataTypes } = require("sequelize");

// Importante: o dotenv deve ser carregado ANTES deste arquivo ser importado.
// Para evitar "undefined" silencioso, validamos variáveis mínimas.
const host = process.env.DB_HOST;
const user = process.env.DB_USER;
const password = process.env.DB_PASS || process.env.DB_PASSWORD;
const database = process.env.DB_NAME;
const port = process.env.DB_PORT;
const dialect = process.env.DB_DIALECT;

const sequelize = new Sequelize(database, user, password, {
  host: host,
  port: port,
  dialect: dialect,
});

// Função para testar a conexão com o banco de dados
async function connectDB() {
  try {
    await sequelize.authenticate();
    console.log("✅ Conexão com o banco de dados estabelecida com sucesso.");
  } catch (error) {
    console.error("❌ Erro ao conectar ao banco de dados:", error);
    process.exit(1); // Sai do processo se a conexão falhar
  }
}

module.exports = { sequelize, DataTypes, connectDB };
