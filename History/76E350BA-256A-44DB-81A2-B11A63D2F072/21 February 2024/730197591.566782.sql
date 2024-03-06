SELECT DISTINCT
	ws.name,
	i.state_id
	
FROM linear.issue AS i
INNER JOIN linear.workflow_state AS ws
	ON i.state_id = ws.id
	AND ws._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND i._fivetran_deleted IS FALSE
	AND i.completed_at IS NOT NULL