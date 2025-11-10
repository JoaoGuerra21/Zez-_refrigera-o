-- Insert additional tools products for expanded inventory
INSERT INTO produtos (codigo, nome, descricao, categoria_id, marca, modelo, preco_custo, preco_venda, estoque_minimo, estoque_maximo, unidade_medida, garantia_meses) VALUES
-- Ferramentas Especializadas para Refrigeração
('TOOL011', 'Chave Sextavada Refrigeração 5/16"', 'Chave específica para conexões de refrigeração', 8, 'Tramontina', 'REF5-16', 38.00, 57.00, 7, 30, 'UN', 12),
('TOOL012', 'Jogo Chaves Sextavadas 11-32mm', 'Jogo completo de chaves sextavadas cromadas', 8, 'Gedore', 'JGS32', 85.00, 127.50, 4, 15, 'UN', 12),
('TOOL013', 'Chave de Tubo 7-19mm', 'Chave de tubo profissional para serviços', 8, 'Stanley', 'CT7-19', 48.00, 72.00, 6, 25, 'UN', 12),
('TOOL014', 'Chave Dinamométrica 0-150Nm', 'Chave para torque preciso de conexões', 8, 'Tramontina', 'DIN150', 120.00, 180.00, 2, 8, 'UN', 24),
('TOOL015', 'Compressor Ar Manual 300cc', 'Soprador de ar comprimido para limpeza', 8, 'Einhell', 'AR300', 95.00, 142.50, 3, 15, 'UN', 12),

-- Ferramentas de Medição
('TOOL016', 'Multímetro Digital Profissional', 'Multímetro com sonda e bateria', 8, 'Fluke', 'MUL110', 185.00, 277.50, 2, 10, 'UN', 12),
('TOOL017', 'Termômetro Infravermelho -40°C a 250°C', 'Medidor de temperatura sem contato', 8, 'Extech', 'TERMO-IRG', 155.00, 232.50, 2, 10, 'UN', 12),
('TOOL018', 'Manômetro Analógico 0-400 PSI', 'Manômetro de alta precisão com escala dupla', 8, 'Ashcroft', 'MAN400', 95.00, 142.50, 3, 12, 'UN', 12),
('TOOL019', 'Detector de Vazamento Ultrassônico', 'Detector profissional de vazamentos refrigerante', 8, 'Testo', 'DETEC-US', 225.00, 337.50, 1, 5, 'UN', 24),
('TOOL020', 'Manômetro Digital 0-600 PSI', 'Manômetro digital com display LCD', 8, 'Digital Gauge', 'MAN-DIG', 165.00, 247.50, 2, 8, 'UN', 12),

-- Ferramentas de Proteção e Segurança
('TOOL021', 'Óculos de Segurança Profissional', 'Óculos anti-impacto com proteção UV', 8, '3M', 'OC-SAFE', 35.00, 52.50, 20, 100, 'UN', 6),
('TOOL022', 'Luvas Proteção Nitrílica Tamanho G', 'Caixa com 100 unidades - tamanho grande', 8, 'Supermax', 'LUVA-GG', 28.00, 42.00, 15, 60, 'CX', 0),
('TOOL023', 'Capacete de Segurança Branco', 'Capacete com proteção frontal completa', 8, 'Protektor', 'CAP-SEG', 42.00, 63.00, 8, 40, 'UN', 12),
('TOOL024', 'Luva de Couro Reforçada', 'Luva profissional para proteção ao soldar/cortar', 8, 'Carbografite', 'LUVA-CR', 38.00, 57.00, 10, 50, 'PAR', 6),
('TOOL025', 'Máscara Descartável PFF2', 'Caixa com 50 máscaras de proteção respiratória', 8, '3M', 'MAS-PFF2', 48.00, 72.00, 10, 40, 'CX', 0),

-- Ferramentas de Limpeza e Manutenção
('TOOL026', 'Escova de Aço Inox 25mm', 'Escova de aço para limpeza de superfícies', 8, 'Brasfort', 'ESC-AISO', 22.00, 33.00, 12, 50, 'UN', 6),
('TOOL027', 'Desoxidante Spray 300ml', 'Produto para limpeza e desoxidação', 8, 'WD-40', 'WD40-300', 18.00, 27.00, 20, 100, 'UN', 0),
('TOOL028', 'Pano de Microfibra Profissional', 'Pano antirriscos para limpeza de circuitos', 8, 'Ziplock', 'PANO-MF', 12.00, 18.00, 30, 150, 'UN', 0),
('TOOL029', 'Escada Alumínio 3 Degraus', 'Escada profissional para acesso em altura', 8, 'Alulev', 'ESC-3D', 145.00, 217.50, 2, 8, 'UN', 24),
('TOOL030', 'Jogo Chaves Cano 2 Peças (17/19)', 'Jogo de chaves de cano cromadas', 8, 'Tramontina', 'JGO-CAN', 52.00, 78.00, 6, 25, 'UN', 12);

-- Insert initial stock for new tools
INSERT INTO estoque (produto_id, quantidade_atual, localizacao, lote) 
SELECT id, CASE 
  WHEN codigo IN ('TOOL016', 'TOOL017', 'TOOL019') THEN 3
  WHEN codigo IN ('TOOL014', 'TOOL018', 'TOOL020') THEN 5
  WHEN codigo IN ('TOOL021', 'TOOL022', 'TOOL025', 'TOOL027', 'TOOL028') THEN 30
  ELSE 8
END, 'Setor G - Ferramentas', CONCAT('TOOL_LOTE_', id)
FROM produtos 
WHERE categoria_id = 8 AND codigo >= 'TOOL011'
ON CONFLICT (produto_id, lote) DO NOTHING;
