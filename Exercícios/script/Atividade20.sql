-- Criação de tabela
CREATE TABLE CLIENTE(
    codcliente int,
    nome varchar(60),
    datanascimento date,
    cpf varchar(11),
    CONSTRAINT pk2_cliente PRIMARY KEY (codcliente)
);
CREATE TABLE PEDIDO(
    codpedido int,
    codcliente int,
    datapedido date,
    nf varchar(12),
    valortotal decimal(10, 2),
    CONSTRAINT pk2_pedido PRIMARY KEY (codpedido),
    CONSTRAINT pk2_pedido_cliente FOREIGN KEY (codcliente) REFERENCES CLIENTE(codcliente)
);
CREATE TABLE PRODUTO(
    codproduto int,
    descricao varchar(100),
    quantidade int,
    CONSTRAINT pk2_produto PRIMARY KEY (codproduto)
);
CREATE TABLE ITEMPEDIDO(
    codpedido int,
    numeroitem int,
    valorunitario decimal(10, 2),
    quantidade int,
    codproduto int,
    CONSTRAINT pk2_itempedido PRIMARY KEY (codpedido, numeroitem),
    CONSTRAINT fk2_codpedido FOREIGN KEY (codpedido) REFERENCES PEDIDO (codpedido),
    CONSTRAINT fk2_itempedido_produto FOREIGN KEY (codproduto) REFERENCES PRODUTO (codproduto)
);
CREATE TABLE LOG(
    codlog int,
    data date,
    descricao varchar(255),
    CONSTRAINT pk2_log PRIMARY KEY (codlog)
);
CREATE TABLE REQUISICAO_COMPRA(
    codrequisicaocompra int,
    codproduto int,
    data date,
    quantidade int,
    CONSTRAINT pk2_reqcompra PRIMARY KEY (codrequisicaocompra),
    CONSTRAINT fk2_reqcompra_produto FOREIGN KEY (codproduto) REFERENCES PRODUTO(codproduto)
);
-- Inserção de dados.
INSERT INTO CLIENTE
VALUES (
        1,
        'Sylvio Barbon',
        TO_DATE('05/12/1984', 'DD/MM/YYYY'),
        '12315541212'
    );
INSERT INTO CLIENTE
VALUES (
        2,
        'Antonio Carlos da Silva',
        TO_DATE('01/11/1970', 'DD/MM/YYYY'),
        '12313345512'
    );
INSERT INTO CLIENTE
VALUES (
        3,
        'Thiago Ribeiro',
        TO_DATE('15/11/1964', 'DD/MM/YYYY'),
        '12315544411'
    );
INSERT INTO CLIENTE
VALUES (
        4,
        'Carlos Eduardo',
        TO_DATE('25/10/1924', 'DD/MM/YYYY'),
        '42515541212'
    );
INSERT INTO CLIENTE
VALUES (
        5,
        'Maria Cristina Goes',
        TO_DATE('03/11/1981', 'DD/MM/YYYY'),
        '67715541212'
    );
INSERT INTO CLIENTE
VALUES (
        6,
        'Ruan Manoel Fanjo',
        TO_DATE('06/12/1983', 'DD/MM/YYYY'),
        '32415541212'
    );
INSERT INTO CLIENTE
VALUES (
        7,
        'Patrícia Marques',
        TO_DATE('01/02/1944', 'DD/MM/YYYY'),
        '77715541212'
    );
INSERT INTO PRODUTO
VALUES (1, 'Mouse', 10);
INSERT INTO PRODUTO
VALUES (2, 'Teclado', 10);
INSERT INTO PRODUTO
VALUES (3, 'Monitor LCD', 10);
INSERT INTO PRODUTO
VALUES (4, 'Caixas Acústicas', 10);
INSERT INTO PRODUTO
VALUES (5, 'Scanner de Mesa', 10);
INSERT INTO PEDIDO
VALUES (
        1,
        1,
        TO_DATE('01/04/2012', 'DD/MM/YYYY'),
        '00001',
        400.00
    );
INSERT INTO ITEMPEDIDO
VALUES (1, 1, 10.90, 1, 1);
INSERT INTO ITEMPEDIDO
VALUES (1, 2, 389.10, 1, 3);
INSERT INTO PEDIDO
VALUES (
        2,
        2,
        TO_DATE('01/04/2012', 'DD/MM/YYYY'),
        '00002',
        10.90
    );
INSERT INTO ITEMPEDIDO
VALUES (2, 1, 10.90, 1, 1);
INSERT INTO PEDIDO
VALUES (
        3,
        2,
        TO_DATE('01/04/2012', 'DD/MM/YYYY'),
        '00003',
        21.80
    );
INSERT INTO ITEMPEDIDO
VALUES (3, 1, 10.90, 1, 1);
INSERT INTO PEDIDO
VALUES (
        4,
        3,
        TO_DATE('01/05/2012', 'DD/MM/YYYY'),
        '00004',
        169.10
    );
