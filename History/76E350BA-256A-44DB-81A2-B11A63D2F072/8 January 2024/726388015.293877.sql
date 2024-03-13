SELECT
	s.name,
	i."key",
	u."name",
	i.summary
FROM jra.issue AS i
INNER JOIN jra.project AS p
	ON i.project = p.id
	AND p."key" = 'PTINC'
INNER JOIN jra.status AS s
	ON i.status = s.id
INNER JOIN jra."user" AS u
	ON i.assignee = u.id
WHERE
	1 = 1
	AND i._fivetran_deleted IS FALSE

ORDER BY 1,2