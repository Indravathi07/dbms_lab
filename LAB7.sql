USE taxpaydb;
SHOW tables;
CREATE OR REPLACE VIEW highest_income AS
SELECT *
FROM Income_Record
WHERE amount = (
	SELECT MAX(amount)
    FROM Income_Record
);
SELECT *FROM highest_income;
CREATE OR REPLACE VIEW lowest_income AS
SELECT *
FROM Income_Record
WHERE amount = (
	SELECT MIN(amount)
    FROM Income_Record
);
SELECT * FROM lowest_income;

CREATE OR REPLACE VIEW above_average_income AS
SELECT *
FROM Income_Record
WHERE amount>(
	SELECT AVG(amount)
    FROM Income_Record
);
SELECT *FROM above_average_income;

CREATE OR REPLACE VIEW highest_income_records AS
SELECT *
FROM Income_Record
WHERE amount = (
	SELECT MAX(amount)
    FROM Income_Record
);
SELECT * FROM highest_income_records;

CREATE OR REPLACE VIEW business_owners AS
SELECT *
FROM Taxpayer
WHERE occupation = 'Business Owner';
SELECT * FROM business_owners;

CREATE or replace VIEW taxpayers_with_income AS
SELECT DISTINCT t.*
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id;
SELECT * FROM taxpayers_with_income;

CREATE OR REPLACE VIEW 
business_income_taxpayers AS
SELECT DISTINCT t.*
FROM Taxpayer t
INNER JOIN Income_Record i 
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id
WHERE c.category_name = 'Business';

SELECT * FROM business_income_taxpayers;
CREATE OR REPLACE VIEW income_2025_2026 AS
SELECT i.*
FROM Income_Record i
INNER JOIN Financial_Year f
ON i.year_id = f.year_id
WHERE f.year_label = '2025-2026';

SELECT * FROM income_2025_2026;
CREATE OR REPLACE VIEW
greater_than_min_business_income AS
SELECT *
FROM Income_Record
WHERE amount >(
	SELECT MIN(i.amount)
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Business'
);
SELECT * FROM greater_than_min_business_income;

CREATE or replace VIEW less_than_max_salary_income AS
SELECT * FROM Income_Record 
WHERE amount < (
	SELECT MAX(i.amount)
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'salary'
);
SELECT *FROM less_than_max_salary_income;

CREATE OR REPLACE VIEW taxpayers_above_average_income AS
SELECT DISTINCT t.*
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.amount > (
    SELECT AVG(amount)
    FROM Income_Record
);

SELECT * FROM taxpayers_above_average_income;
CREATE OR REPLACE VIEW categories_with_income AS

SELECT DISTINCT c.*
FROM Income_Category c
INNER JOIN Income_Record i
ON c.category_id = i.category_id;

SELECT * FROM categories_with_income;

CREATE OR REPLACE VIEW taxpayers_without_investment AS
SELECT *
FROM Taxpayer
WHERE taxpayer_id NOT IN (
    SELECT i.taxpayer_id
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Investment'
);
SELECT * FROM taxpayers_without_investment;

CREATE OR REPLACE VIEW taxpayer_highest_income AS
SELECT t.*, i.amount
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.amount = (
    SELECT MAX(amount)
    FROM Income_Record
);
SELECT * FROM taxpayer_highest_income;

CREATE OR REPLACE VIEW above_average_business_income AS
SELECT *
FROM Income_Record
WHERE amount > (
    SELECT AVG(i.amount)
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Business'
);
SELECT * FROM above_average_business_income;

CREATE OR REPLACE VIEW taxpayers_above_avg_total AS
SELECT t.taxpayer_id,
       t.full_name,
       SUM(i.amount) AS total_income
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
GROUP BY t.taxpayer_id, t.full_name
HAVING SUM(i.amount) > (
    SELECT AVG(total_income)
    FROM (
        SELECT SUM(amount) AS total_income
        FROM Income_Record
        GROUP BY taxpayer_id
    ) AS totals
);
SELECT * FROM taxpayers_above_avg_total;

CREATE OR REPLACE VIEW greater_than_any_investment AS
SELECT *
FROM Income_Record
WHERE amount > ANY (
    SELECT i.amount
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Investment'
);
SELECT * FROM greater_than_any_investment;

CREATE OR REPLACE VIEW greater_than_all_investment AS
SELECT *
FROM Income_Record
WHERE amount > ALL (
    SELECT i.amount
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Investment'
);
SELECT * FROM greater_than_all_investment;

CREATE OR REPLACE VIEW category_highest_income AS
SELECT DISTINCT c.*
FROM Income_Category c
INNER JOIN Income_Record i
ON c.category_id = i.category_id
WHERE i.amount = (
    SELECT MAX(amount)
    FROM Income_Record
);
SELECT * FROM category_highest_income;

CREATE OR REPLACE VIEW year_highest_total_income AS
SELECT f.year_id,
       f.year_label,
       SUM(i.amount) AS total_income
FROM Financial_Year f
INNER JOIN Income_Record i
ON f.year_id = i.year_id
GROUP BY f.year_id, f.year_label
HAVING SUM(i.amount) = (
    SELECT MAX(total_income)
    FROM (
        SELECT SUM(amount) AS total_income
        FROM Income_Record
        GROUP BY year_id
    ) AS yearly_totals
);
SELECT * FROM year_highest_total_income;

CREATE OR REPLACE VIEW taxpayers_greater_avg_total AS
SELECT t.taxpayer_id,
       t.full_name,
       SUM(i.amount) AS total_income
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
GROUP BY t.taxpayer_id, t.full_name
HAVING SUM(i.amount) > (
    SELECT AVG(total_income)
    FROM (
        SELECT SUM(amount) AS total_income
        FROM Income_Record
        GROUP BY taxpayer_id
    ) AS avg_totals
);
SELECT * FROM taxpayers_greater_avg_total;

SELECT t.taxpayer_id, t.full_name, i.amount
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.amount = (
    SELECT MAX(amount)
    FROM Income_Record
);

SELECT DISTINCT t.taxpayer_id, t.full_name
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.amount > (
    SELECT AVG(amount)
    FROM Income_Record
);

SELECT DISTINCT c.category_id, c.category_name
FROM Income_Category c
INNER JOIN Income_Record i
ON c.category_id = i.category_id
WHERE i.amount = (
    SELECT MAX(amount)
    FROM Income_Record
);

SELECT *
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT i.taxpayer_id
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Business'
)
AND taxpayer_id NOT IN (
    SELECT i.taxpayer_id
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Investment'
);

SELECT *
FROM Income_Record
WHERE income_amount > ANY (
    SELECT i.income_amount
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Investment'
);

SELECT t.taxpayer_id,
       t.full_name,
       SUM(i.amount) AS total_income
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
GROUP BY t.taxpayer_id, t.full_name
HAVING SUM(i.amount) = (
    SELECT MAX(total_income)
    FROM (
        SELECT SUM(amount) AS total_income
        FROM Income_Record
        GROUP BY taxpayer_id
    ) AS totals
);

SELECT i.*
FROM Income_Record i
INNER JOIN (
    SELECT category_id,
           AVG(amount) AS avg_income
    FROM Income_Record
    GROUP BY category_id
) AS category_avg
ON i.category_id = category_avg.category_id
WHERE i.amount > category_avg.avg_income;
