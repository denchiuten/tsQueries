SELECT 
	l.id AS label_id,
	COUNT(*)
FROM linear.label AS l
GROUP BY 1
ORDER BY 2 DESC