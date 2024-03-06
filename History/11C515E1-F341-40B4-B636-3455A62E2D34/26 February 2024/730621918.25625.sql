SELECT DISTINCT
		gs.linear_roadmap_id AS roadmap_id,
		r.name AS roadmap_name,
		rp.project_id,
		DATE_TRUNC('month', i.completed_at)::DATE AS completed_at
	FROM google_sheets.capex_roadmaps AS gs
	INNER JOIN linear.roadmap_to_project AS rp
		ON gs.linear_roadmap_id = rp.roadmap_id
		AND rp._fivetran_deleted IS FALSE
	INNER JOIN linear.roadmap AS r
		ON gs.linear_roadmap_id = r.id
		AND r._fivetran_deleted IS FALSE
	INNER JOIN linear.issue AS i
		ON rp.project_id = i.project_id
		AND i._fivetran_deleted IS FALSE
	INNER JOIN linear.workflow_state AS ws
		ON i.state_id = ws.id
		AND ws._fivetran_deleted IS FALSE
		AND ws.name = 'Done'