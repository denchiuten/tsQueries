SELECT
	jira.*,
	emp.internal_status
FROM jra.user AS jira
INNER JOIN bob.employee AS emp
	ON jira.email = emp.email
LEFT JOIN linear.users AS linear
	ON jira.email = linear.email
WHERE
	1 = 1
	AND linear.id IS NULL
	AND emp.internal_status = 'Active'