INSERT INTO ITEMPEDIDO
VALUES (4, 1, 10.90, 1, 1);
INSERT INTO ITEMPEDIDO
VALUES (4, 2, 15.90, 2, 2);
INSERT INTO ITEMPEDIDO
VALUES (4, 3, 25.50, 1, 4);
INSERT INTO ITEMPEDIDO
VALUES (4, 4, 100.90, 1, 5);
INSERT INTO PEDIDO
VALUES (
        5,
        4,
        TO_DATE('01/05/2012', 'DD/MM/YYYY'),
        '00005',
        100.90
    );
INSERT INTO ITEMPEDIDO
VALUES (5, 1, 100.90, 1, 5);
INSERT INTO PEDIDO
VALUES (
        6,
        6,
        TO_DATE('02/05/2012', 'DD/MM/YYYY'),
        '00006',
        51.35
    );
INSERT INTO ITEMPEDIDO
VALUES (6, 1, 25.50, 2, 4);
CREATE SEQUENCE LOG_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 99999 MINVALUE 1 CACHE 20;
-- ATIVIDADES
-- Crie um TRIGGER para baixar o estoque de um PRODUTO quando ele for vendido;
CREATE OR REPLACE FUNCTION baixar_estoque() RETURNS TRIGGER AS $body$ BEGIN
UPDATE PRODUTO
SET quantidade = quantidade - NEW.quantidade
WHERE codproduto = NEW.codproduto;
RETURN NEW;
END;
$body$ LANGUAGE plpgsql;
CREATE TRIGGER baixar_estoque_trigger
AFTER
INSERT ON ITEMPEDIDO FOR EACH ROW EXECUTE FUNCTION baixar_estoque();
-- Crie um TRIGGER para criar um log dos CLIENTES modificados;
CREATE OR REPLACE FUNCTION log_cliente_modificado() RETURNS TRIGGER AS $$ BEGIN
INSERT INTO LOG(codlog, data, descricao)
VALUES (
        NEXTVAL('LOG_SEQ'),
        NOW(),
        'Cliente modificado: ' || OLD.codcliente
    );
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER log_cliente_modificado_trigger
AFTER
UPDATE ON CLIENTE FOR EACH ROW EXECUTE FUNCTION log_cliente_modificado();
-- Crie um TRIGGER para criar um log dos PRODUTOS atualizados;
CREATE OR REPLACE FUNCTION log_produto_atualizado() RETURNS TRIGGER AS $$ BEGIN
INSERT INTO LOG(codlog, data, descricao)
VALUES (
        NEXTVAL('LOG_SEQ'),
        NOW(),
        'Produto atualizado: ' || OLD.codproduto
    );
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER log_produto_atualizado_trigger
AFTER
UPDATE ON PRODUTO FOR EACH ROW EXECUTE FUNCTION log_produto_atualizado();
-- Crie um TRIGGER para criar um log quando não existir a quantidade do ITEMPEDIDO em estoque;
CREATE OR REPLACE FUNCTION log_itempedido_sem_estoque() RETURNS TRIGGER AS $$
DECLARE quantidade_estoque int;
BEGIN
SELECT quantidade INTO quantidade_estoque
FROM PRODUTO
WHERE codproduto = NEW.codproduto;
IF quantidade_estoque < NEW.quantidade THEN
INSERT INTO LOG(codlog, data, descricao)
VALUES (
        NEXTVAL('LOG_SEQ'),
        NOW(),
        'Não há quantidade suficiente em estoque para o produto: ' || NEW.codproduto
    );
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER log_itempedido_sem_estoque_trigger BEFORE
INSERT ON ITEMPEDIDO FOR EACH ROW EXECUTE FUNCTION log_itempedido_sem_estoque();
-- Crie um TRIGGER para criar uma requisição de REQUISICAO_COMPRA quando o estoque atingir 50% da venda mensal;
CREATE OR REPLACE FUNCTION requisicao_compra() RETURNS TRIGGER AS $$
DECLARE venda_mensal int;
BEGIN
SELECT SUM(quantidade) INTO venda_mensal
FROM ITEMPEDIDO
WHERE codproduto = NEW.codproduto
    AND EXTRACT(
        MONTH
        FROM CURRENT_DATE
    ) = EXTRACT(
        MONTH
        FROM datapedido
    );
IF NEW.quantidade < venda_mensal / 2 THEN
INSERT INTO REQUISICAO_COMPRA(
        codrequisicaocompra,
        codproduto,
        data,
        quantidade
    )
VALUES (
        NEXTVAL('REQUISICAO_COMPRA_SEQ'),
        NEW.codproduto,
        NOW(),
        venda_mensal / 2 - NEW.quantidade
    );
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER requisicao_compra_trigger
AFTER
UPDATE ON PRODUTO FOR EACH ROW EXECUTE FUNCTION requisicao_compra();
-- Crie um TRIGGER para criar um log quando um ITEMPEDIDO for removido;
CREATE OR REPLACE FUNCTION requisicao_compra() RETURNS TRIGGER AS $$
DECLARE venda_mensal int;
BEGIN
SELECT SUM(quantidade) INTO venda_mensal
FROM ITEMPEDIDO
WHERE codproduto = NEW.codproduto
    AND EXTRACT(
        MONTH
        FROM CURRENT_DATE
    ) = EXTRACT(
        MONTH
        FROM datapedido
    );
