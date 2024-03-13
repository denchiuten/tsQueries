SELECT
	LOWER(au.email) AS email,
	au.given_name AS first_name,
	au.family_name AS last_name
FROM auth0.users	 AS au
WHERE
	1 = 1
	AND au,_fivetran_deleted IS FALSE
	AND au.email NOT LIKE '%@terrascope.com'
	AND au.email NOT LIKE '%@gmail.com'