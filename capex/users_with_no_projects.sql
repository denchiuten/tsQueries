SELECT DISTINCT 
	u.email
FROM google_sheets.capex_mapping AS map
INNER JOIN bob.employee AS e
	ON map.role = e.work_title
	AND e.internal_status = 'Active'
INNER JOIN linear.users AS u
	ON LOWER(e.email) = LOWER(u.email)
LEFT JOIN (
	SELECT
		p.id AS project_id,
		mem.member_id
	FROM linear.roadmap_to_project AS rp
	INNER JOIN linear.project AS p
		ON rp.project_id = p.id
		AND p._fivetran_deleted IS FALSE
	INNER JOIN linear.roadmap AS r
		ON rp.roadmap_id = r.id
		AND r.name = '2024 Features Roadmap'
	INNER JOIN linear.project_member AS mem
		ON p.id = mem.project_id
		AND mem._fivetran_deleted IS FALSE
	WHERE
		1 = 1
		AND rp._fivetran_deleted IS FALSE
) AS cpm
	ON u.id = cpm.member_id
WHERE cpm.member_id IS NULL