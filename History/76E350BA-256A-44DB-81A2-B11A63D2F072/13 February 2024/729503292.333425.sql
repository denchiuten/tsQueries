SELECT 
	p.id,
	p.name, 
	p.label,
	opt.value,
	opt.label
FROM hubs.property AS p
INNER JOIN hubs.property_option AS opt
	ON p._fivetran_id = opt.property_id	
WHERE
	1 = 1
	AND p.name = 'feature_request_subcategories'