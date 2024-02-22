SELECT
	p._fivetran_synced AS data_up_to,
	r.name AS roadmap_name,
	p.id AS project_id,
	p.name AS project_name,
	p.started_at:: DATE AS project_start_date,
	p.target_date::DATE AS project_target_date,
	p.completed_at::DATE AS project_completed_date,
	p.state AS project_status,
	pm.member_id,
	u.name AS member_name,
	b.work_title AS member_role,	
	b.work_department AS member_department,
	cpm.team AS member_team,
	cpm.development_share AS member_development_share,
	i.id AS issue_id,
	i.identifier AS issue_key,
	i.title AS issue_title,
	i.completed_at::DATE AS issue_completed_at,
	COALESCE(i.estimate, 1) AS story_points_completed,
	DENSE_RANK() OVER (PARTITION BY p.id ORDER BY pm.member_id) + DENSE_RANK() OVER (PARTITION BY p.id ORDER BY pm.member_id DESC) - 1 AS n_project_members
FROM google_sheets.capex_roadmaps AS gs
INNER JOIN linear.roadmap_to_project AS rp
	ON gs.linear_roadmap_id = rp.roadmap_id
	AND rp._fivetran_deleted IS FALSE
INNER JOIN linear.roadmap AS r
	ON gs.linear_roadmap_id = r.id
	AND r._fivetran_deleted IS FALSE
INNER JOIN linear.project AS p
	ON rp.project_id = p.id
	AND p._fivetran_deleted IS FALSE
LEFT JOIN (
	SELECT
		iss.id,
		iss.identifier,
		iss.title,
		iss.project_id,
		iss.estimate,
		iss.completed_at
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
INNER JOIN bob.employee AS b
	ON LOWER(u.email) = LOWER(b.email)
	AND b._fivetran_deleted IS FALSE
INNER JOIN google_sheets.capex_mapping AS cpm
	ON b.work_title = cpm.role
	AND cpm.development_share > 0
WHERE
	1 = 1
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
