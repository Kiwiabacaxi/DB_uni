-- tabela usuario
CREATE TABLE usuario (
    id integer NOT NULL,
    nm_login character varying,
    ds_senha character varying,
    fg_bloqueado boolean,
    nu_tentativa_login integer,
    CONSTRAINT pk_usuario PRIMARY KEY (id)
);
-- Na tabela ‘usuario’, temos os seguintes dados:
-- id nm_login ds_senha fg_bloqueado nu_tentativa_login 
-- 1 hallan hallan2011 false 0 
-- 2 joao 123456 false 0 
-- 3 maria abcd1234 false 2
INSERT INTO usuario (
        id,
        nm_login,
        ds_senha,
        fg_bloqueado,
        nu_tentativa_login
    )
VALUES (1, 'hallan', 'hallan2011', false, 0)
VALUES (2, 'joao', '123456', false, 0)
VALUES (3, 'maria', 'abcd1234', false, 2);
-- Criar uma função onde passa o login do usuário e a função irá retornar o seu ID. Se um usuário que tem o número de tentativas (coluna nu_tentativa_login) = 1 entrar com sua senha errada, o número de tentativas deverá ser alterado para 2. Caso entre novamente com a senha errada, o número de tentativas deverá ser alterado para 3 Ea coluna fg_bloqueadodeverá ser alterada para TRUE.
CREATE OR REPLACE FUNCTION login (nm_login varchar(50)) RETURNS integer AS $body$ BEGIN
SELECT id
FROM usuario
WHERE nm_login = nm_login;
IF nu_tentativa_login = 1 THEN
UPDATE usuario
SET nu_tentativa_login = 2
WHERE nm_login = nm_login;
ELSEIF nu_tentativa_login = 2 THEN
UPDATE usuario
SET nu_tentativa_login = 3
WHERE nm_login = nm_login;
UPDATE usuario
SET fg_bloqueado = true
WHERE nm_login = nm_login;
END IF;
END;
$body$ LANGUAGE plpgsql;
-- Caso um usuário com o número de tentativas = 2 tenha entrado com a senha correta, o valor do número de tentativas deverá voltar a ser 0.
CREATE OR REPLACE FUNCTION login (nm_login varchar(50)) RETURNS integer AS $body$ BEGIN
SELECT id
FROM usuario
WHERE nm_login = nm_loginCaso um usuário com o número de tentativas = 2 tenha entrado com a senha correta,
    o valor do número de tentativas deverá voltar a ser 0.;
IF nu_tentativa_login = 1 THEN
UPDATE usuario
SET nu_tentativa_login = 2
WHERE nm_login = nm_login;
ELSEIF nu_tentativa_login = 2 THEN
UPDATE usuario
SET nu_tentativa_login = 3
WHERE nm_login = nm_login;
UPDATE usuario
SET fg_bloqueado = true
WHERE nm_login = nm_login;
END IF;
END;
$body$ LANGUAGE plpgsql;
-- Escreva funções usando PL/PgSQL usando sobrecarga para que tenham o mesmo nome e executem as seguintes tarefas. Use a tabela IMÓVELNET como base para executar as tarefas.
-- Liste as cidades de um estado, tendo o nome do estado fornecido como argumento.
CREATE OR REPLACE FUNCTION listar_cidades_estado(p_estado character varying) RETURNS TABLE (cidade character varying) AS $$ BEGIN RETURN QUERY
SELECT NMCidade
FROM cidade
    JOIN estado on cidade.SGEstado = estado.SGEstado
WHERE NMEstado = p_estado;
END;
$$ LANGUAGE plpgsql;
-- Liste n cidades de um estado, tendo como argumentos o nome do estado e o número de cidades a serem listadas.
CREATE OR REPLACE FUNCTION listar_n_cidades_estado(p_estado character varying, p_quantidade integer) RETURNS TABLE (cidade character varying) AS $$ BEGIN RETURN QUERY
SELECT NMCidade
FROM cidade
    JOIN estado on estado.Sgestado = cidade.Sgestado
WHERE NMEstado = p_estado
LIMIT p_quantidade;
END;
$$ LANGUAGE plpgsql;
-- Liste as cidades de vários estados, tendo um número variável de estados fornecido como argumento.
CREATE OR REPLACE FUNCTION listar_cidades_varios_estados(VARIADIC p_estados character varying []) RETURNS TABLE (cidade character varying) AS $$ BEGIN RETURN QUERY
SELECT NMCidade
FROM cidade
    JOIN estado on estado.Sgestado = cidade.Sgestado
WHERE NMEstado = ANY(p_estados);
END;
$$ LANGUAGE plpgsql;