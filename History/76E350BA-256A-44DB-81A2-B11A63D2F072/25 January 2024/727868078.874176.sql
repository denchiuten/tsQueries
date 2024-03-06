SELECT 
	l.id AS label_id
	l.name AS label_name,
	t.name AS team_name,
	t.key AS team_key,
FROM linear.label AS l
INNER JOIN linear.team AS t
	ON l.team_id = t.id
	AND t._fivetran_deleted IS FALSE
INNER JOIN linear.issue_label AS map
	ON l.id = map.label_id
	AND map._fivetran_deleted IS FALSE
INNER JOIN linear.issue AS i
	ON map.issue_id = i.id
	AND i._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND l._fivetran_deleted IS FALSE
GROUP BY 1,2,3,4
ORDER BY 2