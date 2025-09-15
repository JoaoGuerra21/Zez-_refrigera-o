-- Stored Procedures para operações frequentes
USE empresa_geladeiras;

DELIMITER //

-- Procedure para calcular análise de rotatividade
CREATE PROCEDURE sp_calcular_rotatividade(
    IN p_data_inicio DATE,
    IN p_data_fim DATE
)
BEGIN
    -- Limpar análises antigas do período
    DELETE FROM analise_rotatividade 
    WHERE periodo_inicio = p_data_inicio AND periodo_fim = p_data_fim;
    
    -- Calcular nova análise
    INSERT INTO analise_rotatividade (
        produto_id, periodo_inicio, periodo_fim, quantidade_vendida, 
        quantidade_comprada, estoque_medio, giro_estoque, dias_estoque, classificacao
    )
    SELECT 
        p.id as produto_id,
        p_data_inicio as periodo_inicio,
        p_data_fim as periodo_fim,
        COALESCE(vendas.total_vendido, 0) as quantidade_vendida,
        COALESCE(compras.total_comprado, 0) as quantidade_comprada,
        COALESCE(estoque_atual.quantidade_atual, 0) as estoque_medio,
        CASE 
            WHEN COALESCE(estoque_atual.quantidade_atual, 0) > 0 
            THEN COALESCE(vendas.total_vendido, 0) / estoque_atual.quantidade_atual
            ELSE 0 
        END as giro_estoque,
        CASE 
            WHEN COALESCE(vendas.total_vendido, 0) > 0 
            THEN (DATEDIFF(p_data_fim, p_data_inicio) * estoque_atual.quantidade_atual) / vendas.total_vendido
            ELSE DATEDIFF(p_data_fim, p_data_inicio)
        END as dias_estoque,
        CASE 
            WHEN COALESCE(vendas.total_vendido, 0) = 0 THEN 'SEM_MOVIMENTO'
            WHEN COALESCE(vendas.total_vendido, 0) / estoque_atual.quantidade_atual >= 2 THEN 'ALTA'
            WHEN COALESCE(vendas.total_vendido, 0) / estoque_atual.quantidade_atual >= 1 THEN 'MEDIA'
            ELSE 'BAIXA'
        END as classificacao
    FROM produtos p
    LEFT JOIN (
        SELECT 
            iv.produto_id,
            SUM(iv.quantidade) as total_vendido
        FROM itens_venda iv
        JOIN vendas v ON iv.venda_id = v.id
        WHERE DATE(v.data_venda) BETWEEN p_data_inicio AND p_data_fim
        AND v.status = 'CONFIRMADO'
        GROUP BY iv.produto_id
    ) vendas ON p.id = vendas.produto_id
    LEFT JOIN (
        SELECT 
            ic.produto_id,
            SUM(ic.quantidade) as total_comprado
        FROM itens_compra ic
        JOIN compras c ON ic.compra_id = c.id
        WHERE c.data_pedido BETWEEN p_data_inicio AND p_data_fim
        AND c.status = 'ENTREGUE'
        GROUP BY ic.produto_id
    ) compras ON p.id = compras.produto_id
    LEFT JOIN (
        SELECT 
            produto_id,
            SUM(quantidade_atual) as quantidade_atual
        FROM estoque
        GROUP BY produto_id
    ) estoque_atual ON p.id = estoque_atual.produto_id
    WHERE p.ativo = TRUE;
END//

-- Procedure para relatório de produtos sem movimento
CREATE PROCEDURE sp_produtos_sem_movimento(
    IN p_dias INT
)
BEGIN
    SELECT 
        p.codigo,
        p.nome,
        p.marca,
        c.nome as categoria,
        SUM(e.quantidade_atual) as estoque_atual,
        (SUM(e.quantidade_atual) * p.preco_custo) as valor_parado,
        DATEDIFF(NOW(), MAX(e.ultima_movimentacao)) as dias_sem_movimento
    FROM produtos p
    JOIN categorias c ON p.categoria_id = c.id
    LEFT JOIN estoque e ON p.id = e.produto_id
    WHERE p.ativo = TRUE
    GROUP BY p.id, p.codigo, p.nome, p.marca, c.nome, p.preco_custo
    HAVING dias_sem_movimento >= p_dias OR dias_sem_movimento IS NULL
    ORDER BY valor_parado DESC;
END//

-- Procedure para sugestão de compras
CREATE PROCEDURE sp_sugestao_compras()
BEGIN
    SELECT 
        p.codigo,
        p.nome,
        p.marca,
        c.nome as categoria,
        COALESCE(SUM(e.quantidade_atual), 0) as estoque_atual,
        p.estoque_minimo,
        p.estoque_maximo,
        (p.estoque_maximo - COALESCE(SUM(e.quantidade_atual), 0)) as quantidade_sugerida,
        p.preco_custo,
        ((p.estoque_maximo - COALESCE(SUM(e.quantidade_atual), 0)) * p.preco_custo) as valor_investimento,
        f.nome as ultimo_fornecedor,
        f.prazo_entrega_dias
    FROM produtos p
    JOIN categorias c ON p.categoria_id = c.id
    LEFT JOIN estoque e ON p.id = e.produto_id
    LEFT JOIN (
        SELECT DISTINCT 
            ic.produto_id,
            fo.nome,
            fo.prazo_entrega_dias,
            ROW_NUMBER() OVER (PARTITION BY ic.produto_id ORDER BY co.data_pedido DESC) as rn
        FROM itens_compra ic
        JOIN compras co ON ic.compra_id = co.id
        JOIN fornecedores fo ON co.fornecedor_id = fo.id
        WHERE fo.ativo = TRUE
    ) f ON p.id = f.produto_id AND f.rn = 1
    WHERE p.ativo = TRUE
    GROUP BY p.id, p.codigo, p.nome, p.marca, c.nome, p.estoque_minimo, 
             p.estoque_maximo, p.preco_custo, f.nome, f.prazo_entrega_dias
    HAVING estoque_atual <= p.estoque_minimo
    ORDER BY valor_investimento DESC;
END//

DELIMITER ;
