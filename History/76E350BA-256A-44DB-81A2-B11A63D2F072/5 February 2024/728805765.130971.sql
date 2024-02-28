SELECT 
	p.id AS page_id,
	p.url AS page_url,
	s.status AS task_status_json,
	a.people AS assignee_json
FROM notion.page AS p
LEFT JOIN notion.page_property AS s
	ON p.id = s.page_id
	AND s.status IS NOT NULL
LEFT JOIN notion.page_property AS a
	ON p.id = a.page_id
	AND a.people IS NOT NULL

WHERE 
	1 = 1
	AND p._fivetran_deleted IS FALSE
	AND p.database_id = 'bdc07b54-34cd-48cd-aabe-c211767cbcd7'