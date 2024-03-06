SELECT
	u.email,
	p.key AS project_key,
	p.name AS project_name,
	'https://gpventure.atlassian.net/browse/' ||p.key AS url

FROM jra.project AS p
LEFT JOIN jra.user AS u
	ON p.lead_id = u.id