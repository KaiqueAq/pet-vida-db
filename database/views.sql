-- tarefa 1
CREATE VIEW vw_consultas_completas AS
SELECT 
consultas.data_hora,
consultas.status AS consultas_status,
consultas.diagnostico,
consultas.valor,
animais.nome AS animais_nome,
especies.nome AS especies_nome,
tutores.nome AS tutores_nome,
tutores.telefone,
veterinarios.nome AS veterinarios_nome,
veterinarios.especialidade,
pagamentos.forma_pagamento,
pagamentos.status AS pagamentos_status
FROM consultas
JOIN animais ON animais.id_animais = consultas.animais_id_animais
JOIN especies ON especies.id_especies = animais.especies_id_especies
JOIN tutores ON tutores.id_tutores = animais.tutores_id_tutores
JOIN veterinarios ON veterinarios.id_veterinarios = consultas.veterinarios_id_veterinarios
LEFT JOIN pagamentos ON consultas.id_consultas = pagamentos.consultas_id_consultas

-- tarefa 2
CREATE VIEW vw_agenda_hoje AS
SELECT 
*
FROM vw_consultas_completas
WHERE DATE(data_hora) = CURDATE()
ORDER BY data_hora ASC;

-- tarefa 3 
CREATE VIEW vw_faturamento_mensal AS
SELECT
 YEAR(data_hora) AS ano,
 MONTH(data_hora) AS mes,
 veterinarios_nome,
 COUNT(*) AS total_consultas,
 SUM(valor) AS faturamento_total
 FROM vw_consultas_completas
 GROUP BY ano, mes, veterinarios_nome;




-- tarefa 4
CREATE VIEW vw_animais_detalhados AS
SELECT
    animais.nome AS animais_nome,
    tutores.nome AS tutores_nome,
    especies.nome AS especies_nome,
    COUNT(consultas.id_consultas) AS total_consultas
FROM animais
INNER JOIN tutores ON tutores.id_tutores = animais.tutores_id_tutores
INNER JOIN especies ON especies.id_especies = animais.especies_id_especies
LEFT JOIN consultas ON consultas.animais_id_animais = animais.id_animais
GROUP BY animais.nome, tutores.nome, especies.nome;



-- tarefa 5
CREATE VIEW vw_inadimplentes AS 
SELECT  
    data_hora, 
    tutores_nome, 
    telefone, 
    forma_pagamento, 
    pagamentos_status 
FROM vw_consultas_completas 
WHERE consultas_status = 'concluida'   
AND (pagamentos_status = 'pendente' OR forma_pagamento IS NULL);
