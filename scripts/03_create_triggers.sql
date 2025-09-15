-- Triggers para automatizar processos
USE empresa_geladeiras;

DELIMITER //

-- Trigger para atualizar estoque após movimentação
CREATE TRIGGER tr_atualizar_estoque_movimentacao
AFTER INSERT ON movimentacoes_estoque
FOR EACH ROW
BEGIN
    IF NEW.tipo_movimentacao = 'ENTRADA' THEN
        UPDATE estoque 
        SET quantidade_atual = quantidade_atual + NEW.quantidade,
            ultima_movimentacao = NOW()
        WHERE produto_id = NEW.produto_id AND (lote = NEW.lote OR NEW.lote IS NULL);
        
        -- Se não existe registro no estoque, criar um novo
        IF ROW_COUNT() = 0 THEN
            INSERT INTO estoque (produto_id, quantidade_atual, lote, ultima_movimentacao)
            VALUES (NEW.produto_id, NEW.quantidade, NEW.lote, NOW());
        END IF;
        
    ELSEIF NEW.tipo_movimentacao = 'SAIDA' THEN
        UPDATE estoque 
        SET quantidade_atual = quantidade_atual - NEW.quantidade,
            ultima_movimentacao = NOW()
        WHERE produto_id = NEW.produto_id AND (lote = NEW.lote OR NEW.lote IS NULL);
        
    ELSEIF NEW.tipo_movimentacao = 'AJUSTE' THEN
        UPDATE estoque 
        SET quantidade_atual = NEW.quantidade_atual,
            ultima_movimentacao = NOW()
        WHERE produto_id = NEW.produto_id AND (lote = NEW.lote OR NEW.lote IS NULL);
    END IF;
END//

-- Trigger para calcular margem de lucro automaticamente
CREATE TRIGGER tr_calcular_margem_lucro
BEFORE UPDATE ON produtos
FOR EACH ROW
BEGIN
    IF NEW.preco_custo > 0 AND NEW.preco_venda > 0 THEN
        SET NEW.margem_lucro = ((NEW.preco_venda - NEW.preco_custo) / NEW.preco_custo) * 100;
    END IF;
END//

-- Trigger para registrar movimentação de estoque nas vendas
CREATE TRIGGER tr_movimentacao_venda
AFTER INSERT ON itens_venda
FOR EACH ROW
BEGIN
    INSERT INTO movimentacoes_estoque (
        produto_id, tipo_movimentacao, quantidade, preco_unitario, 
        valor_total, motivo, documento
    ) VALUES (
        NEW.produto_id, 'SAIDA', NEW.quantidade, NEW.preco_unitario,
        NEW.valor_total, 'Venda', CONCAT('VENDA-', NEW.venda_id)
    );
END//

-- Trigger para registrar movimentação de estoque nas compras
CREATE TRIGGER tr_movimentacao_compra
AFTER INSERT ON itens_compra
FOR EACH ROW
BEGIN
    INSERT INTO movimentacoes_estoque (
        produto_id, tipo_movimentacao, quantidade, preco_unitario, 
        valor_total, motivo, documento, lote
    ) VALUES (
        NEW.produto_id, 'ENTRADA', NEW.quantidade, NEW.preco_unitario,
        NEW.valor_total, 'Compra', CONCAT('COMPRA-', NEW.compra_id), NEW.lote
    );
END//

DELIMITER ;
