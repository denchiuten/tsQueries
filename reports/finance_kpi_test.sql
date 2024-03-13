SELECT
	f.date,
	-SUM(CASE WHEN f.team = 'Revenue' THEN value ELSE 0 END) AS revenue,
	SUM(CASE WHEN f.team = 'Revenue' THEN value ELSE 0 END) / LAG(SUM(CASE WHEN f.team = 'Revenue' THEN value ELSE 0 END), 12) OVER(ORDER BY f.date) - 1 AS revenue_yoy
FROM finance.actuals AS f
WHERE
	1 = 1
	AND f.close_date = (SELECT MAX(close_date) FROM finance.actuals)
	AND f.date <= f.close_date
GROUP BY 1
ORDER BY 1
	