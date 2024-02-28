SELECT DISTINCT name, id
FROM jra.field
WHERE 
	is_custom IS TRUE
ORDER BY 1;