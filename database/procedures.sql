-- tarefa 1
DELIMITER $$

CREATE PROCEDURE sp_agendar_consulta (
	
    IN p_animal_id INT,
    IN p_vet_id INT,
    IN p_data_hora DATETIME,
    IN p_valor DECIMAL(10,2)
)
BEGIN
	
    DECLARE v_existe_animal INT DEFAULT NULL;
    DECLARE v_existe_veterinarios INT DEFAULT NULL;
    DECLARE v_horario_ocupado INT DEFAULT NULL;
    
    SELECT id_animais INTO v_existe_animal
    FROM animais
    WHERE id_animais = p_animal_id;

	SELECT id_veterinarios INTO v_existe_veterinarios
    FROM veterinarios
    WHERE id_veterinarios = p_vet_id;
    
    SELECT COUNT(*) INTO v_horario_ocupado
    FROM consultas
    WHERE data_hora = p_data_hora AND veterinarios_id_veterinarios = p_vet_id;

    IF (v_existe_veterinarios IS NULL) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erro: O veterinário informado não existe no sistema!';
    END IF;

    IF (v_horario_ocupado > 0) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erro: Este veterinário já possui um agendamento neste horário!';
    END IF;
    IF (v_existe_animal IS NULL) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: O animal informado não existe no sistema!';
        END IF;

    
    START TRANSACTION;
        
       
        INSERT INTO db_pet_vida.consultas(animais_id_animais, veterinarios_id_veterinarios, data_hora, valor, status)
        VALUES(p_animal_id, p_vet_id, p_data_hora, p_valor, 'agendada');
       
        INSERT INTO db_pet_vida.pagamentos(consultas_id_consultas, valor_pago, forma_pagamento, data_pagamento, status)
        VALUES (LAST_INSERT_ID(), 0.00, 'dinheiro', p_data_hora, 'pendente');

    COMMIT;

END $$

DELIMITER ;
-- Agendando para o Animal 1, Veterinário 2, numa data futura, valor 150.00
CALL sp_agendar_consulta(1, 2, '2026-06-15 10:00:00', 150.00);

-- O Animal 999 não existe na base de dados
CALL sp_agendar_consulta(999, 2, '2026-06-15 11:00:00', 150.00);

-- Vamos tentar agendar OUTRO animal (ID 2) com o MESMO veterinário (ID 2) no MESMO horário do Teste 1
CALL sp_agendar_consulta(1, 2, '2026-06-15 10:00:00', 150.00);


-- tarefa 2
DELIMITER $$

CREATE PROCEDURE sp_concluir_consulta(
	
    IN p_consulta_id INT,
    IN p_diagnostico VARCHAR(45)
    
)
BEGIN
	
    DECLARE v_consultas_id INT DEFAULT NULL;
    
    
    SELECT id_consultas INTO v_consultas_id
    FROM consultas
    WHERE id_consultas = p_consulta_id;

    IF (v_consultas_id IS NULL) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erro: A consulta informada não existe no sistema!';
    END IF;

    
    START TRANSACTION;
        
       
        UPDATE consultas
        SET 
			consultas.status= 'concluida',
            consultas.diagnostico = p_diagnostico
            WHERE id_consultas = p_consulta_id;

    COMMIT;

END $$

DELIMITER ;
-- Tentando concluir a consulta de ID 999 (que não existe na base)
CALL sp_concluir_consulta(999, 'Animal apresentou melhora clínica relevante.');

SELECT id_consultas, status, diagnostico FROM consultas WHERE id_consultas = 16;
-- Concluindo a consulta de ID 16 com o diagnóstico do médico
CALL sp_concluir_consulta(16, 'Paciente recuperado. Recomenda-se repouso.');

SELECT id_consultas, status, diagnostico FROM consultas WHERE id_consultas = 16;



-- tarefa 3
DELIMITER $$

CREATE PROCEDURE sp_registrar_pagamento(
	
    IN p_consulta_id INT,
    IN p_forma_pagamento VARCHAR(20)
    
)
BEGIN
	
    DECLARE v_pagamento_id INT DEFAULT NULL;
    DECLARE v_status_atual VARCHAR(20) DEFAULT NULL;
    
    
    SELECT id_pagamentos, status INTO v_pagamento_id, v_status_atual
    FROM pagamentos
    WHERE consultas_id_consultas = p_consulta_id;

    IF (v_pagamento_id IS NULL) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erro: O pagamentos informado não existe no sistema!';
    END IF;
    IF (v_status_atual = 'pago') THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erro: Este pagamento já foi realizado anteriormente!.';
    END IF;

    
    START TRANSACTION;
        
       
        UPDATE pagamentos
        SET 
			pagamentos.status= 'pago',
            pagamentos.forma_pagamento = p_forma_pagamento
            WHERE consultas_id_consultas = p_consulta_id;


    COMMIT;

