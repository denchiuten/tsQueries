SELECT
	c.id, 
	c.property_name
FROM hubs.deal AS d
INNER JOIN hubs.deal_company AS dc
	ON d.deal_id = dc.deal_id
	AND dc.type_id = 5
INNER JOIN hubs.company AS c
	ON dc.company_id = c.id
WHERE
	1 = 1
	AND d._fivetran_deleted IS FALSE