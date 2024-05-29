SELECT DISTINCT
	rep.name AS repository_name,
	DATE_TRUNC('month', r.published_at)::DATE,
	COUNT(r.tag_name) AS no_of_tags
FROM github.release AS r
INNER JOIN github.repository AS rep
	ON r.repository_id = rep.id
WHERE r.name NOT ILIKE '%.stg'
GROUP BY 1,2
ORDER BY 1,2