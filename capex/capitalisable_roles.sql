SELECT DISTINCT 
	u.email,
	e.work_department AS department,
	map.team,
	e.work_title AS title,
	e.full_name,
	cpm.completed_at,
	COUNT(DISTINCT cpm.roadmap_id) as n_roadmaps
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
LEFT JOIN (
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
) AS cpm
	ON mem.project_id = cpm.project_id

WHERE 
	1 = 1
	AND map.development_share > 0
GROUP BY 1,2,3,4,5,6