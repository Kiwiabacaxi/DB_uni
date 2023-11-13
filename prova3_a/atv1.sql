-- Criação do banco de dados
CREATE TABLE Address (
    AddressId INTEGER NOT NULL,
    SNumber CHAR(10) NOT NULL,
    Street CHAR(100) NOT NULL,
    City CHAR(20) NOT NULL,
    Province CHAR(2) NOT NULL,
    PCode CHAR(6) NOT NULL,
    IsHquarters CHAR(1) NOT NULL,
    PRIMARY KEY (AddressId)
);
CREATE TABLE ClassTable (
    Class CHAR(1) NOT NULL,
    CDesc VARCHAR(20) NOT NULL,
    PRIMARY KEY (Class)
);
CREATE TABLE Car (
    CarId INTEGER NOT NULL,
    Make CHAR(10) NOT NULL,
    Model CHAR(20) NOT NULL,
    Year CHAR(4) NOT NULL,
    Colour CHAR(10) NOT NULL,
    LPlate CHAR(8) NOT NULL,
    CLocation INTEGER,
    Class CHAR(1),
    PRIMARY KEY (CarId),
    FOREIGN KEY (CLocation) REFERENCES Address (AddressId),
    FOREIGN KEY (Class) REFERENCES ClassTable
);
CREATE TABLE Person (
    DLicense CHAR(20) NOT NULL,
    FName CHAR(50) NOT NULL,
    LName CHAR(50) NOT NULL,
    AddressId INTEGER NOT NULL,
    PRIMARY KEY (DLicense),
    FOREIGN KEY (AddressId) REFERENCES Address
);
CREATE TABLE Phone (
    DLicense CHAR(20) NOT NULL,
    Phone CHAR(20) NOT NULL,
    PRIMARY KEY (DLicense, Phone),
    FOREIGN KEY (DLicense) REFERENCES Person
);
CREATE TABLE ETypeTable (
    EType CHAR(1) NOT NULL,
    PRIMARY KEY (EType)
);
CREATE TABLE Employee (
    DLicense CHAR(20) NOT NULL,
    Location INTEGER NOT NULL,
    EType CHAR(1) NOT NULL,
    IsPres CHAR(1) NOT NULL,
    IsVicePres CHAR(1) NOT NULL,
    PRIMARY KEY (DLicense),
    FOREIGN KEY (DLicense) REFERENCES Person,
    FOREIGN KEY (Location) REFERENCES Address (AddressId),
    FOREIGN KEY (EType) REFERENCES ETypeTable
);
CREATE TABLE Customer (
    DLicense CHAR(20) NOT NULL,
    PRIMARY KEY (DLicense),
    FOREIGN KEY (DLicense) REFERENCES Person
);
CREATE TABLE PRate (
    Duration CHAR(1) NOT NULL,
    Class CHAR(1) NOT NULL,
    Amount DECIMAL(8, 2) NOT NULL,
    PRIMARY KEY (Duration, Class),
    FOREIGN KEY (Class) REFERENCES ClassTable
);
CREATE TABLE Promo (
    Duration CHAR(1) NOT NULL,
    Class CHAR(1) NOT NULL,
    FromDate DATE NOT NULL,
    Percentage DECIMAL(4, 2) NOT NULL,
    PRIMARY KEY (Duration, Class),
    FOREIGN KEY (Duration, Class) REFERENCES PRate
);
CREATE TABLE Rental (
    RentalId INTEGER NOT NULL,
    DLicense CHAR(20) NOT NULL,
    CarId INTEGER NOT NULL,
    FromLocation INTEGER NOT NULL,
    DropoffLocation INTEGER NOT NULL,
    FromDate DATE NOT NULL,
    ToDate DATE,
    Tank CHAR(1) NOT NULL,
    InitOdo INTEGER NOT NULL,
    ReturnOdo INTEGER,
    PRIMARY KEY (RentalId),
    FOREIGN KEY (CarId) REFERENCES Car,
    FOREIGN KEY (DLicense) REFERENCES Customer,
    FOREIGN KEY (FromLocation) REFERENCES Address (AddressId),
    FOREIGN KEY (DropoffLocation) REFERENCES Address (AddressId)
);
CREATE TABLE RentalRate (
    RentalId INTEGER NOT NULL,
    Duration CHAR(1) NOT NULL,
    Class CHAR(1) NOT NULL,
    Count INTEGER NOT NULL,
    PRIMARY KEY (RentalId, Duration, Class),
    FOREIGN KEY (RentalId) REFERENCES Rental,
    FOREIGN KEY (Duration, Class) REFERENCES PRate
);
CREATE TABLE DropoffCharge (
    Class CHAR(1) NOT NULL,
    FromLocation INTEGER NOT NULL,
    ToLocation INTEGER NOT NULL,
    Charge DECIMAL(4, 2) NOT NULL,
    PRIMARY KEY (Class, FromLocation, ToLocation),
    FOREIGN KEY (Class) REFERENCES ClassTable,
    FOREIGN KEY (FromLocation) REFERENCES Address (AddressId),
    FOREIGN KEY (ToLocation) REFERENCES Address (AddressId)
);
-- #######################################
-- TEXTO DA PROVA
-- Aluguel de carros
-- Nossa empresa faz negócios de aluguel de carros e possui vários locais com endereço diferente (endereço consiste em rua ou rota rural com o número, cidade, província e código postal). Os carros são classificados como subcompactos, compactos, sedãs ou luxo. Cada carro tem uma marca, modelo, ano de fabricação e cor específicos. Cada carro tem um número de identificação único e uma placa única.
-- Os carros alugados em um determinado local podem ser devolvidos em um local diferente (o chamado drop off). Para cada carro, mantemos a leitura do hodômetro antes de ser alugado e depois de devolvido. Como confiamos em nossos clientes, não registramos o defeito quando o carro é alugado e devolvido. No entanto, alugamos o carro com o tanque cheio e registramos o volume de gasolina no tanque quando o carro é devolvido, mas apenas indicamos se o tanque está vazio, um quarto cheio, meio cheio, três quartos cheio ou cheio.
-- Acompanhamos o dia em que o carro foi alugado, mas não o horário, da mesma forma para a devolução do carro. Se um cliente solicitar uma classe específica (digamos, sedan), podemos alugar ao cliente um carro de classe superior se não tivermos a classe solicitada em estoque, mas iremos precificá-lo no nível solicitado pelo cliente (o chamado upgrade ). Cada classe de carro tem seu próprio preço, mas todos os carros da mesma classe têm o mesmo preço. Temos políticas de aluguel para 1 dia, 1 semana, 2 semanas e 1 mês. Assim, se um cliente alugar um carro por 8 dias,o preço será de 1 semana + 1 dia. A taxa de entrega depende apenas da classe do carro alugado, do local em que foi alugado e do local para o qual foi devolvido.
-- Sobre nossos clientes, mantemos seus nomes, endereços, possivelmente todos os números de telefone e o número da carteira de motorista (assumimos uma licença única por pessoa).
-- Sobre nossos funcionários mantemos as mesmas informações (exigimos que todos os nossos funcionários tenham carteira de motorista). Temos várias categorias de trabalhadores, motoristas, faxineiros, balconistas e gerentes. Qualquer um dos nossos funcionários pode alugar um carro da nossa empresa com um desconto de 50%, se o aluguer for inferior a 2 semanas. No entanto, para qualquer aluguel mais longo, eles devem pagar 90% do preço normal. Cada funcionário trabalha em apenas um local. Temos sede em Hamilton. As pessoas que trabalham lá são todas classificadas como gerentes, um deles é o presidente, dois deles são os vice-presidentes, um para operação, outro para marketing). 
-- -- Para algumas semanas temos aluguéis promocionais que geralmente são 60% do preço normal, mas também podem ter percentuais diferentes. Eles sempre afetam apenas uma classe de carros – ou seja, podemos ter uma promoção para subcompactos, mas durante essa semana  não temos promoções para compactos, sedãs ou carros de luxo.
-- Durante alguns anos podemos ter muitas promoções, em alguns não temos. As promoções não podem ser aplicadas aos funcionários.
-- #######################################
-- QUESTÕES
-- Você deverá criar, executar e testar as solicitações abaixo do sistema acima:
-- 1 - criar uma tabela de log e inserir informações nela através de uma trigger, contendo o seguinte : id, usuário, data, hora, operação.
-- Criação da tabela LogTable
CREATE TABLE LogTable (
    id SERIAL PRIMARY KEY,
    usuario CHAR(20) NOT NULL,
    data DATE NOT NULL,
    hora TIME NOT NULL,
    operacao CHAR(20) NOT NULL
);

