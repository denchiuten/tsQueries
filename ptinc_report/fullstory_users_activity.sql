SELECT DISTINCT
	e.event_time::DATE,
    u.organization_id,
	o.name,
	COUNT(DISTINCT u.user_id) AS user_count,
	COUNT(DISTINCT e.session_id) AS session_count
FROM fullstory_o_1jfe7s_na1.events AS e	
INNER JOIN fullstory_o_1jfe7s_na1.users AS u
	ON e.device_id = u.device_id
INNER JOIN auth0.organization AS o
	ON u.organization_id = o.id
GROUP BY 1,2,3
ORDER BY 1,2