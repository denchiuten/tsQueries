SELECT
	i.key,
	s.name AS status,
	u.email AS assignee,
	i.summary
FROM jra.issue AS i
INNER JOIN jra.project AS p
	ON i.project = p.id
	AND p.key = 'PTINC'
LEFT JOIN jra.user AS u
	ON i.assignee = i.id
INNER JOIN jra.status AS s
	ON i.status = s.id
WHERE
	1 = 1
	AND i._fivetran_deleted IS FALSE
ORDER BY 2,3