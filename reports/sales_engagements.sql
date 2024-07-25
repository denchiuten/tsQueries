SELECT
	o.last_name,
	o.first_name,
	DATE_TRUNC('month', e.property_hs_createdate)::DATE AS date,
	e.type,
	COUNT(e.engagement_id) AS n_engagements
FROM hubs.all_engagements AS e
INNER JOIN hubs.engagement_deal AS ed
	ON e.engagement_id = ed.engagement_id
INNER JOIN hubs.owner AS o
	ON e.property_hubspot_owner_id = o.owner_id
	AND o.is_active IS TRUE
INNER JOIN bob.vw_employee_team AS et
	ON o.email = et.email
	AND et.team_name = 'Sales'
GROUP BY 1,2,3,4