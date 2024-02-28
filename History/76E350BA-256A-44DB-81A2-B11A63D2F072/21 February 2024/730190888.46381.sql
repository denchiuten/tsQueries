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