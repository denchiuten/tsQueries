SELECT 
	CASE 
		WHEN f.date <= f.close_date THEN 'Actual'
		ELSE 'Forecast'
		END AS type,
	f.*
FROM finance.actuals AS f
WHERE
	1 = 1
	AND f.close_date = (SELECT MAX(close_date) FROM finance.actuals)
	-- date is between the start and end of the close_date year
	AND f.date BETWEEN DATE_TRUNC('year', f.close_date) AND DATE_ADD('day', -1, DATE_ADD('year', 1, DATE_TRUNC('year', f.close_date)))
	
UNION ALL

SELECT
	'Budget' AS type,
	b.*
FROM finance.budget AS b	
WHERE
	-- date is between the start and end of the current year
	b.date BETWEEN DATE_TRUNC('year', CURRENT_DATE) AND DATE_ADD('day', -1, DATE_ADD('year', 1, DATE_TRUNC('year', CURRENT_DATE)))