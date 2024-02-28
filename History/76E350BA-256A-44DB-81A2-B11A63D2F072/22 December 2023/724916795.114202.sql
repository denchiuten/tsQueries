SELECT
	p.name,
	p.type,
	p.field_type
FROM hubs.property AS p

WHERE
	1 = 1
	AND p.hubspot_object = 'ticket'