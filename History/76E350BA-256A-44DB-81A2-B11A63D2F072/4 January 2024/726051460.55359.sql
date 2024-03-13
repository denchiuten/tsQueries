SELECT
	p.id,
	t.title
FROM notion.page AS p
LEFT JOIN notion.page_property AS t
	ON p.id = t.page_id
	AND t.title IS NOT NULL
	AND t._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND p._fivetran_deleted IS FALSE
-- 	database_id for Projects database
	AND p.database_id = '7fe0dfb4-f84f-4b3b-8fc3-cca27a621022'
	AND p.archived IS FALSE