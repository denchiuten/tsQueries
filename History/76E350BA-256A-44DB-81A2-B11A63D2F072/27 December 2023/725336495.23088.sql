SELECT
	jira.*
FROM jra.user AS jira
LEFT JOIN linear.users AS linear
	ON jira.email = linear.email
WHERE
	1 = 1
	AND linear.id IS NULL