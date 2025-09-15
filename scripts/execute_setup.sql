-- Executando configuração completa do banco de dados
-- Este script será executado automaticamente

-- Primeiro, criar as tabelas
-- Tabela de categorias de produtos
CREATE TABLE IF NOT EXISTS categorias (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de fornecedores
CREATE TABLE IF NOT EXISTS fornecedores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cnpj VARCHAR(18) UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco TEXT,
    contato_responsavel VARCHAR(100),
    prazo_entrega_dias INTEGER DEFAULT 7,
    condicoes_pagamento VARCHAR(100),
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de produtos
CREATE TABLE IF NOT EXISTS produtos (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(50) UNIQUE NOT NULL,
    nome VARCHAR(200) NOT NULL,
    descricao TEXT,
    categoria_id INTEGER,
    marca VARCHAR(100),
    modelo VARCHAR(100),
    preco_custo DECIMAL(10,2),
    preco_venda DECIMAL(10,2),
    margem_lucro DECIMAL(5,2),
    estoque_minimo INTEGER DEFAULT 0,
    estoque_maximo INTEGER DEFAULT 100,
    unidade_medida VARCHAR(20) DEFAULT 'UN',
    peso DECIMAL(8,2),
    dimensoes VARCHAR(100),
    garantia_meses INTEGER,
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- Tabela de estoque atual
CREATE TABLE IF NOT EXISTS estoque (
    id SERIAL PRIMARY KEY,
    produto_id INTEGER NOT NULL,
    quantidade_atual INTEGER DEFAULT 0,
    quantidade_reservada INTEGER DEFAULT 0,
    localizacao VARCHAR(100),
    lote VARCHAR(50),
    data_validade DATE,
    ultima_movimentacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (produto_id) REFERENCES produtos(id),
    UNIQUE (produto_id, lote)
);

-- Tipos ENUM
DO $$ BEGIN
    CREATE TYPE tipo_movimentacao AS ENUM ('ENTRADA', 'SAIDA', 'AJUSTE', 'TRANSFERENCIA');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
    CREATE TYPE status_compra AS ENUM ('PENDENTE', 'CONFIRMADO', 'ENTREGUE', 'CANCELADO');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
    CREATE TYPE status_venda AS ENUM ('PENDENTE', 'CONFIRMADO', 'ENTREGUE', 'CANCELADO');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- Tabela de movimentações de estoque
CREATE TABLE IF NOT EXISTS movimentacoes_estoque (
    id SERIAL PRIMARY KEY,
    produto_id INTEGER NOT NULL,
    tipo_movimentacao tipo_movimentacao NOT NULL,
    quantidade INTEGER NOT NULL,
    quantidade_anterior INTEGER,
    quantidade_atual INTEGER,
    preco_unitario DECIMAL(10,2),
    valor_total DECIMAL(12,2),
    motivo VARCHAR(200),
    documento VARCHAR(100),
    lote VARCHAR(50),
    usuario VARCHAR(100),
    observacoes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- Tabela de compras
CREATE TABLE IF NOT EXISTS compras (
    id SERIAL PRIMARY KEY,
    numero_pedido VARCHAR(50) UNIQUE,
    fornecedor_id INTEGER NOT NULL,
    data_pedido DATE NOT NULL,
    data_entrega_prevista DATE,
    data_entrega_real DATE,
    status status_compra DEFAULT 'PENDENTE',
    valor_total DECIMAL(12,2),
    desconto DECIMAL(10,2) DEFAULT 0,
    frete DECIMAL(10,2) DEFAULT 0,
    valor_final DECIMAL(12,2),
    forma_pagamento VARCHAR(100),
    observacoes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (fornecedor_id) REFERENCES fornecedores(id)
);

-- Tabela de itens da compra
CREATE TABLE IF NOT EXISTS itens_compra (
    id SERIAL PRIMARY KEY,
    compra_id INTEGER NOT NULL,
    produto_id INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    valor_total DECIMAL(12,2) NOT NULL,
    lote VARCHAR(50),
    data_validade DATE,
    FOREIGN KEY (compra_id) REFERENCES compras(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- Tabela de vendas
CREATE TABLE IF NOT EXISTS vendas (
    id SERIAL PRIMARY KEY,
    numero_venda VARCHAR(50) UNIQUE,
    cliente_nome VARCHAR(150),
    cliente_documento VARCHAR(20),
    cliente_telefone VARCHAR(20),
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(12,2),
    desconto DECIMAL(10,2) DEFAULT 0,
    valor_final DECIMAL(12,2),
    forma_pagamento VARCHAR(100),
    status status_venda DEFAULT 'CONFIRMADO',
    observacoes TEXT
);

-- Tabela de itens da venda
CREATE TABLE IF NOT EXISTS itens_venda (
    id SERIAL PRIMARY KEY,
    venda_id INTEGER NOT NULL,
    produto_id INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    valor_total DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (venda_id) REFERENCES vendas(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- Inserir dados de exemplo
INSERT INTO categorias (nome, descricao) VALUES 
('Geladeiras', 'Geladeiras e refrigeradores completos'),
('Freezers', 'Freezers e congeladores'),
('Peças Elétricas', 'Componentes elétricos para refrigeração'),
('Peças Mecânicas', 'Componentes mecânicos e estruturais'),
('Acessórios', 'Acessórios e complementos')
ON CONFLICT DO NOTHING;

INSERT INTO fornecedores (nome, cnpj, telefone, email, endereco, contato_responsavel, prazo_entrega_dias, condicoes_pagamento) VALUES 
('Brastemp Fornecedor', '12.345.678/0001-90', '(11) 1234-5678', 'vendas@brastemp.com.br', 'São Paulo, SP', 'João Silva', 15, '30 dias'),
('Consul Distribuidora', '98.765.432/0001-10', '(11) 8765-4321', 'pedidos@consul.com.br', 'Curitiba, PR', 'Maria Santos', 10, '45 dias'),
('Peças Refrigeração Ltda', '11.222.333/0001-44', '(11) 2222-3333', 'contato@pecasrefri.com.br', 'Rio de Janeiro, RJ', 'Carlos Oliveira', 7, '15 dias')
ON CONFLICT DO NOTHING;

INSERT INTO produtos (codigo, nome, descricao, categoria_id, marca, modelo, preco_custo, preco_venda, margem_lucro, estoque_minimo, estoque_maximo) VALUES 
('GEL001', 'Geladeira Brastemp 400L', 'Geladeira duplex frost free 400 litros', 1, 'Brastemp', 'BRM54HK', 1200.00, 1800.00, 50.00, 2, 10),
('FRZ001', 'Freezer Consul 280L', 'Freezer horizontal 280 litros', 2, 'Consul', 'CHB28EB', 800.00, 1200.00, 50.00, 1, 5),
('PEC001', 'Compressor 1/4 HP', 'Compressor para geladeira residencial', 3, 'Embraco', 'EMI60HER', 150.00, 250.00, 66.67, 5, 20),
('PEC002', 'Termostato Universal', 'Termostato para controle de temperatura', 3, 'Danfoss', 'RC1300', 45.00, 80.00, 77.78, 10, 50),
('ACC001', 'Prateleira Vidro', 'Prateleira de vidro temperado 45cm', 5, 'Universal', 'PV45', 25.00, 45.00, 80.00, 20, 100)
ON CONFLICT DO NOTHING;

INSERT INTO estoque (produto_id, quantidade_atual, localizacao, lote) VALUES 
(1, 5, 'Setor A - Prateleira 1', 'LOTE001'),
(2, 3, 'Setor A - Prateleira 2', 'LOTE002'),
(3, 15, 'Setor B - Gaveta 1', 'LOTE003'),
(4, 25, 'Setor B - Gaveta 2', 'LOTE004'),
(5, 50, 'Setor C - Estante 1', 'LOTE005')
ON CONFLICT DO NOTHING;
