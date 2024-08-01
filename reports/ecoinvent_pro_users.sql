SELECT DISTINCT
	org.name,
	com.property_name AS customer,
	u.email
FROM auth0.organization AS org
INNER JOIN google_sheets.customer_config_supporteddbs AS db
	ON org.id = db.org_id
	AND db.efdb = 'ecoinvent'
	AND db.type = 'supportedDbForDriverTree'
INNER JOIN auth0.organization_member_role AS omr
	ON org.id = omr.organization_id
	AND omr._fivetran_deleted IS FALSE
INNER JOIN auth0.users AS u
	ON omr.member_id = u.id
	AND u.email NOT LIKE '%@terrascope.com'
INNER JOIN auth0.role AS r
	ON omr.id = r.id
	AND r.name IN ('role://manage-api/driver-tree-user', 'role://manage-api/manage-module-user')
INNER JOIN plumbing.auth0_to_hubspot_company AS map
	ON org.id = map.auth0_id
LEFT JOIN hubs.company AS com
	ON map.company_id = com.id
