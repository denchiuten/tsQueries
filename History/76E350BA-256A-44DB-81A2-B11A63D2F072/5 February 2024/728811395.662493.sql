SELECT 
	p.id AS page_id,
	p.url AS page_url,
	s.status AS task_status_json,
	a.people AS assignee_json,
	t.title AS title_json,
	tl.select AS timeline_json,
	opp.multi_select AS opp_grouping_json,
	pod.multi_select AS pod_json
FROM notion.page AS p
LEFT JOIN notion.page_property AS s
	ON p.id = s.page_id
	AND s.status IS NOT NULL
	AND s._fivetran_deleted IS FALSE
LEFT JOIN (
	SELECT 
		pp.page_id,
		pp.people
	FROM notion.page_property AS pp
	INNER JOIN notion.database_object_property AS dop
		ON pp.id = dop.id
		AND dop.name = 'Assign'
	WHERE 
		1 = 1
		AND pp._fivetran_deleted IS FALSE
		AND pp.people != '[]'
) AS a
	ON p.id = a.page_id
LEFT JOIN (
	SELECT 
		pp.page_id,
		pp.select
	FROM notion.page_property AS pp
	INNER JOIN notion.database_object_property AS dop
		ON pp.id = dop.id
		AND dop.name = 'Timeline (Commence)'
	WHERE 
		1 = 1
		AND pp._fivetran_deleted IS FALSE
		AND pp.select IS NOT NULL
) AS tl
	ON p.id = tl.page_id
LEFT JOIN (
	SELECT 
		pp.page_id,
		pp.multi_select
	FROM notion.page_property AS pp
	INNER JOIN notion.database_object_property AS dop
		ON pp.id = dop.id
		AND dop.name = 'Opportunity Grouping'
	WHERE 
		1 = 1
		AND pp._fivetran_deleted IS FALSE
		AND pp.multi_select IS NOT NULL
) AS opp
	ON p.id = opp.page_id
LEFT JOIN (
	SELECT 
		pp.page_id,
		pp.multi_select
	FROM notion.page_property AS pp
	INNER JOIN notion.database_object_property AS dop
		ON pp.id = dop.id
		AND dop.name = 'Pod (For effort estimate)'
	WHERE 
		1 = 1
		AND pp._fivetran_deleted IS FALSE
		AND pp.multi_select IS NOT NULL
) AS pod
	ON p.id = pod.page_id
LEFT JOIN notion.page_property AS t
	ON p.id = t.page_id
	AND t.title IS NOT NULL
	AND t._fivetran_deleted IS FALSE

WHERE 
	1 = 1
	AND p._fivetran_deleted IS FALSE
	AND p.database_id = 'bdc07b54-34cd-48cd-aabe-c211767cbcd7' -- ID for Roadmap Planning DB at https://www.notion.so/greenpass/bdc07b5434cd48cdaabec211767cbcd7?v=d026bcd1ac914fa5aef986ad67e76a18&pvs=4