SELECT
	p.id,
	creator.id AS creator_id,
	creator.email AS creator_email,
	p.url,
	s.status AS task_status_json,
	a.people AS assignee_json,
	t.title AS title_json
FROM notion.page AS p
LEFT JOIN notion.page_property AS s
	ON p.id = s.page_id
	AND s.status IS NOT NULL
LEFT JOIN notion.page_property AS a
	ON p.id = a.page_id
	AND a.people IS NOT NULL
LEFT JOIN notion.page_property AS t
	ON p.id = t.page_id
	AND t.title IS NOT NULL
LEFT JOIN notion.users AS creator
	ON p.created_by = creator.id
WHERE
	1 = 1
	AND p._fivetran_deleted IS FALSE
-- 	database_id for Tasks database
	AND p.database_id = '7fe0dfb4-f84f-4b3b-8fc3-cca27a621022'
	AND p.archived IS FALSE