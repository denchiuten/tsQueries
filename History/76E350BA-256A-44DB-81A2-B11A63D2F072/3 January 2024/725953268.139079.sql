SELECT
	p.id AS page_id,
	creator.id AS creator_id,
	creator.email AS creator_email,
	p.url AS page_url,
	s.status AS project_status_json,
	t.title AS project_title_jsonm
	pp_driver.people
FROM notion.page AS p
LEFT JOIN notion.page_property AS s
	ON p.id = s.page_id
	AND s.status IS NOT NULL
LEFT JOIN notion.page_property AS t
	ON p.id = t.page_id
	AND t.title IS NOT NULL
LEFT JOIN notion.users AS creator
	ON p.created_by = creator.id
LEFT JOIN notion.database_object_property AS dop_driver
	ON p.database_id = dop_driver.database_object_id
	AND dop_driver.name = 'Driver'
LEFT JOIN notion.page_property AS pp_driver
	ON dop_driver.id = pp_driver.id
WHERE
	1 = 1
	AND p._fivetran_deleted IS FALSE
-- 	database_id for Projects database
	AND p.database_id = '7fe0dfb4-f84f-4b3b-8fc3-cca27a621022'
	AND p.archived IS FALSE