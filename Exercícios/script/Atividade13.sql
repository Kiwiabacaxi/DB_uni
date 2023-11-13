    -- Crie uma base de dados Universidade com as tabelas a seguir:

    -- Alunos (MAT, nome, endereço, cidade)
    -- Disciplinas (COD_DISC, nome_disc, carga_hor)
    -- Professores (COD_PROF, nome, endereço, cidade)
    -- Turma (COD_DISC, COD_TURMA, COD_PROF, ANO, horário)
    --     COD_DISC referencia Disciplinas
    --     COD_PROF referencia Professores
    -- Histórico (MAT, COD_DISC, COD_TURMA, COD_PROF, ANO, frequência, nota)
    --     MAT referencia Alunos
    --     COD_DISC, COD_TURMA, COD_PROF, ANO referencia Turma

    -- Criação das tabelas
    CREATE TABLE Alunos (
    MAT INT PRIMARY KEY,
    nome VARCHAR(255),
    endereco VARCHAR(255),
    cidade VARCHAR(255)
    );

    CREATE TABLE Disciplinas (
    COD_DISC INT PRIMARY KEY,
    nome_disc VARCHAR(255),
    carga_hor INT
    );

    CREATE TABLE Professores (
    COD_PROF INT PRIMARY KEY,
    nome VARCHAR(255),
    endereco VARCHAR(255),
    cidade VARCHAR(255)
    );

    CREATE TABLE Turma (
    COD_DISC INT,
    COD_TURMA INT,
    COD_PROF INT,
    ANO INT,
    horario VARCHAR(255),
    PRIMARY KEY (COD_DISC, COD_TURMA, COD_PROF, ANO),
    FOREIGN KEY (COD_DISC) REFERENCES Disciplinas(COD_DISC),
    FOREIGN KEY (COD_PROF) REFERENCES Professores(COD_PROF)
    );

    CREATE TABLE Historico (
    MAT INT,
    COD_DISC INT,
    COD_TURMA INT,
    COD_PROF INT,
    ANO INT,
    frequencia FLOAT,
    nota FLOAT,
    PRIMARY KEY (MAT, COD_DISC, COD_TURMA, COD_PROF, ANO),
    FOREIGN KEY (MAT) REFERENCES Alunos(MAT),
    FOREIGN KEY (COD_DISC, COD_TURMA, COD_PROF, ANO) REFERENCES Turma(COD_DISC, COD_TURMA, COD_PROF, ANO)
    );

    -- Inserção de registros na tabela Alunos
    INSERT INTO Alunos (MAT, nome, endereco, cidade) VALUES
    (2015010101, 'JOSE DE ALENCAR', 'RUA DAS ALMAS', 'NATAL'),
    (2015010102, 'JOÃO JOSÉ', 'AVENIDA RUY CARNEIRO', 'JOÃO PESSOA'),
    (2015010103, 'MARIA JOAQUINA', 'RUA CARROSSEL', 'RECIFE'),
    (2015010104, 'MARIA DAS DORES', 'RUA DAS LADEIRAS', 'FORTALEZA'),
    (2015010105, 'JOSUÉ CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL'),
    (2015010106, 'JOSUÉLISSON CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL');

    -- Inserção de registros na tabela Disciplinas
    INSERT INTO Disciplinas (COD_DISC, nome_disc, carga_hor) VALUES
    ('BD', 'BANCO DE DADOS', 100),
    ('POO', 'PROGRAMAÇÃO COM ACESSO A BANCO DE DADOS', 100),
    ('WEB', 'AUTORIA WEB', 50),
    ('ENG', 'ENGENHARIA DE SOFTWARE', 80);

    -- Inserção de registros na tabela Professores
    INSERT INTO Professores (COD_PROF, nome, endereco, cidade) VALUES
    (212131, 'NICKERSON FERREIRA', 'RUA MANAÍRA', 'JOÃO PESSOA'),
    (122135, 'ADORILSON BEZERRA', 'AVENIDA SALGADO FILHO', 'NATAL'),
    (192011, 'DIEGO OLIVEIRA', 'AVENIDA ROBERTO FREIRE', 'NATAL');

    -- Inserção de registros na tabela Turma
    INSERT INTO Turma (COD_DISC, COD_TURMA, COD_PROF, ANO, horario) VALUES
    ('BD', 1, 212131, 2015, '11H-12H'),
    ('BD', 2, 212131, 2015, '13H-14H'),
    ('POO', 1, 192011, 2015, '08H-09H'),
    ('WEB', 1, 192011, 2015, '07H-08H'),
    ('ENG', 1, 122135, 2015, '10H-11H');

    -- Inserção de registros na tabela Historico
    INSERT INTO Historico (MAT, COD_DISC, COD_TURMA, COD_PROF, ANO, frequencia, nota) VALUES
    -- Aluno 2015010101
    (2015010101, 'BD', 1, 212131, 2015, 0.8, 8.5),
    (2015010101, 'BD', 2, 212131, 2015, 0.7, 7.0),
    (2015010101, 'POO', 1, 192011, 2015, 0.9, 9.0),
    (2015010101, 'WEB', 1, 192011, 2015, 0.6, 6.5),
    (2015010101, 'ENG', 1, 122135, 2015, 0.75, 7.5),

    -- Aluno 2015010102
    (2015010102, 'BD', 1, 212131, 2015, 0.85, 8.0),
    (2015010102, 'BD', 2, 212131, 2015, 0.9, 9.5),
    (2015010102, 'POO', 1, 192011, 2015, 0.8, 8.5),
    (2015010102, 'WEB', 1, 192011, 2015, 0.7, 7.0),
    (2015010102, 'ENG', 1, 122135, 2015, 0.9, 9.0),

    -- Aluno 2015010103
    (2015010103, 'BD', 1, 212131, 2015, 0.9, 9.5),
    (2015010103, 'BD', 2, 212131, 2015, 0.8, 8.0),
    (2015010103, 'POO', 1, 192011, 2015, 0.7, 7.5),
    (2015010103, 'WEB', 1, 192011, 2015, 0.9, 9.0),
    (2015010103, 'ENG', 1, 122135, 2015, 0.8, 8.5),

    -- Aluno 2015010104
    (2015010104, 'BD', 1, 212131, 2015, 0.7, 7.0),
    (2015010104, 'BD', 2, 212131, 2015, 0.6, 6.5),
    (2015010104, 'POO', 1, 192011, 2015, 0.8, 8.0),
    (2015010104, 'WEB', 1, 192011, 2015, 0.75, 7.5),
    (2015010104, 'ENG', 1, 122135, 2015, 0.9, 9.5),

    -- Aluno 2015010105
    (2015010105, 'BD', 1, 212131, 2015, 0.8, 8.0),
    (2015010105, 'BD', 2, 212131, 2015, 0.9, 9.0),
    (2015010105, 'POO', 1, 192011, 2015, 0.7, 7.5),
    (2015010105, 'WEB', 1, 192011, 2015, 0.8, 8.5),
    (2015010105, 'ENG', 1, 122135, 2015, 0.85, 8.0),

    -- Aluno 2015010106
    (2015010106, 'BD', 1, 212131, 2015, 0.9, 9.0),
    (2015010106, 'BD', 2, 212131, 2015, 0.8, 8.5),
    (2015010106, 'POO', 1, 192011, 2015, 0.9, 9.5),
    (2015010106, 'WEB', 1, 192011, 2015, 0.7, 7.0),
    (2015010106, 'ENG', 1, 122135, 2015, 0.8, 8.0);

    -- Faça as buscas conforme o solicitado:

    -- a) Encontre a MAT dos alunos com nota em BD em 2015 menor que 5 (obs: BD = código da disciplinas). 
    SELECT DISTINCT MAT
    FROM Historico
    WHERE COD_DISC = 'BD' AND ANO = 2015 AND nota < 5;

    -- b) Encontre a MAT e calcule a média das notas dos alunos na disciplina de POO em 2015. 
    SELECT MAT, AVG(nota) AS media
    FROM Historico
    WHERE COD_DISC = 'POO' AND ANO = 2015
    GROUP BY MAT;

    -- c) Encontre a MAT e calcule a média das notas dos alunos na disciplina de POO em 2015 e que esta média seja superior a 6. 
    SELECT MAT, AVG(nota) AS media
    FROM Historico
    WHERE COD_DISC = 'POO' AND ANO = 2015
    GROUP BY MAT
    HAVING AVG(nota) > 6;

    -- d) Encontre quantos alunos não são de Natal.
    SELECT COUNT(DISTINCT MAT)
    FROM Alunos
    WHERE cidade <> 'NATAL';