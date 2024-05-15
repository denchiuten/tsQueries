SELECT DISTINCT
	rep.name,
	rep.default_branch,
	r.name AS release_name,
	DATE_TRUNC('month', r.published_at)::DATE, 
	r.tag_name 
-- 	COUNT(r.id) AS no_of_release
FROM github.release AS r
INNER JOIN github.repository AS rep
	ON r.repository_id = rep.id
WHERE r.name NOT ILIKE '%.stg'
	AND r.name IS NOT NULL 
-- GROUP BY 1,2,3,4,5
-- ORDER BY 1