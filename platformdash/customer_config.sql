SELECT
	COALESCE(c.property_name, '') AS company_name,
	con.*
FROM google_sheets.customer_config AS con
LEFT JOIN plumbing.auth0_to_hubspot_company AS map
	ON con.org_id = map.auth0_id
LEFT JOIN hubs.company AS c
	ON map.company_id = c.id