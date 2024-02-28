SELECT 
	name, 
	id
FROM linear.workflow_state AS ws
WHERE 
 1 = 1
 AND ws.team_id = '87fa2ccb-12f4-4a4c-8d7f-37db1d23e8e4'
 AND ws._fivetran_deleted IS FALSE
ORDER BY 1