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

UNION

SELECT
	LOWER(not.email) AS email,
	emp.internal_status,
	sl.name AS slack_name,
	sl.id AS slack_id
FROM notion.users AS not
LEFT JOIN bob.employee AS emp
	ON LOWER(not.email) = LOWER(emp.email)
INNER JOIN slack.users AS sl
	ON LOWER(not.email) = LOWER(sl.profile_email)
LEFT JOIN linear.users AS linear
	ON LOWER(not.email) = LOWER(linear.email)
WHERE
	1 = 1
	AND linear.id IS NULL
	AND not._fivetran_deleted IS FALSE
	AND (emp.internal_status = 'Active' OR emp.internal_status IS NULL)