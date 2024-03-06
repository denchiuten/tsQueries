SELECT DISTINCT
		r.id AS roadmap_id,
		p.id AS project_id,
		mem.member_id
	FROM google_sheets.capex_roadmaps AS gs
	INNER JOIN linear.roadmap_to_project AS rp
		ON gs.linear_roadmap_id = rp.roadmap_id
		AND rp._fivetran_deleted IS FALSE
	INNER JOIN linear.project AS p
		ON rp.project_id = p.id
		AND p._fivetran_deleted IS FALSE
	INNER JOIN linear.roadmap AS r
		ON rp.roadmap_id = r.id
	INNER JOIN linear.project_member AS mem
		ON p.id = mem.project_id
		AND mem._fivetran_deleted IS FALSE