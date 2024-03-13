SELECT
	t.name,
	c.*
FROM linear.cycle AS c
INNER JOIN linear.team AS t
	ON c.team_id = t.team_id