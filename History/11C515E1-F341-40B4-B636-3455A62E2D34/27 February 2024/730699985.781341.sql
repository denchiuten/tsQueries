SELECT
	b.date,
	SUM(b.value)

FROM finance.budget AS b
WHERE 
	b.cash_commitment IS TRUE
	AND b.date BETWEEN DATE_TRUNC('year', CURRENT_DATE) AND DATE_ADD('day', -1, DATE_ADD('year', 1, DATE_TRUNC('year', CURRENT_DATE)))