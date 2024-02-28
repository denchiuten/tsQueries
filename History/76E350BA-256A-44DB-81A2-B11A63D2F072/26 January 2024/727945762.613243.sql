SELECT
	p.id AS project_id,
	p.name AS project_name,
	p.state,
	p.created_at::DATE AS created_at,
	COUNT(i.*) AS n_issues
FROM linear.project AS p
LEFT JOIN linear.issue AS i
	ON p.id = i.project_id
	AND i._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND p._fivetran_deleted IS FALSE
GROUP BY 1,2,3,4