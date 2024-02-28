SELECT
	p.id AS task_id,
	creator.id AS creator_id,
	creator.email AS creator_email,
	p.url AS task_url,
	s.status AS task_status_json,
	a.people AS assignee_json,
	t.title AS title_json,
	r.relation AS project_id_json
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
INNER JOIN notion.page_property AS r
	ON p.id = r.page_id
	AND r.id = 'notion%3A%2F%2Ftasks%2Ftask_to_project_relation'
	AND r.relation IS NOT NULL
	AMD r.relation <> '[]'
LEFT JOIN notion.users AS creator
	ON p.created_by = creator.id
WHERE
	1 = 1
	AND p._fivetran_deleted IS FALSE
-- 	database_id for Tasks database
	AND p.database_id = 'd16f5b7b-8d03-4497-b265-875e58f1a772'
	AND p.archived IS FALSE