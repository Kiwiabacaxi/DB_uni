-- Criar apenas as tabelas e depois adicionar as chaves estrangeiras
CREATE TABLE imoveis (
    cdimovel INTEGER,
    rua VARCHAR(60),
    numero INTEGER,
    nrareautil DECIMAL(10, 2),
    areatotal DECIMAL(10, 2),
    descricaodoimovel VARCHAR(100),
    vlpreco VARCHAR(10),
    nrofertas VARCHAR(10),
    statusvendido CHAR(1),
    dtlancamento DATE,
    imovel_indicado VARCHAR(10),
    cdvendedor INTEGER,
    -- foreign key
    cdbairro INTEGER,
    -- foreign key
    sgestado CHAR(2),
    -- foreign key
    cdcidade INTEGER,
    -- foreign key
    PRIMARY KEY (cdimovel) -- FOREIGN KEY (cdbairro, sgestado, cdcidade) REFERENCES bairro (cdbairro, sgestado, cdcidade),
    -- FOREIGN KEY (cdvendedor) REFERENCES vendedor (cdvendedor)
);
CREATE TABLE bairro (
    cdbairro INTEGER,
    -- primary key & foreign key
    sgestado CHAR(2),
    -- primary key & foreign key
    cdcidade INTEGER,
    -- primary key
    nomebairro VARCHAR(10),
    PRIMARY KEY (cdbairro, sgestado, cdcidade) -- FOREIGN KEY (sgestado) REFERENCES estado (sgestado),
    -- FOREIGN KEY (cdcidade) REFERENCES cidade (cdcidade)
);
CREATE TABLE cidade (
    cdcidade INTEGER,
    -- primary key
    sgestado CHAR(2),
    -- primary key & foreign key
    nmcidade VARCHAR(10),
    PRIMARY KEY (cdcidade, sgestado) -- FOREIGN KEY (sgestado) REFERENCES estado (sgestado)
);
CREATE TABLE estado (
    sgestado CHAR(2),
    -- primary key
    nmestado VARCHAR(10),
    PRIMARY KEY (sgestado)
);
CREATE TABLE oferta (
    cdimovel INTEGER,
    -- foreign key
    cdcomprador INTEGER,
    -- foreign key
    vloferta NUMERIC(10, 2),
    dataoferta DATE,
    PRIMARY KEY (cdimovel, cdcomprador)
    -- FOREIGN KEY (cdimovel) REFERENCES imoveis (cdimovel),
    -- FOREIGN KEY (cdcomprador) REFERENCES comprador (cdcomprador)
);
CREATE TABLE comprador (
    cdcomprador INTEGER,
    -- primary key
    cpf VARCHAR(10),
    nmcomprador VARCHAR(10),
    endereco VARCHAR(10),
    cidade VARCHAR(10),
    bairro VARCHAR(10),
    estado CHAR(2),
    email VARCHAR(10),
    PRIMARY KEY (cdcomprador)
);
CREATE TABLE telefone_comprador (
    telefone_pk INTEGER,
    -- primary key
    telefone VARCHAR(10),
    cdcomprador_fk INTEGER,
    -- foreign key
    PRIMARY KEY (telefone_pk)
    -- FOREIGN KEY (cdcomprador_fk) REFERENCES comprador (cdcomprador)
);
CREATE TABLE vendedor (
    cdvendedor INTEGER,
    -- primary key
    email VARCHAR(10),
    nmvendedor VARCHAR(10),
    nmestado VARCHAR(10),
    nmrcpf VARCHAR(10),
    nmbairro VARCHAR(10),
    nmcidade VARCHAR(10),
    PRIMARY KEY (cdvendedor)
);
CREATE TABLE telefone_vendedor (
    telefone_pk INTEGER,
    -- primary key
    telefone VARCHAR(10),
    cdvendedor_fk INTEGER,
    -- foreign key
    PRIMARY KEY (telefone_pk)
    -- FOREIGN KEY (cdvendedor_fk) REFERENCES vendedor (cdvendedor)
);
-- relacionamentos com chaves estrangeiras usando alter table

-- imoveis
ALTER TABLE imoveis ADD FOREIGN KEY (cdbairro, sgestado, cdcidade) REFERENCES bairro (cdbairro, sgestado, cdcidade);
ALTER TABLE imoveis ADD FOREIGN KEY (cdvendedor) REFERENCES vendedor (cdvendedor);

