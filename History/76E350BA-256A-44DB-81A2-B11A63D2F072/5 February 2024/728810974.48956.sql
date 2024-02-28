SELECT 
		pp.page_id,
		pp.people
	FROM notion.page_property AS pp
	INNER JOIN notion.database_object_property AS dop
		ON pp.id = dop.id
		AND dop.name = 'Assign'
	WHERE 
		1 = 1
		AND pp.people IS NOT NULL
		AND pp._fivetran_deleted IS FALSE