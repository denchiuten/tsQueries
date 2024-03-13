SELECT DISTINCT
		gs.linear_roadmap_id AS roadmap_id,
		rp.project_id,
		r.name AS roadmap_name
	FROM google_sheets.capex_roadmaps AS gs
	INNER JOIN linear.roadmap_to_project AS rp
		ON gs.linear_roadmap_id = rp.roadmap_id
		AND rp._fivetran_deleted IS FALSE
	INNER JOIN linear.roadmap AS r
		ON gs.linear_roadmap_id = r.id
		AND r._fivetran_deleted IS FALSE