SELECT
	p.name AS project_name,
	t.name AS team_name,
	t.key AS team_key,
	u.email AS assignee_email,
	u.name AS assignee_name,
	DATE_TRUNC('month', i.completed_at)::DATE AS month_completed,
	SUM(COALESCE(i.estimate, 0)) AS points_completed
FROM linear.roadmap AS r
INNER JOIN linear.roadmap_to_project AS rp
	ON r.id = rp.roadmap_id
	AND rp._fivetran_deleted IS FALSE
INNER JOIN linear.project AS p
	ON rp.project_id = p.id
	AND p._fivetran_deleted IS FALSE
INNER JOIN linear.issue AS i
	ON p.id = i.project_id
	AND i.completed_at IS NOT NULL
INNER JOIN linear.team AS t
	ON i.team_id = t.id
INNER JOIN linear.users AS u
	ON i.assignee_id = u.id
WHERE
	1 = 1
	AND r._fivetran_deleted IS FALSE
	AND r.name = '2024 Features Roadmap'
GROUP BY 1,2,3,4,5,6