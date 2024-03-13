SELECT
		iss.id,
		iss.identifier,
		iss.title,
		iss.project_id,
		iss.estimate,
		DATE_TRUNC('month', iss.completed_at)::DATE AS completed_at
	FROM linear.issue AS iss
	
	-- inner join to the workflow state table to filter only for issues where the state name = 'Done'
	INNER JOIN linear.workflow_state AS ws
		ON iss.state_id = ws.id
		AND ws._fivetran_deleted IS FALSE
		AND ws.name = 'Done'
		
	WHERE
		1 = 1
		AND iss._fivetran_deleted IS FALSE
		AND DATE_TRUNC('month', iss.completed_at)::DATE IS NULL
		
	LIMIT 1000