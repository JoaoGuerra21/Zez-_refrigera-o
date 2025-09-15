-- Índices para otimização de performance
USE empresa_geladeiras;

-- Índices para produtos
CREATE INDEX idx_produtos_categoria ON produtos(categoria_id);
CREATE INDEX idx_produtos_codigo ON produtos(codigo);
CREATE INDEX idx_produtos_nome ON produtos(nome);
CREATE INDEX idx_produtos_ativo ON produtos(ativo);

-- Índices para estoque
CREATE INDEX idx_estoque_produto ON estoque(produto_id);
CREATE INDEX idx_estoque_quantidade ON estoque(quantidade_atual);

-- Índices para movimentações
CREATE INDEX idx_movimentacoes_produto ON movimentacoes_estoque(produto_id);
CREATE INDEX idx_movimentacoes_data ON movimentacoes_estoque(created_at);
CREATE INDEX idx_movimentacoes_tipo ON movimentacoes_estoque(tipo_movimentacao);

-- Índices para compras
CREATE INDEX idx_compras_fornecedor ON compras(fornecedor_id);
CREATE INDEX idx_compras_data ON compras(data_pedido);
CREATE INDEX idx_compras_status ON compras(status);

-- Índices para vendas
CREATE INDEX idx_vendas_data ON vendas(data_venda);
CREATE INDEX idx_vendas_status ON vendas(status);

-- Índices para análise de rotatividade
CREATE INDEX idx_rotatividade_produto ON analise_rotatividade(produto_id);
CREATE INDEX idx_rotatividade_periodo ON analise_rotatividade(periodo_inicio, periodo_fim);
