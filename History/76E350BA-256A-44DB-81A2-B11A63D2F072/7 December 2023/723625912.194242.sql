SELECT
	p.name AS project,
	com.property_name AS company,
	emp.first_name,
-- 	emp.last_name,
	u.last_name,
	t.spent_date,
	COALESCE(ooo.type, 'Active') AS status,
	SUM(rounded_hours) AS hours
FROM harvest.time_entry AS t
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
GROUP BY 1,2,3,4,5,6