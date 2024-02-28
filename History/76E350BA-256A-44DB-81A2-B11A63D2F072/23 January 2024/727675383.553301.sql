SELECT
	i.id AS jira_issue_id,
	i.key AS jira_issue_key
FROM jra.issue AS i
INNER JOIN jra.status AS s
	ON i.status = s.id
	AND s.name = 'Done'
WHERE
	1 = 1
	AND i._fivetran_deleted IS FALSE