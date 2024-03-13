SELECT
	t.name AS team,
	c.id AS cycle_id,
	c.starts_at AS cycle_start,
	c.ends_at AS cycle_end,
	COALESCE(u.name, 'Unassigned') AS assignee,
	s.name AS status,
	i.estimate
FROM linear.issue AS i
INNER JOIN linear.cycle AS c	
	ON i.cycle_id = c.id
	AND c._fivetran_deleted IS FALSE
	AND c.completed_at IS NULL
INNER JOIN linear.team AS t
	ON c.team_id = t.id
INNER JOIN linear.workflow_state AS s
	ON i.state_id = s.id
LEFT JOIN linear.users AS u
	ON i.assignee_id = u.id
WHERE
	1 = 1
	AND i._fivetran_deleted IS FALSE