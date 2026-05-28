import "./style.css";

export default function Main() {
  return (
    <main className="main-servicos" id="clinica">
      <div className="servicos-header">
        <h2>Nossos Serviços</h2>
        <p>
          Oferecemos uma estrutura completa e moderna para cuidar da saúde e do
          bem-estar do seu pet em todas as fases da vida.
        </p>
      </div>

      <div className="cards-container">
        {/* Card 1 */}
        <div className="card-servico">
          <span className="icone-servico" role="img" aria-label="Estetoscópio">
            🩺
          </span>
          <h3>Consultas Gerais</h3>
          <p>
            Atendimento clínico completo para check-ups preventivos e
            diagnósticos precisos.
          </p>
        </div>

        {/* Card 2 */}
        <div className="card-servico">
          <span className="icone-servico" role="img" aria-label="Seringa">
            💉
          </span>
          <h3>Vacinação</h3>
          <p>
            Protocolos de imunização atualizados para proteger seu pet contra
            diversas doenças.
          </p>
        </div>

        {/* Card 3 */}
        <div className="card-servico">
          <span className="icone-servico" role="img" aria-label="Microscópio">
            🔬
          </span>
          <h3>Exames Laboratoriais</h3>
          <p>
            Resultados rápidos e confiáveis com nosso laboratório próprio
            integrado.
          </p>
        </div>

        {/* Card 4 */}
        <div className="card-servico">
          <span className="icone-servico" role="img" aria-label="Hospital">
            🏥
          </span>
          <h3>Centro Cirúrgico</h3>
          <p>
            Ambiente equipado e profissionais especializados para procedimentos
            seguros.
          </p>
        </div>
      </div>
    </main>
  );
}
