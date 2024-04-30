SELECT 
	o.name AS org_name,
	o.id AS organization_id,
	LOWER(u.email) AS email
FROM auth0.users AS u
INNER JOIN hubs.contact_to_emails AS h
	ON LOWER(u.email) = LOWER(h.email)
INNER JOIN auth0.organization_member AS om
	ON u.id = om.id
	AND om._fivetran_deleted IS FALSE
INNER JOIN auth0.organization AS o
	ON om.organization_id = o.id
	AND o._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND u._fivetran_deleted IS FALSE
ORDER BY 1,3