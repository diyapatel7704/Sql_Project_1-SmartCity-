CREATE DATABASE SmartCityDB;
USE SmartCityDB;
CREATE TABLE Zones (
    zone_id INT PRIMARY KEY,
    zone_name VARCHAR(100),
    population INT
);

CREATE TABLE Residents (
    resident_id INT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(200),
    zone_id INT,
    household_size INT,
    FOREIGN KEY (zone_id) REFERENCES Zones(zone_id)
);

CREATE TABLE Utilities (
    utility_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE UsageRecords (
    record_id INT PRIMARY KEY,
    resident_id INT,
    utility_id INT,
    usage_unit DECIMAL(10,2),
    usage_date DATE,
    FOREIGN KEY (resident_id) REFERENCES Residents(resident_id),
    FOREIGN KEY (utility_id) REFERENCES Utilities(utility_id)
);

CREATE TABLE Billing (
    bill_id INT PRIMARY KEY,
    resident_id INT,
    utility_id INT,
    billing_month DATE,
    amount_due DECIMAL(10,2),
    paid_status VARCHAR(10),
    FOREIGN KEY (resident_id) REFERENCES Residents(resident_id),
    FOREIGN KEY (utility_id) REFERENCES Utilities(utility_id)
);

-- Zones
INSERT INTO Zones VALUES (1, 'North Zone', 25000), (2, 'South Zone', 18000);

-- Utilities
INSERT INTO Utilities VALUES (1, 'Electricity'), (2, 'Water');

-- Residents
INSERT INTO Residents VALUES
(1, 'Amit Sharma', '123 North Street', 1, 4),
(2, 'Priya Verma', '45 South Lane', 2, 3);

-- Usage Records
INSERT INTO UsageRecords VALUES
(101, 1, 1, 120.50, '2025-04-01'),
(102, 2, 2, 45.20, '2025-04-01');

-- Billing
INSERT INTO Billing VALUES
(1, 1, 1, '2025-04-30', 800.00, 'Unpaid'),
(2, 2, 2, '2025-04-30', 200.00, 'Paid');