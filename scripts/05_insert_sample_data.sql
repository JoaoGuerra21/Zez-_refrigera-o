-- Dados de exemplo para testar o sistema
USE empresa_geladeiras;

-- Inserir categorias
INSERT INTO categorias (nome, descricao) VALUES
('Geladeiras', 'Geladeiras completas para uso doméstico e comercial'),
('Freezers', 'Freezers horizontais e verticais'),
('Peças Compressor', 'Compressores e peças relacionadas'),
('Peças Elétricas', 'Componentes elétricos e eletrônicos'),
('Peças Vedação', 'Borrachas, vedações e isolamentos'),
('Termostatos', 'Termostatos e controles de temperatura'),
('Gases Refrigerantes', 'Gases para recarga de sistemas'),
('Ferramentas', 'Ferramentas para manutenção e reparo');

-- Inserir fornecedores
INSERT INTO fornecedores (nome, cnpj, telefone, email, endereco, contato_responsavel, prazo_entrega_dias, condicoes_pagamento) VALUES
('Embraco Compressores', '12.345.678/0001-90', '(11) 3456-7890', 'vendas@embraco.com', 'Rua Industrial, 123 - São Paulo/SP', 'João Silva', 5, '30 dias'),
('Consul Peças', '23.456.789/0001-01', '(11) 2345-6789', 'pecas@consul.com.br', 'Av. Paulista, 456 - São Paulo/SP', 'Maria Santos', 7, '45 dias'),
('Brastemp Componentes', '34.567.890/0001-12', '(11) 3456-7891', 'componentes@brastemp.com', 'Rua das Máquinas, 789 - Campinas/SP', 'Pedro Costa', 3, '30 dias'),
('Metalfrio Distribuidora', '45.678.901/0001-23', '(11) 4567-8901', 'vendas@metalfrio.com', 'Av. Industrial, 321 - Guarulhos/SP', 'Ana Oliveira', 10, '60 dias'),
('Tecumseh do Brasil', '56.789.012/0001-34', '(11) 5678-9012', 'brasil@tecumseh.com', 'Rua dos Compressores, 654 - São Bernardo/SP', 'Carlos Lima', 7, '30 dias');

-- Inserir produtos
INSERT INTO produtos (codigo, nome, descricao, categoria_id, marca, modelo, preco_custo, preco_venda, estoque_minimo, estoque_maximo, unidade_medida, garantia_meses) VALUES
-- Geladeiras
('GEL001', 'Geladeira Brastemp 400L Duplex', 'Geladeira duplex frost free 400 litros', 1, 'Brastemp', 'BRM54HK', 1200.00, 1800.00, 2, 10, 'UN', 12),
('GEL002', 'Geladeira Consul 340L', 'Geladeira uma porta 340 litros', 1, 'Consul', 'CRA39AB', 900.00, 1350.00, 3, 15, 'UN', 12),
('GEL003', 'Geladeira Electrolux 310L', 'Geladeira duplex 310 litros', 1, 'Electrolux', 'DC35A', 800.00, 1200.00, 2, 12, 'UN', 12),

-- Freezers
('FRZ001', 'Freezer Horizontal 411L', 'Freezer horizontal tampa cega', 2, 'Metalfrio', 'DA420', 1100.00, 1650.00, 1, 8, 'UN', 12),
('FRZ002', 'Freezer Vertical 280L', 'Freezer vertical 4 gavetas', 2, 'Consul', 'CVU30EB', 950.00, 1425.00, 2, 10, 'UN', 12),

-- Compressores
('COMP001', 'Compressor 1/4 HP R134a', 'Compressor hermético para geladeira', 3, 'Embraco', 'EMI60HER', 180.00, 270.00, 10, 50, 'UN', 24),
('COMP002', 'Compressor 1/3 HP R600a', 'Compressor ecológico baixo consumo', 3, 'Embraco', 'EMX70CLC', 220.00, 330.00, 8, 40, 'UN', 24),
('COMP003', 'Compressor 1/2 HP R134a', 'Compressor para freezer horizontal', 3, 'Tecumseh', 'AE4440Y', 280.00, 420.00, 5, 25, 'UN', 24),

