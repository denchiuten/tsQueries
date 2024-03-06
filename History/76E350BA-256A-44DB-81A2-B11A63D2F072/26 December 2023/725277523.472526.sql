SELECT
	team.name,
	c.*
FROM linear.cycle AS c
INNER JOIN linear.team AS t
	ON c.team_id = team_id