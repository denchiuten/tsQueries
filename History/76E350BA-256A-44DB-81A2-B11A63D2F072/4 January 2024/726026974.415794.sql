SELECT
	LOWER(jira.email) AS email,
	emp.internal_status AS bob_status,
	sl.name AS slack_name,
	sl.id AS slack_id
FROM jra.user AS jira
LEFT JOIN bob.employee AS emp
	ON LOWER(jira.email) = LOWER(emp.email)
INNER JOIN slack.users AS sl
	ON LOWER(jira.email) = LOWER(sl.profile_email)
LEFT JOIN linear.users AS linear
	ON LOWER(jira.email) = LOWER(linear.email)
WHERE
	1 = 1
	AND linear.id IS NULL
	AND jira.is_active IS TRUE
	AND (emp.internal_status = 'Active' OR emp.internal_status IS NULL)
	AND LOWER(jira.email) NOT IN ('askhr@terrascope.com', 'joydeep@terrascope.com','manuela.cosentino@terrascope.com',"suresh@terrascope.com")

UNION

SELECT
	LOWER(n.email) AS email,
	emp.internal_status,
	sl.name AS slack_name,
	sl.id AS slack_id
FROM notion.users AS n
LEFT JOIN bob.employee AS emp
	ON LOWER(n.email) = LOWER(emp.email)
INNER JOIN slack.users AS sl
	ON LOWER(n.email) = LOWER(sl.profile_email)
LEFT JOIN linear.users AS linear
	ON LOWER(n.email) = LOWER(linear.email)
WHERE
	1 = 1
	AND linear.id IS NULL
	AND n._fivetran_deleted IS FALSE
	AND (emp.internal_status = 'Active' OR emp.internal_status IS NULL)
	AND LOWER(n.email) NOT IN ('askhr@terrascope.com', 'joydeep@terrascope.com','manuela.cosentino@terrascope.com',"suresh@terrascope.com")