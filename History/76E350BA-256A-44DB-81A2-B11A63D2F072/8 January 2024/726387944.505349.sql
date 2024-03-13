SELECT
	s.name,
	i."key",
	i.summary
FROM jra.issue AS i
INNER JOIN jra.project AS p
	ON i.project = p.id
	AND p."key" = 'PTINC'
INNER JOIN jra.status AS s
	ON i.status = s.id
WHERE
	1 = 1
	AND i._fivetran_deleted IS FALSE
GROUP BY 1,2
ORDER BY 1,2