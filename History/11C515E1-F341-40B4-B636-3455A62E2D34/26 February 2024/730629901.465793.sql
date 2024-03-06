SELECT DISTINCT 
	u.email,
	e.work_department AS department,
	map.team,
	e.work_title AS title,
	e.full_name,
	DATE_TRUNC('month', d.date) AS completed_at,
	0 as n_roadmaps
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
LEFT JOIN plumbing.dates AS d
	ON d.date BETWEEN CURRENT_DATE - 365 AND CURRENT_DATE + 35