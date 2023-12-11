SELECT
-- 	p.id AS project_id,
	t.is_closed,
-- 	p.name AS project,
-- 	com.property_name AS company,
-- 	role.name AS team,
-- 	emp.first_name,
-- 	emp.surname AS last_name,
-- 	t.spent_date,
-- 	COALESCE(ooo.policy_type_display_name, 'Active') AS status,
-- 	p.budget,
-- 	t.billable,
-- 	task.name AS task_name,
-- 	deal.property_product_tier AS tier,
	SUM(rounded_hours) AS hours
-- 	MAX(MAX(u._fivetran_synced)) OVER()::TIMESTAMP AS data_up_to 
FROM harvest.time_entry AS t
INNER JOIN harvest.task AS task
	ON t.task_id = task.id
-- INNER JOIN harvest.users AS u
-- 	ON t.user_id = u.id
-- INNER JOIN harvest.role_user AS role_user
-- 	ON u.id = role_user.role_user_id
-- INNER JOIN harvest.role AS role
-- 	ON role_user.role_id = role.id
-- 	AND role.id != 981289 -- exclude BizOps team
INNER JOIN harvest.project AS p
	ON t.project_id = p.id
-- INNER JOIN hubs.company AS com
-- 	ON t.client_id = com.property_harvest_client_id
-- LEFT JOIN bob.employee AS emp
-- 	ON u.email = emp.email
-- LEFT JOIN bob.employee_out_of_office AS ooo
-- 	ON emp.id = ooo.employee_id
-- 	AND t.spent_date BETWEEN ooo.start_date AND ooo.end_date
-- LEFT JOIN hubs.deal AS deal
-- 	ON p.code = deal.deal_id
GROUP BY 1
-- ORDER BY 2