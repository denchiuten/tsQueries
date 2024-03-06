SELECT
		p.page_id,
		p."select" AS ongoing_timebound
	FROM notion.page_property AS p
	INNER JOIN notion.database_object_property AS dop
		ON p.id = dop.id
		AND dop.database_object_id = '7fe0dfb4-f84f-4b3b-8fc3-cca27a621022'
	WHERE
		1 = 1
		AND p._fivetran_deleted IS FALSE
		AND p.type = 'select'
		AND p."select" IS NOT NULL