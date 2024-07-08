SELECT
	com.property_name AS company,
	p.name AS project_name,
	deal.property_dealtype AS deal_type,
	deal.property_acv_usd AS acv,
	deal.property_commencement_date AS start_date,
	deal.property_end_date AS end_date,
	p.code AS hs_deal_id,
	map.linear_milestone_name AS milestone,
	t.name AS task_name,
	hu.email,
	et.team_name,
	SUM(te.rounded_hours) AS rounded_hours
FROM harvest.vw_time_entry_latest AS te
INNER JOIN harvest.project AS p
	ON te.project_id = p.id
INNER JOIN plumbing.harvest_task_to_linear_milestone AS map
	ON te.task_id = map.harvest_task_id
INNER JOIN harvest.vw_tasks_latest AS t
	ON te.task_id = t.id
INNER JOIN harvest.vw_users_latest AS hu
	ON te.user_id = hu.id
LEFT JOIN bob.vw_employee_team AS et
	ON LOWER(hu.email) = LOWER(et.email)
LEFT JOIN hubs.deal_company AS dc
	ON p.code = dc.deal_id
	AND dc.type_id = 5 -- only primary company 
LEFT JOIN hubs.company AS com
	ON dc.company_id = com.id
LEFT JOIN hubs.deal AS deal
	ON p.code = deal.deal_id
WHERE
	1 = 1
	AND te._fivetran_deleted IS FALSE
GROUP BY 1,2,3,4,5,6,7,8,9,10,11