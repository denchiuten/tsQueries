SELECT DISTINCT
	LOWER(au.email) AS email
FROM auth0.users	 AS au
LEFT JOIN hubs.contact_to_emails AS hc
	ON LOWER(REPLACE(au.email, '''', '')) = LOWER(hc.email)
WHERE
	1 = 1
	AND au._fivetran_deleted IS FALSE
	AND au.email NOT LIKE '%@terrascope.com'
	AND au.email NOT LIKE '%@gmail.com'
	AND au.email NOT LIKE '%@mobileprogramming.com'
	AND au.email NOT LIKE '%@mailinator.com'
	AND au.email NOT LIKE '%@thoughtworks.com'
	AND hc.id IS NULL