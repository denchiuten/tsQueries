SELECT
	jissue.key AS jira__issue_key,
	jissue.id AS jira_issue_id,
	p.key AS jira_project_key
FROM jra.issue AS jra
INNER JOIN jra.project AS p
LEFT JOIN linear.attachment AS att 
	ON j.key = REPLACE(att.url, 'https://gpventure.atlassian.net/browse/', '')
	AND att._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND jra._fivetran_deleted IS FALSE
	AND att.id IS NULL