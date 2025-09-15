-- Criação do banco de dados para empresa de geladeiras e peças
CREATE DATABASE IF NOT EXISTS empresa_geladeiras;
USE empresa_geladeiras;

-- Tabela de categorias de produtos
CREATE TABLE categorias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de fornecedores
CREATE TABLE fornecedores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    cnpj VARCHAR(18) UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco TEXT,
    contato_responsavel VARCHAR(100),
    prazo_entrega_dias INT DEFAULT 7,
    condicoes_pagamento VARCHAR(100),
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de produtos
CREATE TABLE produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    codigo VARCHAR(50) UNIQUE NOT NULL,
    nome VARCHAR(200) NOT NULL,
    descricao TEXT,
    categoria_id INT,
    marca VARCHAR(100),
    modelo VARCHAR(100),
    preco_custo DECIMAL(10,2),
    preco_venda DECIMAL(10,2),
    margem_lucro DECIMAL(5,2),
    estoque_minimo INT DEFAULT 0,
    estoque_maximo INT DEFAULT 100,
    unidade_medida VARCHAR(20) DEFAULT 'UN',
    peso DECIMAL(8,2),
    dimensoes VARCHAR(100),
    garantia_meses INT,
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- Tabela de estoque atual
CREATE TABLE estoque (
    id INT PRIMARY KEY AUTO_INCREMENT,
    produto_id INT NOT NULL,
    quantidade_atual INT DEFAULT 0,
    quantidade_reservada INT DEFAULT 0,
    quantidade_disponivel INT GENERATED ALWAYS AS (quantidade_atual - quantidade_reservada) STORED,
    localizacao VARCHAR(100),
    lote VARCHAR(50),
    data_validade DATE,
    ultima_movimentacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (produto_id) REFERENCES produtos(id),
    UNIQUE KEY unique_produto_lote (produto_id, lote)
);

-- Tabela de movimentações de estoque
CREATE TABLE movimentacoes_estoque (
    id INT PRIMARY KEY AUTO_INCREMENT,
    produto_id INT NOT NULL,
    tipo_movimentacao ENUM('ENTRADA', 'SAIDA', 'AJUSTE', 'TRANSFERENCIA') NOT NULL,
    quantidade INT NOT NULL,
    quantidade_anterior INT,
    quantidade_atual INT,
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
CREATE TABLE compras (
    id INT PRIMARY KEY AUTO_INCREMENT,
    numero_pedido VARCHAR(50) UNIQUE,
    fornecedor_id INT NOT NULL,
    data_pedido DATE NOT NULL,
    data_entrega_prevista DATE,
    data_entrega_real DATE,
    status ENUM('PENDENTE', 'CONFIRMADO', 'ENTREGUE', 'CANCELADO') DEFAULT 'PENDENTE',
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
CREATE TABLE itens_compra (
    id INT PRIMARY KEY AUTO_INCREMENT,
    compra_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    valor_total DECIMAL(12,2) NOT NULL,
    lote VARCHAR(50),
    data_validade DATE,
    FOREIGN KEY (compra_id) REFERENCES compras(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- Tabela de vendas
CREATE TABLE vendas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    numero_venda VARCHAR(50) UNIQUE,
    cliente_nome VARCHAR(150),
    cliente_documento VARCHAR(20),
    cliente_telefone VARCHAR(20),
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(12,2),
    desconto DECIMAL(10,2) DEFAULT 0,
    valor_final DECIMAL(12,2),
    forma_pagamento VARCHAR(100),
    status ENUM('PENDENTE', 'CONFIRMADO', 'ENTREGUE', 'CANCELADO') DEFAULT 'CONFIRMADO',
    observacoes TEXT
);

-- Tabela de itens da venda
CREATE TABLE itens_venda (
    id INT PRIMARY KEY AUTO_INCREMENT,
    venda_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    valor_total DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (venda_id) REFERENCES vendas(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- Tabela de análise de rotatividade
CREATE TABLE analise_rotatividade (
    id INT PRIMARY KEY AUTO_INCREMENT,
    produto_id INT NOT NULL,
    periodo_inicio DATE NOT NULL,
    periodo_fim DATE NOT NULL,
    quantidade_vendida INT DEFAULT 0,
    quantidade_comprada INT DEFAULT 0,
    estoque_medio DECIMAL(10,2),
    giro_estoque DECIMAL(8,4),
    dias_estoque DECIMAL(8,2),
    classificacao ENUM('ALTA', 'MEDIA', 'BAIXA', 'SEM_MOVIMENTO') DEFAULT 'SEM_MOVIMENTO',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);
