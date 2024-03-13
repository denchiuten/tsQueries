SELECT 
	p.page_id,
	p.id,
	p."select" AS value,
	dop.database_object_id,
	dop.name
FROM notion.page_property AS p
INNER JOIN notion.database_object_property AS dop
	ON p.id = dop.id
WHERE 
	page_id = 'f7db8fb2-e51d-45fa-af05-65567184e4f5'
	AND p.type = 'select'