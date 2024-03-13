SELECT
	p.id,
	creator.email AS creator_email,
	p.url,
	s.status AS task_status,
	json_extract_path_text(a.people, id)
FROM notion.page AS p
LEFT JOIN notion.page_property AS s
	ON p.id = s.page_id
	AND s.status IS NOT NULL
LEFT JOIN notion.page_property AS a
	ON p.id = assignee.page_id
	AND assignee.people IS NOT NULL
LEFT JOIN notion.users AS creator
	ON p.created_by = creator.id
-- LEFT JOIN notion.users AS assignee
-- 	ON a
WHERE
	1 = 1
	AND p._fivetran_deleted IS FALSE
	AND p.database_id = 'd16f5b7b-8d03-4497-b265-875e58f1a772'
	AND p.archived IS FALSE
	
SELECT * FROM notion.page_property
WHERE replace(page_id, '-','') = 'f1d8430069c7489ab184d6573fc557c4'