SELECT
	t.name AS team,
	c.id AS cycle_id,
	c.starts_at,
	c.ends_at,
	COUNT(i.*)
FROM linear.issue AS i
INNER JOIN linear.cycle AS c	
	ON i.cycle_id = c.id
	AND c._fivetran_deleted IS FALSE
	AND c.completed_at IS NULL
INNER JOIN linear.team AS t
	ON c.team_id = t.id
WHERE
	1 = 1
	AND i._fivetran_deleted IS FALSE
GROUP BY 1,2,3,4