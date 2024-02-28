SELECT
	linear.email,
	jira.id AS jira_id,
	linear.id AS linear_id
FROM jra.user AS jira
INNER JOIN linear.users AS linear
	ON jira.email = linear.email
WHERE
	1 = 1
	AND jira._fivetran_deleted IS FALSE
	AND linear._fivetran_deleted IS FALSE