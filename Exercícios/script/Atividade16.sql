-- funcao com data em sql usando $body$
CREATE OR REPLACE FUNCTION adicionar_dias (data_inicio date, dias integer)
RETURNS date AS $body$
BEGIN
    RETURN data_inicio + dias;
END;
$body$
LANGUAGE plpgsql;

-- funcao com data em sql usando $body$ e cast
CREATE OR REPLACE FUNCTION adicionar_dias (data_inicio date, dias integer)
RETURNS date AS $body$
BEGIN
    RETURN CAST(data_inicio + dias AS date);
END;
$body$
LANGUAGE plpgsql;

-- EXERCÍCIO 1:
-- CRIE UMA FUNÇÃO QUE RECEBA COMO PARÂMETRO O NÚMERO DE UM DEPARTAMENTO E
-- RETORNE O TOTAL DE HORAS TRABALHADAS PELO SEU GERENTE.
CREATE OR REPLACE FUNCTION total_horas_gerente(dept_no integer)
RETURNS integer AS $body$
DECLARE
    total_horas integer;
BEGIN
    SELECT SUM(horas) INTO total_horas
    FROM funcionarios
    WHERE dept_no = dept_no;
    RETURN total_horas;
END;
$body$
LANGUAGE plpgsql;

-- EXERCÍCIO 2:
-- CRIE UMA FUNÇÃO QUE SOME AS HORAS TRABALHADAS DE CADA PROJETO E ATUALIZE A
-- DURAÇÃO DOS MESMOS (EM DIAS)
CREATE OR REPLACE FUNCTION atualizar_duracao_projetos()
RETURNS void AS $body$
DECLARE
    total_horas integer;
BEGIN
    SELECT SUM(horas) INTO total_horas
    FROM funcionarios;
    UPDATE projetos
    SET duracao = total_horas;
END;
$body$
LANGUAGE plpgsql;

-- EXERCÍCIO 3:
-- CRIE UMA FUNÇÃO QUE RECEBA COMO PARÂMETRO O NÚMERO DE UM DEPARTAMENTO E
-- EXCLUA TODOS OS REGISTROS DE PARTICIPAÇÕES EM PROJETOS CONTROLADOS PELO
-- MESMO.
CREATE OR REPLACE FUNCTION excluir_participacoes(dept_no integer)
RETURNS void AS $body$
BEGIN
    DELETE FROM participacoes
    WHERE dept_no = dept_no;
END;
$body$
LANGUAGE plpgsql;

-- EXERCÍCIO 4:
-- CRIE UMA FUNÇÃO QUE RECEBA COMO PARÂMETROS DOIS VALORES DE PORCENTAGEM E
-- AUMENTE COM O PRIMEIRO VALOR O SALÁRIO DOS FUNCIONÁRIOS NASCIDOS ANTES
-- DE 1972 E COM O SEGUNDO VALOR O SALÁRIO DOS FUNCIONÁRIOS NASCIDOS EM
-- 1972 OU DEPOIS
CREATE OR REPLACE FUNCTION aumentar_salarios(porcentagem1 numeric, porcentagem2 numeric)
RETURNS void AS $body$
BEGIN
    UPDATE funcionarios
    SET salario = salario * (1 + porcentagem1)
    WHERE data_nascimento < '1972-01-01';
    UPDATE funcionarios
    SET salario = salario * (1 + porcentagem2)
    WHERE data_nascimento >= '1972-01-01';
END;
$body$
LANGUAGE plpgsql;

-- CRIE UMA STORED PROCEDURE PARA GERAR UMA CONSULTA DE
-- PREÇOS DOS IMÓVEIS COM AUMENTO A ESCOLHER PELO USUÁRIO.
CREATE OR REPLACE PROCEDURE aumentar_preco_imoveis(porcentagem numeric)
AS $body$
BEGIN
    UPDATE imoveis
    SET preco = preco * (1 + porcentagem);
END;
$body$
LANGUAGE plpgsql;

-- CRIE UMA STORED PROCEDURE PARA INSERIR DADOS NO SCHEMA
-- LOJA_CD
CREATE OR REPLACE PROCEDURE inserir_dados_loja_cd()
AS $body$
BEGIN
    INSERT INTO loja_cd (codigo, nome, preco)
    VALUES (1, 'CD 1', 10);
    INSERT INTO loja_cd (codigo, nome, preco)
    VALUES (2, 'CD 2', 20);
    INSERT INTO loja_cd (codigo, nome, preco)
    VALUES (3, 'CD 3', 30);
END;
$body$
LANGUAGE plpgsql;
