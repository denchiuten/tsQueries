SELECT *
FROM finance.actuals AS f
WHERE
	1 = 1
	AND f.close_date = (SELECT MAX(close_date) FROM finance.actuals)
	AND f.date <= DATE_ADD('day', -1, DATE_ADD('year', 1, DATE_TRUNC('year', f.close_date)))