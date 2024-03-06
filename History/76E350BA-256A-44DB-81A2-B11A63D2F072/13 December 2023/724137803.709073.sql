SELECT
	p.key AS project_key,
	p.name AS project_name,
	'https://gpventure.atlassian.net/browse/' ||p.key AS url

FROM jra.project AS p