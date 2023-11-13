-- // Aluno: Carlos Alexandre Sousa Silva
-- Considere o banco de dados da empresa de transporte aéreo mostrado abaixo, em que as chaves primárias estão sublinhadas. Construa as seguintes consultas em SQL para este banco de dados relacional, depois povoe o banco com informações nas tabelas.
-- Piloto (codigo_piloto, nome_piloto, salario, gratificacao, companhia, pais)
CREATE TABLE Piloto (
    codigo_piloto INTEGER NOT NULL,
    nome_piloto VARCHAR(50) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    gratificacao DECIMAL(10, 2) NOT NULL,
    companhia VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    PRIMARY KEY (codigo_piloto)
);
-- Voo (codigo_voo, aeroporto_origem, aeroporto_destino, hora)
CREATE TABLE Voo (
    codigo_voo INTEGER NOT NULL,
    aeroporto_origem INTEGER NOT NULL,
    aeroporto_destino INTEGER NOT NULL,
    hora TIME NOT NULL,
    PRIMARY KEY (codigo_voo),
    FOREIGN KEY (aeroporto_origem) REFERENCES Aeroporto(codigo_aeroporto),
    FOREIGN KEY (aeroporto_destino) REFERENCES Aeroporto(codigo_aeroporto)
);
-- Escala (codigo_voo, data_voo, codigo_piloto, aviao)
CREATE TABLE Escala (
    codigo_voo INTEGER NOT NULL,
    data_voo DATE NOT NULL,
    codigo_piloto INTEGER NOT NULL,
    aviao VARCHAR(50) NOT NULL,
    PRIMARY KEY (codigo_voo, data_voo, codigo_piloto),
    FOREIGN KEY (codigo_voo) REFERENCES Voo(codigo_voo),
    FOREIGN KEY (codigo_piloto) REFERENCES Piloto(codigo_piloto)
);
-- Aeroporto (codigo_aeroporto, nome_aeroporto, cidade, pais)
CREATE TABLE Aeroporto (
    codigo_aeroporto INTEGER NOT NULL,
    nome_aeroporto VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    PRIMARY KEY (codigo_aeroporto)
);
-- Escreva a Visões em SQL para armazenar as Consultas dos dados no esquema acima.
-- Os dados de todos os pilotos de companhias brasileiras.
CREATE VIEW pilotos_brasileiros AS
SELECT *
FROM Piloto
WHERE pais = 'Brasil';
-- O nome de todos os pilotos da Varig.
CREATE VIEW pilotos_varig AS
SELECT nome_piloto
FROM Piloto
WHERE companhia = 'Varig';
-- O nome de todos os pilotos escalados.
CREATE VIEW pilotos_escalados AS
SELECT DISTINCT nome_piloto
FROM Piloto
    NATURAL JOIN Escala;
-- Os códigos do vôos que partem do Brasil.
CREATE VIEW voos_partem_brasil AS
SELECT codigo_voo
FROM Voo
WHERE aeroporto_origem IN (
        SELECT codigo_aeroporto
        FROM Aeroporto
        WHERE pais = 'Brasil'
    );
-- Os pilotos que voam para o seu pais de origem.
CREATE VIEW pilotos_voam_origem AS
SELECT DISTINCT nome_piloto
FROM Piloto
    NATURAL JOIN Escala
    NATURAL JOIN Voo
WHERE pais = Escala.pais;
-- Nome de todos os pilotos, junto com seu salário e gratificação.
CREATE VIEW pilotos_salario_gratificacao AS
SELECT nome_piloto,
    salario,
    gratificacao
FROM Piloto;
-- O código dos vôos com seu respectivo nome dos pilotos e do nome dos seus aeroportos de origem e destino.
CREATE VIEW voos_pilotos_aeroportos AS
SELECT codigo_voo,
    nome_piloto,
    aeroporto_origem,
    aeroporto_destino
FROM Voo
    NATURAL JOIN Escala
    NATURAL JOIN Piloto
    NATURAL JOIN Aeroporto;
-- O código de todos os vôos, nome dos pilotos escalados para os mesmos, e respectivos tipos de avião e companhia.
CREATE VIEW voos_pilotos_aviao_companhia AS
SELECT codigo_voo,
    nome_piloto,
    tipo_aviao,
    companhia
FROM Voo
    NATURAL JOIN Escala
    NATURAL JOIN Piloto
    NATURAL JOIN Aviao;
-- A companhia dos pilotos que voam para a Itália.
CREATE VIEW companhia_pilotos_italia AS
SELECT DISTINCT companhia
FROM Piloto
    NATURAL JOIN Escala
WHERE pais = 'Itália';
-- O nome de todos os aeroportos onde a varig opera.
CREATE VIEW aeroportos_varig AS
SELECT nome_aeroporto
FROM Aeroporto
WHERE codigo_aeroporto IN (
        SELECT aeroporto_origem
        FROM Voo
        WHERE companhia = 'Varig'
    )
    OR codigo_aeroporto IN (
        SELECT aeroporto_destino
        FROM Voo
        WHERE companhia = 'Varig'
    );
-- O maior, o menor e quantidade de pilotos.
CREATE VIEW estatisticas_pilotos AS
SELECT MAX(salario + gratificacao) AS maior_salario,
    MIN(salario + gratificacao) AS menor_salario,
    COUNT(*) AS quantidade_pilotos
FROM Piloto;
-- O maior, o menor e quantidade de pilotos por companhia.
CREATE VIEW estatisticas_pilotos_companhia AS
SELECT companhia,
    MAX(salario + gratificacao) AS maior_salario,
    MIN(salario + gratificacao) AS menor_salario,
    COUNT(*) AS quantidade_pilotos
FROM Piloto
GROUP BY companhia;
-- O maior, o menor e média dos salários dos pilotos de companhias brasileiras.
CREATE VIEW estatisticas_salarios_brasileiros AS
SELECT MAX(salario + gratificacao) AS maior_salario,
    MIN(salario + gratificacao) AS menor_salario,
    AVG(salario + gratificacao) AS media_salarios
FROM Piloto
WHERE companhia IN (
        SELECT DISTINCT companhia
        FROM Piloto
        WHERE pais = 'Brasil'
    );
-- O total da folha de pagamento por companhias.
CREATE VIEW folha_pagamento_companhias AS
SELECT companhia,
    SUM(salario + gratificacao) AS total_folha_pagamento
FROM Piloto
GROUP BY companhia;
-- O total de pilotos por pais.
CREATE VIEW total_pilotos_pais AS
SELECT pais,
    COUNT(*) AS total_pilotos
FROM Piloto
GROUP BY pais;
-- O Número de Aeroporto por Cidade Brasileira.
CREATE VIEW numero_aeroportos_cidade_brasileira AS
SELECT cidade,
    COUNT(*) AS numero_aeroportos
FROM Aeroporto
WHERE pais = 'Brasil'
GROUP BY cidade;