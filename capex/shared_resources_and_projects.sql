SELECT DISTINCT 
	e.full_name,
	e.department,
	e.title,
	proj.name
FROM google_sheets.capex_mapping AS cm
INNER JOIN bob.employee AS e
	ON TRIM(LOWER(cm.role)) = TRIM(LOWER(e.title))
	AND cm.department = e.department

CROSS JOIN (SELECT DISTINCT
	p.name	
FROM linear.roadmap_to_project AS rp
INNER JOIN linear.project AS p
	ON rp.project_id = p.id
	AND p._fivetran_deleted IS FALSE
WHERE rp.roadmap_id = 'bcaa52ba-7dc0-4004-9a1f-c493dac497b3'
	AND rp._fivetran_deleted IS FALSE) AS proj

ORDER BY 1,4
