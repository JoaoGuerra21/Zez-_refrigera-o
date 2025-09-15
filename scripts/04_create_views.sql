-- Views para relatórios e consultas frequentes
USE empresa_geladeiras;

-- View para produtos com estoque atual
CREATE VIEW vw_produtos_estoque AS
SELECT 
    p.id,
    p.codigo,
    p.nome,
    p.marca,
    p.modelo,
    c.nome as categoria,
    p.preco_custo,
    p.preco_venda,
    p.margem_lucro,
    COALESCE(SUM(e.quantidade_atual), 0) as estoque_atual,
    p.estoque_minimo,
    p.estoque_maximo,
    CASE 
        WHEN COALESCE(SUM(e.quantidade_atual), 0) <= p.estoque_minimo THEN 'CRÍTICO'
        WHEN COALESCE(SUM(e.quantidade_atual), 0) <= (p.estoque_minimo * 1.5) THEN 'BAIXO'
        WHEN COALESCE(SUM(e.quantidade_atual), 0) >= p.estoque_maximo THEN 'EXCESSO'
        ELSE 'NORMAL'
    END as status_estoque,
    p.ativo
FROM produtos p
LEFT JOIN categorias c ON p.categoria_id = c.id
LEFT JOIN estoque e ON p.id = e.produto_id
WHERE p.ativo = TRUE
GROUP BY p.id, p.codigo, p.nome, p.marca, p.modelo, c.nome, 
         p.preco_custo, p.preco_venda, p.margem_lucro, 
         p.estoque_minimo, p.estoque_maximo, p.ativo;

-- View para análise de custos de estoque
CREATE VIEW vw_analise_custos_estoque AS
SELECT 
    p.id,
    p.codigo,
    p.nome,
    c.nome as categoria,
    COALESCE(SUM(e.quantidade_atual), 0) as quantidade_estoque,
    p.preco_custo,
    (COALESCE(SUM(e.quantidade_atual), 0) * p.preco_custo) as valor_estoque,
    p.estoque_minimo,
    p.estoque_maximo,
    DATEDIFF(NOW(), MAX(e.ultima_movimentacao)) as dias_sem_movimento,
    CASE 
        WHEN DATEDIFF(NOW(), MAX(e.ultima_movimentacao)) > 90 THEN 'SEM_ROTATIVIDADE'
        WHEN DATEDIFF(NOW(), MAX(e.ultima_movimentacao)) > 60 THEN 'BAIXA_ROTATIVIDADE'
        WHEN DATEDIFF(NOW(), MAX(e.ultima_movimentacao)) > 30 THEN 'ROTATIVIDADE_NORMAL'
        ELSE 'ALTA_ROTATIVIDADE'
    END as classificacao_rotatividade
FROM produtos p
LEFT JOIN categorias c ON p.categoria_id = c.id
LEFT JOIN estoque e ON p.id = e.produto_id
WHERE p.ativo = TRUE
GROUP BY p.id, p.codigo, p.nome, c.nome, p.preco_custo, 
         p.estoque_minimo, p.estoque_maximo;

-- View para produtos que precisam ser comprados
CREATE VIEW vw_produtos_comprar AS
SELECT 
    p.id,
    p.codigo,
    p.nome,
    p.marca,
    c.nome as categoria,
    COALESCE(SUM(e.quantidade_atual), 0) as estoque_atual,
    p.estoque_minimo,
    p.estoque_maximo,
    (p.estoque_maximo - COALESCE(SUM(e.quantidade_atual), 0)) as quantidade_sugerida,
    p.preco_custo,
    ((p.estoque_maximo - COALESCE(SUM(e.quantidade_atual), 0)) * p.preco_custo) as valor_compra_sugerido,
    f.nome as fornecedor_principal,
    f.prazo_entrega_dias
FROM produtos p
LEFT JOIN categorias c ON p.categoria_id = c.id
LEFT JOIN estoque e ON p.id = e.produto_id
LEFT JOIN (
    SELECT DISTINCT 
        ic.produto_id,
        f.nome,
        f.prazo_entrega_dias,
        ROW_NUMBER() OVER (PARTITION BY ic.produto_id ORDER BY c.data_pedido DESC) as rn
    FROM itens_compra ic
    JOIN compras c ON ic.compra_id = c.id
    JOIN fornecedores f ON c.fornecedor_id = f.id
    WHERE f.ativo = TRUE
) f ON p.id = f.produto_id AND f.rn = 1
WHERE p.ativo = TRUE 
AND COALESCE(SUM(e.quantidade_atual), 0) <= p.estoque_minimo
GROUP BY p.id, p.codigo, p.nome, p.marca, c.nome, 
         p.estoque_minimo, p.estoque_maximo, p.preco_custo,
         f.nome, f.prazo_entrega_dias;

-- View para relatório de vendas por período
CREATE VIEW vw_relatorio_vendas AS
SELECT 
    DATE(v.data_venda) as data_venda,
    COUNT(v.id) as total_vendas,
    SUM(v.valor_final) as faturamento_dia,
    AVG(v.valor_final) as ticket_medio,
    SUM(iv.quantidade) as total_itens_vendidos
FROM vendas v
JOIN itens_venda iv ON v.id = iv.venda_id
WHERE v.status = 'CONFIRMADO'
GROUP BY DATE(v.data_venda)
ORDER BY data_venda DESC;
