SELECT
	LOWER(au.email) AS email,
	hc.property_firstname,
	hc.property_lastname
FROM auth0.users	 AS au
LEFT JOIN hubs.contact AS hc
	ON LOWER(au.email) = LOWER(hc.property_email)
WHERE
	1 = 1
	AND au._fivetran_deleted IS FALSE
	AND au.email NOT LIKE '%@terrascope.com'
	AND au.email NOT LIKE '%@gmail.com'