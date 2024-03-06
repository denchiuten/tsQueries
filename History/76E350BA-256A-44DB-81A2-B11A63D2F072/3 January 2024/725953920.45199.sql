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
			AND dop.name IN ('Driver', 'Contributors', 'Informed', 'Approvers')
			AND dop._fivetran_deleted IS FALSE
			AND pp._fivetran_deleted IS FALSE
)