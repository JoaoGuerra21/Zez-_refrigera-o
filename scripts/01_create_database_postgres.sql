-- Adaptando script MySQL para PostgreSQL/Supabase
-- Criação do banco de dados para empresa de geladeiras e peças

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
    quantidade_disponivel INTEGER GENERATED ALWAYS AS (quantidade_atual - quantidade_reservada) STORED,
    localizacao VARCHAR(100),
    lote VARCHAR(50),
    data_validade DATE,
    ultima_movimentacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (produto_id) REFERENCES produtos(id),
    UNIQUE (produto_id, lote)
);

-- Tipo ENUM para movimentações
CREATE TYPE tipo_movimentacao AS ENUM ('ENTRADA', 'SAIDA', 'AJUSTE', 'TRANSFERENCIA');

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

-- Tipo ENUM para status de compras
CREATE TYPE status_compra AS ENUM ('PENDENTE', 'CONFIRMADO', 'ENTREGUE', 'CANCELADO');

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

-- Tipo ENUM para status de vendas
CREATE TYPE status_venda AS ENUM ('PENDENTE', 'CONFIRMADO', 'ENTREGUE', 'CANCELADO');

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

-- Tipo ENUM para classificação de rotatividade
CREATE TYPE classificacao_rotatividade AS ENUM ('ALTA', 'MEDIA', 'BAIXA', 'SEM_MOVIMENTO');

-- Tabela de análise de rotatividade
CREATE TABLE IF NOT EXISTS analise_rotatividade (
    id SERIAL PRIMARY KEY,
    produto_id INTEGER NOT NULL,
    periodo_inicio DATE NOT NULL,
    periodo_fim DATE NOT NULL,
    quantidade_vendida INTEGER DEFAULT 0,
    quantidade_comprada INTEGER DEFAULT 0,
    estoque_medio DECIMAL(10,2),
    giro_estoque DECIMAL(8,4),
    dias_estoque DECIMAL(8,2),
    classificacao classificacao_rotatividade DEFAULT 'SEM_MOVIMENTO',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);
