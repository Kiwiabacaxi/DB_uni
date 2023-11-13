-- #######################################
-- EXEMPLOS PARA TESTE
-- Inserir dados na tabela Address
INSERT INTO Address (
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
        'Rua Principal',
        'São Paulo',
        'SP',
        '12345',
        'Y'
    );
-- Inserir dados na tabela ClassTable
INSERT INTO ClassTable (Class, CDesc)
VALUES ('A', 'Econômico');
-- Inserir dados na tabela Car
INSERT INTO Car (
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
        'Ford',
        'Fiesta',
        '2020',
        'Azul',
        'ABC1234',
        1,
        'A'
    );
-- Inserir dados na tabela Person
INSERT INTO Person (DLicense, FName, LName, AddressId)
VALUES ('12345678', 'João', 'Silva', 1);
-- Inserir dados na tabela Phone
INSERT INTO Phone (DLicense, Phone)
VALUES ('12345678', '11987654321');
-- Inserir dados na tabela ETypeTable
INSERT INTO ETypeTable (EType)
VALUES ('E');
-- Inserir dados na tabela Employee
INSERT INTO Employee (DLicense, Location, EType, IsPres, IsVicePres)
VALUES ('12345678', 1, 'E', 'N', 'N');
-- Inserir dados na tabela Customer
INSERT INTO Customer (DLicense)
VALUES ('12345678');
-- Inserir dados na tabela PRate
INSERT INTO PRate (Duration, Class, Amount)
VALUES ('D', 'A', 100.00);
-- Inserir dados na tabela Promo
INSERT INTO Promo (Duration, Class, FromDate, Percentage)
VALUES ('D', 'A', '2022-01-01', 10.00);
-- Inserir dados na tabela Rental
INSERT INTO Rental (
        RentalId,
        DLicense,
        CarId,
        FromLocation,
        DropoffLocation,
        FromDate,
        Tank,
        InitOdo
    )
VALUES (1, '12345678', 1, 1, 1, '2022-01-01', 'Y', 10000);
-- Inserir dados na tabela RentalRate
INSERT INTO RentalRate (RentalId, Duration, Class, Count)
VALUES (1, 'D', 'A', 1);
-- Inserir dados na tabela DropoffCharge
INSERT INTO DropoffCharge (Class, FromLocation, ToLocation, Charge)
VALUES ('A', 1, 1, 50.00);
-- Consultar todas as locações de um cliente
SELECT *
FROM Rental
WHERE DLicense = '12345678';
-- Consultar todos os carros de uma determinada classe
SELECT *
FROM Car
WHERE Class = 'A';