-- Peças Elétricas
('ELE001', 'Termostato Universal', 'Termostato para geladeira e freezer', 6, 'Danfoss', 'RC1075', 45.00, 67.50, 20, 100, 'UN', 6),
('ELE002', 'Timer Degelo 220V', 'Timer para degelo automático', 4, 'Brastemp', 'W10393157', 35.00, 52.50, 15, 80, 'UN', 6),
('ELE003', 'Resistência Degelo 110V', 'Resistência para degelo do evaporador', 4, 'Consul', 'W10178766', 25.00, 37.50, 25, 120, 'UN', 3),

-- Vedações
('VED001', 'Borracha Porta Geladeira Brastemp', 'Vedação porta geladeira duplex', 5, 'Brastemp', 'W10163975', 80.00, 120.00, 10, 50, 'UN', 3),
('VED002', 'Borracha Freezer Consul', 'Vedação porta freezer vertical', 5, 'Consul', 'W10393158', 65.00, 97.50, 12, 60, 'UN', 3),

-- Gases
('GAS001', 'Gás R134a 13,6kg', 'Gás refrigerante R134a cilindro', 7, 'DuPont', 'R134A-13.6', 450.00, 675.00, 2, 10, 'UN', 0),
('GAS002', 'Gás R600a 6,5kg', 'Gás refrigerante ecológico', 7, 'Honeywell', 'R600A-6.5', 380.00, 570.00, 3, 15, 'UN', 0);

-- Inserir estoque inicial
INSERT INTO estoque (produto_id, quantidade_atual, localizacao, lote) VALUES
(1, 5, 'Setor A - Prateleira 1', 'LOTE001'),
(2, 8, 'Setor A - Prateleira 2', 'LOTE002'),
(3, 6, 'Setor A - Prateleira 3', 'LOTE003'),
(4, 3, 'Setor B - Área 1', 'LOTE004'),
(5, 4, 'Setor B - Área 2', 'LOTE005'),
(6, 25, 'Setor C - Gaveta 1', 'LOTE006'),
(7, 18, 'Setor C - Gaveta 2', 'LOTE007'),
(8, 12, 'Setor C - Gaveta 3', 'LOTE008'),
(9, 45, 'Setor D - Prateleira 1', 'LOTE009'),
(10, 32, 'Setor D - Prateleira 2', 'LOTE010'),
(11, 28, 'Setor D - Prateleira 3', 'LOTE011'),
(12, 35, 'Setor E - Prateleira 1', 'LOTE012'),
(13, 22, 'Setor E - Prateleira 2', 'LOTE013'),
(14, 8, 'Setor F - Área Especial', 'LOTE014'),
(15, 12, 'Setor F - Área Especial', 'LOTE015');

-- Inserir algumas compras de exemplo
INSERT INTO compras (numero_pedido, fornecedor_id, data_pedido, data_entrega_prevista, status, valor_total, valor_final, forma_pagamento) VALUES
('PED001', 1, '2024-01-15', '2024-01-20', 'ENTREGUE', 2200.00, 2200.00, 'Boleto 30 dias'),
('PED002', 2, '2024-01-20', '2024-01-27', 'ENTREGUE', 1800.00, 1800.00, 'Cartão'),
('PED003', 3, '2024-02-01', '2024-02-04', 'ENTREGUE', 3500.00, 3500.00, 'Transferência');

-- Inserir itens das compras
INSERT INTO itens_compra (compra_id, produto_id, quantidade, preco_unitario, valor_total, lote) VALUES
(1, 6, 10, 180.00, 1800.00, 'LOTE006'),
(1, 7, 2, 220.00, 440.00, 'LOTE007'),
(2, 9, 20, 45.00, 900.00, 'LOTE009'),
(2, 10, 15, 35.00, 525.00, 'LOTE010'),
(2, 11, 15, 25.00, 375.00, 'LOTE011'),
(3, 1, 2, 1200.00, 2400.00, 'LOTE001'),
(3, 2, 3, 900.00, 2700.00, 'LOTE002');
