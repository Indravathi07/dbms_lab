USE taxpaydb;

SHOW TABLES;

SELECT * FROM Taxpayer;
SELECT * FROM Income_Category;
SELECT * FROM Financial_Year;
SELECT * FROM Income_Record;

SET AUTOCOMMIT = 0;

SELECT @@AUTOCOMMIT;

START TRANSACTION;

UPDATE Income_Record
SET amount = 900000
WHERE income_id = 1001;

SELECT * FROM Income_Record WHERE income_id = 1001;

START TRANSACTION;

UPDATE Income_Record
SET amount = 950000
WHERE income_id = 1001;

SELECT * FROM Income_Record WHERE income_id = 1001;

COMMIT;

SELECT * FROM Income_Record WHERE income_id = 1001;

START TRANSACTION;

UPDATE Income_Record
SET amount = 1200000
WHERE income_id = 1001;

SELECT * FROM Income_Record WHERE income_id = 1001;

ROLLBACK;

SELECT * FROM Income_Record WHERE income_id = 1001;

START TRANSACTION;

INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, category_id, amount, received_date, year_id)
VALUES
(1015, 101, 'Test Income', 1, 500000.00, '2026-03-31', 6);

SELECT * FROM Income_Record WHERE income_id = 1015;

ROLLBACK;

SELECT * FROM Income_Record WHERE income_id = 1015;

START TRANSACTION;

DELETE FROM Income_Record
WHERE income_id = 1006;

SELECT * FROM Income_Record WHERE income_id = 1006;

ROLLBACK;

SELECT * FROM Income_Record WHERE income_id = 1006;

START TRANSACTION;

UPDATE Income_Record
SET amount = 1600000
WHERE income_id = 1006;

INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, category_id, amount, received_date, year_id)
VALUES
(1015, 102, 'Part Time Work', 1, 400000.00, '2026-03-31', 6);

SELECT * FROM Income_Record
WHERE income_id IN (1006, 1015);

COMMIT;

START TRANSACTION;

UPDATE Income_Record
SET amount = 900000
WHERE income_id = 1001;

SAVEPOINT income_update;

UPDATE Income_Record
SET amount = 1300000
WHERE income_id = 1002;

SELECT * FROM Income_Record
WHERE income_id IN (1001, 1002);

ROLLBACK TO SAVEPOINT income_update;

SELECT * FROM Income_Record
WHERE income_id IN (1001, 1002);

COMMIT;

START TRANSACTION;

INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, category_id, amount, received_date, year_id)
VALUES
(1016, 103, 'Consulting', 2, 600000.00, '2026-03-31', 6);

SAVEPOINT new_income;

UPDATE Income_Record
SET amount = 2000000
WHERE income_id = 1003;

SELECT * FROM Income_Record
WHERE income_id IN (1003, 1016);

ROLLBACK TO SAVEPOINT new_income;

SELECT * FROM Income_Record
WHERE income_id IN (1003, 1016);

COMMIT;

START TRANSACTION;

UPDATE Income_Record
SET amount = 910000
WHERE income_id = 1001;

SAVEPOINT sp1;

UPDATE Income_Record
SET amount = 1250000
WHERE income_id = 1002;

SAVEPOINT sp2;

UPDATE Income_Record
SET amount = 1900000
WHERE income_id = 1003;

SELECT * FROM Income_Record
WHERE income_id IN (1001, 1002, 1003);

ROLLBACK TO SAVEPOINT sp1;

SELECT * FROM Income_Record
WHERE income_id IN (1001, 1002, 1003);

COMMIT;

START TRANSACTION;

INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, category_id, amount, received_date, year_id)
VALUES
(1017, 104, 'Bonus', 1, 100000.00, '2026-03-31', 6);

UPDATE Income_Record
SET amount = 700000
WHERE income_id = 1004;

SAVEPOINT before_delete;

DELETE FROM Income_Record
WHERE income_id = 1005;

SELECT * FROM Income_Record
WHERE income_id IN (1004, 1005, 1017);

ROLLBACK TO SAVEPOINT before_delete;

SELECT * FROM Income_Record
WHERE income_id IN (1004, 1005, 1017);

COMMIT;

START TRANSACTION;

UPDATE Income_Record
SET amount = 880000
WHERE income_id = 1001;

SAVEPOINT test_savepoint;

RELEASE SAVEPOINT test_savepoint;

ROLLBACK;

START TRANSACTION;

UPDATE Income_Record
SET amount = 111111
WHERE income_id = 1001;

UPDATE Income_Record
SET amount = 222222
WHERE income_id = 1002;

ROLLBACK;

SELECT * FROM Income_Record
WHERE income_id IN (1001, 1002);

START TRANSACTION;

UPDATE Income_Record
SET amount = 333333
WHERE income_id = 1001;

SAVEPOINT partial_rollback;

UPDATE Income_Record
SET amount = 444444
WHERE income_id = 1002;

ROLLBACK TO SAVEPOINT partial_rollback;

SELECT * FROM Income_Record
WHERE income_id IN (1001, 1002);

COMMIT;

