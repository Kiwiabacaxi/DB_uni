-- Faça uma função onde passamos o código da encomenda como parâmetro e retorne qual o fornecedor ela pertence.
-- do luiz abaixo
CREATE OR REPLACE FUNCTION GetFornecedorByPedido(p_codpedido INT) RETURNS TABLE(nf VARCHAR(12)) AS $BODY$ BEGIN RETURN QUERY
SELECT PEDIDO.nf
FROM PEDIDO
WHERE codpedido = p_codpedido;
END;
$BODY$ LANGUAGE plpgsql;
-- tosada
CREATE OR REPLACE FUNCTION get_fornecedor_by_pedido(p_codpedido INT) RETURNS TABLE(nf VARCHAR(12)) LANGUAGE plpgsql AS $BODY$ BEGIN RETURN QUERY
SELECT nf
FROM PEDIDO
WHERE codpedido = p_codpedido;
END;
$BODY$;
-- WTF - TESTADA E TOSADA
CREATE OR REPLACE FUNCTION get_fornecedor_by_pedido(p_codpedido INT) RETURNS TABLE(nf VARCHAR(12)) LANGUAGE plpgsql AS $BODY$ BEGIN RETURN QUERY
SELECT p.nf
FROM PEDIDO p
WHERE p.codpedido = p_codpedido;
END;
$BODY$;
