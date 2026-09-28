USE taxpaydb;

SELECT UPPER(taxpayer_name) AS name_uppercase 
FROM Taxpayer;

SELECT LOWER(occupation) AS occupation_lowercase 
FROM Taxpayer;

SELECT taxpayer_name, LENGTH(taxpayer_name) AS name_length 
FROM Taxpayer;

SELECT COALESCE(LEFT(pan_number, 4), LEFT(taxpayer_id, 4)) AS id_prefix 
FROM Taxpayer;

SELECT CONCAT(taxpayer_name, ' - ', occupation) AS profile 
FROM Taxpayer;

SELECT REPLACE(category_name, 'Income', 'Inc.') AS short_category_name 
FROM Income_Category;

SELECT TRIM(taxpayer_name) AS cleaned_name 
FROM Taxpayer;

SELECT SUBSTRING_INDEX(TRIM(taxpayer_name), ' ', 1) AS first_name 
FROM Taxpayer;

SELECT CONCAT('Taxpayer : ', taxpayer_name, '\nOccupation : ', occupation) AS formatted_display 
FROM Taxpayer;

SELECT * 
FROM Taxpayer 
WHERE pan_number LIKE 'AP%';

SELECT ROUND(amount) AS rounded_income 
FROM Income_Record;

SELECT ABS(amount - 500000) AS absolute_difference 
FROM Income_Record;

SELECT POWER(amount, 2) AS squared_income 
FROM Income_Record;

SELECT MOD(amount, 1000) AS income_remainder 
FROM Income_Record;

SELECT ROUND(amount, 2) AS rounded_income_2dec 
FROM Income_Record;

SELECT CEIL(amount) AS ceiling_income, FLOOR(annual_income) AS floor_income 
FROM Income_Record;

SELECT FLOOR(1 + RAND() * 100) AS random_integer;

SELECT SQRT(amount) AS sqrt_income 
FROM Income_Record;

SELECT amount, (amount * 1.10) AS incremented_income 
FROM Income_Record;

SELECT CURDATE() AS todays_date;

SELECT NOW() AS current_datetime;

SELECT YEAR(start_date) AS fy_start_year 
FROM Financial_Year;

SELECT MONTH(start_date) AS fy_start_month 
FROM Financial_Year;

SELECT DAY(start_date) AS fy_start_day 
FROM Financial_Year;

SELECT DATE_ADD(start_date, INTERVAL 1 YEAR) AS fy_end_date 
FROM Financial_Year;

SELECT DATE_ADD(start_date, INTERVAL 30 DAY) AS start_plus_30_days 
FROM Financial_Year;

SELECT DATE_SUB(start_date, INTERVAL 7 DAY) AS start_minus_7_days 
FROM Financial_Year;

SELECT DATEDIFF(CURDATE(), start_date) AS days_difference 
FROM Financial_Year;

SELECT * 
FROM Financial_Year 
WHERE YEAR(start_date) = YEAR(CURDATE());

SELECT CAST(amount AS SIGNED) AS integer_income 
FROM Income_Record;

SELECT CAST(taxpayer_id AS CHAR) AS char_taxpayer_id 
FROM Taxpayer;

SELECT CAST(start_date AS DATETIME) AS datetime_start 
FROM Financial_Year;

SELECT CAST(amount AS DECIMAL(15, 2)) AS decimal_income 
FROM Income_Record;

SELECT CONVERT(amount, CHAR) AS string_income 
FROM Income_Record;

SELECT CAST(amount AS DECIMAL(15, 2)) * 0.20 AS calculated_tax 
FROM Income_Record;