-- bairro
ALTER TABLE bairro ADD FOREIGN KEY (sgestado, cdcidade) REFERENCES cidade (sgestado, cdcidade);

-- cidade
ALTER TABLE cidade ADD FOREIGN KEY (sgestado) REFERENCES estado (sgestado);

-- oferta
ALTER TABLE oferta ADD FOREIGN KEY (cdimovel, cdcomprador) REFERENCES oferta (cdimovel, cdcomprador);

-- comprador
ALTER TABLE telefone_comprador ADD FOREIGN KEY (cdcomprador_fk) REFERENCES comprador (cdcomprador);

-- vendedor
ALTER TABLE telefone_vendedor ADD FOREIGN KEY (cdvendedor_fk) REFERENCES vendedor (cdvendedor);

-- ATIVIDADES

-- 1 Inclua linhas na tabela ESTADO:

 -- alter table para alterar o tipo de dado de nmestado para varchar(20)
ALTER TABLE estado ALTER COLUMN nmestado TYPE VARCHAR(20);
 -- inserir linhas na tabela estado
INSERT INTO estado VALUES ('SP', 'São Paulo');
INSERT INTO estado VALUES ('RJ', 'Rio de Janeiro');
 -- mostrar as linhas da tabela estado
SELECT * FROM estado;

-- 2 Inclua linhas na tabela CIDADE:

    -- alter table para alterar o tipo de dado de nmcidade para varchar(20)
ALTER TABLE cidade ALTER COLUMN nmcidade TYPE VARCHAR(20);
    -- inserir linhas na tabela cidade
    -- cidade cdcidade, sgestado, nmcidade
INSERT INTO cidade VALUES (1, 'SP', 'São Paulo');
INSERT INTO cidade VALUES (2, 'SP', 'Santo André');
INSERT INTO cidade VALUES (3, 'SP', 'Campinas');
INSERT INTO cidade VALUES (1, 'RJ', 'Rio de Janeiro');
INSERT INTO cidade VALUES (2, 'RJ', 'Niterói');


-- 3 Inclua linhas na tabela BAIRRO:
    
        -- alter table para alterar o tipo de dado de nomebairro para varchar(20)
ALTER TABLE bairro ALTER COLUMN nomebairro TYPE VARCHAR(20);
        -- inserir linhas na tabela bairro
        -- bairro cdbairro, sgestado, cdcidade, nomebairro
INSERT INTO bairro VALUES (1, 'SP', 1, 'JARDINS');
INSERT INTO bairro (cdbairro, sgestado, cdcidade, nomebairro) VALUES 
(2, 'SP', 1, 'MORUMBI'),
(3, 'SP', 1, 'AEROPORTO'),
(1, 'RJ', 1, 'AEROPORTO'),
(2, 'RJ', 1, 'FLAMENGO');

-- 4 Inclua linhas na tabela VENDEDOR:

    -- alter table para alterar o tipo de dado de nmvendedor para varchar(20)
ALTER TABLE vendedor ALTER COLUMN nmvendedor TYPE VARCHAR(20);
    -- alter table para alterar o tipo de dado de email para varchar(50)
ALTER TABLE vendedor ALTER COLUMN email TYPE VARCHAR(50);
    -- alter table para adicionar a coluna nmendereco varchar(20)
ALTER TABLE vendedor ADD COLUMN nmendereco VARCHAR(20);

    -- inserir linhas na tabela vendedor
    -- cdvendedor, nmvendedor, nmendereco, email
INSERT INTO vendedor (cdvendedor, nmvendedor, nmendereco, email) VALUES 
(1, 'MARIA DA SILVA', 'RUA DO GRITO, 45', 'msilva@mednet.com.br'),
(2, 'MARCOS ANDRADE', 'AV. DA SAUDADE, 325', 'mandrade@mednet.com.br'),
(3, 'ANDRE CARDOSO', 'AV. BRASIL, 401', 'acardoso@mednet.com.br'),
(4, 'TATIANA SOUZA', 'RUA DO IMPERADOR', 'tsouza@mednet.com.br'),
(5, 'JUÃO DA SILVA', 'RUA DO GRITO, 45', 'juaodasilva@mednet.com.br');

-- mostrar as linhas da tabela vendedor
select * from vendedor

-- 5 Inclua linhas na tabela IMOVEL:

    -- alter table para criar a coluna nmendereco varchar(30)