END $$

DELIMITER ;
-- Tentando pagar uma consulta de ID 999 que não existe
CALL sp_registrar_pagamento(999, 'pix');


SELECT consultas_id_consultas, forma_pagamento, status FROM pagamentos WHERE consultas_id_consultas = 17;

-- Registrando que o tutor da consulta 17 pagou via PIX
CALL sp_registrar_pagamento(17, 'pix');

SELECT consultas_id_consultas, forma_pagamento, status FROM pagamentos WHERE consultas_id_consultas = 17;

-- tarefa 4
DELIMITER $$

CREATE PROCEDURE sp_cancelar_consulta(
	
    IN p_consulta_id INT
    
    
)
BEGIN
	
    DECLARE v_consultas_id INT DEFAULT NULL;
    
    
    SELECT id_consultas INTO v_consultas_id
    FROM consultas
    WHERE id_consultas = p_consulta_id;

    IF (v_consultas_id IS NULL) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erro: A consulta informada não existe no sistema!';
    END IF;

    
    START TRANSACTION;
        
       
        UPDATE consultas
        SET 
			consultas.status= 'cancelada'
            WHERE id_consultas = p_consulta_id;
		
        UPDATE pagamentos
        SET status = 'cancelado'
        WHERE consultas_id_consultas = p_consulta_id;

    COMMIT;

END $$

DELIMITER ;

CALL sp_cancelar_consulta(999);

SELECT id_consultas, status FROM consultas WHERE id_consultas = 18;
SELECT consultas_id_consultas, status FROM pagamentos WHERE consultas_id_consultas = 18;

CALL sp_cancelar_consulta(18);

SELECT id_consultas, status FROM consultas WHERE id_consultas = 18;
SELECT consultas_id_consultas, status FROM pagamentos WHERE consultas_id_consultas = 18;


-- tarefa 5
DELIMITER $$

CREATE PROCEDURE sp_cadastrar_animal (
	
    IN p_nome VARCHAR(50),
    IN p_especie_id INT,
    IN p_raca VARCHAR(30),
    IN p_nascimento DATE,
    IN P_tutor_id INT,
    OUT p_novo_id INT
)
BEGIN
	
    DECLARE v_existe_tutor INT DEFAULT NULL;
    DECLARE v_existe_especie INT DEFAULT NULL;
    
    
    SELECT id_tutores INTO v_existe_tutor
    FROM tutores
    WHERE id_tutores = P_tutor_id;

	SELECT id_especies INTO v_existe_especie
    FROM especies
    WHERE id_especies = p_especie_id;
    

    IF (v_existe_tutor IS NULL) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = '"Erro: O tutor informado não existe no sistema!';
    END IF;

    IF (v_existe_especie IS NULL) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erro: A espécie informada não existe no sistema!';
    END IF;

    
    START TRANSACTION;
        
       
        
        INSERT INTO animais (nome, raca, data_nascimento, tutores_id_tutores, especies_id_especies)
        VALUES (p_nome, p_raca, p_nascimento, p_tutor_id, p_especie_id);
       
        
        SET p_novo_id = LAST_INSERT_ID();
        
    COMMIT;

END $$

DELIMITER ;

-- Tenta cadastrar um pet para o tutor ID 999 que não existe
CALL sp_cadastrar_animal('Pipoca', 1, 'Poodle', '2025-01-01', 999, @id_saida);

-- O código de espécie 999 não existe no sistema
CALL sp_cadastrar_animal('Rex', 999, 'Vira-lata', '2025-06-01', 1, @id_saida);


-- Cadastra um animal associando ao Espécie 1 (Cachorro) e Tutor 1 (Ana), que já existem no seu seed
CALL sp_cadastrar_animal('Oliver', 1, 'Beagle', '2024-05-20', 1, @id_gerado);

-- Executa o SELECT para ver o ID que a Procedure te devolveu pelo parâmetro OUT
SELECT @id_gerado;
