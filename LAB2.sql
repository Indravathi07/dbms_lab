CREATE DATABASE taxpaydb;
USE taxation_db;
SELECT * FROM taxpayer;
SELECT *FROM income_record;
SELECT * FROM income_category;
SELECT * FROM financial_year;

ALTER TABLE Income_Record
DROP COLUMN category_name;

ALTER TABLE Income_Record
DROP COLUMN financial_year;
ALTER TABLE Income_Record
ADD category_id INT,
ADD year_id INT;
UPDATE Income_Record
SET category_id = 1
WHERE income_id = 1001;
UPDATE Income_Record
SET category_id = 1
WHERE income_id = 1002;
UPDATE Income_Record
SET category_id = 2
WHERE income_id = 1003;
UPDATE Income_Record
SET category_id = 1
WHERE income_id = 1004;
UPDATE Income_Record
SET category_id = 2
WHERE income_id = 1005;
UPDATE Income_Record
SET category_id = 2
WHERE income_id = 1006;
UPDATE Income_Record
SET year_id = 6;
ALTER TABLE Income_Record
ADD CONSTRAINT fk_taxpayer
FOREIGN KEY (taxpayer_id)
REFERENCES Taxpayer(taxpayer_id);
ALTER TABLE Income_Record
ADD CONSTRAINT fk_category
FOREIGN KEY (category_id)
REFERENCES Income_Category(category_id);
ALTER TABLE Income_Record
ADD CONSTRAINT fk_year
FOREIGN KEY (year_id)
REFERENCES Financial_Year(year_id);
DESC Income_Record;
SELECT * FROM Income_Record;
INSERT INTO Income_Record
VALUES
(1007,999,'ABC Company',600000,'2026-03-20',NULL,1,6);
INSERT INTO Income_Record
VALUES
(1008,101,'ABC Company',500000,'2026-03-21',NULL,20,6);
INSERT INTO Income_Record
VALUES
(1009,101,'ABC Company',500000,'2026-03-21',NULL,1,15);
DELETE FROM Taxpayer
WHERE taxpayer_id=101;
DELETE FROM Income_Category
WHERE category_id=1;
SELECT DISTINCT occupation
FROM Taxpayer;
SELECT DISTINCT category_name
FROM Income_Category;
SELECT DISTINCT year_label
FROM Financial_Year;
SELECT DISTINCT income_source
FROM Income_Record;
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id IN
(
SELECT taxpayer_id
FROM Income_Record
WHERE category_id=1
)
UNION
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id IN

(
SELECT taxpayer_id
FROM Income_Record
WHERE category_id=2
);
SELECT income_source
FROM Income_Record
WHERE year_id=5
UNION
SELECT income_source
FROM Income_Record
WHERE year_id=6;
SELECT full_name
FROM Taxpayer
WHERE occupation='Teacher'
UNION
SELECT full_name
FROM Taxpayer
WHERE occupation='Software Engineer';
SELECT  DISTINCT taxpayer_id
FROM Income_Record
WHERE category_id=1
AND taxpayer_id IN 
(
SELECT taxpayer_id
FROM Income_Record
WHERE category_id=2);
SELECT DISTINCT taxpayer_id
FROM Income_Record
WHERE financial_year='2024-2025'
 AND taxpayer_id IN
 (
SELECT taxpayer_id
FROM Income_Record
WHERE financial_year='2025-2026');
SELECT DISTINCT taxpayer_id
FROM Income_Record
WHERE category_id = 1
AND taxpayer_id NOT IN
(
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id = 2
);
SELECT DISTINCT taxpayer_id
FROM Income_Record
WHERE financial_year='2025-2026'
AND taxpayer_id NOT IN
(
    SELECT taxpayer_id
    FROM Income_Record
    WHERE financial_year='2024-2025'
);
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id IN
(
    SELECT taxpayer_id
    FROM Income_Record
);
SELECT *
FROM Taxpayer
WHERE occupation IN
(
    SELECT occupation
    FROM Taxpayer
    WHERE taxpayer_id IN
    (
        SELECT taxpayer_id
        FROM Income_Record
        WHERE category_name='Business'
    )
);
SELECT *
FROM Taxpayer
WHERE taxpayer_id NOT IN
(
    SELECT taxpayer_id
    FROM Income_Record
);
SELECT DISTINCT occupation
FROM Taxpayer
WHERE taxpayer_id NOT IN
(
    SELECT taxpayer_id
    FROM Income_Record
);
SELECT full_name
FROM Taxpayer T
WHERE EXISTS
(
    SELECT *
    FROM Income_Record I
    WHERE T.taxpayer_id=I.taxpayer_id
);
SELECT year_label
FROM Financial_Year F
WHERE EXISTS
(
    SELECT *
    FROM Income_Record I
    WHERE F.year_label=I.financial_year
);
SELECT full_name
FROM Taxpayer T
WHERE NOT EXISTS
(
    SELECT *
    FROM Income_Record I
    WHERE T.taxpayer_id=I.taxpayer_id
);
SELECT category_name
FROM Income_Category C
WHERE NOT EXISTS
(
    SELECT *
    FROM Income_Record I
    WHERE C.category_name=I.category_name
);
SELECT *
FROM Taxpayer
WHERE annual_income > ANY
(
    SELECT annual_income
    FROM Taxpayer
    WHERE occupation='Teacher'
);
SELECT *
FROM Taxpayer
WHERE annual_income > ANY
(
    SELECT amount
    FROM Income_Record
    WHERE category_name='Business'
);
SELECT *
FROM Taxpayer
WHERE annual_income > ALL
(
    SELECT annual_income
    FROM Taxpayer
    WHERE occupation='Teacher'
);
SELECT *
FROM Taxpayer
WHERE annual_income > ALL
(
    SELECT amount
    FROM Income_Record
    WHERE category_name='Business'
);
SELECT *
FROM Taxpayer
ORDER BY full_name ASC;
SELECT *
FROM Taxpayer
WHERE annual_income > 800000;
SELECT *
FROM Taxpayer
WHERE occupation='Software Engineer';
SELECT *
FROM Income_Record
WHERE category_id=2;
SELECT *
FROM Income_Record
WHERE amount BETWEEN 500000 AND 1000000;
SELECT *
FROM Taxpayer
WHERE full_name LIKE 'A%';
SELECT *
FROM Taxpayer
WHERE is_active=TRUE;
SELECT COUNT(*) AS Total_Taxpayers
FROM Taxpayer;
SELECT MAX(annual_income) AS Highest_Income
FROM Taxpayer;
SELECT full_name
FROM Taxpayer
WHERE annual_income=
(
    SELECT MAX(annual_income)
    FROM Taxpayer
);
SELECT category_name,COUNT(*) AS Total_Records
FROM Income_Record
GROUP BY category_name
ORDER BY Total_Records DESC;
SELECT occupation,COUNT(*) AS Total_Taxpayers
FROM Taxpayer
GROUP BY occupation;
SELECT COUNT(*) AS Active_Taxpayers
FROM Taxpayer
WHERE is_active=TRUE;
SELECT financial_year,COUNT(*) AS Total_Records
FROM Income_Record
GROUP BY financial_year
ORDER BY Total_Records DESC;
