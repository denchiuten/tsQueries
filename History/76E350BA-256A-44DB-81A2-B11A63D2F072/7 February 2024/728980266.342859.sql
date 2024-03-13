SELECT
	c.property_name AS company_name,
	c.id AS company_id
FROM hubs.deal AS d
INNER JOIN hubs.deal_company AS dc
	ON d.deal_id = dc.deal_id
	AND dc.type_id = 5
INNER JOIN hubs.company AS c
	ON dc.company_id = c.id
WHERE
	1 = 1
	AND d._fivetran_deleted IS FALSE
	AND d.deal_pipeline_id = 19800993
ORDER BY 1