ALTER TABLE imoveis ADD COLUMN nmendereco VARCHAR(30);
    -- inserir linhas na tabela imoveis
    -- CDIMOVEL,CDVENDEDOR,CDBAIRRO,CDCID,SGE,NMENDERECO,nrareautil,NRAREATOR,VLPRECO,IMOVEL_INDICADO
INSERT INTO imoveis (cdimovel, cdvendedor, cdbairro, cdcidade, sgestado, nmendereco, nrareautil, areatotal, vlpreco, imovel_indicado) 
VALUES 
(1, 1, 1, 1, 'SP', 'AL TIETE,3304', 250, 400, 180000, NULL),
(2, 1, 2, 1, 'SP', 'AV MORUMBI,2230', 150, 250, 135000, 1),
(3, 2, 1, 1, 'RJ', 'R GAL OSORIO, 445', 250, 400, 185000, 2),
(4, 2, 2, 1, 'RJ', 'R PEDRO I, 882', 120, 200, 110000, 1),
(5, 3, 3, 1, 'SP', 'AV RUBEM BERTA, 2355', 110, 200, 95000, 4),
(6, 4, 1, 1, 'RJ', 'R GETULIO VARGAS, 552', 200, 300, 99000, 5);
 
-- 6 Inclua linhas na tabela OFERTA

    -- inserir linhas na tabela oferta
    -- CDIMOVEL, CDCOMPRADOR, VLOFERTA, DATAOFERTA
INSERT INTO oferta (cdcomprador, cdimovel, vloferta, dataoferta) 
VALUES 
(1, 1, 170000, '2002-01-10'),
(1, 3, 180000, '2002-01-10'),
(2, 2, 135000, '2002-02-15'),
(2, 4, 100000, '2002-02-15'),
(3, 1, 160000, '2002-01-05'),
(3, 2, 140000, '2002-02-20');




-- 7 Incluir linhas na tabela comprador

    -- alter table para alterar o tipo de dado de nmcomprador para varchar(50)
ALTER TABLE comprador ALTER COLUMN nmcomprador TYPE VARCHAR(50);
    -- alter table para alterar o tipo de dado de endereco para varchar(50)
ALTER TABLE comprador ALTER COLUMN endereco TYPE VARCHAR(50);
    -- alter table para alterar o tipo de dado de cidade para varchar(50)
ALTER TABLE comprador ALTER COLUMN cidade TYPE VARCHAR(50);
    -- alter table para alterar o tipo de dado de bairro para varchar(50)
ALTER TABLE comprador ALTER COLUMN bairro TYPE VARCHAR(50);
    -- alter table para alterar o tipo de dado de email para varchar(50)
ALTER TABLE comprador ALTER COLUMN email TYPE VARCHAR(50);
    -- alter table para alterar o tipo de dados de cpf para varchar(12)
ALTER TABLE comprador ALTER COLUMN cpf TYPE VARCHAR(12);

    -- inserir linhas na tabela comprador
    -- cdcomprador, cpf, nmcomprador, endereco, cidade, bairro, estado, email


INSERT INTO comprador (cdcomprador, cpf, nmcomprador, endereco, cidade, bairro, estado, email)
VALUES 
(1, '11111111111', 'JOÃO DA SILVA', 'RUA DO GRITO, 45', 'SÃO PAULO', 'JARDINS', 'SP', 'jao@email.com'),
(2, '22222222222', 'MARIA DA SILVA', 'RUA DO GRITO, 45', 'SÃO PAULO', 'JARDINS', 'SP', 'maria@email.com'),
(3, '33333333333', 'MARCOS ANDRADE', 'AV. DA SAUDADE, 325', 'SÃO PAULO', 'MORUMBI', 'SP', 'marcos@email.com');


