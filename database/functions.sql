-- tarefa 1

DELIMITER $$

CREATE FUNCTION fn_idade_animal (data_nascimento DATE) 
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE v_anos INT;
    DECLARE v_meses INT;
    DECLARE v_resultado VARCHAR(50);
    
    IF data_nascimento IS NULL OR data_nascimento > CURDATE() THEN
        RETURN '0 anos e 0 meses';
    END IF;
    
    SET v_anos = TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE());
    SET v_meses = TIMESTAMPDIFF(MONTH, data_nascimento, CURDATE()) - (v_anos * 12);
    SET v_resultado = CONCAT(v_anos, ' anos e ', v_meses, ' meses');
    
    RETURN v_resultado;
END $$
  DELIMITER ;

SELECT nome, data_nascimento, fn_idade_animal(data_nascimento) AS idade_amigavel 
FROM animais;

  DELIMITER $$
  -- tarefa 2

CREATE FUNCTION fn_total_gasto_tutor (tutor_id INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_total DECIMAL(10,2) DEFAULT 0.00;
    
    SELECT IFNULL(SUM(c.valor), 0.00) INTO v_total
    FROM consultas c
    JOIN animais a ON c.animais_id_animais = a.id_animais
    WHERE a.tutores_id_tutores = tutor_id 
      AND c.status <> 'cancelada';
      
    RETURN v_total;
END $$
DELIMITER ;

SELECT id_tutores, nome, cpf, fn_total_gasto_tutor(id_tutores) AS total_gasto_acumulado 
FROM tutores;
  
DELIMITER $$
  -- tarefa 3

CREATE FUNCTION fn_qtd_consultas_animal (animal_id INT) 
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_qtd INT DEFAULT 0;
    
    SELECT COUNT(*) INTO v_qtd
    FROM consultas
    WHERE animais_id_animais = animal_id;
    
    RETURN v_qtd;
END $$
DELIMITER ;

SELECT id_animais, nome, raca, fn_qtd_consultas_animal(id_animais) AS total_de_consultas 
FROM animais;


  DELIMITER $$

  -- tarefa 4

DROP FUNCTION IF EXISTS fn_status_emoji $$
CREATE FUNCTION fn_status_emoji (status_consulta VARCHAR(20)) 
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE v_status_visual VARCHAR(50);
    
    -- Tradução do status textual ENUM para formato legível com Emoji descritivo
    CASE status_consulta
        WHEN 'agendada' THEN SET v_status_visual = '📅 Agendada';
        WHEN 'em_atendimento' THEN SET v_status_visual = '🏥 Em Atendimento';
        WHEN 'concluida' THEN SET v_status_visual = '✅ Concluída';
        WHEN 'cancelada' THEN SET v_status_visual = '❌ Cancelada';
        ELSE SET v_status_visual = '❓ Desconhecido';
    END CASE;
    
    RETURN v_status_visual;
END $$

DELIMITER ;

SELECT 
    id_consultas, 
    data_hora, 
    status,
    fn_status_emoji(status) AS status_formatado, 
    valor,
    fn_classificar_valor(valor) AS classificacao_preco
FROM consultas;

DELIMITER ;

DELIMITER $$
  -- tarefa 5
CREATE FUNCTION fn_classificar_valor (valor_consulta DECIMAL(10,2)) 
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE v_classificacao VARCHAR(50);
    
    IF valor_consulta < 100.00 THEN
        SET v_classificacao = 'Consulta Simples';
    ELSEIF valor_consulta BETWEEN 100.00 AND 300.00 THEN
        SET v_classificacao = 'Consulta Padrão';
    ELSE
        SET v_classificacao = 'Procedimento Especial';
    END IF;
    
    RETURN v_classificacao;
END $$

DELIMITER ;
