SELECT
	u.email,
	p.key AS project_key,
	p.name AS project_name,
	'https://gpventure.atlassian.net/browse/' ||p.key AS url,
	COUNT(DISTINCT i.id) AS n_issues,
	MAX(i.last_viewed)::DATE AS last_viewed,
	MAX(i.created)::DATE AS last_created

FROM jra.project AS p
INNER JOIN jra.issue AS i
	ON p.id = i.project
LEFT JOIN jra.user AS u
	ON p.lead_id = u.id
GROUP BY 1,2,3,4