----------- atividade 2

    -- converter o tipo de dado de vloferta para decimal(10,2)
    ALTER TABLE oferta ALTER COLUMN vloferta TYPE DECIMAL(10,2);

    -- converter o tipo de dado de vlpreco para decimal(10,2)
    ALTER TABLE imoveis ALTER COLUMN vlpreco TYPE DECIMAL(10,2) USING vlpreco::numeric(10,2);

    -- Aumente o preço de venda dos imóveis em 10%.
    UPDATE imoveis SET vlpreco = vlpreco * 1.1;

    -- Abaixe o preço de venda dos imóveis do vendedor 1 em 5%.
    UPDATE imoveis SET vlpreco = vlpreco * 0.95 WHERE cdvendedor = 1;

    -- Aumente em 5% o valor das ofertas do comprador 2.
    UPDATE oferta SET vloferta = vloferta * 1.05 WHERE cdcomprador = 2;

    -- * (extra) aumentar o tamanho de endereço para varchar(40)
    ALTER TABLE comprador ALTER COLUMN endereco TYPE VARCHAR(40);

    -- Altere o endereço do comprador 3 para RANANÁS, 45 e o estado para RJ.
    UPDATE comprador SET endereco = 'RANANÁS, 45', estado = 'RJ' WHERE cdcomprador = 3;

    -- Altere a oferta do comprador 2 no imóvel 4 para 101.000;
    UPDATE oferta SET vloferta = 101000 WHERE cdcomprador = 2 AND cdimovel = 4;
    
    -- Exclua a oferta do comprador 3 no imóvel 1.
    DELETE FROM oferta WHERE cdcomprador = 3 AND cdimovel = 1;
    
    -- Exclua a cidade 3 do Estado SP.
    DELETE FROM cidade WHERE cdcidade = 3 AND sgestado = 'SP';

    -- Liste todos os campos e linhas da tabela BAIRRO.
    SELECT * FROM bairro;

    -- Liste todas as linhas e os campos CDCOMPRADOR, NMCOMPRADOR e EMAIL da tabela COMPRADOR.
    SELECT cdcomprador, nmcomprador, email FROM comprador;

    -- Liste todas as linhas e os campos CDVENDEDOR, NMVENDEDOR e EMAIL da tabela VENDEDOR em ordem alfabética.
    SELECT cdvendedor, nmvendedor, email FROM vendedor ORDER BY nmvendedor ASC;

    -- Repita o comando anterior em ordem alfabética decrescente.
    SELECT cdvendedor, nmvendedor, email FROM vendedor ORDER BY nmvendedor DESC;
    
    -- Liste todos os bairros do Estado de SP.
    SELECT * FROM bairro WHERE sgestado = 'SP';
    
    -- Liste as colunas CDIMOVEL, CDVENDEDOR e VLPRECO de todos os imóveis do vendedor 2.
    SELECT cdimovel, cdvendedor, vlpreco FROM imoveis WHERE cdvendedor = 2;

    -- Liste as colunas CDIMOVEL, CDVENDEDOR, VLPRECO e SGESTADO dos imóveis cujo preço de venda seja inferior a 150 mil e sejam do estado do RJ.
    SELECT cdimovel, cdvendedor, vlpreco, sgestado FROM imoveis WHERE vlpreco < 150000 AND sgestado = 'RJ';

    -- Liste as colunas CDIMOVEL, CDVENDEDOR, VLPRECO e SGESTADO dos imóveis cujo preço de venda seja inferior a 150 mil ou seja do  vendedor 1.
    SELECT cdimovel, cdvendedor, vlpreco, sgestado FROM imoveis WHERE vlpreco < 150000 OR cdvendedor = 1;
    
    -- Liste as colunas CDIMOVEL, CDVENDEDOR, VLPRECO e SGESTADO dos imóveis cujo preço de venda seja inferior a 150 mil e o vendedor não seja 2.
    SELECT cdimovel, cdvendedor, vlpreco, sgestado FROM imoveis WHERE vlpreco < 150000 AND cdvendedor != 2;
    
    -- Liste as colunas CDCOMPRADOR, NMCOMPRADOR, NMENDERECO e SGESTADO da tabela COMPRADOR em que o Estado seja nulo.
    SELECT cdcomprador, nmcomprador, endereco, estado FROM comprador WHERE estado IS NULL;
    
    -- Liste as colunas CDCOMPRADOR, NMCOMPRADOR, NMENDERECO e SGESTADO da tabela COMPRADOR em que o Estado não seja nulo.
    SELECT cdcomprador, nmcomprador, endereco, estado FROM comprador WHERE estado IS NOT NULL;
    
    -- Liste dotas as ofertas cujo valor esteja entre 100 mil e 150 mil.
    SELECT * FROM oferta WHERE vloferta BETWEEN 100000 AND 150000;

    -- Liste todas as ofertas cuja data da oferta esteja entre ‘01/02/02’ e ‘01/03/02’.
    SELECT * FROM oferta WHERE dataoferta BETWEEN '2002-02-01' AND '2002-03-01';

    -- Liste todos os vendedores que comecem com a letra M.
    SELECT * FROM vendedor WHERE nmvendedor LIKE 'M%';

    -- Liste todos os vendedores que tenham a letra A na segunda posição do nome.
    SELECT * FROM vendedor WHERE nmvendedor LIKE '_A%';

    -- Liste todos os compradores que tenham a letra U em qualquer posição do endereço.
    SELECT * FROM comprador WHERE endereco LIKE '%U%';

    -- Liste todas as ofertas cujo imóvel seja 1 ou 2.
    SELECT * FROM oferta WHERE cdimovel IN (1, 2);

    -- Liste todos os imóveis cujo código seja 2 ou 3 em ordem alfabética de endereço.
    SELECT * FROM imoveis WHERE cdimovel IN (2, 3) ORDER BY nmendereco ASC;

    -- Liste todas as ofertas cujo imóvel seja 2 ou 3  e o valor da oferta seja maior que 140 mil, em ordem decrescente de data.
    SELECT * FROM oferta WHERE cdimovel IN (2, 3) AND vloferta > 140000 ORDER BY dataoferta DESC;
    
    -- Liste todos os imóveis cujo preço de venda esteja entre 110 mil e 200 mil ou seja do vendedor 1 em ordem de área útil.
    SELECT * FROM imoveis WHERE (vlpreco BETWEEN 110000 AND 200000) OR cdvendedor = 1 ORDER BY nrareautil ASC;

    -- Escreva uma busca que mostre CDIMOVEL, VLPRECO e VLPRECO com 10% de aumento.
    SELECT cdimovel, vlpreco, vlpreco * 1.1 FROM imoveis;

    -- Escreva uma busca igual à anterior, porém acrescente uma coluna mostrando a diferença entre VLPRECO e VLPRECO com 10% de aumento.
    SELECT cdimovel, vlpreco, vlpreco * 1.1, vlpreco * 1.1 - vlpreco FROM imoveis;
    
    -- Escreva uma busca que mostre o NMVENDEDOR em letras maiúsculas e Email em letras minúsculas.
    SELECT UPPER(nmvendedor), LOWER(email) FROM vendedor;
    
    -- Escreva uma busca que mostre o NMCOMPRADOR  e NMCIDADE em uma única coluna e separados por um hífen.
    SELECT nmcomprador || ' - ' || cidade FROM comprador;
    
    -- Escreva uma busca que mostre todos os compradores que tenham a letra A no nome.
    SELECT * FROM comprador WHERE nmcomprador LIKE '%A%';
    
    -- Escreva uma busca que mostre todos os compradores que o campo nome dos compradores não seja nulo.
    SELECT * FROM comprador WHERE nmcomprador IS NOT NULL;
    
    -- Escreva uma busca que mostre todos os imóveis do estado de São Paulo
    SELECT * FROM imoveis WHERE sgestado = 'SP';
    
    -- Escreva uma busca que mostre todos os imóveis com preço maior que 100000 Reais.
    SELECT * FROM imoveis WHERE vlpreco > 100000;
    
    -- Escreva uma busca que mostre o NMVENDEDOR, NMENDERECO e NMCIDADE da cidade de Ribeirão Preto e estado de São Paulo.
    SELECT v.nmvendedor, i.nmendereco, c.nmcidade FROM vendedor v, imoveis i, cidade c WHERE v.cdvendedor = i.cdvendedor AND i.cdcidade = c.cdcidade AND c.nmcidade = 'Ribeirão Preto' AND c.sgestado = 'SP';
    
    -- Escreva uma busca que mostre o imóvel localizado no estado de São Paulo ou o estado Minas Gerais.
    SELECT * FROM imoveis WHERE sgestado = 'SP' OR sgestado = 'MG';
    
    -- Faça uma busca que mostre CDIMOVEL, CD VENDEDOR, NMVENDEDOR e  SGESTADO;
    SELECT i.cdimovel, i.cdvendedor, v.nmvendedor, i.sgestado FROM imoveis i, vendedor v WHERE i.cdvendedor = v.cdvendedor;
    
    -- Faça uma busca que mostre CDCOMPRADOR, NMCOMPRADOR, CDIMOVEL e VLOFERTA;
    SELECT c.cdcomprador, c.nmcomprador, o.cdimovel, o.vloferta FROM comprador c, oferta o WHERE c.cdcomprador = o.cdcomprador;

    -- Faça uma busca que mostre CDIMOVEL, VLPRECO  e NMBAIRRO, cujo código do vendedor seja 2;
    SELECT i.cdimovel, i.vlpreco, b.nomebairro FROM imoveis i, bairro b WHERE i.cdbairro = b.cdbairro AND i.cdvendedor = 2;
    
    -- Faça uma busca que mostre todos os imóveis que tenham ofertas cadastradas.
    SELECT * FROM imoveis WHERE nrofertas > 0;

    -- Faça uma busca  que mostre os imóveis e ofertas  mesmo que não haja ofertas cadastradas para o imóvel;
    SELECT * FROM imoveis WHERE nrofertas >= 0;
    
    -- Faça uma busca que mostre todos os compradores e as respectivas ofertas realizadas por eles;
    SELECT c.nmcomprador, o.vloferta FROM comprador c, oferta o WHERE c.cdcomprador = o.cdcomprador;
    
    -- Faça a mesma busca, porém acrescentando os compradores que ainda não fizeram ofertas para os imóveis;
    SELECT c.nmcomprador, o.vloferta FROM comprador c LEFT JOIN oferta o ON c.cdcomprador = o.cdcomprador;
    
    -- Faça uma busca anterior o nome dos vendedores de imóveis e os endereços dos imóveis indicados;
    SELECT v.nmvendedor, i.nmendereco FROM vendedor v LEFT JOIN imoveis i ON v.cdvendedor = i.cdvendedor;
    
    -- Acrescente à busca anterior o  nome dos vendedores tanto do imóvel quanto do imóvel indicado;
    SELECT c.nmcomprador, o.cdimovel, o.vloferta FROM comprador c LEFT JOIN oferta o ON c.cdcomprador = o.cdcomprador;

    -- Faça uma busca que mostre  o endereço do imóvel, o bairro e o nível de preço do imóvel.
    SELECT i.nmendereco, b.nomebairro, i.vlpreco FROM imoveis i, bairro b WHERE i.cdbairro = b.cdbairro;
    
    -- Verifique a maior, a menor e o valor médio das ofertas da tabela;
    SELECT MAX(vloferta), MIN(vloferta), AVG(vloferta) FROM oferta;
    
    -- Verifique o desvio-padrão e a variância do preço de venda dos imóveis;
    SELECT STDDEV(vlpreco), VARIANCE(vlpreco) FROM imoveis;
    
    -- Refaça o comando anterior mostrando o resultado em formato decimal com duas casas depois da vírgula;
    SELECT ROUND(STDDEV(vlpreco), 2), ROUND(VARIANCE(vlpreco), 2) FROM imoveis;
    
    -- Mostre o maior, o menor, o total e a média de preço de venda dos imóveis.
    SELECT MAX(vlpreco), MIN(vlpreco), SUM(vlpreco), AVG(vlpreco) FROM imoveis;

    -- Modifique o comando anterior para que seja mostrados os mesmos índices por bairro;
    SELECT b.nomebairro, MAX(i.vlpreco), MIN(i.vlpreco), SUM(i.vlpreco), AVG(i.vlpreco) FROM imoveis i, bairro b WHERE i.cdbairro = b.cdbairro GROUP BY b.nomebairro;

    -- Faça uma busca que retorne o total de imóveis por vendedor. Apresente em ordem total de imóveis;
    SELECT i.cdvendedor, COUNT(i.cdimovel) FROM imoveis i GROUP BY i.cdvendedor ORDER BY COUNT(i.cdimovel) DESC;

    -- Verifique a diferença de preços entre o maior e o menor imóvel da tabela;
    SELECT MAX(vlpreco) - MIN(vlpreco) FROM imoveis;

    -- Mostre o código do vendedor e o menor preço de imóvel dele no cadastro. Exclua da busca os valores de imóveis inferiores a 10 mil;
    SELECT i.cdvendedor, MIN(i.vlpreco) FROM imoveis i WHERE i.vlpreco > 10000 GROUP BY i.cdvendedor;

    -- Mostre o código e o nome do comprador e a média do valor das ofertas e o número de ofertas deste comprador;
    SELECT c.cdcomprador, c.nmcomprador, AVG(o.vloferta), COUNT(o.vloferta) FROM comprador c, oferta o WHERE c.cdcomprador = o.cdcomprador GROUP BY c.cdcomprador;
    
    -- Faça uma busca que retorne o total de ofertas realizadas nos anos de 2000, 2001 e 2002.
    SELECT COUNT(o.vloferta) FROM oferta o WHERE o.dataoferta BETWEEN '2000-01-01' AND '2002-12-31';
