SELECT
	p.name AS project_name,
	p.state,
	p.completed_at::DATE AS completed_at
FROM linear.roadmap AS r
INNER JOIN linear.roadmap_to_project AS rp
	ON r.id = rp.roadmap_id
	AND rp._fivetran_deleted IS FALSE
INNER JOIN linear.project AS p
	ON rp.project_id = p.id
	AND p._fivetran_deleted IS FALSE
	
WHERE
	1 = 1
	AND r._fivetran_deleted IS FALSE
	AND r.name = '2024 Features Roadmap'