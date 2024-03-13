SELECT
	id AS hubspot_id,
	property_email AS email
FROM hubs.contact
WHERE
	1 = 1
	AND email NOT LIKE '%@terrascope.com'
	AND email NOT LIKE '%@gmail.com';