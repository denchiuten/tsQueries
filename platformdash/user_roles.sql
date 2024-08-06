SELECT 
	o.name AS org_name,
	o.id AS organization_id,
	CASE 
		WHEN map.auth_0_id IS NULL THEN 'Internal'
		ELSE 'External'
		END AS data_plane_type,
	con.app_environment,
	LOWER(u.email) AS email,
	r.name AS role_name,
	r.description AS role_description
FROM auth0.users AS u
INNER JOIN hubs.contact_to_emails AS h
	ON LOWER(u.email) = LOWER(h.email)
INNER JOIN auth0.organization_member_role AS omr
	ON u.id = omr.member_id
	AND omr._fivetran_deleted IS FALSE
INNER JOIN auth0.role AS r
	ON omr.id = r.id
	AND r._fivetran_deleted IS FALSE
INNER JOIN auth0.organization AS o
	ON omr.organization_id = o.id
	AND o._fivetran_deleted IS FALSE
LEFT JOIN plumbing.auth_0_to_hubspot_company AS map
	ON o.id = map.auth_0_id
LEFT JOIN google_sheets.customer_config AS con
	ON omr.organization_id = con.org_id
WHERE
	1 = 1
	AND u._fivetran_deleted IS FALSE