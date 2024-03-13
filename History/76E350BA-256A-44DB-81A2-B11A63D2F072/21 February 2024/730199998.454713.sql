SELECT
	p._fivetran_synced AS data_up_to,
	p.name AS project_name,
	lead.name AS project_lead,
	p.started_at:: DATE AS project_start_date,
	p.target_date::DATE AS project_target_date,
	p.completed_at::DATE AS project_completed_date,
	p.state AS project_status,
	u.name AS member_name,
	b.work_title AS role,	
	b.work_department AS department,
	i.id AS issue_id,
	i.identifier AS issue_key,
	i.title AS issue_title,
	cpm.team,
	cpm.development_share,
	COALESCE(i.estimate, 1) AS story_points_completed	
FROM google_sheets.capex_roadmaps AS gs
INNER JOIN linear.roadmap_to_project AS rp
	ON gs.linear_roadmap_id = rp.roadmap_id
	AND rp._fivetran_deleted IS FALSE
INNER JOIN linear.project AS p
	ON rp.project_id = p.id
	AND p._fivetran_deleted IS FALSE
LEFT JOIN (
	SELECT
		iss.id,
		iss.identifier,
		iss.title,
		iss.project_id,
		iss.estimate
	FROM linear.issue AS iss
	INNER JOIN linear.workflow_state AS ws
		ON iss.state_id = ws.id
		AND ws._fivetran_deleted IS FALSE
		AND ws.name = 'Done'
	WHERE
		1 = 1
		AND iss._fivetran_deleted IS FALSE
) AS i
	ON p.id = i.project_id
INNER JOIN linear.project_member AS pm
	ON p.id = pm.project_id
	AND pm._fivetran_deleted IS FALSE
INNER JOIN linear.users AS u
	ON pm.member_id = u.id
LEFT JOIN linear.users AS lead
	ON p.lead_id = lead.id
INNER JOIN bob.employee AS b
	ON LOWER(u.email) = LOWER(b.email)
	AND b._fivetran_deleted IS FALSE
INNER JOIN google_sheets.capex_mapping AS cpm
	ON b.work_title = cpm.role
	AND cpm.development_share > 0