-- Faça uma function que faça uma atualização na tabela “ ItemPedido ”,
-- recebendo o codpedido,
-- numeroitem,
-- codproduto,
-- utilizando a ferramenta “case
--     ”,
--     onde siga as seguintes instruções: 3,
--     0 Quantidade < 10 aumento de 25 unidades,
--     Quantidade >= 10 e Quantidade < 40 aumento de 15 unidades,
--     Quantidade >= 40 aumento de 5 unidades.
CREATE OR REPLACE FUNCTION atualizaQuantidadeItemPedido(
        parametroCodpedido int,
        parametroNumeroitem int,
        parametroCodproduto int
    ) RETURNS void AS $$ BEGIN
UPDATE ITEMPEDIDO
SET quantidade = CASE
        WHEN quantidade < 10 THEN quantidade + 25
        WHEN quantidade >= 10
        AND quantidade < 40 THEN quantidade + 15
        ELSE quantidade + 5
    END
WHERE codpedido = parametroCodpedido
    AND numeroitem = parametroNumeroitem
    AND codproduto = parametroCodproduto;
END;
$$ LANGUAGE plpgsql;
-- alterada
CREATE OR REPLACE FUNCTION atualiza_quantidade_item_pedido(
        parametro_codpedido INT,
        parametro_numeroitem INT,
        parametro_codproduto INT
    ) RETURNS void LANGUAGE plpgsql AS $BODY$ BEGIN
UPDATE ITEMPEDIDO
SET quantidade = CASE
        WHEN quantidade < 10 THEN quantidade + 25
        WHEN quantidade >= 10
        AND quantidade < 40 THEN quantidade + 15
        ELSE quantidade + 5
    END
WHERE codpedido = parametro_codpedido
    AND numeroitem = parametro_numeroitem
    AND codproduto = parametro_codproduto;
END;
$BODY$;
-- eder
CREATE OR REPLACE FUNCTION atualizaTabelaItemPedido(
        codpedido_atualizar int,
        numero_item_atualizar int,
        codproduto_atualizar int
    ) RETURNS void AS $$ BEGIN
UPDATE ITEMPEDIDO
SET quantidade = CASE
        WHEN quantidade < 10 THEN quantidade + 25
        WHEN quantidade >= 10
        AND quantidade < 40 THEN quantidade + 15
        ELSE quantidade + 5
    END
WHERE codpedido = codpedido_atualizar
    AND numeroitem = numero_item_atualizar
    AND codproduto = codproduto_atualizar;
END;
$$ LANGUAGE plpgsql;