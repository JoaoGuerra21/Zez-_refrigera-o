-- Consultas para relatórios gerenciais
USE empresa_geladeiras;

-- Relatório: Produtos com estoque crítico
SELECT 
    'ESTOQUE CRÍTICO' as relatorio,
    codigo,
    nome,
    categoria,
    estoque_atual,
    estoque_minimo,
    status_estoque,
    (estoque_atual * preco_custo) as valor_estoque_atual
FROM vw_produtos_estoque 
WHERE status_estoque IN ('CRÍTICO', 'BAIXO')
ORDER BY estoque_atual ASC;

-- Relatório: Produtos com excesso de estoque
SELECT 
    'EXCESSO DE ESTOQUE' as relatorio,
    codigo,
    nome,
    categoria,
    estoque_atual,
    estoque_maximo,
    (estoque_atual * preco_custo) as valor_parado
FROM vw_produtos_estoque 
WHERE status_estoque = 'EXCESSO'
ORDER BY valor_parado DESC;

-- Relatório: Análise de custos por categoria
SELECT 
    'CUSTOS POR CATEGORIA' as relatorio,
    categoria,
    COUNT(*) as total_produtos,
    SUM(quantidade_estoque) as total_pecas_estoque,
    SUM(valor_estoque) as valor_total_categoria,
    AVG(valor_estoque) as valor_medio_produto,
    SUM(CASE WHEN classificacao_rotatividade = 'SEM_ROTATIVIDADE' THEN valor_estoque ELSE 0 END) as valor_sem_rotatividade
FROM vw_analise_custos_estoque
GROUP BY categoria
ORDER BY valor_total_categoria DESC;

-- Relatório: Top 10 produtos mais vendidos (últimos 30 dias)
SELECT 
    'TOP VENDAS - 30 DIAS' as relatorio,
    p.codigo,
    p.nome,
    p.marca,
    SUM(iv.quantidade) as total_vendido,
    SUM(iv.valor_total) as faturamento_produto,
    AVG(iv.preco_unitario) as preco_medio_venda
FROM produtos p
JOIN itens_venda iv ON p.id = iv.produto_id
JOIN vendas v ON iv.venda_id = v.id
WHERE v.data_venda >= DATE_SUB(NOW(), INTERVAL 30 DAY)
AND v.status = 'CONFIRMADO'
GROUP BY p.id, p.codigo, p.nome, p.marca
ORDER BY total_vendido DESC
LIMIT 10;

-- Relatório: Margem de lucro por produto
SELECT 
    'ANÁLISE MARGEM LUCRO' as relatorio,
    codigo,
    nome,
    marca,
    preco_custo,
    preco_venda,
    margem_lucro,
    estoque_atual,
    (estoque_atual * (preco_venda - preco_custo)) as lucro_potencial_estoque
FROM vw_produtos_estoque
WHERE estoque_atual > 0
ORDER BY margem_lucro DESC;
