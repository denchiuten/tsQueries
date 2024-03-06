SELECT DISTINCT
		rp.project_id,
		DATE_TRUNC('month', i.completed_at)::DATE AS completed_at
	FROM linear.roadmap_to_project AS rp
	INNER JOIN linear.issue AS i
		ON rp.project_id = i.project_id
		AND i._fivetran_deleted IS FALSE
	INNER JOIN linear.workflow_state AS ws
		ON i.state_id = ws.id
		AND ws._fivetran_deleted IS FALSE
		AND ws.name = 'Done'
	WHERE
		1 = 1
		-- roadmap ID for 2024 Features Roadmap
		AND rp.roadmap_id = 'bcaa52ba-7dc0-4004-9a1f-c493dac497b3'
		AND rp._fivetran_deleted IS FALSE