CREATE USER IF NOT EXISTS
'tax_clerk1'@'localhost'
IDENTIFIED BY 'Tax@123';

SHOW GRANTS FOR 'tax_clerk1'@'localhost';

GRANT SELECT
ON taxpaydb.Taxpayer
TO 'tax_clerk1'@'localhost';

SHOW GRANTS FOR 'tax_clerk1'@'localhost';

GRANT INSERT
ON taxpaydb.Income_Record
TO 'tax_clerk1'@'localhost';

SHOW GRANTS FOR 'tax_clerk1'@'localhost';

CREATE OR REPLACE VIEW Taxpayer_Income_Summary AS
SELECT
    t.taxpayer_id,
    t.full_name,
    ir.income_source,
    ir.amount
FROM Taxpayer t
INNER JOIN Income_Record ir
ON t.taxpayer_id = ir.taxpayer_id;

GRANT SELECT
ON taxpaydb.Taxpayer_Income_Summary
TO 'tax_clerk1'@'localhost';

SHOW GRANTS FOR 'tax_clerk1'@'localhost';

REVOKE INSERT
ON taxpaydb.Income_Record
FROM 'tax_clerk1'@'localhost';

SHOW GRANTS FOR 'tax_clerk1'@'localhost';

CREATE USER IF NOT EXISTS
'tax_data_entry'@'localhost'
IDENTIFIED BY 'Entry@123';

GRANT SELECT, INSERT
ON taxpaydb.Income_Record
TO 'tax_data_entry'@'localhost';

SHOW GRANTS FOR 'tax_data_entry'@'localhost';

CREATE USER IF NOT EXISTS
'tax_officer'@'localhost'
IDENTIFIED BY 'Officer@123';

GRANT SELECT, INSERT, UPDATE
ON taxpaydb.Income_Record
TO 'tax_officer'@'localhost';

SHOW GRANTS FOR 'tax_officer'@'localhost';

GRANT SELECT
ON taxpaydb.Taxpayer_Income_Summary
TO 'tax_officer'@'localhost';

SHOW GRANTS FOR 'tax_officer'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON taxpaydb.Income_Record
TO 'tax_officer'@'localhost';

REVOKE UPDATE
ON taxpaydb.Income_Record
FROM 'tax_officer'@'localhost';

SHOW GRANTS FOR 'tax_officer'@'localhost';

SHOW GRANTS FOR 'tax_data_entry'@'localhost';

SHOW GRANTS FOR 'tax_officer'@'localhost';

CREATE USER IF NOT EXISTS
'tax_entry_min'@'localhost'
IDENTIFIED BY 'Min@123';

GRANT SELECT, INSERT
ON taxpaydb.Income_Record
TO 'tax_entry_min'@'localhost';

SHOW GRANTS FOR 'tax_entry_min'@'localhost';

START TRANSACTION;

INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, category_id, amount, received_date, year_id)
VALUES
(1019, 106, 'Consulting', 2, 750000.00, '2026-03-31', 6);

SELECT * FROM Income_Record
WHERE income_id = 1019;

COMMIT;

SELECT * FROM Income_Record
WHERE income_id = 1019;

START TRANSACTION;

UPDATE Income_Record
SET amount = 9999999
WHERE income_id = 1001;

SELECT * FROM Income_Record
WHERE income_id = 1001;

ROLLBACK;

SELECT * FROM Income_Record
WHERE income_id = 1001;

START TRANSACTION;

UPDATE Income_Record
SET amount = 900000
WHERE income_id = 1001;

SAVEPOINT valid_change;

UPDATE Income_Record
SET amount = 9999999
WHERE income_id = 1002;

ROLLBACK TO SAVEPOINT valid_change;

SELECT * FROM Income_Record
WHERE income_id IN (1001, 1002);

COMMIT;

CREATE USER IF NOT EXISTS
'tax_data_entry2'@'localhost'
IDENTIFIED BY 'Entry2@123';

GRANT SELECT, INSERT
ON taxpaydb.Income_Record
TO 'tax_data_entry2'@'localhost';

SHOW GRANTS FOR 'tax_data_entry2'@'localhost';

GRANT SELECT
ON taxpaydb.Taxpayer_Income_Summary
TO 'tax_data_entry2'@'localhost';

SELECT * FROM Taxpayer_Income_Summary;

GRANT UPDATE
ON taxpaydb.Income_Record
TO 'tax_data_entry2'@'localhost';

SHOW GRANTS FOR 'tax_data_entry2'@'localhost';

REVOKE UPDATE
ON taxpaydb.Income_Record
FROM 'tax_data_entry2'@'localhost';

SHOW GRANTS FOR 'tax_data_entry2'@'localhost';

USE taxpaydb;

SHOW TABLES;

SELECT * FROM Taxpayer;

SELECT * FROM Income_Category;

SELECT * FROM Financial_Year;

SELECT * FROM Income_Record;

SELECT @@AUTOCOMMIT;

SET AUTOCOMMIT = 1;

SELECT @@AUTOCOMMIT;

SELECT CURRENT_USER();

SHOW GRANTS FOR 'tax_clerk1'@'localhost';

