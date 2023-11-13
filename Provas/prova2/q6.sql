-- 6 - Crie uma função onde passamos como parâmetro o cpf do cliente e seja retornado o seu nome 
CREATE OR REPLACE FUNCTION getNomeCliente(cpfCliente varchar) RETURNS varchar AS $body$
DECLARE nomeCliente varchar;
BEGIN
SELECT nome INTO nomeCliente
FROM CLIENTE
WHERE cpf = cpfCliente;
RETURN nomeCliente;
END;
$body$ LANGUAGE plpgsql;
-- aa(TESTADO FUNCIONANDO)
CREATE OR REPLACE FUNCTION get_nome_cliente(cpf_cliente VARCHAR) RETURNS VARCHAR AS $BODY$
DECLARE nome_cliente VARCHAR;
BEGIN
SELECT nome INTO nome_cliente
FROM cliente
WHERE cpf = cpf_cliente;
RETURN nome_cliente;
END;
$BODY$ LANGUAGE plpgsql;
-- eder
CREATE OR REPLACE FUNCTION pegarNomeDoCliente(cpf_cliente varchar)
RETURNS varchar AS $body$
DECLARE
    nome_cliente varchar;
BEGIN
    SELECT nome INTO nome_cliente FROM CLIENTE WHERE cpf = cpf_cliente;
    RETURN nomeCliente;
END; $body$
LANGUAGE plpgsql;
-- eder corrigida
CREATE OR REPLACE FUNCTION pegarNomeDoCliente(cpf_cliente varchar)
RETURNS varchar AS $body$
DECLARE
    nome_cliente varchar;
BEGIN
    SELECT nome INTO nome_cliente FROM CLIENTE WHERE cpf = cpf_cliente;
    RETURN nome_cliente;
END; $body$
LANGUAGE plpgsql;