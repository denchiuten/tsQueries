SELECT
	contact.property_email AS email	
FROM auth0.users AS u
INNER JOIN hubs.contact AS contact 
	ON u.email = '''' || contact.property_email
WHERE
	1 = 1
	AND u.email NOT LIKE '%@terrascope.com'