-- Criação da função de trigger
CREATE OR REPLACE FUNCTION log_insert() RETURNS TRIGGER AS $body$
BEGIN
    INSERT INTO LogTable (usuario, data, hora, operacao)
    VALUES (CURRENT_USER, CURRENT_DATE, CURRENT_TIME, TG_OP);
    RETURN NEW;
END;
$body$ LANGUAGE plpgsql;

CREATE TRIGGER log_insert_trigger 
BEFORE INSERT OR UPDATE OR DELETE ON Address 
FOR EACH ROW 
EXECUTE PROCEDURE log_insert();

CREATE TRIGGER log_insert_trigger 
BEFORE INSERT OR UPDATE OR DELETE ON ClassTable 
FOR EACH ROW 
EXECUTE PROCEDURE log_insert();

CREATE TRIGGER log_insert_trigger 
BEFORE INSERT OR UPDATE OR DELETE ON Car 
FOR EACH ROW 
EXECUTE PROCEDURE log_insert();

CREATE TRIGGER log_insert_trigger 
BEFORE INSERT OR UPDATE OR DELETE ON Person 
FOR EACH ROW 
EXECUTE PROCEDURE log_insert();

CREATE TRIGGER log_insert_trigger 
BEFORE INSERT OR UPDATE OR DELETE ON Phone 
FOR EACH ROW 
EXECUTE PROCEDURE log_insert();

