SELECT
	type.name AS issue_type,
	i.key AS issue_key,
	i.id AS issue_id,
	p.key AS project_key
FROM jra.issue AS i
INNER JOIN jra.project AS p
	ON i.project = p.id
INNER JOIN jra.issue_type AS type
	ON i.issue_type = type.id
LEFT JOIN linear.attachment AS att 
	ON i.key = REPLACE(att.url, 'https://gpventure.atlassian.net/browse/', '')
	AND att._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND i._fivetran_deleted IS FALSE
	AND att.id IS NULL