SELECT 
	id,
	email,
	given_name,
	family_name
FROM auth0.users
WHERE
	1 = 1
	AND email NOT LIKE '%@terrascope.com'
	AND email NOT LIKE '%@gmail.com';