IF NEW.quantidade < venda_mensal / 2 THEN
INSERT INTO REQUISICAO_COMPRA(
        codrequisicaocompra,
        codproduto,
        data,
        quantidade
    )
VALUES (
        NEXTVAL('REQUISICAO_COMPRA_SEQ'),
        NEW.codproduto,
        NOW(),
        venda_mensal / 2 - NEW.quantidade
    );
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER requisicao_compra_trigger
AFTER
UPDATE ON PRODUTO FOR EACH ROW EXECUTE FUNCTION requisicao_compra();
-- Crie um TRIGGER para NÃO deixar valores negativos serem INSERIDOS em ITEMPEDIDO, o valor mínimo é "0";
CREATE OR REPLACE FUNCTION verificar_valor_negativo() RETURNS TRIGGER AS $$ BEGIN IF NEW.valorunitario < 0
    OR NEW.quantidade < 0 THEN RAISE EXCEPTION 'Valor negativo não permitido';
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER verificar_valor_negativo_trigger BEFORE
INSERT ON ITEMPEDIDO FOR EACH ROW EXECUTE FUNCTION verificar_valor_negativo();
-- Crie um TRIGGER que NÃO permita que uma PESSOA com data de nascimento anterior a data de hoje seja inserida ou atualizada.
CREATE OR REPLACE FUNCTION verificar_data_nascimento() RETURNS TRIGGER AS $$ BEGIN IF NEW.datanascimento > CURRENT_DATE THEN RAISE EXCEPTION 'Data de nascimento não pode ser futura';
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER verificar_data_nascimento_trigger BEFORE
INSERT
    OR
UPDATE ON CLIENTE FOR EACH ROW EXECUTE FUNCTION verificar_data_nascimento();
-- Crie um TRIGGER para não permitir quantidade negativa no ITEMPEDIDO.
CREATE OR REPLACE FUNCTION verificar_quantidade_negativa() RETURNS TRIGGER AS $$ BEGIN IF NEW.quantidade < 0 THEN RAISE EXCEPTION 'Quantidade negativa não é permitida';
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER verificar_quantidade_negativa_trigger BEFORE
INSERT
    OR
UPDATE ON ITEMPEDIDO FOR EACH ROW EXECUTE FUNCTION verificar_quantidade_negativa();
-- Crie um TRIGGER para acrescentar a palavra "Sr(a)" ao nome das PESSOAS que tem nasceram há mais de 30 anos.
CREATE OR REPLACE FUNCTION adicionar_sra() RETURNS TRIGGER AS $$ BEGIN IF (
        EXTRACT(
            YEAR
            FROM AGE(NEW.datanascimento)
        ) > 30
    ) THEN NEW.nome = 'Sr(a) ' || NEW.nome;
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER adicionar_sra_trigger BEFORE
INSERT
    OR
UPDATE ON CLIENTE FOR EACH ROW EXECUTE FUNCTION adicionar_sra();
-- Crie um TRIGGER para retornar a quantidade em estoque de um ITEMPEDIDO que foi removido.
CREATE OR REPLACE FUNCTION retornar_estoque() RETURNS TRIGGER AS $$ BEGIN
UPDATE PRODUTO
SET quantidade = quantidade + OLD.quantidade
WHERE codproduto = OLD.codproduto;
RETURN OLD;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER retornar_estoque_trigger
AFTER DELETE ON ITEMPEDIDO FOR EACH ROW EXECUTE FUNCTION retornar_estoque();
-- Crie um TRIGGER para remover as REQUISICOESCOMPRA de um produto que é removido.
CREATE OR REPLACE FUNCTION remover_requisicoes_compra() RETURNS TRIGGER AS $$ BEGIN
DELETE FROM REQUISICAO_COMPRA
WHERE codproduto = OLD.codproduto;
RETURN OLD;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER remover_requisicoes_compra_trigger
AFTER DELETE ON PRODUTO FOR EACH ROW EXECUTE FUNCTION remover_requisicoes_compra();
-- Crie um TRIGGER que ajuste os pedidos de compra para que não existam itens repetidos, ou seja, quando o mesmo ITEMPEDIDO for inserido deve-se disparar uma mensagem.
CREATE OR REPLACE FUNCTION verificar_item_repetido() RETURNS TRIGGER AS $$
DECLARE item_existente int;
BEGIN
SELECT COUNT(*) INTO item_existente
FROM ITEMPEDIDO
WHERE codpedido = NEW.codpedido
    AND codproduto = NEW.codproduto;
IF item_existente > 0 THEN RAISE EXCEPTION 'Item já existente no pedido';
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER verificar_item_repetido_trigger BEFORE
INSERT ON ITEMPEDIDO FOR EACH ROW EXECUTE FUNCTION verificar_item_repetido();