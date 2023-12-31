SELECT
	p.name AS project,
	com.property_name AS company,
	emp.first_name,
	emp.surname AS last_name,
	t.spent_date,
	COALESCE(ooo.policy_type_display_name, 'Active') AS status,
	p.budget,
	t.billable,
	task.name AS task_name,
	SUM(rounded_hours) AS hours
FROM harvest.time_entry AS t
INNER JOIN harvest.task AS task
	ON t.task_id = task.id
INNER JOIN harvest.users AS u
	ON t.user_id = u.id
INNER JOIN harvest.project AS p
	ON t.project_id = p.id
INNER JOIN hubs.company AS com
	ON t.client_id = com.property_harvest_client_id
LEFT JOIN bob.employee AS emp
	ON u.email = emp.email
LEFT JOIN bob.employee_out_of_office AS ooo
	ON emp.id = ooo.employee_id
	AND t.spent_date BETWEEN ooo.start_date AND ooo.end_date
GROUP BY 1,2,3,4,5,6,7,8,9

UNION ALL

SELECT
	NULL AS project,
	NULL AS company,
	emp.first_name,
	emp.surname AS last_name,
	d.date AS spent_date,
	ooo.policy_type_display_name AS status,
	NULL AS budget,
	FALSE AS billable,
	NULL AS task_name,
	0 AS hours
FROM  harvest.users AS u
INNER JOIN bob.employee AS emp
	ON u.email = emp.email
INNER JOIN bob.employee_out_of_office AS ooo
	ON emp.id = ooo.employee_id
INNER JOIN plumbing.dates AS d
	ON d.date BETWEEN ooo.start_date AND ooo.end_date