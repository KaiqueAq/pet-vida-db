--Criar tabela
CREATE TABLE IF NOT EXISTS log_auditoria (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    tabela_afetada VARCHAR(50) NOT NULL,
    acao VARCHAR(20) NOT NULL,
    registro_id INT NOT NULL,
    detalhes VARCHAR(255) NOT NULL,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
) 



--tarefa 1
DELIMITER $$

CREATE TRIGGER trg_after_insert_consulta
AFTER INSERT ON consultas
FOR EACH ROW
BEGIN
    
    INSERT INTO log_auditoria (tabela_afetada, acao, registro_id, detalhes)
	VALUES ('consultas', 'INSERT', NEW.id_consultas, 'Nova consulta agendada');
  
END$$

DELIMITER ;


-- 1. Comando que ativa a trigger
INSERT INTO consultas (animais_id_animais, veterinarios_id_veterinarios, data_hora, status, valor) 
VALUES (1, 1, '2026-09-01 10:00:00', 'agendada', 150.00);

-- 2. Comando para ver o resultado (Tire o print aqui)
SELECT * FROM log_auditoria WHERE tabela_afetada = 'consultas' AND acao = 'INSERT';



--tarefa 2
DELIMITER $$

CREATE TRIGGER trg_after_update_consulta_status	
AFTER UPDATE ON consultas 
FOR EACH ROW
BEGIN
    
    IF OLD.status <> NEW.status THEN
        INSERT INTO log_auditoria (tabela_afetada, acao, registro_id, detalhes)
        VALUES ('consultas', 'UPDATE', NEW.id_consultas, CONCAT('Status alterado de ', OLD.status, ' para ', NEW.status));
    END IF;

END$$

DELIMITER ;

-- 1. Comando que ativa a trigger (atualiza a consulta que criamos no teste anterior)
UPDATE consultas SET status = 'em_atendimento' WHERE id_consultas = LAST_INSERT_ID();

-- 2. Comando para ver o resultado (Tire o print aqui)
SELECT * FROM log_auditoria WHERE tabela_afetada = 'consultas' AND acao = 'UPDATE';



--tarefa 3
DELIMITER $$

CREATE TRIGGER trg_before_delete_consulta
BEFORE DELETE ON consultas
FOR EACH ROW
BEGIN
    DECLARE v_pago INT DEFAULT 0;
    
    SELECT COUNT(*) INTO v_pago 
    FROM pagamentos
    WHERE consultas_id_consultas = OLD.id_consultas AND status = 'pago';
    
    IF v_pago > 0 THEN -- Corrigido de iv_pago para v_pago
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Nao eh possivel excluir uma consulta cujo pagamento ja foi realizado';
    END IF;
       
END$$

DELIMITER ;

-- 1. Comando que ativa a trigger (A consulta ID 1 do seu seed já está paga)
DELETE FROM consultas WHERE id_consultas = 1;

-- Nota para o print: O comando vai falhar de propósito. 
-- Tire o print da mensagem de erro vermelha que aparecer na barra inferior (Output) do seu Workbench.



--tarefa 4
DELIMITER $$

CREATE TRIGGER trg_after_insert_animal
AFTER INSERT ON animais
FOR EACH ROW
BEGIN
     INSERT INTO log_auditoria (tabela_afetada, acao, registro_id, detalhes)
	 VALUES ('animais', 'INSERT', NEW.id_animais,  CONCAT('Novo animal cadastrado: ', NEW.nome));
END$$

DELIMITER ;

-- 1. Comando que ativa a trigger
INSERT INTO animais (nome, raca, data_nascimento, tutores_id_tutores, especies_id_especies) 
VALUES ('Bidu', 'Schnauzer', '2025-08-10', 1, 1);

-- 2. Comando para ver o resultado (Tire o print aqui)
SELECT * FROM log_auditoria WHERE tabela_afetada = 'animais' AND acao = 'INSERT';



--tarefa 5
DELIMITER $$

CREATE TRIGGER trg_before_update_pagamento
BEFORE UPDATE ON pagamentos
FOR EACH ROW
BEGIN
    
    IF NEW.status = 'pago' AND OLD.status <> 'pago' THEN
	SET NEW.data_pagamento = NOW();

	END IF;
END$$

DELIMITER ;

-- 1. Comando que ativa a trigger (A consulta ID 16 do seu seed original está como 'pendente')
UPDATE pagamentos SET status = 'pago' WHERE consultas_id_consultas = 16;

-- 2. Comando para ver o resultado (Tire o print aqui para mostrar a data preenchida sozinha)
SELECT consultas_id_consultas, status, data_pagamento 
FROM pagamentos 
WHERE consultas_id_consultas = 16;
