SELECT 
		pp.*
	FROM notion.page_property AS pp
	INNER JOIN notion.database_object_property AS dop
		ON pp.id = dop.id
		AND dop.name = 'Timeline (Commence)'
	WHERE 
		1 = 1
		AND pp._fivetran_deleted IS FALSE