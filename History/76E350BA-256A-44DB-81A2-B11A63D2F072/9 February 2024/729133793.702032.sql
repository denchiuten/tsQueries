SELECT *
FROM finance.actuals AS f
WHERE
	1 = 1
	AND f.close_date = (SELECT MAX(close_date) FROM finance.actuals)
	AND f.date <= f.close_date