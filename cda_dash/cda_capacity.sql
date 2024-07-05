WITH assignments AS (
	SELECT
		p.name AS project,
		u.email,
		COALESCE(i.due_date, mi.target_date) AS due_date,
		SUM(COALESCE(i.estimate, 1)) AS points
	FROM linear.issue AS i
	INNER JOIN linear.workflow_state AS ws
		ON i.state_id = ws.id
		AND ws.type NOT IN ('completed', 'canceled')
	INNER JOIN linear.roadmap_to_project AS rp
		ON i.project_id = rp.project_id
		AND rp.roadmap_id = '1e8b8685-6651-4046-a784-2748b351581f' -- Implementations initiative / roadmap
		AND rp._fivetran_deleted IS FALSE
	INNER JOIN linear.project AS p
		ON i.project_id = p.id
	INNER JOIN linear.users AS u
		ON i.assignee_id = u.id
	LEFT JOIN linear.project_milestone AS mi
		ON i.project_milestone_id = mi.id
		AND mi._fivetran_deleted IS FALSE
	WHERE
		1 = 1
		AND i._fivetran_deleted IS FALSE
		AND COALESCE(i.due_date, mi.target_date) BETWEEN DATE_TRUNC('month', CURRENT_DATE) AND DATEADD(YEAR, 1, CURRENT_DATE)
	GROUP BY 1,2,3
)

SELECT
	e.email,
	e.display_name,
	ass.project,
	d.date,
	d.week_ending_date,
	ooo.employee_id IS NOT NULL AS ooo_boolean,
	ass.points
FROM bob.employee AS e
INNER JOIN bob.vw_employee_team AS et
	ON e.id = et.employee_id
	AND et.team_name = 'Implementation'
LEFT JOIN plumbing.dates AS d
	ON d.date BETWEEN DATE_TRUNC('month', CURRENT_DATE) AND DATEADD(YEAR, 1, CURRENT_DATE)
LEFT JOIN bob.employee_out_of_office AS ooo
	ON e.id = ooo.employee_id
	AND d.date BETWEEN ooo.start_date AND ooo.end_date
	AND ooo._fivetran_deleted IS FALSE
	AND ooo.start_portion = 'all_day'
LEFT JOIN assignments AS ass
	ON e.email = ass.email
	AND d.date = ass.due_date
WHERE
	1 = 1
	AND e._fivetran_deleted IS FALSE
	AND e.status = 'Active'
ORDER BY 1,3,4