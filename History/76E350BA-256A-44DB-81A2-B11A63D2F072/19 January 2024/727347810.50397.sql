SELECT
	p.id AS linear_project_id,
	p.name AS linear_project_name
FROM linear.project AS p
WHERE
	1 = 1
	AND p._fivetran_deleted IS FALSE