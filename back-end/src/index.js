const path = require("path");
// Carrega o .env da raiz do projeto e usa 'override: true' para substituir variáveis vazias injetadas pelo Node
require("dotenv").config({
  // __dirname = back-end/src/db_config  => ../.. = raiz do projeto (pet-vida-db)
  path: path.resolve(__dirname, "../../.env"),
  override: true,
});
const express = require("express");
const { sequelize, DataTypes, connectDB } = require("./db_config/database"); // Importa a instância do sequelize e DataTypes
const cors = require("cors");

// Importa os modelos
const Tutor = require("./models/Tutor")(sequelize, DataTypes);
const Especie = require("./models/Especie")(sequelize, DataTypes);
const Animal = require("./models/Animal")(sequelize, DataTypes);
const Veterinario = require("./models/Veterinario")(sequelize, DataTypes);
const Consulta = require("./models/Consulta")(sequelize, DataTypes);
const Pagamento = require("./models/Pagamento")(sequelize, DataTypes); // Incluindo o modelo Pagamento

// Define as associações entre os modelos
// Tutor - Animal (Um para Muitos)
Tutor.hasMany(Animal, { foreignKey: "tutores_id_tutores", as: "animais" });
Animal.belongsTo(Tutor, {
  foreignKey: "tutores_id_tutores",
  as: "tutor",
  onDelete: "CASCADE", // Alterado para CASCADE para ser compatível com NOT NULL no DB
});

// Especie - Animal (Um para Muitos)
Especie.hasMany(Animal, { foreignKey: "especies_id_especies", as: "animais" });
Animal.belongsTo(Especie, {
  foreignKey: "especies_id_especies",
  as: "especie",
  onDelete: "CASCADE",
});

// Animal - Consulta (Um para Muitos)
Animal.hasMany(Consulta, { foreignKey: "animais_id_animais", as: "consultas" });
Consulta.belongsTo(Animal, {
  foreignKey: "animais_id_animais",
  as: "animal",
  onDelete: "CASCADE",
});

// Veterinario - Consulta (Um para Muitos)
Veterinario.hasMany(Consulta, {
  foreignKey: "veterinarios_id_veterinarios",
  as: "consultas",
});
Consulta.belongsTo(Veterinario, {
  foreignKey: "veterinarios_id_veterinarios",
  as: "veterinario",
  onDelete: "CASCADE",
});

// Consulta - Pagamento (Um para Um)
// Uma consulta pode ter um pagamento, e um pagamento pertence a uma consulta.
Consulta.hasOne(Pagamento, {
  foreignKey: "consultas_id_consultas",
  as: "pagamento",
});
Pagamento.belongsTo(Consulta, {
  foreignKey: "consultas_id_consultas",
  as: "consulta",
  onDelete: "CASCADE",
});

// Inicializa o aplicativo Express
const app = express();
const port = process.env.PORT || 3000;
// Middlewares
app.use(cors());
app.use(express.json());

// Função para iniciar o servidor e sincronizar o banco de dados
async function startServer() {
  // Primeiro, tenta conectar ao banco de dados
  await connectDB();
  try {
    // Sincroniza os modelos com o banco de dados.
    // `alter: true` tenta fazer alterações no schema para corresponder aos modelos,
    // sem apagar dados existentes. Use com cautela em produção.
    // Se o schema já estiver criado pelo `schema.sql`, `sync()` sem opções apenas verifica.
    await sequelize.sync({ alter: true });
    console.log("Banco de dados sincronizado.");

    // Inicia o servidor Express
    app.listen(port, () => {
      console.log(`✅ Servidor rodando em http://localhost:${port}`);
    });
  } catch (error) {
    console.error("❌ Erro ao sincronizar o banco de dados:", error);
    process.exit(1); // Sai do processo se a sincronização falhar
  }
}
// Chama a função para iniciar o servidor
startServer();
