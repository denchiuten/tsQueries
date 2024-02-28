SELECT
	p.id AS project_id,
	p.name AS project_name,
	p.state,
	p.created_at::DATE AS created_at,
	u.display_name AS creator_name,
	u.email AS creator_email,
	u.id AS creator_id,
	SUM(CASE WHEN i.id IS NOT NULL THEN 1 ELSE 0 END) AS n_issues
FROM linear.project AS p
LEFT JOIN linear.users AS u
	ON p.creator_id = u.id
LEFT JOIN linear.issue AS i
	ON p.id = i.project_id
	AND i._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND p._fivetran_deleted IS FALSE
	AND p.state NOT IN ('canceled', 'completed')
GROUP BY 1,2,3,4,5,6,7