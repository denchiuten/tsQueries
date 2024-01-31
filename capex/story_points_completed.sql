SELECT
	p.name AS project_name,
	lead.name AS project_lead,
	p.started_at:: DATE AS project_start_date,
	p.target_date::DATE AS project_target_date,
	p.completed_at::DATE AS project_completed_date,
	t.name AS team_name,
	t.key AS team_key,
	u.email AS assignee_email,
	u.name AS assignee_name,
	b.work_title AS role,
	cpm.team,
	b.work_department AS department,
	i.completed_at::DATE AS completed_at,
	i.id AS issue_id,
	i.identifier AS issue_key,
	i.title AS issue_title,
	COALESCE(i.estimate, 1) AS estimate,
	cpm.development_share,
	MAX(MAX(i._fivetran_synced)) OVER()::TIMESTAMP AS data_up_to
FROM linear.roadmap AS r
INNER JOIN linear.roadmap_to_project AS rp
	ON r.id = rp.roadmap_id
	AND rp._fivetran_deleted IS FALSE
INNER JOIN linear.project AS p
	ON rp.project_id = p.id
	AND p._fivetran_deleted IS FALSE
INNER JOIN linear.issue AS i
	ON p.id = i.project_id
	AND i.completed_at IS NOT NULL
INNER JOIN linear.team AS t
	ON i.team_id = t.id
INNER JOIN linear.users AS u
	ON i.assignee_id = u.id
INNER JOIN linear.users AS lead
	ON p.lead_id = lead.id
INNER JOIN bob.employee AS b
	ON LOWER(u.email) = LOWER(b.email)
INNER JOIN google_sheets.capex_mapping AS cpm
	ON b.work_title = cpm.role
WHERE
	1 = 1
	AND r._fivetran_deleted IS FALSE
	AND r.name = '2024 Features Roadmap'
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18