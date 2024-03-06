SELECT
	i.id AS jira_issue_id,
	i.key AS jira_issue_key,
	s.name AS jira_status
FROM jra.issue AS i
INNER JOIN jra.project AS p
	ON i.project = p.id
	AND p.key = 'CS'
INNER JOIN jra.status AS s
	ON i.status = s.id
WHERE
	1 = 1
	AND i._fivetran_deleted IS FALSE