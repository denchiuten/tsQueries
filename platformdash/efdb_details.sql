SELECT
	ef.org_id AS org_id,
	con.org_name AS org_name,
	con.app_environment,
	COALESCE(c.property_name, '') AS company_name,
	ef.efdb_name,
	ef.efdb_locales,
	ef.efdb_versions
FROM google_sheets.customer_config_efdb AS ef
INNER JOIN google_sheets.customer_config AS con
	ON ef.org_id = con.org_id
LEFT JOIN plumbing.auth0_to_hubspot_company AS map
	ON ef.org_id = map.auth0_id
LEFT JOIN hubs.company AS c
	ON map.company_id = c.id