SELECT
	p.name AS project,
	com.property_name AS company,
	u.first_name,
	u.last_name,
	t.spent_date,
	SUM(rounded_hours) AS hours
	
FROM harvest.time_entry AS t
INNER JOIN harvest.users AS u
	ON t.user_id = u.id
INNER JOIN harvest.project AS p
	ON t.project_id = p.id
INNER JOIN hubs.company AS com
	ON t.client_id = com.property_harvest_client_id
GROUP BY 1,2,3,4,5