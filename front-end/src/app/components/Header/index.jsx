import "./style.css";

export default function Header() {
  return (
    <header className="header-veterinaria">
      {/* Área reservada para o nome ou logo da clínica */}
      <div className="logo-clinica">
        <h2 className="nome-clinica">Pet-Vida</h2>
      </div>

      {/* Navegação principal */}
      <nav className="nav-menu">
        <a href="#inicio">Início</a>
        <a href="#sobre">Sobre</a>
        <a href="#clinica">Clínica</a>
        <a href="#contato">Contato</a>
      </nav>
    </header>
  );
}
