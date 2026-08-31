USE taxation_db;

SELECT COUNT(*) FROM Income_Record;

SELECT SUM(income_amount) FROM Income_Record;

SELECT AVG(income_amount) FROM Income_Record;

SELECT MAX(income_amount) FROM Income_Record;

SELECT MIN(income_amount) FROM Income_Record;

SELECT category_id, COUNT(*) FROM Income_Record GROUP BY category_id;

SELECT category_id, SUM(income_amount) FROM Income_Record GROUP BY category_id;

SELECT category_id, AVG(income_amount) FROM Income_Record GROUP BY category_id;

SELECT category_id, MAX(income_amount) FROM Income_Record GROUP BY category_id;

SELECT category_id, MIN(income_amount) FROM Income_Record GROUP BY category_id;

SELECT year_id, SUM(income_amount) FROM Income_Record GROUP BY year_id;

SELECT year_id, COUNT(*) FROM Income_Record GROUP BY year_id;

SELECT category_id, year_id, SUM(income_amount) FROM Income_Record GROUP BY category_id, year_id;

SELECT category_id, SUM(income_amount) FROM Income_Record GROUP BY category_id HAVING SUM(income_amount) > 1000000;

SELECT category_id, AVG(income_amount) FROM Income_Record GROUP BY category_id HAVING AVG(income_amount) > 500000;

SELECT year_id, COUNT(*) FROM Income_Record GROUP BY year_id HAVING COUNT(*) > 3;

SELECT category_id, SUM(income_amount) FROM Income_Record GROUP BY category_id ORDER BY SUM(income_amount) DESC;

SELECT category_id, SUM(income_amount) FROM Income_Record GROUP BY category_id HAVING SUM(income_amount) > 1000000 ORDER BY SUM(income_amount) DESC;

SELECT category_id, SUM(income_amount), AVG(income_amount) FROM Income_Record GROUP BY category_id;

SELECT category_id, year_id, SUM(income_amount) FROM Income_Record GROUP BY category_id, year_id ORDER BY SUM(income_amount) DESC LIMIT 1;

SELECT f.financial_year, COUNT(DISTINCT r.taxpayer_id) FROM Income_Record r INNER JOIN Financial_Year f ON r.year_id = f.year_id GROUP BY f.financial_year;

SELECT c.category_name, SUM(r.income_amount) FROM Income_Record r INNER JOIN Income_Category c ON r.category_id = c.category_id GROUP BY c.category_name ORDER BY SUM(r.income_amount) DESC LIMIT 1;

SELECT f.financial_year, SUM(r.income_amount) FROM Income_Record r INNER JOIN Financial_Year f ON r.year_id = f.year_id GROUP BY f.financial_year ORDER BY SUM(r.income_amount) DESC LIMIT 1;

SELECT c.category_name, AVG(r.income_amount) FROM Income_Record r INNER JOIN Income_Category c ON r.category_id = c.category_id GROUP BY c.category_name ORDER BY AVG(r.income_amount) DESC LIMIT 1;

SELECT c.category_name, COUNT(*) FROM Income_Record r INNER JOIN Income_Category c ON r.category_id = c.category_id GROUP BY c.category_name HAVING COUNT(*) > 2;

SELECT year_id, SUM(income_amount) FROM Income_Record GROUP BY year_id HAVING SUM(income_amount) > 1000000;

SELECT c.category_name, COUNT(r.income_id), SUM(r.income_amount), AVG(r.income_amount), MAX(r.income_amount), MIN(r.income_amount) FROM Income_Record r INNER JOIN Income_Category c ON r.category_id = c.category_id GROUP BY c.category_name;
