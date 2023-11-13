-- 3 - Crie uma function que retorne o registro da tabela peca, passando o campo código como argumento.
-- codigo base do camilo
CREATE TABLE PRODUTO(
    codproduto int,
    descricao varchar(100),
    quantidade int,
    CONSTRAINT pk2_produto PRIMARY KEY (codproduto)
);
-- aa
CREATE OR REPLACE FUNCTION get_produto_by_cod(cod INT) RETURNS TABLE (
        codproduto INT,
        descricao VARCHAR(100),
        quantidade INT
    ) AS $BODY$ BEGIN RETURN QUERY
SELECT produto.codproduto,
    produto.descricao,
    produto.quantidade
FROM produto
WHERE produto.codproduto = cod;
END;
$BODY$ LANGUAGE plpgsql;