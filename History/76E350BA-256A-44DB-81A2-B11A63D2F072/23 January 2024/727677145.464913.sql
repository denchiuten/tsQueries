SELECT	
	ws.id AS state_id,
FROM linear.workflow_state AS ws
INNER JOIN linear.team AS t
	ON ws.team_id = t.id
	AND t._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND ws._fivetran_deleted IS FALSE 
	AND ws.name = 'Done'