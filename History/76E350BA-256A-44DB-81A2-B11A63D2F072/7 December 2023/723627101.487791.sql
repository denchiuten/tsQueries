SELECT
	NULL AS project,
	NULL AS company,
	emp.first_name,
	emp.surname AS last_name,
	d.date AS spent_date,
	ooo.type AS status,
	NULL AS budget,
	FALSE AS billable,
	NULL AS task_name,
	0 AS hours
FROM  harvest.users AS u
INNER JOIN bob.employee AS emp
	AS u.email = emp.email
INNER JOIN bob.employee_out_of_office AS ooo
	ON emp.id = ooo.employee_id
INNER JOIN plumbing.dates AS d
	ON d.date BETWEEN ooo.start_date AND ooo.end_date