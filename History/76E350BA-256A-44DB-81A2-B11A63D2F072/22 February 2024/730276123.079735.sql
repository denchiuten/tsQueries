SELECT
		iss.id,
		iss.identifier,
		iss.title,
		iss.project_id,
		iss.estimate,
		iss.completed_at,
		DATE_TRUNC('month', iss.completed_at) AS month_completed
	FROM linear.issue AS iss
	
	-- inner join to the workflow state table to filter only for issues where the state name = 'Done'
	INNER JOIN linear.workflow_state AS ws
		ON iss.state_id = ws.id
		AND ws._fivetran_deleted IS FALSE
		AND ws.name = 'Done'
	WHERE
		1 = 1
		AND iss._fivetran_deleted IS FALSE