CREATE TRIGGER log_insert_trigger 
BEFORE INSERT OR UPDATE OR DELETE ON ETypeTable 
FOR EACH ROW 
EXECUTE PROCEDURE log_insert();

CREATE TRIGGER log_insert_trigger 
BEFORE INSERT OR UPDATE OR DELETE ON Employee 
FOR EACH ROW 
EXECUTE PROCEDURE log_insert();

CREATE TRIGGER log_insert_trigger 
BEFORE INSERT OR UPDATE OR DELETE ON Customer 
FOR EACH ROW 
EXECUTE PROCEDURE log_insert();

CREATE TRIGGER log_insert_trigger 
BEFORE INSERT OR UPDATE OR DELETE ON PRate 
FOR EACH ROW 
EXECUTE PROCEDURE log_insert();

CREATE TRIGGER log_insert_trigger 
BEFORE INSERT OR UPDATE OR DELETE ON Promo 
FOR EACH ROW 
EXECUTE PROCEDURE log_insert();

CREATE TRIGGER log_insert_trigger 
BEFORE INSERT OR UPDATE OR DELETE ON Rental 
FOR EACH ROW 
EXECUTE PROCEDURE log_insert();

CREATE TRIGGER log_insert_trigger 
BEFORE INSERT OR UPDATE OR DELETE ON RentalRate 
FOR EACH ROW 
EXECUTE PROCEDURE log_insert();

CREATE TRIGGER log_insert_trigger 
BEFORE INSERT OR UPDATE OR DELETE ON DropoffCharge 
FOR EACH ROW 
EXECUTE PROCEDURE log_insert();


-- TESTE DA QUESTÃO 1
-- Inserindo registros na tabela ClassTable
INSERT INTO ClassTable (Class, Description)
VALUES 
('E', 'Economy'),
('C', 'Compact'),
('S', 'Sports'),
('M', 'Midsize'),
('L', 'Luxury');

-- Inserindo um novo registro na tabela Car
INSERT INTO Car (CarId, Make, Model, Year, Colour, LPlate, CLocation, Class)
VALUES (1, 'Ford', 'Fiesta', '2020', 'Blue', 'ABC1234', 1, 'A');

-- Inserindo um novo registro na tabela Person
INSERT INTO Person (DLicense, FName, LName, AddressId)
VALUES ('123456789', 'João', 'Silva', 1);
-- Atualizando um registro existente na tabela Person
UPDATE Person SET FName = 'João' WHERE DLicense = '123456789';
-- Deletando um registro existente na tabela Person
DELETE FROM Person WHERE DLicense = '123456789';


-- ##########################################################
-- 2 - uma trigger que controle a seguinte restrição - cada cliente poderá alugar no máximo 5 carros;
-- Criação da função de trigger
CREATE OR REPLACE FUNCTION check_rental() RETURNS TRIGGER AS $body$
DECLARE
    rental_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO rental_count FROM Rental WHERE DLicense = NEW.DLicense;
    IF rental_count >= 5 THEN
        RAISE EXCEPTION 'O cliente não pode alugar mais de 5 carros.';
    END IF;
    RETURN NEW;
