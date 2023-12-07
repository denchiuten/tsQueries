SELECT
	p.id AS project_id,
	p.name AS project,
	com.property_name AS company,
	role.name AS team,
	emp.first_name,
	emp.surname AS last_name,
	t.spent_date,
	COALESCE(ooo.policy_type_display_name, 'Active') AS status,
	p.budget,
	t.billable,
	task.name AS task_name,
	deal.property_product_tier AS tier,
	SUM(rounded_hours) AS hours,
	MAX(MAX(u._fivetran_synced)) OVER()::TIMESTAMP AS data_up_to 
FROM harvest.vw_time_entry_latest AS t
INNER JOIN harvest.task AS task
	ON t.task_id = task.id
INNER JOIN harvest.vw_userslatest AS u
	ON t.user_id = u.id
INNER JOIN harvest.role_user AS role_user
	ON u.id = role_user.role_user_id
INNER JOIN harvest.role AS role
	ON role_user.role_id = role.id
	AND role.id != 981289 -- exclude BizOps team
INNER JOIN harvest.project AS p
	ON t.project_id = p.id
INNER JOIN hubs.company AS com
	ON t.client_id = com.property_harvest_client_id
LEFT JOIN bob.employee AS emp
	ON u.email = emp.email
LEFT JOIN bob.employee_out_of_office AS ooo
	ON emp.id = ooo.employee_id
	AND t.spent_date BETWEEN ooo.start_date AND ooo.end_date
LEFT JOIN hubs.deal AS deal
	ON p.code = deal.deal_id
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12

UNION ALL

-- dummy NULL rows when employees are on leave
SELECT
	NULL::INT AS project_id,
	NULL AS project,
	NULL AS company,
	role.name AS team,
	emp.first_name,
	emp.surname AS last_name,
	d.date AS spent_date,
	ooo.policy_type_display_name AS status,
	0 AS budget,
	FALSE AS billable,
	NULL AS task_name,
	NULL AS tier,
	0 AS hours,
	MAX(MAX(u._fivetran_synced)) OVER()::TIMESTAMP AS data_up_to
FROM  harvest.vw_users_latest AS u
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