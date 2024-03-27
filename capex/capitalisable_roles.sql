SELECT DISTINCT 
	u.email,
	e.work_department AS department,
	map.team,
	e.work_title AS title,
	e.full_name,
	cpm.completed_at,
	p.id AS project_id,
	p.name AS project_name,
	map.development_share,
	DATE_TRUNC('month', p.started_at)::DATE AS project_start_date,
	LAST_DAY(p.target_date) AS project_target_date,
	LAST_DAY(p.completed_at::DATE) AS project_completed_date
FROM google_sheets.capex_mapping AS map
INNER JOIN bob.employee AS e
	-- add TRIM and LOWER to correct for trailing white space and improper capitalisation
	ON TRIM(LOWER(map.role)) = TRIM(LOWER(e.work_title))
	
	-- also include department in the JOIN since some job titles may exist in multiple departments
	AND map.department = e.work_department
INNER JOIN linear.users AS u
	ON LOWER(e.email) = LOWER(u.email)
LEFT JOIN linear.project_member AS mem
	ON u.id = mem.member_id
	AND mem._fivetran_deleted IS FALSE
LEFT JOIN linear.project AS p
	ON mem.project_id = p.id
	AND p._fivetran_deleted IS FALSE

INNER JOIN (
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
) AS cpm
	ON mem.project_id = cpm.project_id

WHERE 
	1 = 1
	AND map.development_share > 0

UNION ALL

-- add dummy rows for every combination of person and month
SELECT DISTINCT 
	u.email,
	e.work_department AS department,
	map.team,
	e.work_title AS title,
	e.full_name,
	DATE_TRUNC('month', d.date)::DATE AS completed_at,
	NULL AS project_id,
	NULL AS project_name,
	map.development_share,
	DATE_TRUNC('month', p.started_at)::DATE AS project_start_date,
	LAST_DAY(p.target_date) AS project_target_date,
	LAST_DAY(p.completed_at::DATE) AS project_completed_date
FROM google_sheets.capex_mapping AS map
INNER JOIN bob.employee AS e
	-- add RTRIM and LOWER to correct for trailing white space and improper capitalisation
	ON RTRIM(LOWER(map.role)) = RTRIM(LOWER(e.work_title))
	
	-- also include department in the JOIN since some job titles may exist in multiple departments
	AND map.department = e.work_department
	AND e.internal_status = 'Active'
INNER JOIN linear.users AS u
	ON LOWER(e.email) = LOWER(u.email)
LEFT JOIN linear.project_member AS mem
	ON u.id = mem.member_id
	AND mem._fivetran_deleted IS FALSE
LEFT JOIN linear.project AS p
	ON mem.project_id = p.id
	AND p._fivetran_deleted IS FALSE
LEFT JOIN plumbing.dates AS d
	
	-- between the start of the year and current date
	ON d.date BETWEEN DATE_TRUNC('year', CURRENT_DATE) AND CURRENT_DATE
	
