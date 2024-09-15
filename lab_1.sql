-- Таблица для сущности Company
CREATE TABLE Company (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    foundation_date DATE,
    employee_count INTEGER,
    field_of_activity VARCHAR(50),
    status VARCHAR(50)
);

-- Таблица для сущности Drug
CREATE TABLE Drug (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    purpose VARCHAR(100),
    development_stage VARCHAR(50),
    start_date DATE,
    patent_status VARCHAR(50),
    company_id INTEGER REFERENCES Company(id) ON DELETE CASCADE
);

-- Таблица для связи между Company и Drug
CREATE TABLE Company_Drug (
    company_id INTEGER REFERENCES Company(id) ON DELETE CASCADE,
    drug_id INTEGER REFERENCES Drug(id) ON DELETE CASCADE,
    PRIMARY KEY (company_id, drug_id)
);

-- Таблица для сущности Procedure
CREATE TABLE Procedure (
    id SERIAL PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    description TEXT,
    start_date DATE,
    status VARCHAR(50),
    drug_id INTEGER REFERENCES Drug(id) ON DELETE CASCADE
);

-- Таблица для сущности Patent 
CREATE TABLE Patent (
    id SERIAL PRIMARY KEY,
    number VARCHAR(100) NOT NULL,
    issue_date DATE,
    status VARCHAR(50),
    drug_id INTEGER UNIQUE REFERENCES Drug(id) ON DELETE CASCADE -- Связь 1 к 1
);

-- Таблица для сущности Agreement
CREATE TABLE Agreement (
    id SERIAL PRIMARY KEY,
    type VARCHAR(50),
    description TEXT,
    date DATE,
    company_id INTEGER REFERENCES Company(id) ON DELETE CASCADE
);

-- Таблица для сущности Challenge
CREATE TABLE Challenge (
    id SERIAL PRIMARY KEY,
    type VARCHAR(50),
    description TEXT,
    severity VARCHAR(50),
    procedure_id INTEGER REFERENCES Procedure(id) ON DELETE CASCADE
);

-- Добавление данных в таблицы

-- Добавление компаний
INSERT INTO Company (name, foundation_date, employee_count, field_of_activity, status)
VALUES ('BioPharma', '2001-06-12', 300, 'Pharmaceuticals', 'Active'),
       ('GeneTech', '2015-09-01', 120, 'Genetic Engineering', 'Research');

-- Добавление препаратов
INSERT INTO Drug (name, purpose, development_stage, start_date, patent_status, company_id)
VALUES ('CureX', 'Cancer treatment', 'Testing', '2022-01-10', 'Pending', 1),
       ('GenVax', 'Vaccine development', 'Research', '2021-05-22', 'Granted', 2);

-- Связь компаний с препаратами (таблица Company_Drug)
INSERT INTO Company_Drug (company_id, drug_id)
VALUES (1, 1), -- BioPharma и CureX
       (2, 2); -- GeneTech и GenVax

-- Добавление процедур
INSERT INTO Procedure (type, description, start_date, status, drug_id)
VALUES ('Patent Application', 'Filing for patent of CureX', '2022-03-15', 'In Process', 1);

-- Добавление патентов (теперь 1 к 1 с Drug)
INSERT INTO Patent (number, issue_date, status, drug_id)
VALUES ('US123456', '2023-06-01', 'Approved', 2);

-- Добавление соглашений
INSERT INTO Agreement (type, description, date, company_id)
VALUES ('Patent Approval', 'Patent approved for GenVax', '2023-06-01', 2);

-- Добавление проблем
INSERT INTO Challenge (type, description, severity, procedure_id)
VALUES ('Delay', 'Patent application delayed due to missing documents', 'High', 1);
