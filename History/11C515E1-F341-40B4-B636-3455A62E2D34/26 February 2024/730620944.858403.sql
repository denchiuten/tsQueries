SELECT DISTINCT
		iss.project_id,
		pm.member_id,
		DATE_TRUNC('month', iss.completed_at)::DATE AS completed_at
	FROM linear.issue AS iss
	
	-- inner join to the workflow state table to filter only for issues where the state name = 'Done'
	INNER JOIN linear.workflow_state AS ws
		ON iss.state_id = ws.id
		AND ws._fivetran_deleted IS FALSE
		AND ws.name = 'Done'
	INNER JOIN linear.project AS proj
		ON iss.project_id = proj.id
		AND proj._fivetran_deleted IS FALSE
	INNER JOIN linear.project_member AS pm
		ON proj.id = pm.project_id
		AND pm._fivetran_deleted IS FALSE
	WHERE
		iss._fivetran_deleted IS FALSE