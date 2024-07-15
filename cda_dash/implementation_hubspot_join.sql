SELECT
	p.name AS project,
	p.id AS project_id,
	c.property_name AS hubspot_company_name,
	c.id AS hubspot_company_id
FROM linear.project AS p 
INNER JOIN linear.roadmap_to_project AS rp
	ON rp.project_id = p.id
	AND rp.roadmap_id = '1e8b8685-6651-4046-a784-2748b351581f' -- Implementations initiative / roadmap
	AND rp._fivetran_deleted IS FALSE
LEFT JOIN linear.project_link AS pl
	ON p.id = pl.project_id
	AND pl._fivetran_deleted IS FALSE
	AND pl.url LIKE 'https://app.hubspot.com/contacts/22313216/record/0-2/%'
LEFT JOIN hubs.company AS c
	ON REPLACE(pl.url, 'https://app.hubspot.com/contacts/22313216/record/0-2/', '') = c.id
WHERE
	1 = 1
	AND p._fivetran_deleted IS FALSE