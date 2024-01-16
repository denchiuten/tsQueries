SELECT
	t.name AS team,
	c.id AS cycle_id,
	c.starts_at::DATE AS cycle_start,
	c.ends_at::DATE AS cycle_end,
	COALESCE(u.name, 'Unassigned') AS assignee,
	s.name AS issue_status,
	i.identifier AS issue_key,
	t.key AS team_key,
	i.title AS issue_title,
	COALESCE(i.estimate, 0) AS issue_estimate,
	c.ends_at::DATE - c.starts_at::DATE AS days_in_cycle,
	COUNT(DISTINCT ds.date) AS n_days_ooo,
	MAX(MAX(i._fivetran_synced)) OVER()::TIMESTAMP AS data_up_to
FROM linear.issue AS i
INNER JOIN linear.cycle AS c	
	ON i.cycle_id = c.id
	AND c._fivetran_deleted IS FALSE
	AND c.completed_at IS NULL
INNER JOIN linear.team AS t
	ON c.team_id = t.id
	AND t.key = 'CCF'
INNER JOIN linear.workflow_state AS s
	ON i.state_id = s.id
	AND s.name <> 'Duplicate'
LEFT JOIN linear.users AS u
	ON i.assignee_id = u.id
LEFT JOIN bob.vw_ooo_dates AS ds
	ON LOWER(u.email) = LOWER(ds.email)
	AND ds.date BETWEEN c.starts_at AND c.ends_at
WHERE
	1 = 1
	AND i._fivetran_deleted IS FALSE
GROUP BY 1,2,3,4,5,6,7,8,9,10,11