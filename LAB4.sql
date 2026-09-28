USE taxpaydb;

SELECT t.fullname, r.income_source 
FROM Taxpayer t 
INNER JOIN Income_Record r ON t.taxpayer_id = r.taxpayer_id;

SELECT t.full_name, c.category_name 
FROM Taxpayer t 
INNER JOIN Income_Record r ON t.taxpayer_id = r.taxpayer_id 
INNER JOIN Income_Category c ON r.category_id = c.category_id;

SELECT r.record_id, f.financial_year 
FROM Income_Record r 
INNER JOIN Financial_Year f ON r.year_id = f.year_id;

SELECT t.full_name, r.annual_income, r.income_amount 
FROM Taxpayer t 
INNER JOIN Income_Record r ON t.taxpayer_id = r.taxpayer_id;

SELECT t.full_name, r.income_source, c.category_name, f.financial_year 
FROM Income_Record r 
INNER JOIN Taxpayer t ON r.taxpayer_id = t.taxpayer_id 
INNER JOIN Income_Category c ON r.category_id = c.category_id 
INNER JOIN Financial_Year f ON r.year_id = f.year_id;

SELECT t.full_name, r.income_source 
FROM Taxpayer t 
INNER JOIN Income_Record r ON t.taxpayer_id = r.taxpayer_id 
INNER JOIN Income_Category c ON r.category_id = c.category_id 
WHERE c.category_name = 'Salary';

SELECT t.full_name, t.occupation, r.income_source 
FROM Taxpayer t 
INNER JOIN Income_Record r ON t.taxpayer_id = r.taxpayer_id 
INNER JOIN Income_Category c ON r.category_id = c.category_id 
WHERE c.category_name = 'Business';

SELECT t.taxpayer_name, t.pan_number, f.start_date, f.end_date 
FROM Taxpayer t 
INNER JOIN Income_Record r ON t.taxpayer_id = r.taxpayer_id 
INNER JOIN Financial_Year f ON r.year_id = f.year_id;

SELECT t.taxpayer_name, c.description 
FROM Taxpayer t 
INNER JOIN Income_Record r ON t.taxpayer_id = r.taxpayer_id 
INNER JOIN Income_Category c ON r.category_id = c.category_id;

SELECT t.taxpayer_name, t.pan_number, t.occupation, r.income_source, c.category_name, r.income_amount, f.financial_year, f.start_date, f.end_date 
FROM Taxpayer t 
INNER JOIN Income_Record r ON t.taxpayer_id = r.taxpayer_id 
INNER JOIN Income_Category c ON r.category_id = c.category_id 
INNER JOIN Financial_Year f ON r.year_id = f.year_id;

SELECT t.taxpayer_name, r.record_id 
FROM Taxpayer t 
LEFT OUTER JOIN Income_Record r ON t.taxpayer_id = r.taxpayer_id;

SELECT r.record_id, c.category_name 
FROM Income_Record r 
RIGHT OUTER JOIN Income_Category c ON r.category_id = c.category_id;

SELECT t.taxpayer_name, r.record_id 
FROM Taxpayer t 
LEFT OUTER JOIN Income_Record r ON t.taxpayer_id = r.taxpayer_id 
UNION 
SELECT t.taxpayer_name, r.record_id 
FROM Taxpayer t 
RIGHT OUTER JOIN Income_Record r ON t.taxpayer_id = r.taxpayer_id;

SELECT t.taxpayer_name, f.financial_year 
FROM Taxpayer t 
CROSS JOIN Financial_Year f;

SELECT t1.taxpayer_name AS taxpayer_1, t2.taxpayer_name AS taxpayer_2, t1.occupation 
FROM Taxpayer t1 
INNER JOIN Taxpayer t2 ON t1.occupation = t2.occupation 
WHERE t1.taxpayer_id < t2.taxpayer_id;

SELECT t.taxpayer_name, t.pan_number, r.income_source, c.category_name, f.financial_year 
FROM Taxpayer t 
INNER JOIN Income_Record r ON t.taxpayer_id = r.taxpayer_id 
INNER JOIN Income_Category c ON r.category_id = c.category_id 
INNER JOIN Financial_Year f ON r.year_id = f.year_id;

SELECT t.taxpayer_name, c.category_name, c.description 
FROM Taxpayer t 
INNER JOIN Income_Record r ON t.taxpayer_id = r.taxpayer_id 
INNER JOIN Income_Category c ON r.category_id = c.category_id;

SELECT r.income_source, f.financial_year 
FROM Income_Record r 
INNER JOIN Financial_Year f ON r.year_id = f.year_id;

SELECT t.taxpayer_name 
FROM Taxpayer t 
INNER JOIN Income_Record r ON t.taxpayer_id = r.taxpayer_id 
INNER JOIN Income_Category c ON r.category_id = c.category_id 
INNER JOIN Financial_Year f ON r.year_id = f.year_id 
WHERE c.category_name = 'Business' AND f.financial_year = '2025–2026';

SELECT t.taxpayer_id, t.taxpayer_name, t.pan_number, t.occupation, r.record_id, r.income_source, r.income_amount, c.category_id, c.category_name, f.year_id, f.financial_year 
FROM Taxpayer t 
INNER JOIN Income_Record r ON t.taxpayer_id = r.taxpayer_id 
INNER JOIN Income_Category c ON r.category_id = c.category_id 
INNER JOIN Financial_Year f ON r.year_id = f.year_id;
