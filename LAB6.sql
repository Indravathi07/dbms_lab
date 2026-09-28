USE taxpaydb;
SHOW TABLES;

SELECT * FROM taxpayer;
SELECT *FROM income_record;
SELECT * FROM income_category;
SELECT * FROM financial_year;

SELECT * 
FROM income_record
WHERE amount = (
	SELECT MAX(amount)
    FROM income_record
);

SELECT *
FROM income_record
WHERE amount = (
	SELECT MIN(amount)
    FROM income_record
);

SELECT *
FROM income_record
WHERE amount > (
	SELECT AVG(amount)
    FROM income_record
);

SELECT *
FROM income_record
WHERE amount = (
	SELECT MAX(amount)
    FROM income_record
);

SELECT *
FROM taxpayer
WHERE taxpayer_ID IN(
	SELECT taxpayer_id
    FROM taxpayer
    WHERE occupation = 'Business OWNER'
);

SELECT *
FROM taxpayer
WHERE taxpayer_id IN(
	SELECT taxpayer_id
    FROM income_record
);

SELECT *
FROM taxpayer
WHERE taxpayer_id IN(
	SELECT taxpayer_id
    FROM income_record
    WHERE category_id IN(
		SELECT category_id
        FROM income_category
        WHERE category_name = 'BUSINESS'
	)
);

SELECT *
FROM income_record
WHERE YEAR_ID IN(
	SELECT year_id 
    FROM financial_year
    WHERE year_label = '2025-2026'
);

SELECT *
FROM income_record
WHERE amount >(
	SELECT MIN(amount)
    FROM income_category
    WHERE category_id IN(
		SELECT category_id
        FROM income_category
        WHERE category_name='BUSINESS'
	)
);

SELECT *
FROM income_record
WHERE amount < (
	SELECT max(amount)
    FROM income_record
    WHERE category_id IN(
		SELECT category_id 
        from income_category
        where category_name='salary'
	)
);

SELECT DISTINCT t.*
FROM taxpayer t
JOIN income_record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.amount > (
	SELECT AVG(amount)
    from income_record
);

SELECT *
FROM income_category
WHERE category_id IN(
	SELECT category_id
    FROM income_record
);

SELECT *
FROM taxpayer
where taxpayer_id NOT IN(
	SELECT taxpayer_id
    FROM income_record
    WHERE category_id IN(
		SELECT category_id
        FROM income_category
        WHERE category_name='INVESTMENT'
	)
);

SELECT *
FROM taxpayer
WHERE taxpayer_id IN(
	SELECT taxpayer_id
    FROM income_record
    WHERE amount=(
		SELECT MAX(amount)
        FROM income_record
	)
);

SELECT *
FROM income_record
WHERE amount > (
	SELECT AVG(amount)
    FROM income_record
    WHERE category_id IN(
		SELECT category_id
        FROM income_category
        WHERE category_name='business'
	)
);

SELECT DISTINCT t.*
FROM Taxpayer t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.amount > (
    SELECT AVG(amount)
    FROM Income_Record
);

SELECT *
FROM Income_Record
WHERE amount > ANY (
    SELECT amount
    FROM Income_Record
    WHERE category_id IN (
        SELECT category_id
        FROM Income_Category
        WHERE category_name = 'Investment'
    )
);

SELECT *
FROM Income_Record
WHERE amount > ALL (
    SELECT amount
    FROM Income_Record
    WHERE category_id IN (
        SELECT category_id
        FROM Income_Category
        WHERE category_name = 'Investment'
    )
);

SELECT *
FROM Income_Category
WHERE category_id IN (
    SELECT category_id
    FROM Income_Record
    WHERE amount = (
        SELECT MAX(amount)
        FROM Income_Record
    )
);

SELECT *
FROM Financial_Year
WHERE year_id IN (
    SELECT year_id
    FROM Income_Record
    GROUP BY year_id
    HAVING SUM(amount) = (
        SELECT MAX(total_income)
        FROM (
            SELECT year_id,
                   SUM(amount) AS total_income
            FROM Income_Record
            GROUP BY year_id
        ) AS yearly_total
    )
);

SELECT t.taxpayer_id, t.full_name, SUM(i.amount) AS total_income
FROM Taxpayer t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
GROUP BY t.taxpayer_id, t.full_name
HAVING SUM(i.amount) > (
    SELECT AVG(total_income)
    FROM (
        SELECT taxpayer_id,
               SUM(amount) AS total_income
        FROM Income_Record
        GROUP BY taxpayer_id
    ) AS taxpayer_totals
);

SELECT t.*
FROM Taxpayer t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.amount = (
    SELECT MAX(amount)
    FROM Income_Record
);

SELECT DISTINCT t.*
FROM Taxpayer t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.amount > (
    SELECT AVG(amount)
    FROM Income_Record
);

SELECT *
FROM Income_Category
WHERE category_id IN (
    SELECT category_id
    FROM Income_Record
    WHERE amount = (
        SELECT MAX(amount)
        FROM Income_Record
    )
);

SELECT *
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id IN (
        SELECT category_id
        FROM Income_Category
        WHERE category_name = 'Business'
    )
)
AND taxpayer_id NOT IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id IN (
        SELECT category_id
        FROM Income_Category
        WHERE category_name = 'Investment'
    )
);

SELECT *
FROM Income_Record
WHERE amount > ALL (
    SELECT amount
    FROM Income_Record
    WHERE category_id IN (
        SELECT category_id
        FROM Income_Category
        WHERE category_name = 'Investment'
    )
);

SELECT *
FROM Income_Record
WHERE amount > ANY (
    SELECT amount
    FROM Income_Record
    WHERE category_id IN (
        SELECT category_id
        FROM Income_Category
        WHERE category_name = 'Investment'
    )
);

SELECT t.taxpayer_id,
       t.full_name,
       SUM(i.amount) AS total_income
FROM Taxpayer t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
GROUP BY t.taxpayer_id, t.full_name
HAVING SUM(i.amount) = (
    SELECT MAX(total_income)
    FROM (
        SELECT taxpayer_id,
               SUM(amount) AS total_income
        FROM Income_Record
        GROUP BY taxpayer_id
    ) AS totals
);

SELECT i.*
FROM Income_Record i
JOIN (
    SELECT category_id,
           AVG(amount) AS avg_income
    FROM Income_Record
    GROUP BY category_id
) AS category_avg
ON i.category_id = category_avg.category_id
WHERE i.amount > category_avg.avg_income;
