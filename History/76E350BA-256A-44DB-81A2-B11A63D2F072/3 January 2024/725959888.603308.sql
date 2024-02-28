WITH daci AS (
	SELECT
			dop.name,
			pp.page_id,
			pp.people
		FROM notion.database_object_property AS dop
		INNER JOIN notion.page_property AS pp
			ON dop.id = pp.id
			AND dop.database_object_id = '7fe0dfb4-f84f-4b3b-8fc3-cca27a621022'
		WHERE 
			1 = 1
			AND dop.name IN ('Driver', 'Contributors', 'Informed', 'Approver')
			AND dop._fivetran_deleted IS FALSE
			AND pp._fivetran_deleted IS FALSE
)
SELECT
	p.id AS project_page_id,
	creator.id AS creator_id,
	creator.email AS creator_email,
	p.url AS page_url,
	s.status AS project_status_json,
	t.title AS project_title_json,
	d.people AS driver_json,
	a.people AS approver_json,
	c.people AS contributors_json,
	i.people AS informed_json
FROM notion.page AS p
LEFT JOIN notion.page_property AS s
	ON p.id = s.page_id
	AND s.status IS NOT NULL
LEFT JOIN notion.page_property AS t
	ON p.id = t.page_id
	AND t.title IS NOT NULL
LEFT JOIN notion.users AS creator
	ON p.created_by = creator.id
LEFT JOIN daci AS d
	ON p.id = d.page_id
	AND d.name = 'Driver'
LEFT JOIN daci AS a
	ON p.id = a.page_id
	AND a.name = 'Approver'
LEFT JOIN daci AS c
	ON p.id = c.page_id
	AND c.name = 'Contributors'
LEFT JOIN daci AS i
	ON p.id = i.page_id
	AND i.name = 'Informed'
	
WHERE
	1 = 1
-- 	AND p._fivetran_deleted IS FALSE
-- 	database_id for Projects database
	AND p.database_id = '7fe0dfb4-f84f-4b3b-8fc3-cca27a621022'
-- 	AND p.archived IS FALSE