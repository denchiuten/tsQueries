SELECT 
	l.id AS label_id,
	l.name AS label_name,
	COUNT(DISTINCT t.id) AS n_teams
FROM linear.label AS l
INNER JOIN linear.team AS t
	ON l.team_id = t.id
	AND t._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND l._fivetran_deleted IS FALSE
GROUP BY 1,2
ORDER BY 3 DESC