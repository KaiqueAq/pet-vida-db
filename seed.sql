

-- 1. Seed: 5 Espécies
INSERT INTO `especies` (`id_especies`, `nome`) VALUES
(1, 'Cachorro'), (2, 'Gato'), (3, 'Pássaro'), (4, 'Peixe'), (5, 'Réptil');

-- 2. Seed: 3 Veterinários
INSERT INTO `veterinarios` (`id_veterinarios`, `nome`, `crmv`, `especialidade`) VALUES
(1, 'Dr. Carlos Silva', 'CRMV-SP1234', 'Clínica Geral'),
(2, 'Dra. Juliana Mendes', 'CRMV-SP5678', 'Felinos'),
(3, 'Dr. Roberto Souza', 'CRMV-SP9012', 'Animais Silvestres');

-- 3. Seed: 8 Tutores
INSERT INTO `tutores` (`id_tutores`, `nome`, `cpf`, `email`) VALUES
(1, 'Ana Oliveira', '111.111.111-11', 'ana@email.com'),
(2, 'Bruno Santos', '222.222.222-22', 'bruno@email.com'),
(3, 'Carla Souza', '333.333.333-33', 'carla@email.com'),
(4, 'Diego Lima', '444.444.444-44', 'diego@email.com'),
(5, 'Elena Ribeiro', '555.555.555-55', 'elena@email.com'),
(6, 'Fábio Costa', '666.666.666-66', 'fabio@email.com'),
(7, 'Gisele Almeida', '777.777.777-77', 'gisele@email.com'),
(8, 'Hugo Pereira', '888.888.888-88', 'hugo@email.com');

-- 4. Seed: 15 Animais
INSERT INTO `animais` (`id_animais`, `nome`, `raca`, `tutores_id_tutores`, `especies_id_especies`) VALUES
(1, 'Rex', 'Vira-lata', 1, 1), (2, 'Mia', 'Siamês', 1, 2), (3, 'Thor', 'Pitbull', 2, 1),
(4, 'Loki', 'Persa', 3, 2), (5, 'Mel', 'Poodle', 4, 1), (6, 'Pipoca', 'Calopsita', 4, 3),
(7, 'Nemo', 'Palhaço', 5, 4), (8, 'Fred', 'Iguana', 6, 5), (9, 'Luna', 'Husky', 7, 1),
(10, 'Simba', 'Angorá', 8, 2), (11, 'Max', 'Boxer', 2, 1), (12, 'Bela', 'Golden', 3, 1),
(13, 'Chico', 'Papagaio', 5, 3), (14, 'Bubbles', 'Goldfish', 6, 4), (15, 'Ziggy', 'Gecko', 7, 5);

-- 5. Seed: 20 Consultas
INSERT INTO `consultas` (`id_consultas`, `animais_id_animais`, `veterinarios_id_veterinarios`, `data_hora`, `status`, `valor`) VALUES
(1, 1, 1, '2026-05-01 09:00:00', 'concluida', 150.00), (2, 2, 2, '2026-05-01 10:00:00', 'concluida', 180.00),
(3, 3, 1, '2026-05-02 14:00:00', 'concluida', 150.00), (4, 4, 2, '2026-05-03 11:00:00', 'concluida', 180.00),
(5, 5, 1, '2026-05-04 16:00:00', 'concluida', 150.00), (6, 6, 3, '2026-05-05 09:30:00', 'concluida', 200.00),
(7, 7, 3, '2026-05-06 13:00:00', 'concluida', 200.00), (8, 8, 3, '2026-05-07 15:00:00', 'concluida', 250.00),
(9, 9, 1, '2026-05-08 10:00:00', 'concluida', 150.00), (10, 10, 2, '2026-05-09 11:00:00', 'concluida', 180.00),
(11, 11, 1, '2026-05-10 14:00:00', 'cancelada', 150.00), (12, 12, 1, '2026-05-11 09:00:00', 'concluida', 150.00),
(13, 13, 3, '2026-05-12 10:30:00', 'concluida', 200.00), (14, 14, 3, '2026-05-13 14:00:00', 'concluida', 200.00),
(15, 15, 3, '2026-05-14 16:00:00', 'concluida', 250.00), (16, 1, 1, '2026-05-21 09:00:00', 'agendada', 150.00),
(17, 2, 2, '2026-05-21 14:00:00', 'agendada', 180.00), (18, 3, 1, '2026-05-22 10:00:00', 'agendada', 150.00),
(19, 4, 2, '2026-05-22 15:00:00', 'agendada', 180.00), (20, 5, 1, '2026-05-23 09:00:00', 'agendada', 150.00);

-- 6. Seed: 20 Pagamentos 
INSERT INTO `pagamentos` (`id_pagamentos`, `consultas_id_consultas`, `valor_pago`, `forma_pagamento`, `data_pagamento`, `status`) VALUES
(1, 1, 150.00, 'pix', '2026-05-01 09:30:00', 'pago'), (2, 2, 180.00, 'cartao', '2026-05-01 10:45:00', 'pago'),
(3, 3, 150.00, 'dinheiro', '2026-05-02 14:30:00', 'pago'), (4, 4, 180.00, 'convênio', '2026-05-03 11:15:00', 'pago'),
(5, 5, 150.00, 'pix', '2026-05-04 16:20:00', 'pago'), (6, 6, 200.00, 'cartao', '2026-05-05 10:10:00', 'pago'),
(7, 7, 200.00, 'pix', '2026-05-06 13:40:00', 'pago'), (8, 8, 250.00, 'cartao', '2026-05-07 15:55:00', 'pago'),
(9, 9, 150.00, 'dinheiro', '2026-05-08 10:20:00', 'pago'), (10, 10, 180.00, 'pix', '2026-05-09 11:30:00', 'pago'),
(11, 11, 0.00, 'pix', '2026-05-10 14:00:00', 'cancelado'), (12, 12, 150.00, 'convênio', '2026-05-11 09:40:00', 'pago'),
(13, 13, 200.00, 'cartao', '2026-05-12 11:00:00', 'pago'), (14, 14, 200.00, 'pix', '2026-05-13 14:30:00', 'pago'),
(15, 15, 250.00, 'dinheiro', '2026-05-14 16:45:00', 'pago'), (16, 16, 150.00, 'pix', '2026-05-20 23:00:00', 'pendente'),
(17, 17, 180.00, 'cartao', '2026-05-20 23:00:00', 'pendente'), (18, 18, 150.00, 'pix', '2026-05-20 23:00:00', 'pendente'),
(19, 19, 180.00, 'convênio', '2026-05-20 23:00:00', 'pendente'), (20, 20, 150.00, 'dinheiro', '2026-05-20 23:00:00', 'pendente');
