SELECT
	u.email AS owner_email,
	bob.full_name AS owner_name,
	p.key AS project_key,
	p.name AS project_name,
	'https://gpventure.atlassian.net/browse/' ||p.key AS url,
	COUNT(DISTINCT i.id) AS n_issues,
	MAX(i.updated)::DATE AS last_issue_updated,
	MAX(i.created)::DATE AS last_issue_created
FROM jra.project AS p
INNER JOIN jra.issue AS i
	ON p.id = i.project
LEFT JOIN jra.user AS u
	ON p.lead_id = u.id
LEFT JOIN bob.employee AS bob
	ON u.email = bob.email
GROUP BY 1,2,3,4,5