SELECT
	p.name AS property_id,
	p.label AS property_label,
	p.field_type,
	o.label,
	o.value
FROM hubs.property AS p
INNER JOIN hubs.property_option AS o
	ON p._fivetran_id = o.property_id

WHERE
	1 = 1
	AND p.hubspot_object = 'ticket'
ORDER BY 1,4,5