END;
$body$ LANGUAGE plpgsql;

-- Criação da trigger
CREATE TRIGGER check_rental_trigger 
BEFORE INSERT ON Rental 
FOR EACH ROW 
EXECUTE PROCEDURE check_rental();

-- TESTE DA QUESTÃO 2
-- Inserindo registros na tabela Address
INSERT INTO Address (AddressId, SNumber, Street, City, Province, PCode, IsHquarters)
VALUES (1, '123', 'Rua 1', 'Cidade 1', 'SP', '123456', 'F'),
       (2, '123', 'Rua 2', 'Cidade 2', 'SP', '123456', 'F'),
       (3, '123', 'Rua 3', 'Cidade 3', 'SP', '123456', 'F'),
       (4, '123', 'Rua 4', 'Cidade 4', 'SP', '123456', 'T'),
       (5, '123', 'Rua 5', 'Cidade 5', 'SP', '123456', 'T');

-- Inserindo registros na tabela Person
INSERT INTO Person (DLicense, FName, LName, AddressId)
VALUES ('123456789', 'Person1', 'Lastname1', 1),
       ('223456789', 'Person2', 'Lastname2', 2),
       ('323456789', 'Person3', 'Lastname3', 3),
       ('423456789', 'Person4', 'Lastname4', 4),
       ('523456789', 'Person5', 'Lastname5', 5);

-- Inserindo 5 clientes distintos na tabela Customer
INSERT INTO Customer (DLicense)
VALUES ('123456789'),
       ('223456789'),
       ('323456789'),
       ('423456789'),
       ('523456789');
       

-- Inserindo registros na tabela ClassTable
INSERT INTO ClassTable (Class, cdesc)
VALUES 
('E', 'Economy'),
('C', 'Compact'),
('S', 'Sports'),
('M', 'Midsize'),
('L', 'Luxury');

-- Inserindo registros na tabela Car
INSERT INTO Car (CarId, Make, Model, Year, colour, LPlate, CLocation, Class)
VALUES 
(1, 'Toyota', 'Corolla', 2020, 'Blue', 'ABC123', 1, 'E'),
(2, 'Honda', 'Civic', 2019, 'Red', 'DEF456', 2, 'C'),
(3, 'Ford', 'Mustang', 2018, 'Black', 'GHI789', 3, 'S'),
(4, 'Chevrolet', 'Malibu', 2021, 'White', 'JKL012', 4, 'M'),
(5, 'BMW', '3 Series', 2022, 'Silver', 'MNO345', 5, 'L');

-- Inserindo 5 aluguéis distintos na tabela Rental
INSERT INTO Rental (RentalId, DLicense, CarId, FromLocation, DropoffLocation, FromDate, Tank, InitOdo)
VALUES (1, '123456789', 1, 1, 2, '2022-01-01', 'F', 10000),
       (2, '223456789', 2, 1, 2, '2022-01-02', 'F', 20000),
       (3, '323456789', 3, 1, 2, '2022-01-03', 'F', 30000),
       (4, '423456789', 4, 1, 2, '2022-01-04', 'F', 40000),
       (5, '523456789', 5, 1, 2, '2022-01-05', 'F', 50000);

-- Tentando inserir um 6º registro de aluguel para o mesmo cliente
-- Isso deve disparar a trigger e impedir a inserção
INSERT INTO Rental (RentalId, DLicense, CarId, FromLocation, DropoffLocation, FromDate, Tank, InitOdo)
VALUES (6, '123456789', 6, 1, 2, '2022-01-06', 'F', 60000);

-- ##########################################################

-- 3 - uma trigger que dispare uma mensagem de negação quando o usuário tentar alugar um carro que já esteja alugado;
-- ##########################################################
-- 4 - uma trigger que controle o aluguel de carros para funcionários de acordo com a restrição descrita no texto;
-- ##########################################################
-- 5 - uma trigger que controle a inserção de promoções de acordo com a restrição descrita no texto;
-- ##########################################################
-- 6 -  criar uma tabela que guarde, de forma separada, as seguintes informações: item, driver_licence, fisrt_name, last_name, Car_id, amount;
-- ##########################################################
-- 7 - uma trigger que insira a data de saída do veículo que está sendo alugado;
-- ##########################################################
-- 8 - uma trigger que insira a data de retorno do carro;
-- ##########################################################
-- 9 - uma trigger para verificar e cobrar ou não a taxa de entrega do carro;
-- ##########################################################