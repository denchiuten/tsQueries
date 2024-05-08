SELECT DISTINCT 
	-- member's details -- 
	e.full_name,
	e.email,
	e.department,
	cm.team,
	e.title,
	cm.development_share, 
	
	-- project details -- 
	proj.id,
	proj.name,
	INITCAP(proj.state) AS project_status,
	DATE_TRUNC('month', proj.started_at)::DATE AS project_start_date,
	LAST_DAY(proj.target_date) AS project_target_date,
	LAST_DAY(proj.completed_at) AS project_completed_date
	
FROM google_sheets.capex_mapping AS cm
INNER JOIN bob.employee AS e
	ON TRIM(LOWER(cm.role)) = TRIM(LOWER(e.title))
	AND cm.department = e.department

CROSS JOIN (SELECT DISTINCT
	p.id,
	p.name,
	p.state,
	p.started_at,
	p.target_date,
	DATE_TRUNC('month', i.completed_at)::DATE AS completed_at
FROM linear.roadmap_to_project AS rp
INNER JOIN linear.project AS p
	ON rp.project_id = p.id
	AND p._fivetran_deleted IS FALSE
INNER JOIN linear.issue AS i
	ON rp.project_id = i.project_id
	AND i._fivetran_deleted IS FALSE
INNER JOIN linear.workflow_state AS ws
	ON i.state_id = ws.id
	AND ws._fivetran_deleted IS FALSE
	AND ws.name = 'Done'
WHERE rp.roadmap_id = 'bcaa52ba-7dc0-4004-9a1f-c493dac497b3'
	AND rp._fivetran_deleted IS FALSE
) AS proj
