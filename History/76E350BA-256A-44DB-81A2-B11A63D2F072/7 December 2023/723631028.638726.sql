SELECT
	NULL AS project_id,
	NULL AS project,
	NULL AS company,
	role.name AS team,
	emp.first_name,
	emp.surname AS last_name,
	d.date AS spent_date,
	ooo.policy_type_display_name AS status,
	NULL AS budget,
	FALSE AS billable,
	NULL AS task_name,
	NULL AS tier,
	0 AS hours,
	MAX(MAX(u._fivetran_synced)) OVER()::DATE AS data_up_to
FROM  harvest.users AS u
INNER JOIN harvest.role_user AS role_user
	ON u.id = role_user.role_user_id
INNER JOIN harvest.role AS role
	ON role_user.role_id = role.id
	AND role.id != 981289 -- exclude BizOps team
INNER JOIN bob.employee AS emp
	ON u.email = emp.email
INNER JOIN bob.employee_out_of_office AS ooo
	ON emp.id = ooo.employee_id
INNER JOIN plumbing.dates AS d
	ON d.date BETWEEN ooo.start_date AND ooo.end_date
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13