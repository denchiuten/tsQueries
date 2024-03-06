SELECT
	p.id,
	p.description,
	p.created_by,
	p.url,
	prop.status
FROM notion.page AS p
INNER JOIN notion.page_property AS prop
	ON p.id = prop.page_id
WHERE
	1 = 1
	AND p._fivetran_deleted IS FALSE
	AND p.database_id = 'd16f5b7b-8d03-4497-b265-875e58f1a772'
	AND p.archived IS FALSE