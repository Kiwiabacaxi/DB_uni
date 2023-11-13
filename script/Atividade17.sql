-- PRODUTOS produtoid nome categoriaid preco estoque
CREATE TABLE PRODUTOS (
    produtoid INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(50) NOT NULL,
    categoriaid INTEGER NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INTEGER NOT NULL
);
-- CATEGORIAS categoriaid(PK) nome descrição
CREATE TABLE CATEGORIAS (
    categoriaid INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(100) NOT NULL
);
-- ITENSPEDIDOS itenspedidosid produtoid preco quantidade
CREATE TABLE ITENSPEDIDOS (
    itenspedidosid INTEGER PRIMARY KEY AUTOINCREMENT,
    produtoid INTEGER NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade INTEGER NOT NULL
);
-- PEDIDOS pedidoid clienteid data frete
CREATE TABLE PEDIDOS (
    pedidoid INTEGER PRIMARY KEY AUTOINCREMENT,
    clienteid INTEGER NOT NULL,
    data DATE NOT NULL,
    frete DECIMAL(10, 2) NOT NULL
);
-- CLIENTES nome endereco cidade cep pais email
CREATE TABLE CLIENTES (
    clienteid INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(50) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    cep VARCHAR(10) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL
);
-- produtos relaciona com categorias e itenspedidos
ALTER TABLE PRODUTOS
ADD FOREIGN KEY (categoriaid) REFERENCES CATEGORIAS(categoriaid);
ALTER TABLE ITENSPEDIDOS
ADD FOREIGN KEY (produtoid) REFERENCES PRODUTOS(produtoid);
-- itenspedidos relaciona com produtos e pedidos
ALTER TABLE ITENSPEDIDOS
ADD FOREIGN KEY (pedidoid) REFERENCES PEDIDOS(pedidoid);
-- pedidos relaciona com cliente 
ALTER TABLE PEDIDOS
ADD FOREIGN KEY (clienteid) REFERENCES CLIENTES(clienteid);
-- Criar funções, usando a linguagem SQL, de acordo com as especificações abaixo. 
--     Criar uma função para excluir um registro de cliente da tabela clientes. Observar que o cliente poderá estar vinculado a vendas e itens de vendas através de chaves estrangeiras, portanto, é necessário excluir também os registro vinculados. A função deverá receber como parâmetro o código do cliente a ser excluído e retornar o código do cliente excluído.
CREATE OR REPLACE FUNCTION excluir_cliente (clienteid integer) RETURNS integer AS $body$ BEGIN
DELETE FROM CLIENTES
WHERE clienteid = clienteid;
DELETE FROM PEDIDOS
WHERE clienteid = clienteid;
DELETE FROM ITENSPEDIDOS
WHERE pedidoid = pedidoid;
RETURN clienteid;
END;
$body$ LANGUAGE plpgsql;
--     Criar uma função para inserir um produto perecível na tabela de produtos. A função deverá receber a descrição do produto e a data de validade como parâmetros e retornar o registro inserido.
CREATE OR REPLACE FUNCTION inserir_produto_perecivel (descricao varchar(100), data_validade date) RETURNS PRODUTOS AS $body$ BEGIN
INSERT INTO PRODUTOS (nome, categoriaid, preco, estoque)
VALUES (descricao, 1, 0, 0);
RETURN PRODUTOS;
END;
$body$ LANGUAGE plpgsql;
--     Criar uma função para excluir todos os produtos que não estiverem presentes em nenhuma venda, isto é, aqueles que não são usados na tabela produtos_venda. Consulte a documentação do comando DELETE do PostgreSQL para verificar como isto pode ser feito com o auxílio de um SELECT.
CREATE OR REPLACE FUNCTION excluir_produtos_sem_venda () RETURNS void AS $body$ BEGIN
DELETE FROM PRODUTOS
WHERE produtoid NOT IN (
        SELECT produtoid
        FROM ITENSPEDIDOS
    );
END;
$body$ LANGUAGE plpgsql;
--     Executar as funções criadas para confirmar a sua funcionalidade.
SELECT excluir_cliente(1);
SELECT inserir_produto_perecivel('teste', '2021-01-01');
SELECT excluir_produtos_sem_venda();