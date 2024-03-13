SELECT
		iss.id AS issue_id,
		iss.identifier AS issue_key,
		iss.title AS issue_title,
		iss.project_id
	FROM linear.issue AS iss
	INNER JOIN linear.workflow_state AS ws
		ON iss.state_id = ws.id
		AND ws._fivetran_deleted IS FALSE
		AND ws.name = 'Done'
	WHERE
		1 = 1
		AND iss._fivetran_deleted IS FALSE