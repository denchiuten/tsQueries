SELECT
	'Budget' AS type,
	b.*
FROM finance.budget AS b	
WHERE
	b.date BETWEEN DATE_ADD('day', -1, DATE_ADD('year', 1, DATE_TRUNC('year', CURRENT_DATE))) AND DATE_TRUNC('year', CURRENT_DATE)