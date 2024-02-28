SELECT 
	'finance.actuals' AS table,
	COUNT(*) AS n_rows
FROM finance.actuals

UNION ALL

SELECT 
	'finance.budget' AS table,
	COUNT(*) AS n_rows
FROM finance.budget