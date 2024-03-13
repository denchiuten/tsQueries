SELECT
	s.name AS status,
	i.assignee IS NULL AS no_assignee_boolean,
	COUNT(*),
	SUM(COUNT(*)) OVER (PARTITION BY s.name) AS share
FROM jra.issue AS i
INNER JOIN jra.status AS s
	ON i.status = s.id
WHERE
	1 = 1
	AND i._fivetran_deleted IS FALSE
GROUP BY 1,2
ORDER BY 1,2