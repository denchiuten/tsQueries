SELECT 
	p.*
FROM notion.database_object AS db
LEFT JOIN notion.page AS p
	ON db.id = p.database_id
WHERE db.id = '7fe0dfb4-f84f-4b3b-8fc3-cca27a621022'