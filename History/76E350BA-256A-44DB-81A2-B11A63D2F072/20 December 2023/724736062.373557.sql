SELECT
	i.key AS jira_issue_key,
	i.id AS jira_issue_id,
	p.key AS jira_project_key
FROM jra.issue AS i
INNER JOIN jra.project AS p
	ON i.project = p.id
LEFT JOIN linear.attachment AS att 
	ON i.key = REPLACE(att.url, 'https://gpventure.atlassian.net/browse/', '')
	AND att._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND i._fivetran_deleted IS FALSE
	AND att.id IS NULL