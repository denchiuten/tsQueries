SELECT 
	db.title,
	db._fivetran_deleted,
	db.id,
	COUNT(p.*) AS n_pages
FROM notion.database_object AS db
LEFT JOIN notion.page AS p
	ON db.id = p.database_id
GROUP BY 1,2,3
ORDER BY 1,2