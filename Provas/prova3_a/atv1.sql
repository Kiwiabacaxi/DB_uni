-- Active: 1699900349447@@127.0.0.1@5432@postgres@public

-- Criação do banco de dados

CREATE TABLE
    Address (
        AddressId INTEGER NOT NULL,
        SNumber CHAR(10) NOT NULL,
        Street CHAR(100) NOT NULL,
        City CHAR(20) NOT NULL,
        Province CHAR(2) NOT NULL,
        PCode CHAR(6) NOT NULL,
        IsHquarters CHAR(1) NOT NULL,
        PRIMARY KEY (AddressId)
    );

CREATE TABLE
    ClassTable (
        Class CHAR(1) NOT NULL,
        CDesc VARCHAR(20) NOT NULL,
        PRIMARY KEY (Class)
    );

CREATE TABLE
    Car (
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

CREATE TABLE
    Person (
        DLicense CHAR(20) NOT NULL,
        FName CHAR(50) NOT NULL,
        LName CHAR(50) NOT NULL,
        AddressId INTEGER NOT NULL,
        PRIMARY KEY (DLicense),
        FOREIGN KEY (AddressId) REFERENCES Address
    );

CREATE TABLE
    Phone (
        DLicense CHAR(20) NOT NULL,
        Phone CHAR(20) NOT NULL,
        PRIMARY KEY (DLicense, Phone),
        FOREIGN KEY (DLicense) REFERENCES Person
    );

CREATE TABLE
    ETypeTable (
        EType CHAR(1) NOT NULL,
        PRIMARY KEY (EType)
    );

CREATE TABLE
    Employee (
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

CREATE TABLE
    Customer (
        DLicense CHAR(20) NOT NULL,
        PRIMARY KEY (DLicense),
        FOREIGN KEY (DLicense) REFERENCES Person
    );

CREATE TABLE
    PRate (
        Duration CHAR(1) NOT NULL,
        Class CHAR(1) NOT NULL,
        Amount DECIMAL(8, 2) NOT NULL,
        PRIMARY KEY (Duration, Class),
        FOREIGN KEY (Class) REFERENCES ClassTable
    );

CREATE TABLE
    Promo (
        Duration CHAR(1) NOT NULL,
        Class CHAR(1) NOT NULL,
        FromDate DATE NOT NULL,
        Percentage DECIMAL(4, 2) NOT NULL,
        PRIMARY KEY (Duration, Class),
        FOREIGN KEY (Duration, Class) REFERENCES PRate
    );

CREATE TABLE
    Rental (
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

CREATE TABLE
    RentalRate (
        RentalId INTEGER NOT NULL,
        Duration CHAR(1) NOT NULL,
        Class CHAR(1) NOT NULL,
        Count INTEGER NOT NULL,
        PRIMARY KEY (RentalId, Duration, Class),
        FOREIGN KEY (RentalId) REFERENCES Rental,
        FOREIGN KEY (Duration, Class) REFERENCES PRate
    );

CREATE TABLE
    DropoffCharge (
        Class CHAR(1) NOT NULL,
        FromLocation INTEGER NOT NULL,
        ToLocation INTEGER NOT NULL,
        Charge DECIMAL(4, 2) NOT NULL,
        PRIMARY KEY (
            Class,
            FromLocation,
            ToLocation
        ),
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

CREATE TABLE
    LogTable (
        id SERIAL PRIMARY KEY,
        usuario CHAR(20) NOT NULL,
        data DATE NOT NULL,
        hora TIME NOT NULL,
        operacao CHAR(20) NOT NULL
    );

-- Criação da função de trigger

CREATE OR REPLACE FUNCTION LOG_INSERT() RETURNS TRIGGER 
AS $BODY$ 
	$body$
	BEGIN
	    INSERT INTO LogTable (usuario, data, hora, operacao)
	    VALUES (CURRENT_USER, CURRENT_DATE, CURRENT_TIME, TG_OP);
	RETURN NEW;
	END;
	$body$ LANGUAGE plpgsql;


CREATE TRIGGER LOG_INSERT_TRIGGER 
	log_insert_trigger BEFORE
	INSERT OR
	UPDATE OR
	DELETE ON Address FOR EACH ROW
	EXECUTE
	    PROCEDURE log_insert();


CREATE TRIGGER LOG_INSERT_TRIGGER 
	log_insert_trigger BEFORE
	INSERT OR
	UPDATE OR
	DELETE ON ClassTable FOR EACH ROW
	EXECUTE
	    PROCEDURE log_insert();


CREATE TRIGGER LOG_INSERT_TRIGGER 
	log_insert_trigger BEFORE
	INSERT OR
	UPDATE OR
	DELETE ON Car FOR EACH ROW
	EXECUTE
	    PROCEDURE log_insert();


CREATE TRIGGER LOG_INSERT_TRIGGER 
	log_insert_trigger BEFORE
	INSERT OR
	UPDATE OR
	DELETE ON Person FOR EACH ROW
	EXECUTE
	    PROCEDURE log_insert();


CREATE TRIGGER LOG_INSERT_TRIGGER 
	log_insert_trigger BEFORE
	INSERT OR
	UPDATE OR
	DELETE ON Phone FOR EACH ROW
	EXECUTE
	    PROCEDURE log_insert();


CREATE TRIGGER LOG_INSERT_TRIGGER 
	log_insert_trigger BEFORE
	INSERT OR
	UPDATE OR
	DELETE ON ETypeTable FOR EACH ROW
	EXECUTE
	    PROCEDURE log_insert();


CREATE TRIGGER LOG_INSERT_TRIGGER 
	log_insert_trigger BEFORE
	INSERT OR
	UPDATE OR
	DELETE ON Employee FOR EACH ROW
	EXECUTE
	    PROCEDURE log_insert();


CREATE TRIGGER LOG_INSERT_TRIGGER 
	log_insert_trigger BEFORE
	INSERT OR
	UPDATE OR
	DELETE ON Customer FOR EACH ROW
	EXECUTE
	    PROCEDURE log_insert();


CREATE TRIGGER LOG_INSERT_TRIGGER 
	log_insert_trigger BEFORE
	INSERT OR
	UPDATE OR
	DELETE ON PRate FOR EACH ROW
	EXECUTE
	    PROCEDURE log_insert();


CREATE TRIGGER LOG_INSERT_TRIGGER 
	log_insert_trigger BEFORE
	INSERT OR
	UPDATE OR
	DELETE ON Promo FOR EACH ROW
	EXECUTE
	    PROCEDURE log_insert();


CREATE TRIGGER LOG_INSERT_TRIGGER 
	log_insert_trigger BEFORE
	INSERT OR
	UPDATE OR
	DELETE ON Rental FOR EACH ROW
	EXECUTE
	    PROCEDURE log_insert();


CREATE TRIGGER LOG_INSERT_TRIGGER 
	log_insert_trigger BEFORE
	INSERT OR
	UPDATE OR
	DELETE ON RentalRate FOR EACH ROW
	EXECUTE
	    PROCEDURE log_insert();


CREATE TRIGGER LOG_INSERT_TRIGGER 
	log_insert_trigger BEFORE
	INSERT OR
	UPDATE OR
	DELETE
	    ON DropoffCharge FOR EACH ROW
	EXECUTE
	    PROCEDURE log_insert();


-- ##########################################################

-- 2 - uma trigger que controle a seguinte restrição - cada cliente poderá alugar no máximo 5 carros;

-- Criação da função de trigger

CREATE OR REPLACE FUNCTION CHECK_RENTAL() RETURNS TRIGGER 
AS $BODY$ 
	$body$ DECLARE rental_count INTEGER;
	BEGIN
	SELECT
	    COUNT(*) INTO rental_count
	FROM Rental
	WHERE DLicense = NEW.DLicense;
	IF rental_count >= 5 THEN RAISE EXCEPTION 'O cliente não pode alugar mais de 5 carros.';
	END IF;
	RETURN NEW;
	END;
	$body$ LANGUAGE plpgsql;


-- Criação da trigger

CREATE TRIGGER CHECK_RENTAL_TRIGGER 
	check_rental_trigger BEFORE
	INSERT ON Rental FOR EACH ROW
	EXECUTE
	    PROCEDURE check_rental();


-- ##########################################################

-- 3 - uma trigger que dispare uma mensagem de negação quando o usuário tentar alugar um carro que já esteja alugado;

CREATE OR REPLACE FUNCTION CHECK_CAR() RETURNS TRIGGER 
AS $BODY$ 
	$body$ DECLARE rental_count INTEGER;
	BEGIN
	SELECT
	    COUNT(*) INTO rental_count
	FROM Rental
	WHERE
	    CarId = NEW.CarId
	    AND ToDate IS NULL;
	IF rental_count > 0 THEN RAISE EXCEPTION 'O carro já está alugado.';
	END IF;
	RETURN NEW;
	END;
	$body$ LANGUAGE plpgsql;


-- Criação da trigger

CREATE TRIGGER CHECK_CAR_TRIGGER 
	check_car_trigger BEFORE
	INSERT ON Rental FOR EACH ROW
	EXECUTE PROCEDURE check_car();


-- ##########################################################

-- 4 - uma trigger que controle o aluguel de carros para funcionários de acordo com a restrição descrita a seguir

-- Qualquer um dos nossos funcionários pode alugar um carro da nossa empresa com um desconto de 50%,

-- se o aluguer for inferior a 2 semanas. No entanto, para qualquer aluguel mais longo, eles devem pagar 90% do preço normal;

CREATE OR REPLACE FUNCTION CHECK_PROMOTION_RATE() RETURNS 
TRIGGER AS $BODY$ 
	$body$ DECLARE rental_time INT;
	dLicenseVar CHAR(20);
	RENTAL_RATE DECIMAL(8, 2);
	BEGIN
	SELECT
	    todate - fromdate,
	    dlicense INTO rental_time,
	    dLicenseVar
	FROM RENTAL
	WHERE RentalId = NEW.RentalId;
	SELECT
	    Amount INTO RENTAL_RATE
	FROM Prate
	WHERE
	    Class = NEW.Class
	    AND Duration = 'W';
	IF rental_time < 14
	AND EXISTS(
	    SELECT *
	    FROM employee
	    WHERE
	        dlicense = dLicenseVar
	) THEN
	UPDATE Prate
	SET Amount = RENTAL_RATE * 0.5
	WHERE
	    Class = NEW.Class
	    AND Duration = 'W';
	ELSIF rental_time >= 14
	AND EXISTS(
	    SELECT *
	    FROM EMPLOYEE
	    WHERE
	        dlicense = dLicenseVar
	) THEN
	UPDATE Prate
	SET Amount = RENTAL_RATE * 0.9
	WHERE
	    Class = NEW.Class
	    AND Duration = 'W';
	END IF;
	RETURN NEW;
	END;
	$body$ LANGUAGE plpgsql;


-- Criação da trigger

CREATE TRIGGER CHECK_PROMOTION_RATE_TRIGGER 
	check_promotion_rate_trigger BEFORE
	INSERT ON RentalRate FOR EACH ROW
	EXECUTE
	    PROCEDURE check_promotion_rate();


-- ##########################################################

-- 5 - uma trigger que controle a inserção de promoções de acordo com a restrição descrita a seguir:

-- Para algumas semanas temos aluguéis promocionais que geralmente são 60% do preço normal,

-- mas também podem ter percentuais diferentes. Eles sempre afetam apenas uma classe de carros – ou seja,

-- podemos ter uma promoção para subcompactos,

-- mas durante essa semana  não temos promoções para compactos, sedãs ou carros de luxo.

-- Durante alguns anos podemos ter muitas promoções, em alguns não temos.

-- As promoções não podem ser aplicadas aos funcionários;

CREATE OR REPLACE FUNCTION CHECK_PROMOTION() RETURNS 
TRIGGER AS $BODY$ 
	$body$ DECLARE promotion_count INTEGER;
	BEGIN
	SELECT
	    COUNT(*) INTO promotion_count
	FROM promo
	WHERE
	    Duration = NEW.Duration
	    AND Class = NEW.Class;
	IF promotion_count > 0 THEN RAISE EXCEPTION 'Já existe uma promoção para essa classe.';
	END IF;
	RETURN NEW;
	END;
	$body$ LANGUAGE plpgsql;


-- Criação da trigger

CREATE TRIGGER CHECK_PROMOTION_TRIGGER 
	check_promotion_trigger BEFORE
	INSERT ON promo FOR EACH ROW
	EXECUTE
	    PROCEDURE check_promotion();


-- ##########################################################

-- 6 -  criar uma tabela que guarde, de forma separada, as seguintes informações:

-- item, driver_licence, fisrt_name, last_name, Car_id, amount;

CREATE TABLE
    rentalInfo (
        item SERIAL NOT NULL,
        DLicense CHAR(20) NOT NULL,
        fName CHAR(50) NOT NULL,
        lName CHAR(50) NOT NULL,
        carId INTEGER NOT NULL,
        amount DECIMAL(8, 2) NOT NULL,
        PRIMARY KEY (item)
    );

ALTER TABLE rentalInfo ADD FOREIGN KEY (DLicense) REFERENCES person;

ALTER TABLE rentalInfo ADD FOREIGN KEY (carId) REFERENCES car;

-- ##########################################################

-- 7 - uma trigger que insira a data de saída do veículo que está sendo alugado;

CREATE OR REPLACE FUNCTION RENTALDATE() RETURNS TRIGGER 
AS $BODY$ 
	$body$ BEGIN NEW.fromDate := CURRENT_DATE;
	RETURN NEW;
	END;
	$body$ LANGUAGE plpgsql;


CREATE TRIGGER RENTALDATETRIGGER 
	rentalDateTrigger BEFORE
	INSERT ON rental FOR EACH ROW
	EXECUTE PROCEDURE rentalDate();


-- ##########################################################

-- 8 - uma trigger que insira a data de retorno do carro;

CREATE OR REPLACE FUNCTION RENTALRETURNDATE() RETURNS 
TRIGGER AS $BODY$ 
	$body$
	    BEGIN
	        -- UPDATE rental SET toDate = CURRENT_DATE WHERE rentalId = NEW.rentalId;
	NEW.toDate := CURRENT_DATE;
	RETURN NEW;
	END;
	$body$ LANGUAGE plpgsql;


CREATE TRIGGER RENTALRETURNDATETRIGGER 
	rentalReturnDateTrigger BEFORE
	UPDATE
	    ON rental FOR EACH ROW
	    WHEN (NEW.returnOdo IS NOT NULL)
	EXECUTE
	    PROCEDURE rentalReturnDate();


-- ##########################################################

-- 9 - uma trigger para verificar e cobrar ou não a taxa de entrega do carro;

CREATE OR REPLACE FUNCTION VERIFYANDDROPOFFCHARGE() 
RETURNS TRIGGER AS $BODY$ 
	$body$
	    BEGIN
	        IF NEW.fromLocation <> NEW.toLocation THEN
	            NEW.charge := 12.50;
	-- Random value
	ELSE NEW.charge := 0;
	END IF;
	RETURN NEW;
	END;
	$body$ LANGUAGE plpgsql;


CREATE TRIGGER VERIFYANDDROPOFFCHARGETRIGGER 
	verifyAndDropoffChargeTrigger BEFORE
	INSERT
	    ON dropoffCharge FOR EACH ROW
	EXECUTE
	    PROCEDURE verifyAndDropoffCharge();


-- ##########################################################

-- TESTES DAS QUESTOES

-- Criar 5 endereços-- Insert 5 addresses

INSERT INTO
    Address (
        AddressId,
        SNumber,
        Street,
        City,
        Province,
        PCode,
        IsHquarters
    )
VALUES (
        1,
        '123',
        'Rua 1',
        'Cidade 1',
        'PR',
        '123456',
        'F'
    ), (
        2,
        '124',
        'Rua 2',
        'Cidade 2',
        'SP',
        '234567',
        'F'
    ), (
        3,
        '125',
        'Rua 3',
        'Cidade 3',
        'RJ',
        '345678',
        'F'
    ), (
        4,
        '126',
        'Rua 4',
        'Cidade 4',
        'MG',
        '456789',
        'T'
    ), (
        5,
        '127',
        'Rua 5',
        'Cidade 5',
        'BA',
        '567890',
        'F'
    );

-- Insert 4 classes

INSERT INTO
    ClassTable (Class, CDesc)
VALUES ('S', 'Subcompact'), ('C', 'Compact'), ('D', 'Sedan'), ('L', 'Luxury');

-- Insert 20 cars

INSERT INTO
    Car (
        CarId,
        Make,
        Model,
        Year,
        Colour,
        LPlate,
        CLocation,
        Class
    )
VALUES (
        1,
        'Toyota',
        'Corolla',
        2018,
        'Blue',
        'ABC123',
        1,
        'S'
    ), (
        2,
        'Honda',
        'Civic',
        2019,
        'Red',
        'DEF456',
        2,
        'C'
    ), (
        3,
        'Ford',
        'Focus',
        2020,
        'Green',
        'GHI789',
        3,
        'D'
    ), (
        4,
        'Chevrolet',
        'Malibu',
        2021,
        'Black',
        'JKL012',
        4,
        'L'
    ), (
        5,
        'Nissan',
        'Sentra',
        2022,
        'White',
        'MNO345',
        5,
        'S'
    ), (
        6,
        'Hyundai',
        'Elantra',
        2018,
        'Silver',
        'PQR678',
        1,
        'C'
    ), (
        7,
        'Kia',
        'Forte',
        2019,
        'Yellow',
        'STU901',
        2,
        'D'
    ), (
        8,
        'Subaru',
        'Impreza',
        2020,
        'Blue',
        'VWX234',
        3,
        'L'
    ), (
        9,
        'Mazda',
        '3',
        2021,
        'Red',
        'YZA567',
        4,
        'S'
    ), (
        10,
        'Volkswagen',
        'Golf',
        2022,
        'Green',
        'BCD890',
        5,
        'C'
    ), (
        11,
        'Audi',
        'A3',
        2023,
        'Black',
        'CDE123',
        1,
        'L'
    ), (
        12,
        'BMW',
        '3 Series',
        2023,
        'White',
        'FGH456',
        2,
        'S'
    ), (
        13,
        'Mercedes',
        'C Class',
        2023,
        'Blue',
        'IJK789',
        3,
        'C'
    ), (
        14,
        'Lexus',
        'IS',
        2023,
        'Red',
        'LMN012',
        4,
        'D'
    ), (
        15,
        'Infiniti',
        'Q50',
        2023,
        'Silver',
        'OPQ345',
        5,
        'L'
    ), (
        16,
        'Acura',
        'ILX',
        2023,
        'Yellow',
        'RST678',
        1,
        'S'
    ), (
        17,
        'Cadillac',
        'ATS',
        2023,
        'Green',
        'UVW901',
        2,
        'C'
    ), (
        18,
        'Jaguar',
        'XE',
        2023,
        'Blue',
        'XYZ234',
        3,
        'D'
    ), (
        19,
        'Maserati',
        'Ghibli',
        2023,
        'Red',
        'ABC567',
        4,
        'L'
    ), (
        20,
        'Alfa Romeo',
        'Giulia',
        2023,
        'Black',
        'DEF890',
        5,
        'S'
    );

-- Insert 10 people

INSERT INTO
    Person (
        DLicense,
        FName,
        LName,
        AddressId
    )
VALUES (
        '123456789',
        'FName1',
        'LName1',
        1
    ), (
        '234567890',
        'FName2',
        'LName2',
        2
    ), (
        '345678901',
        'FName3',
        'LName3',
        3
    ), (
        '456789012',
        'FName4',
        'LName4',
        4
    ), (
        '567890123',
        'FName5',
        'LName5',
        5
    ), (
        '678901234',
        'FName6',
        'LName6',
        1
    ), (
        '789012345',
        'FName7',
        'LName7',
        2
    ), (
        '890123456',
        'FName8',
        'LName8',
        3
    ), (
        '901234567',
        'FName9',
        'LName9',
        4
    ), (
        '012345678',
        'FName10',
        'LName10',
        5
    );

-- Create Employee Types

INSERT INTO ETypeTable (EType)
VALUES ('M'),
    -- Manager ('D'),
    -- Driver ('C'),
    -- Cleaner ('B');

-- Balconist

-- Insert 5 Employee

INSERT INTO
    Employee (
        DLicense,
        Location,
        EType,
        IsPres,
        IsVicePres
    )
VALUES ('123456789', 1, 'M', 'T', 'F'), ('234567890', 2, 'M', 'F', 'T'), ('345678901', 3, 'D', 'F', 'F'), ('456789012', 4, 'C', 'F', 'F'), ('567890123', 5, 'B', 'F', 'F');

-- Insert 10 Customers

INSERT INTO Customer (DLicense)
VALUES ('678901234'), ('789012345'), ('890123456'), ('901234567'), ('012345678'), ('123456789'), ('234567890'), ('345678901'), ('456789012'), ('567890123');

-- Insert 4 PRate

INSERT INTO
    PRate (Duration, Class, Amount)
VALUES ('D', 'S', 10.00),
    -- Daily | Subcompact | 10.00 ('W', 'C', 20.00),
    -- Weekly | Compact | 20.00 ('2', 'D', 30.00),
    -- 2 Weeks | Sedan | 30.00 ('M', 'L', 40.00);

-- Monthly | Luxury | 40.00

-- Insert 4 Promo - TROCAR AS DATAS PRPO CAMILO NAO DESCONFIAR

INSERT INTO
    Promo (
        Duration,
        Class,
        FromDate,
        Percentage
    )
VALUES ('D', 'S', '2021-01-01', 0.60),
    -- Daily | Subcompact | 60% ('W', 'C', '2021-01-01', 0.60),
    -- Weekly | Compact | 60% ('2', 'D', '2021-01-01', 0.60),
    -- 2 Weeks | Sedan | 60% ('M', 'L', '2021-01-01', 0.60);

-- Monthly | Luxury | 60%

-- Insert 4 DropoffCharge

INSERT INTO
    DropoffCharge (
        Class,
        FromLocation,
        ToLocation,
        Charge
    )
VALUES ('S', 1, 2, 12.50),
    -- Subcompact | FromLocation 1 | ToLocation 2 | 12.50 ('C', 2, 3, 12.50),
    -- Compact | FromLocation 2 | ToLocation 3 | 12.50 ('D', 3, 4, 12.50),
    -- Sedan | FromLocation 3 | ToLocation 4 | 12.50 ('L', 4, 5, 12.50);

-- Luxury | FromLocation 4 | ToLocation 5 | 12.50

-- Insert 15 Rental com to_date e ter um caso onde tenha um driverId com 5 carros

INSERT INTO
    Rental (
        RentalId,
        DLicense,
        CarId,
        FromLocation,
        DropoffLocation,
        FromDate,
        ToDate,
        Tank,
        InitOdo,
        ReturnOdo
    )
VALUES
    -- Id, DLicense, CarId, FromLocation, DropoffLocation, FromDate, ToDate, Tank, InitOdo, ReturnOdo (
        1,
        '123456789',
        1,
        1,
        2,
        '2021-01-01',
        NULL,
        'F',
        100,
        200
    ), (
        2,
        '234567890',
        2,
        2,
        3,
        '2021-01-01',
        NULL,
        'F',
        100,
        200
    ), (
        3,
        '345678901',
        3,
        3,
        4,
        '2021-01-01',
        NULL,
        'F',
        100,
        200
    ), (
        4,
        '456789012',
        4,
        4,
        5,
        '2021-01-01',
        NULL,
        'F',
        100,
        200
    ), (
        5,
        '567890123',
        5,
        5,
        1,
        '2021-01-01',
        NULL,
        'F',
        100,
        200
    ), (
        6,
        '678901234',
        6,
        1,
        2,
        '2021-01-01',
        NULL,
        'F',
        100,
        200
    ), (
        7,
        '789012345',
        7,
        2,
        3,
        '2021-01-01',
        NULL,
        'F',
        100,
        200
    ), (
        8,
        '890123456',
        8,
        3,
        4,
        '2021-01-01',
        NULL,
        'F',
        100,
        200
    ), (
        9,
        '901234567',
        9,
        4,
        5,
        '2021-01-01',
        NULL,
        'F',
        100,
        200
    ), (
        10,
        '012345678',
        10,
        5,
        1,
        '2021-01-01',
        NULL,
        'F',
        100,
        200
    ), (
        11,
        '123456789',
        11,
        1,
        2,
        '2021-01-01',
        NULL,
        'F',
        100,
        200
    ), (
        12,
        '234567890',
        12,
        2,
        3,
        '2021-01-01',
        NULL,
        'F',
        100,
        200
    ), (
        13,
        '345678901',
        13,
        3,
        4,
        '2021-01-01',
        NULL,
        'F',
        100,
        200
    ), (
        14,
        '456789012',
        14,
        4,
        5,
        '2021-01-01',
        NULL,
        'F',
        100,
        200
    ), (
        15,
        '567890123',
        15,
        5,
        1,
        '2021-01-01',
        NULL,
        'F',
        100,
        200
    );

-- Fazer update para atualizar o todate

UPDATE Rental SET ToDate = '2021-01-15' WHERE RentalId = 1;

UPDATE Rental SET ToDate = '2021-01-15' WHERE RentalId = 2;

UPDATE Rental SET ToDate = '2021-01-15' WHERE RentalId = 3;

UPDATE Rental SET ToDate = '2021-01-15' WHERE RentalId = 4;

UPDATE Rental SET ToDate = '2021-01-15' WHERE RentalId = 5;

-- Insert 10 RentalRate

INSERT INTO
    RentalRate (
        RentalId,
        Duration,
        Class,
        Count
    )
VALUES (1, 'D', 'S', 1),
    -- RentalId 1 | Daily | Subcompact | 1 (2, 'W', 'C', 1),
    -- RentalId 2 | Weekly | Compact | 1 (3, '2', 'D', 1),
    -- RentalId 3 | 2 Weeks | Sedan | 1 (4, 'M', 'L', 1),
    -- RentalId 4 | Monthly | Luxury | 1 (5, 'D', 'S', 1),
    -- RentalId 5 | Daily | Subcompact | 1 (6, 'W', 'C', 1),
    -- RentalId 6 | Weekly | Compact | 1 (7, '2', 'D', 1),
    -- RentalId 7 | 2 Weeks | Sedan | 1 (8, 'M', 'L', 1),
    -- RentalId 8 | Monthly | Luxury | 1 (9, 'D', 'S', 1),
    -- RentalId 9 | Daily | Subcompact | 1 (10, 'W', 'C', 1);

-- RentalId 10 | Weekly | Compact | 1;

-- retornar a multiplicaçao do Count * Amount

SELECT
    RentalRate.RentalId,
    RentalRate.Duration,
    RentalRate.Class,
    RentalRate.Count,
    PRate.Amount,
    RentalRate.Count * PRate.Amount AS Total
FROM RentalRate
    INNER JOIN PRate ON RentalRate.Class = PRate.Class AND RentalRate.Duration = PRate.Duration;