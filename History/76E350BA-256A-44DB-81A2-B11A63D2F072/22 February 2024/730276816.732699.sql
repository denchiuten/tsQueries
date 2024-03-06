SELECT
	p._fivetran_synced AS data_up_to,
	r.name AS roadmap_name,
	p.id AS project_id,
	p.name AS project_name,
	p.started_at::DATE AS project_start_date,
	p.target_date::DATE AS project_target_date,
	p.completed_at::DATE AS project_completed_date,
	p.state AS project_status,
	pm.member_id,
	u.name AS member_name,
	b.work_title AS member_role,	
	b.work_department AS member_department,
	cpm.team AS member_team,
	cpm.development_share AS member_development_share,
	i.completed_at AS issue_completed_at_month,
	SUM(COALESCE(i.estimate, 1)) AS story_points_completed,
	DENSE_RANK() OVER (PARTITION BY p.id ORDER BY pm.member_id ASC) + DENSE_RANK() OVER (PARTITION BY p.id ORDER BY pm.member_id DESC) - 1 AS n_project_members,
	DENSE_RANK() OVER (PARTITION BY p.id ORDER BY pm.member_id ASC) AS ascending,
	DENSE_RANK() OVER (PARTITION BY p.id ORDER BY pm.member_id DESC) AS descending
-- start from table of roadmaps for capitalisable projects from https://docs.google.com/spreadsheets/d/1gn5WFe1PfniN2UbDv9LytvbxX9n60XlbVEs31Og37v8/edit#gid=0
FROM google_sheets.capex_roadmaps AS gs

-- join to mapping table that connects roadmaps to projects
INNER JOIN linear.roadmap_to_project AS rp
	ON gs.linear_roadmap_id = rp.roadmap_id
	AND rp._fivetran_deleted IS FALSE

-- join to roadmaps table to pull specific details for each roadmap
INNER JOIN linear.roadmap AS r
	ON gs.linear_roadmap_id = r.id
	AND r._fivetran_deleted IS FALSE

-- do the same thing with the project table
INNER JOIN linear.project AS p
	ON rp.project_id = p.id
	AND p._fivetran_deleted IS FALSE

-- subquery to pull only issues that are Done in Linear
-- make it a left join in case finance needs to see all relevant projects even if they don't have any completed issues
LEFT JOIN (
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
) AS i
	ON p.id = i.project_id

-- join to project_member mapping table to identify the members of each project
INNER JOIN linear.project_member AS pm
	ON p.id = pm.project_id
	AND pm._fivetran_deleted IS FALSE

-- now the users table to pull the details of each member
INNER JOIN linear.users AS u
	ON pm.member_id = u.id

-- join to HiBob to pull each employee's job title
INNER JOIN bob.employee AS b
	-- wrap the emails in LOWER to avoid case mismatches
	ON LOWER(u.email) = LOWER(b.email)
	AND b._fivetran_deleted IS FALSE

-- join to table that maps capitalisable job titles to the share of time that can be capitalised
-- source sheet: https://docs.google.com/spreadsheets/d/19MtGI9rrpaIj5KLv2CA5Fb-1cNNMRB7Qgf3I3wzRYLQ/edit#gid=991396617
INNER JOIN google_sheets.capex_mapping AS cpm
	ON b.work_title = cpm.role
	AND cpm.development_share > 0
WHERE
	1 = 1
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
ORDER BY  p.id, pm.member_id