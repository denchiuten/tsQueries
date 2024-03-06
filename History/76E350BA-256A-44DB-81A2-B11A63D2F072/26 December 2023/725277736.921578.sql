SELECT
	t.name,
	c.id AS cycle_id,
	c.starts_at::DATE AS starts_at,
	c.ends_at::DATE AS ends_at
FROM linear.cycle AS c
INNER JOIN linear.team AS t
	ON c.team_id = t.id