SELECT
	LAST_DAY(t.spent_date) AS spent_date,
	com.property_name AS company,
	p.name AS project,
	role.name AS team,
	emp.title,
	task.name AS task_name,
	deal.property_product_tier AS tier,
	SUM(t.rounded_hours) AS hours
FROM harvest.vw_time_entry_latest AS t
INNER JOIN harvest.task AS task
	ON t.task_id = task.id
INNER JOIN harvest.vw_users_latest AS u
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
	AND com.id <> 9244595755 -- exclude Terrascope
LEFT JOIN bob.employee AS emp
	ON u.email = emp.email
LEFT JOIN hubs.deal AS deal
	ON p.code = deal.deal_id

GROUP BY 1,2,3,4,5,6,7

