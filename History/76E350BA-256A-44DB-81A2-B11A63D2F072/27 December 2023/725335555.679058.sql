SELECT
	i.id AS jira_issue_id,
	i.key AS jira_issue_key,
	jirauser.email,
	jirauser.id AS jira_user_id,
	linearuser.id AS linear_user_id
FROM jra.issue AS i
INNER JOIN jra.user	AS jirauser
	ON i.assignee = jirauser.id
INNER JOIN linear.users AS linearuser
	ON jirauser.email = linearuser.email
	AND linearuser._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND i._fivetran_deleted IS FALSE