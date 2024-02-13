SELECT
	p.name AS project_name,
	p.id AS project_id,
	p.started_at:: DATE AS started_at,
	p.completed_at::DATE AS completed_at,
	p.target_date,
	p.state
FROM linear.roadmap_to_project AS rp
INNER JOIN linear.project AS p
	ON rp.project_id = p.id
	AND p._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND rp._fivetran_deleted IS FALSE
	AND rp.roadmap_id = '09497322-ced0-413f-8f14-066f55a1d76f' -- "id for Food & Agri Features roadmap"