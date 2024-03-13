SELECT
	p.name AS project_name,
	t.name AS team_name,
	t.key AS team_key,
	u.email AS assignee_email,
	u.name AS assignee_name,
	b.work_title AS role,
	i.completed_at::DATE AS month_completed,
	i.id AS issue_id,
	i.identifier AS issue_key,
	i.estimate
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
	AND EXTRACT(YEAR FROM i.completed_at) = EXTRACT(YEAR FROM CURRENT_DATE)
INNER JOIN linear.team AS t
	ON i.team_id = t.id
INNER JOIN linear.users AS u
	ON i.assignee_id = u.id
LEFT JOIN bob.employee AS b
	ON LOWER(u.email) = LOWER(b.email)
WHERE
	1 = 1
	AND r._fivetran_deleted IS FALSE
	AND r.name = '2024 Features Roadmap'