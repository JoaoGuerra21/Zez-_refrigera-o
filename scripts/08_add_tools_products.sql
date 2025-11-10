-- Insert tools products to the existing Ferramentas category
INSERT INTO produtos (codigo, nome, descricao, categoria_id, marca, modelo, preco_custo, preco_venda, estoque_minimo, estoque_maximo, unidade_medida, garantia_meses) VALUES
-- Ferramentas
('TOOL001', 'Chave de Cano Ajustável 15"', 'Chave inglesa profissional ajustável', 8, 'Tramontina', 'EDA15', 25.00, 37.50, 8, 40, 'UN', 12),
('TOOL002', 'Jogo Chaves Philips/Fenda', 'Jogo com 6 chaves variadas', 8, 'Gedore', 'JGO6CH', 32.00, 48.00, 10, 50, 'UN', 12),
('TOOL003', 'Alicate Corte Diagonal 8"', 'Alicate para corte de fios e cabos', 8, 'Stanley', 'HC15', 18.00, 27.00, 15, 60, 'UN', 12),
('TOOL004', 'Chave Allen Hexagonal 10 Peças', 'Jogo de chaves allen de 1.5mm a 10mm', 8, 'Positivo', 'JGA10AL', 22.00, 33.00, 12, 50, 'UN', 12),
('TOOL005', 'Martelo de Borracha 500g', 'Martelo com cabeça de borracha', 8, 'Tramontina', 'MAR500', 35.00, 52.50, 6, 30, 'UN', 12),
('TOOL006', 'Chave de Fenda Isolada 1000V', 'Chave segura com isolamento até 1000V', 8, 'Tramontina', 'ISOxBASE', 28.00, 42.00, 10, 45, 'UN', 12),
('TOOL007', 'Broca Carbeto Bits 21 Peças', 'Jogo de brocas variadas para furadeira', 8, 'Bosch', 'JGB21', 45.00, 67.50, 8, 35, 'UN', 6),
('TOOL008', 'Chave Inglesa 250mm', 'Chave inglesa profissional cromada', 8, 'Gedore', 'CRO250', 42.00, 63.00, 5, 25, 'UN', 12),
('TOOL009', 'Jogo Soquete e Extensores 1/4"', 'Jogo com 22 soquetes variados', 8, 'Stanley', 'JGS22', 55.00, 82.50, 6, 25, 'UN', 12),
('TOOL010', 'Lanterna LED Recarregável 5W', 'Lanterna profissional com bateria recarregável', 8, 'Einhell', 'LED5W', 65.00, 97.50, 4, 20, 'UN', 12)
ON CONFLICT (codigo) DO NOTHING;

-- Insert initial stock for tools
INSERT INTO estoque (produto_id, quantidade_atual, localizacao, lote) 
SELECT id, 10, 'Setor G - Ferramentas', CONCAT('TOOL_LOTE_', id)
FROM produtos 
WHERE categoria_id = 8 AND codigo LIKE 'TOOL%'
ON CONFLICT (produto_id, lote) DO NOTHING;
