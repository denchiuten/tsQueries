SELECT DISTINCT
	r.name AS release_name,
	DATE_TRUNC('month', r.published_at)::DATE, 
	r.tag_name,
	COUNT(r.id) AS no_of_release
FROM github.release AS r
WHERE r.name NOT ILIKE '%.stg'
GROUP BY 1,2,3
ORDER BY 1