SELECT
	p.id,
	p.description,
	p.created_by,
	p.url
FROM notion.page AS p
WHERE
	1 = 1
	AND p._fivetran_deleted IS FALSE
	AND p.database_id = 'd16f5b7b-8d03-4497-b265-875e58f1a772'
	AND p.archived IS FALSE