
-- 1) Ranking de tutores que mais gastam
SELECT 
    ROW_NUMBER() OVER (ORDER BY SUM(pagamentos.valor_pago) DESC) AS posicao,
    tutores.nome AS nome_tutor,
    SUM(pagamentos.valor_pago) AS total_gasto,
    COUNT(DISTINCT consultas.id_consultas) AS qtd_consultas
FROM tutores
INNER JOIN animais ON animais.tutores_id_tutores = tutores.id_tutores
INNER JOIN consultas ON consultas.animais_id_animais = animais.id_animais
INNER JOIN pagamentos ON pagamentos.consultas_id_consultas = consultas.id_consultas
WHERE pagamentos.status = 'pago'
GROUP BY tutores.id_tutores, tutores.nome
ORDER BY total_gasto DESC;


-- 2) Faturamento mensal
SELECT 
    YEAR(consultas.data_hora) AS ano,
    MONTH(consultas.data_hora) AS mes,
    COUNT(consultas.id_consultas) AS total_consultas,
    SUM(consultas.valor) AS bruto,
    SUM(CASE WHEN pagamentos.status = 'pago' THEN pagamentos.valor_pago ELSE 0 END) AS recebido,
    SUM(CASE WHEN pagamentos.status = 'pendente' THEN pagamentos.valor_pago ELSE 0 END) AS pendente
FROM consultas
LEFT JOIN pagamentos ON consultas.id_consultas = pagamentos.consultas_id_consultas
WHERE consultas.status <> 'cancelada'
GROUP BY YEAR(consultas.data_hora), MONTH(consultas.data_hora)
ORDER BY ano ASC, mes ASC;


-- 3) Animais sem consulta há 6+ meses (Ajustado para dezembro/2026 para fins de teste do Seed)
SELECT 
    animais.nome AS nome_animal,
    MAX(consultas.data_hora) AS data_ultima_consulta 
FROM animais 
LEFT JOIN consultas ON animais.id_animais = consultas.animais_id_animais
GROUP BY animais.id_animais, animais.nome
HAVING DATEDIFF('2026-12-01', MAX(consultas.data_hora)) >= 180 
    OR MAX(consultas.data_hora) IS NULL
ORDER BY data_ultima_consulta DESC;


-- 4) Dashboard financeiro
SELECT 
    COUNT(consultas.id_consultas) AS total_consultas,
    SUM(consultas.valor) AS bruto,
    SUM(CASE WHEN pagamentos.status = 'pago' THEN pagamentos.valor_pago ELSE 0 END) AS recebido,
    SUM(CASE WHEN pagamentos.status = 'pendente' THEN pagamentos.valor_pago ELSE 0 END) AS pendente,
    (SUM(CASE WHEN pagamentos.status = 'pendente' THEN pagamentos.valor_pago ELSE 0 END) / SUM(consultas.valor)) * 100 AS percentual_inadimplencia
FROM consultas
LEFT JOIN pagamentos ON consultas.id_consultas = pagamentos.consultas_id_consultas
WHERE consultas.status <> 'cancelada';


-- 5) Veterinário do mês
SELECT 
    veterinarios.nome AS nome_veterinario,
    SUM(pagamentos.valor_pago) AS faturamento_total
FROM veterinarios
INNER JOIN consultas ON veterinarios.id_veterinarios = consultas.veterinarios_id_veterinarios
INNER JOIN pagamentos ON consultas.id_consultas = pagamentos.consultas_id_consultas
WHERE consultas.status = 'concluida'
  AND pagamentos.status = 'pago'
  AND YEAR(consultas.data_hora) = 2026
  AND MONTH(consultas.data_hora) = 5
GROUP BY veterinarios.id_veterinarios, veterinarios.nome
ORDER BY faturamento_total DESC
LIMIT 1;

-- 6) Distribuição por espécie 
SELECT 
    especies.nome AS nome_especie,
    COUNT(animais.id_animais) AS total_animais,
    ROUND((COUNT(animais.id_animais) / (SELECT COUNT(*) FROM animais)) * 100, 2) AS percentual
FROM especies
LEFT JOIN animais ON especies.id_especies = animais.especies_id_especies
GROUP BY especies.id_especies, especies.nome
ORDER BY total_animais DESC;
