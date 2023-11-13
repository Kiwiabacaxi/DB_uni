-- 3 - Crie uma function que retorne o registro da tabela peca, passando o campo código como argumento.
-- codigo base do camilo
CREATE TABLE PRODUTO(
    codproduto int,
    descricao varchar(100),
    quantidade int,
    CONSTRAINT pk2_produto PRIMARY KEY (codproduto)
);
-- auto gerado primera vers
CREATE FUNCTION buscar_peca(cod_peca INT) RETURNS TABLE (
    cod_peca INT,
    nome VARCHAR(64),
    descricao TEXT,
    preco DECIMAL(10, 2)
) AS $body$ BEGIN RETURN QUERY
SELECT *
FROM peca
WHERE cod_peca = buscar_peca.cod_peca;
END;
$body$ LANGUAGE plpgsql;
-- copiada --
CREATE FUNCTION registroPeca(cod_peca INT) RETURNS TABLE(
    cod_peca INT,
    nome VARCHAR(50),
    descricao TEXT,
    preco DECIMAL(10, 2)
) AS $body$ BEGIN RETURN QUERY
SELECT *
FROM peca
WHERE cod_peca = buscar_peca.cod_peca;
END;
$body$ LANGUAGE plpgsql;
-- segunda try - ficou a msm coisa
CREATE FUNCTION registroPeca(cod_peca INT) RETURNS TABLE(
    cod_peca INT,
    nome VARCHAR(50),
    descricao TEXT,
    preco DECIMAL(10, 2)
) AS $body$ BEGIN RETURN QUERY
SELECT *
FROM peca
WHERE cod_peca = buscar_peca.cod_peca;
END;
$body$ LANGUAGE plpgsql;