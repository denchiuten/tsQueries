SELECT 
	rep.name AS repository_name,
	r.name AS release_name,
	DATE_TRUNC('month', r.published_at)::DATE,
	t.name, 
	COUNT(r.tag_name) AS no_of_tags
FROM github.release AS r
INNER JOIN github.repository AS rep
	ON r.repository_id = rep.id
INNER JOIN github.repo_team AS rt
	ON rep.id = rt.repository_id
INNER JOIN github.team AS t
	ON rt.team_id = t.id
WHERE r.name NOT ILIKE '%.stg'
GROUP BY 1,2,3,4
ORDER BY 1



